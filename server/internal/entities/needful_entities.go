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

type Messages struct {
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
