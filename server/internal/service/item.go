package service

import (
	"needful/internal/dtos"
	"needful/internal/entities"
)

type ItemService interface {
	GetItems() ([]entities.Item, error)
	GetItemByUserId(int) ([]entities.Item, error)
	GetItemByItemId(int) (*entities.Item, error)

	///////////////////////////////////////////////////////////

	GetItemDetailsByItemId(int) (*entities.Item, error)

	///////////////////////////////////////////////////////////

	GetItemsOfCurrentUser(userid int) ([]dtos.ItemsOfCurrentUserResponse, error)
	GetDonateItemsOfCurrentUser(userid int) ([]dtos.DonateItemsOfCurrentUserResponse, error)
	GetReceiveItemsOfCurrentUser(userid int) ([]dtos.ReceiveItemsOfCurrentUserResponse, error)

	PostAddItem(int, dtos.AddItemRequest) (*entities.Item, error)

	DeleteItemByItemID(itemID int) error

	GetMarketPlace(userid int) ([]dtos.MarketPlaceResponse, error)
	GetDonateMarketPlace(userid int) ([]dtos.DonateMarketPlaceResponse, error)
	GetReceiveMarketPlace(userid int) ([]dtos.ReceiveMarketPlaceResponse, error)
}
