package main

import (
	"fmt"
	//jwtware "github.com/gofiber/contrib/jwt"
	"github.com/minio/minio-go/v7"
	"github.com/minio/minio-go/v7/pkg/credentials"
	"log"
	"needful/internal/entities"
	"needful/internal/handler"
	"needful/internal/repository"
	"needful/internal/service"
	"strings"
	"time"

	"github.com/gofiber/fiber/v2"

	"github.com/spf13/viper"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

const jwtSecret = "NeedFulSecret"

func main() {
	initTimeZone()
	initConfig()
	dsn := fmt.Sprintf("%v:%v@tcp(%v:%v)/%v?parseTime=true",
		viper.GetString("db.username"),
		viper.GetString("db.password"),
		viper.GetString("db.host"),
		viper.GetInt("db.port"),
		viper.GetString("db.database"),
	)
	log.Println(dsn)

	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})

	if err != nil {
		panic("Failed to connect database")
	}

	err = db.AutoMigrate(&entities.User{})
	if err != nil {
		panic("Failed to AutoMigrate User")
	}

	err = db.AutoMigrate(&entities.Item{})
	if err != nil {
		panic("Failed to AutoMigrate Item")
	}

	err = db.AutoMigrate(&entities.Messages{})
	if err != nil {
		panic("Failed to AutoMigrate Messages")
	}

	minioClient, err := minio.New(viper.GetString("minio.host")+":"+viper.GetString("minio.port"), &minio.Options{
		Creds:  credentials.NewStaticV4("EneudJTZpjRIZuFYq6MF", "eo1uLxOg33oeuOHbI7kokmSNSp1AgJTfw1QMWLda", ""),
		Secure: false,
	})
	if err != nil {
		log.Fatalln(err)
	}
	fmt.Println("Minio connected")

	uploadSer := service.NewUploadService(minioClient)
	storageHandler := handler.NewStorageHandler(uploadSer)

	userRepositoryDB := repository.NewUserRepositoryDB(db)
	wishlistRepositoryDB := repository.NewWishlistRepositoryDB(db)
	//followRepositoryDB := repository.NewFollowRepositoryDB(db)

	userService := service.NewUserService(userRepositoryDB, jwtSecret)
	wishlistService := service.NewWishlistService(wishlistRepositoryDB)
	//followService := service.NewFollowService(followRepositoryDB)
	uploadService := service.NewUploadService(minioClient)

	userHandler := handler.NewUserHandler(userService, jwtSecret, uploadService)
	wishlistHandler := handler.NewWishlistHandler(wishlistService, jwtSecret, uploadService)
	//followHandler := handler.NewFollowHandler(followService, jwtSecret)

	app := fiber.New()

	//app.Use(func(c *fiber.Ctx) error {
	//	if c.Path() != "/Register" && c.Path() != "/Login" {
	//		jwtMiddleware := jwtware.New(jwtware.Config{
	//			SigningKey: jwtware.SigningKey{Key: []byte(jwtSecret)},
	//			ErrorHandler: func(c *fiber.Ctx, err error) error {
	//				return fiber.ErrUnauthorized
	//			},
	//		})
	//		return jwtMiddleware(c)
	//	}
	//	return c.Next()
	//})

	//Endpoint ###########################################################################

	// Endpoint of test
	app.Get("/Users", userHandler.GetUsers)
	app.Get("/UserById/:UserID", userHandler.GetUserById)
	app.Get("/UserByToken", userHandler.GetUserByToken) //#

	app.Get("/Wishlists", wishlistHandler.GetWishlists)
	app.Get("/Wishlist/:WishlistID", wishlistHandler.GetWishlist)

	app.Get("/WishlistOfUser/:UserID", wishlistHandler.GetWishlistsOfUser)

	app.Post("/upload", storageHandler.UploadFile)

	//////////////////////////////////////////////////////////////////////////////////////

	// Endpoint for project
	app.Post("/Register", userHandler.Register)
	app.Post("/Login", userHandler.Login)

	app.Get("/CurrentUser", userHandler.GetCurrentUser) //#
	app.Get("/GetProfileOfCurrentUser/:UserID", userHandler.GetProfileOfCurrentUserById)
	app.Get("/GetEditUserProfile/:UserID", userHandler.GetEditUserProfileById)
	app.Patch("/UpdateEditUserProfile/:UserID", userHandler.PatchEditUserProfileById)

	app.Get("/GetWishlistsOfCurrentUser", wishlistHandler.GetWishlistsOfCurrentUser) //#

	app.Get("/GetFriendsWishlists", wishlistHandler.GetFriendsWishlists) //#
	app.Get("/GetWishlistDetails/:WishlistID", wishlistHandler.GetWishlistDetails)
	app.Get("/GetProfileFriendWishlists/:CurrentUserID/:WishlistOwnerID", wishlistHandler.GetProfileFriendWishlists)

	app.Put("/UpdateGrantForFriend/:WishlistID/:GranterUserID", wishlistHandler.UpdateGrantForFriend)
	app.Put("/UpdateReceiverGotIt/:WishlistID/:GranterUserID", wishlistHandler.UpdateReceiverGotIt)
	app.Put("/UpdateReceiverDidntGetIt/:WishlistID/:GranterUserID", wishlistHandler.UpdateReceiverDidntGetIt)

	app.Post("/PostAddWishlist", wishlistHandler.PostAddWishlist) //#

	//#####################################################################################

	log.Printf("SweetFavors run at port:  %v", viper.GetInt("app.port"))
	app.Listen(fmt.Sprintf(":%v", viper.GetInt("app.port")))

}

func initConfig() {
	viper.SetConfigName("config")
	viper.SetConfigType("yaml")
	viper.AddConfigPath(".")
	viper.AutomaticEnv()
	viper.SetEnvKeyReplacer(strings.NewReplacer(".", "_"))

	err := viper.ReadInConfig()
	if err != nil {
		panic(err)
	}
}

func initTimeZone() {
	ict, err := time.LoadLocation("Asia/Bangkok")
	if err != nil {
		panic(err)
	}

	time.Local = ict
}
