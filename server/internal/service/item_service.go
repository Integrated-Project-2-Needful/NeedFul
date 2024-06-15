package service

import (
	"log"
	"needful/internal/dtos"
	"needful/internal/entities"
	"needful/internal/repository"
	"needful/internal/utils/v"
)

type itemService struct {
	itemRepo repository.ItemRepository
}

func NewItemService(itemRepo repository.ItemRepository) itemService {
	return itemService{itemRepo: itemRepo}
}

func (s itemService) GetItems() ([]entities.Item, error) {
	items, err := s.itemRepo.GetAllItem()
	if err != nil {
		log.Println(err)
		return nil, err
	}

	itemResponses := []entities.Item{}
	for _, item := range items {
		itemResponse := entities.Item{
			ItemID:        item.ItemID,
			UserID:        item.UserID,
			Itemname:      item.Itemname,
			Description:   item.Description,
			ItemPic:       item.ItemPic,
			OfferType:     item.OfferType,
			AskedByUserID: item.AskedByUserID,
			AlreadyGave:   item.AlreadyGave,
		}
		itemResponses = append(itemResponses, itemResponse)
	}
	return itemResponses, nil
}

func (s itemService) GetItemByUserId(userid int) ([]entities.Item, error) {
	items, err := s.itemRepo.GetItemByUserId(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	itemResponses := []entities.Item{}
	for _, item := range items {
		itemResponse := entities.Item{
			ItemID:        item.ItemID,
			UserID:        item.UserID,
			Itemname:      item.Itemname,
			Description:   item.Description,
			ItemPic:       item.ItemPic,
			OfferType:     item.OfferType,
			AskedByUserID: item.AskedByUserID,
			AlreadyGave:   item.AlreadyGave,
		}
		itemResponses = append(itemResponses, itemResponse)
	}
	return itemResponses, nil
}

func (s itemService) GetItemByItemId(itemid int) (*entities.Item, error) {
	item, err := s.itemRepo.GetItemByItemId(itemid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	itemResponse := entities.Item{
		ItemID:        item.ItemID,
		UserID:        item.UserID,
		Itemname:      item.Itemname,
		Description:   item.Description,
		ItemPic:       item.ItemPic,
		OfferType:     item.OfferType,
		AskedByUserID: item.AskedByUserID,
		AlreadyGave:   item.AlreadyGave,
	}
	return &itemResponse, nil
}

////////////////////////////////////////////////////////////////////////////////////////////////////

func (s itemService) GetItemDetailsByItemId(itemid int) (*entities.Item, error) {
	item, err := s.itemRepo.GetItemDetailsByItemId(itemid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	itemResponse := entities.Item{
		ItemID:        item.ItemID,
		UserID:        item.UserID,
		Itemname:      item.Itemname,
		Description:   item.Description,
		ItemPic:       item.ItemPic,
		OfferType:     item.OfferType,
		AskedByUserID: item.AskedByUserID,
		AlreadyGave:   item.AlreadyGave,
	}
	return &itemResponse, nil
}

////////////////////////////////////////////////////////////////////////////////////////////////////

func (s itemService) GetItemsOfCurrentUser(userid int) ([]entities.Item, error) {
	items, err := s.itemRepo.GetAllItemOfCurrentUser(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	itemResponses := []entities.Item{}
	for _, item := range items {
		itemResponse := entities.Item{
			ItemID:        item.ItemID,
			UserID:        item.UserID,
			Itemname:      item.Itemname,
			Description:   item.Description,
			ItemPic:       item.ItemPic,
			OfferType:     item.OfferType,
			AskedByUserID: item.AskedByUserID,
			AlreadyGave:   item.AlreadyGave,
		}
		itemResponses = append(itemResponses, itemResponse)
	}
	return itemResponses, nil
}

func (s itemService) PostAddItem(userID int, req dtos.AddItemRequest) (*entities.Item, error) {
	item := &entities.Item{
		UserID:      v.UintPtr(userID),
		Itemname:    req.Itemname,
		Description: req.Description,
		ItemPic:     req.ItemPic,
		OfferType:   req.OfferType,
	}

	err := s.itemRepo.PostAddItem(item)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	return item, nil
}
