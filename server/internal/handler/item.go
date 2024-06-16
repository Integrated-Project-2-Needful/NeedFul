package handler

import (
	"errors"
	"github.com/gofiber/fiber/v2"
	"needful/internal/dtos"
	"needful/internal/service"
	"needful/internal/utils"
	"strconv"
	"strings"
)

type itemHandler struct {
	itemSer   service.ItemService
	jwtSecret string
	uploadSer service.UploadService
}

func NewItemHandler(itemSer service.ItemService, jwtSecret string, uploadSer service.UploadService) itemHandler {
	return itemHandler{itemSer: itemSer, jwtSecret: jwtSecret, uploadSer: uploadSer}
}

func (h *itemHandler) GetItems(c *fiber.Ctx) error {
	itemsResponse := make([]dtos.ItemDataResponse, 0)

	items, err := h.itemSer.GetItems()
	if err != nil {
		return err
	}

	for _, item := range items {
		itemsResponse = append(itemsResponse, dtos.ItemDataResponse{
			ItemID:        item.ItemID,
			UserID:        item.UserID,
			Itemname:      item.Itemname,
			Description:   item.Description,
			ItemPic:       item.ItemPic,
			OfferType:     item.OfferType,
			AskedByUserID: item.AskedByUserID,
			AlreadyGave:   item.AlreadyGave,
		})
	}
	return c.JSON(itemsResponse)
}

func (h *itemHandler) GetItemByUserId(c *fiber.Ctx) error {

	userIDReceive, err := strconv.Atoi(c.Params("UserID"))

	itemsResponse := make([]dtos.ItemDataByUserIdResponse, 0)
	items, err := h.itemSer.GetItemByUserId(userIDReceive)
	if err != nil {
		return err
	}

	for _, item := range items {
		itemsResponse = append(itemsResponse, dtos.ItemDataByUserIdResponse{
			ItemID:        item.ItemID,
			UserID:        item.UserID,
			Itemname:      item.Itemname,
			Description:   item.Description,
			ItemPic:       item.ItemPic,
			OfferType:     item.OfferType,
			AskedByUserID: item.AskedByUserID,
			AlreadyGave:   item.AlreadyGave,
		})
	}
	return c.JSON(itemsResponse)
}

func (h *itemHandler) GetItemByItemId(c *fiber.Ctx) error {
	itemIDReceive, err := strconv.Atoi(c.Params("ItemID"))

	item, err := h.itemSer.GetItemByItemId(itemIDReceive)
	if err != nil {
		return err
	}

	itemResponse := dtos.ItemDataByItemIdResponse{
		ItemID:        item.ItemID,
		UserID:        item.UserID,
		Itemname:      item.Itemname,
		Description:   item.Description,
		ItemPic:       item.ItemPic,
		OfferType:     item.OfferType,
		AskedByUserID: item.AskedByUserID,
		AlreadyGave:   item.AlreadyGave,
	}

	return c.JSON(itemResponse)
}

//****************************************************************************

func (h *itemHandler) GetItemDetailsByItemId(c *fiber.Ctx) error {
	itemIDReceive, err := strconv.Atoi(c.Params("ItemID"))

	item, err := h.itemSer.GetItemDetailsByItemId(itemIDReceive)
	if err != nil {
		return err
	}

	itemResponse := dtos.ItemDetailsByItemIdResponse{
		ItemID:        item.ItemID,
		UserID:        item.UserID,
		Itemname:      item.Itemname,
		Description:   item.Description,
		ItemPic:       item.ItemPic,
		OfferType:     item.OfferType,
		AskedByUserID: item.AskedByUserID,
		AlreadyGave:   item.AlreadyGave,
	}

	return c.JSON(itemResponse)
}

//****************************************************************************

func (h *itemHandler) GetItemsOfCurrentUser(c *fiber.Ctx) error {
	// Extract the token from the request headers
	token := c.Get("Authorization")

	// Check if the token is empty
	if token == "" {
		return errors.New("token is missing")
	}

	// Extract the user ID from the token
	userID, err := utils.ExtractUserIDFromToken(strings.Replace(token, "Bearer ", "", 1), h.jwtSecret)
	if err != nil {
		return err
	}

	items, err := h.itemSer.GetItemsOfCurrentUser(userID)
	if err != nil {
		return err
	}

	itemsResponse := make([]dtos.ItemsOfCurrentUserResponse, 0)
	for _, item := range items {
		itemsResponse = append(itemsResponse, dtos.ItemsOfCurrentUserResponse{
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
		})
	}
	return c.JSON(itemsResponse)
}

func (h *itemHandler) PostAddItem(c *fiber.Ctx) error {
	// Extract the token from the request headers
	token := c.Get("Authorization")

	// Check if the token is empty
	if token == "" {
		return errors.New("token is missing")
	}

	// Extract the user ID from the token
	userIDExtract, err := utils.ExtractUserIDFromToken(strings.Replace(token, "Bearer ", "", 1), h.jwtSecret)
	if err != nil {
		return err
	}

	var request dtos.AddItemRequest
	if err := c.BodyParser(&request); err != nil {
		return err
	}

	// Check if a file is uploaded
	file, err := c.FormFile("file")
	if err != nil {
		return fiber.NewError(fiber.StatusBadRequest, "File not found")
	}

	// Call upload service to upload the file
	fileURL, err := h.uploadSer.UploadFile(file)
	if err != nil {
		return fiber.NewError(fiber.StatusInternalServerError, "Failed to upload file")
	}

	// Set the uploaded file URL in the registration request
	request.ItemPic = fileURL

	// Check if user_pic field is empty or nil
	if request.ItemPic == nil {
		return fiber.NewError(fiber.StatusBadRequest, "Item picture is required")
	}

	item, err := h.itemSer.PostAddItem(userIDExtract, request)
	if err != nil {
		return err
	}

	itemResponse := dtos.AddItemRequest{
		UserID:      item.UserID,
		Itemname:    item.Itemname,
		Description: item.Description,
		ItemPic:     item.ItemPic,
		OfferType:   item.OfferType,
	}

	return c.JSON(itemResponse)
}
