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

	DeleteItemByItemId(itemID int) error

	GetMarketPlace(int) ([]dtos.MarketPlaceResponse, error)
	GetDonateMarketPlace(int) ([]dtos.DonateMarketPlaceResponse, error)
	GetReceiveMarketPlace(int) ([]dtos.ReceiveMarketPlaceResponse, error)

	PutAskByItemId(item *entities.Item) error
}
