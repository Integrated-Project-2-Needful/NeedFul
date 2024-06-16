package service

import (
	"github.com/gofiber/fiber/v2"
	"log"
	"needful/internal/dtos"
	"needful/internal/entities"
	"needful/internal/repository"
	"needful/internal/utils/v"
	"strings"
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

	if *item == (entities.Item{}) {
		return nil, fiber.NewError(fiber.StatusNotFound, "item doesn't exist")
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

	if *item == (entities.Item{}) {
		return nil, fiber.NewError(fiber.StatusNotFound, "item doesn't exist")
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

func (s itemService) GetItemsOfCurrentUser(userid int) ([]dtos.ItemsOfCurrentUserResponse, error) {
	items, err := s.itemRepo.GetAllItemOfCurrentUser(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	itemsResponse := []dtos.ItemsOfCurrentUserResponse{}
	for _, item := range items {
		itemResponse := dtos.ItemsOfCurrentUserResponse{
			ItemID:                  item.ItemID,
			UserID:                  item.UserID,
			Itemname:                item.Itemname,
			Description:             item.Description,
			ItemPic:                 item.ItemPic,
			OfferType:               item.OfferType,
			AskedByUserID:           item.AskedByUserID,
			AlreadyGave:             item.AlreadyGave,
			Username:                item.Username,
			UserPic:                 item.UserPic,
			UsernameOfAskedByUserID: item.UsernameOfAskedByUserID,
		}
		itemsResponse = append(itemsResponse, itemResponse)
	}
	return itemsResponse, nil
}

func (s itemService) GetDonateItemsOfCurrentUser(userid int) ([]dtos.DonateItemsOfCurrentUserResponse, error) {
	items, err := s.itemRepo.GetDonateItemsOfCurrentUser(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	itemsResponse := []dtos.DonateItemsOfCurrentUserResponse{}
	for _, item := range items {
		itemResponse := dtos.DonateItemsOfCurrentUserResponse{
			ItemID:                  item.ItemID,
			UserID:                  item.UserID,
			Itemname:                item.Itemname,
			Description:             item.Description,
			ItemPic:                 item.ItemPic,
			OfferType:               item.OfferType,
			AskedByUserID:           item.AskedByUserID,
			AlreadyGave:             item.AlreadyGave,
			Username:                item.Username,
			UserPic:                 item.UserPic,
			UsernameOfAskedByUserID: item.UsernameOfAskedByUserID,
		}
		itemsResponse = append(itemsResponse, itemResponse)
	}
	return itemsResponse, nil
}

func (s itemService) GetReceiveItemsOfCurrentUser(userid int) ([]dtos.ReceiveItemsOfCurrentUserResponse, error) {
	items, err := s.itemRepo.GetReceiveItemsOfCurrentUser(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	itemsResponse := []dtos.ReceiveItemsOfCurrentUserResponse{}
	for _, item := range items {
		itemResponse := dtos.ReceiveItemsOfCurrentUserResponse{
			ItemID:                  item.ItemID,
			UserID:                  item.UserID,
			Itemname:                item.Itemname,
			Description:             item.Description,
			ItemPic:                 item.ItemPic,
			OfferType:               item.OfferType,
			AskedByUserID:           item.AskedByUserID,
			AlreadyGave:             item.AlreadyGave,
			Username:                item.Username,
			UserPic:                 item.UserPic,
			UsernameOfAskedByUserID: item.UsernameOfAskedByUserID,
		}
		itemsResponse = append(itemsResponse, itemResponse)
	}
	return itemsResponse, nil
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

func (s itemService) DeleteItemByItemID(itemID int) error {
	_, err := s.GetItemByItemId(itemID)
	if err != nil {
		if strings.Contains(err.Error(), "item doesn't exist") {
			return fiber.NewError(fiber.StatusNotFound, "item not found")
		}
		return err
	}

	err = s.itemRepo.DeleteItemByItemID(itemID)
	if err != nil {
		return err
	}

	return nil
}

func (s itemService) GetMarketPlace(userid int) ([]dtos.MarketPlaceResponse, error) {
	items, err := s.itemRepo.GetMarketPlace(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	itemsResponse := []dtos.MarketPlaceResponse{}
	for _, item := range items {
		itemResponse := dtos.MarketPlaceResponse{
			ItemID:        item.ItemID,
			UserID:        item.UserID,
			Itemname:      item.Itemname,
			Description:   item.Description,
			ItemPic:       item.ItemPic,
			OfferType:     item.OfferType,
			AskedByUserID: item.AskedByUserID,
			AlreadyGave:   item.AlreadyGave,
			Username:      item.Username,
			UserPic:       item.UserPic,
		}
		itemsResponse = append(itemsResponse, itemResponse)
	}
	return itemsResponse, nil
}

func (s itemService) GetDonateMarketPlace(userid int) ([]dtos.DonateMarketPlaceResponse, error) {
	items, err := s.itemRepo.GetDonateMarketPlace(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	itemsResponse := []dtos.DonateMarketPlaceResponse{}
	for _, item := range items {
		itemResponse := dtos.DonateMarketPlaceResponse{
			ItemID:        item.ItemID,
			UserID:        item.UserID,
			Itemname:      item.Itemname,
			Description:   item.Description,
			ItemPic:       item.ItemPic,
			OfferType:     item.OfferType,
			AskedByUserID: item.AskedByUserID,
			AlreadyGave:   item.AlreadyGave,
			Username:      item.Username,
			UserPic:       item.UserPic,
		}
		itemsResponse = append(itemsResponse, itemResponse)
	}
	return itemsResponse, nil
}

func (s itemService) GetReceiveMarketPlace(userid int) ([]dtos.ReceiveMarketPlaceResponse, error) {
	items, err := s.itemRepo.GetReceiveMarketPlace(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	itemsResponse := []dtos.ReceiveMarketPlaceResponse{}
	for _, item := range items {
		itemResponse := dtos.ReceiveMarketPlaceResponse{
			ItemID:        item.ItemID,
			UserID:        item.UserID,
			Itemname:      item.Itemname,
			Description:   item.Description,
			ItemPic:       item.ItemPic,
			OfferType:     item.OfferType,
			AskedByUserID: item.AskedByUserID,
			AlreadyGave:   item.AlreadyGave,
			Username:      item.Username,
			UserPic:       item.UserPic,
		}
		itemsResponse = append(itemsResponse, itemResponse)
	}
	return itemsResponse, nil
}
