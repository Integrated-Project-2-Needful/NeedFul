package entities

type User struct {
	UserID    *uint `gorm:"primaryKey;autoIncrement"`
	Username  *string
	Password  *string
	Email     *string
	Firstname *string
	Lastname  *string
	PhoneNum  *string
	UserPic   *string
}

type Item struct {
	ItemID        *uint `gorm:"primaryKey;autoIncrement"`
	UserID        *uint `gorm:"not null"`
	Itemname      *string
	Description   *string
	ItemPic       *string
	OfferType     *string
	AskedByUserID *uint
	AlreadyGave   *bool
	///////////////////////////////////////////////
	User User `gorm:"foreignKey:UserID"`
	//////////////////////////////////////////////

}

type Message struct {
	MsgID            *uint `gorm:"primaryKey;autoIncrement"`
	SenderUserID     *uint `gorm:"not null;"`
	ReceiverUserID   *uint `gorm:"not null;"`
	MsgText          *string
	ConFromItemOwner *bool
	ConFromItemAsker *bool
}

type ItemsOfCurrentUserResponse struct {
	ItemID                  *uint
	UserID                  *uint
	Itemname                *string
	Description             *string
	ItemPic                 *string
	OfferType               *string
	AskedByUserID           *uint
	AlreadyGave             *bool
	Username                *string
	UserPic                 *string
	UsernameOfAskedByUserID *string
}

type DonateItemsOfCurrentUserResponse struct {
	ItemID                  *uint
	UserID                  *uint
	Itemname                *string
	Description             *string
	ItemPic                 *string
	OfferType               *string
	AskedByUserID           *uint
	AlreadyGave             *bool
	Username                *string
	UserPic                 *string
	UsernameOfAskedByUserID *string
}

type ReceiveItemsOfCurrentUserResponse struct {
	ItemID                  *uint
	UserID                  *uint
	Itemname                *string
	Description             *string
	ItemPic                 *string
	OfferType               *string
	AskedByUserID           *uint
	AlreadyGave             *bool
	Username                *string
	UserPic                 *string
	UsernameOfAskedByUserID *string
}

type MarketPlaceResponse struct {
	ItemID        *uint
	UserID        *uint
	Itemname      *string
	Description   *string
	ItemPic       *string
	OfferType     *string
	AskedByUserID *uint
	AlreadyGave   *bool
	Username      *string
	UserPic       *string
}

type DonateMarketPlaceResponse struct {
	ItemID        *uint
	UserID        *uint
	Itemname      *string
	Description   *string
	ItemPic       *string
	OfferType     *string
	AskedByUserID *uint
	AlreadyGave   *bool
	Username      *string
	UserPic       *string
}

type ReceiveMarketPlaceResponse struct {
	ItemID        *uint
	UserID        *uint
	Itemname      *string
	Description   *string
	ItemPic       *string
	OfferType     *string
	AskedByUserID *uint
	AlreadyGave   *bool
	Username      *string
	UserPic       *string
}

type MessagePageOfCurrentUserResponse struct {
	UserID         *uint   `json:"user_id" validate:"required"`
	Username       *string `json:"username" validate:"required"`
	Firstname      *string `json:"firstname" validate:"required"`
	Lastname       *string `json:"lastname" validate:"required"`
	UserPic        *string `json:"user_pic" validate:"required"`
	MsgID          *uint   `json:"msg_id" validate:"required"`
	SenderUserID   *uint   `json:"sender_user_id" validate:"required"`
	ReceiverUserID *uint   `json:"receiver_user_id" validate:"required"`
	MsgText        *string `json:"msg_text" validate:"required"`
}
