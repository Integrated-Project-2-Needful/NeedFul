package repository

import "needful/internal/entities"

type ItemRepository interface {
	GetAllItem() ([]entities.Item, error)
	GetItemByUserId(int) ([]entities.Item, error)
	GetItemByItemId(int) (*entities.Item, error)

	////////////////////////////////////////////////////////////////////

	GetItemDetailsByItemId(int) (*entities.Item, error)

	/////////////////////////////////////////////////////////////////

	GetAllItemOfCurrentUser(int) ([]entities.Item, error)

	PostAddItem(item *entities.Item) error
}

//Get.GetItemOfCurrentUser //#
//Get.GetDonateItemOfCurrentUser //#
//Get.GetReceiveItemOfCurrentUser //#
//
//Delete.DeleteItemByID
//
//Post.PostAddItem //#
//
//Get.GetMarketPlace //#
//Get.GetDonateMarketPlace //#
//Get.GetReceiveMarketPlace //#
//Put.PutDonateByID
//Put.PutReceiveByID
