package dtos

//ItemID        *uint `gorm:"primaryKey;autoIncrement"`
//UserID        *uint `gorm:"not null"`
//Itemname      *string
//Description   *string
//ItemPic       *string
//OfferType     *string
//AskedByUserID *uint
//AlreadyGave   *bool

type ItemDataResponse struct {
	ItemID        *uint   `json:"item_id" validate:"required"`
	UserID        *uint   `json:"user_id" validate:"required"`
	Itemname      *string `json:"itemname" validate:"required"`
	Description   *string `json:"description" validate:"required"`
	ItemPic       *string `json:"item_pic" validate:"required"`
	OfferType     *string `json:"offer_type" validate:"required"`
	AskedByUserID *uint   `json:"asked_by_user_id" validate:"required"`
	AlreadyGave   *bool   `json:"already_gave" validate:"required"`
}

type ItemDataByUserIdResponse struct {
	ItemID        *uint   `json:"item_id" validate:"required"`
	UserID        *uint   `json:"user_id" validate:"required"`
	Itemname      *string `json:"itemname" validate:"required"`
	Description   *string `json:"description" validate:"required"`
	ItemPic       *string `json:"item_pic" validate:"required"`
	OfferType     *string `json:"offer_type" validate:"required"`
	AskedByUserID *uint   `json:"asked_by_user_id" validate:"required"`
	AlreadyGave   *bool   `json:"already_gave" validate:"required"`
}

type ItemDataByItemIdResponse struct {
	ItemID        *uint   `json:"item_id" validate:"required"`
	UserID        *uint   `json:"user_id" validate:"required"`
	Itemname      *string `json:"itemname" validate:"required"`
	Description   *string `json:"description" validate:"required"`
	ItemPic       *string `json:"item_pic" validate:"required"`
	OfferType     *string `json:"offer_type" validate:"required"`
	AskedByUserID *uint   `json:"asked_by_user_id" validate:"required"`
	AlreadyGave   *bool   `json:"already_gave" validate:"required"`
}

///////////////////////////////////////////////////

type ItemDetailsByItemIdResponse struct {
	ItemID        *uint   `json:"item_id" validate:"required"`
	UserID        *uint   `json:"user_id" validate:"required"`
	Itemname      *string `json:"itemname" validate:"required"`
	Description   *string `json:"description" validate:"required"`
	ItemPic       *string `json:"item_pic" validate:"required"`
	OfferType     *string `json:"offer_type" validate:"required"`
	AskedByUserID *uint   `json:"asked_by_user_id" validate:"required"`
	AlreadyGave   *bool   `json:"already_gave" validate:"required"`
}

///////////////////////////////////////////////////

type ItemsOfCurrentUserResponse struct {
	ItemID        *uint   `json:"item_id" validate:"required"`
	UserID        *uint   `json:"user_id" validate:"required"`
	Itemname      *string `json:"itemname" validate:"required"`
	Description   *string `json:"description" validate:"required"`
	ItemPic       *string `json:"item_pic" validate:"required"`
	OfferType     *string `json:"offer_type" validate:"required"`
	AskedByUserID *uint   `json:"asked_by_user_id" validate:"required"`
	AlreadyGave   *bool   `json:"already_gave" validate:"required"`
}

type AddItemRequest struct {
	UserID      *uint   `json:"user_id" validate:"required"`
	Itemname    *string `json:"itemname" validate:"required"`
	Description *string `json:"description" validate:"required"`
	ItemPic     *string `json:"item_pic" validate:"required"`
	OfferType   *string `json:"offer_type" validate:"required"`
}
