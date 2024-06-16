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

	PostAddItem(int, dtos.AddItemRequest) (*entities.Item, error)
}
