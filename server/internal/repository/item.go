package repository

import (
	"needful/internal/dtos"
	"needful/internal/entities"
)

type ItemRepository interface {
	GetAllItem() ([]entities.Item, error)
	GetItemByUserId(int) ([]entities.Item, error)
	GetItemByItemId(int) (*entities.Item, error)

	////////////////////////////////////////////////////////////////////

	GetItemDetailsByItemId(int) (*entities.Item, error)

	/////////////////////////////////////////////////////////////////

	GetAllItemOfCurrentUser(int) ([]dtos.ItemsOfCurrentUserResponse, error)
	GetDonateItemsOfCurrentUser(int) ([]dtos.DonateItemsOfCurrentUserResponse, error)
	GetReceiveItemsOfCurrentUser(int) ([]dtos.ReceiveItemsOfCurrentUserResponse, error)

	PostAddItem(item *entities.Item) error

	DeleteItemByItemID(itemID int) error
}

//Get.GetDonateItemOfCurrentUser //#
//Get.GetReceiveItemOfCurrentUser //#
//
//Delete.DeleteItemByID
//
//Get.GetMarketPlace //#
//Get.GetDonateMarketPlace //#
//Get.GetReceiveMarketPlace //#
//Put.PutDonateByID
//Put.PutReceiveByID
