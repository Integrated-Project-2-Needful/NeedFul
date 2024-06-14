package repository

import "needful/internal/entities"

type UserRepository interface {
	GetAllUser() ([]entities.User, error)
	GetUserById(int) (*entities.User, error)
	GetUserByToken(int) (*entities.User, error)

	////////////////////////////////////////////////////////////////////

	GetCurrentUser(int) (*entities.User, error)

	GetProfileOfCurrentUserById(int) (*entities.User, error)

	GetEditUserProfileById(int) (*entities.User, error)
	PatchEditUserProfileById(user *entities.User) error

	CreateUser(user *entities.User) error                      //Register
	GetUserByUsername(username string) (*entities.User, error) //Login
}
