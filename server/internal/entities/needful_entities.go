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

	// Define associations
	Items []Item `gorm:"foreignKey:UserID"`
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
	/////////////////////////////////////////
	//UsernameOfWishOwner *string `gorm:"->"`
	//UserPicOfWishOwner  *string `gorm:"->"`
	//UsernameOfAsker     *string `gorm:"->"`
}

type Messages struct {
	MsgID            *uint `gorm:"primaryKey;autoIncrement"`
	SenderUserID     *uint `gorm:"not null;"`
	ReceiverUserID   *uint `gorm:"not null;"`
	MsgText          *string
	ConFromItemOwner *bool
	ConFromItemAsker *bool
	/////////////////////////////////////////
	//UsernameOfSender   *string `gorm:"->"`
	//UserPicOfSender    *string `gorm:"->"`
	//UsernameOfReceiver *string `gorm:"->"`
	//UserPicOfReceiver  *string `gorm:"->"`
}
