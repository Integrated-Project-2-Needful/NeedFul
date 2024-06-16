package handler

import (
	"github.com/gofiber/fiber/v2"
	"needful/internal/dtos"
	"needful/internal/service"
	"strconv"
)

type messageHandler struct {
	messageSer service.MessageService
	jwtSecret  string
	uploadSer  service.UploadService
}

func NewMessageHandler(messageSer service.MessageService, jwtSecret string) messageHandler {
	return messageHandler{messageSer: messageSer, jwtSecret: jwtSecret}
}

func (h *messageHandler) GetMessages(c *fiber.Ctx) error {
	messagesResponse := make([]dtos.MessageDataResponse, 0)

	messages, err := h.messageSer.GetMessages()
	if err != nil {
		return err
	}

	for _, message := range messages {
		messagesResponse = append(messagesResponse, dtos.MessageDataResponse{
			MsgID:            message.MsgID,
			SenderUserID:     message.SenderUserID,
			ReceiverUserID:   message.ReceiverUserID,
			MsgText:          message.MsgText,
			ConFromItemOwner: message.ConFromItemOwner,
			ConFromItemAsker: message.ConFromItemAsker,
		})
	}
	return c.JSON(messagesResponse)
}

func (h *messageHandler) GetMessageByUserId(c *fiber.Ctx) error {

	userIDReceive, err := strconv.Atoi(c.Params("UserID"))

	messagesResponse := make([]dtos.MessageDataByUserIdResponse, 0)
	message, err := h.messageSer.GetMessageByUserId(userIDReceive)
	if err != nil {
		return err
	}

	for _, message := range message {
		messagesResponse = append(messagesResponse, dtos.MessageDataByUserIdResponse{
			MsgID:            message.MsgID,
			SenderUserID:     message.SenderUserID,
			ReceiverUserID:   message.ReceiverUserID,
			MsgText:          message.MsgText,
			ConFromItemOwner: message.ConFromItemOwner,
			ConFromItemAsker: message.ConFromItemAsker,
		})
	}
	return c.JSON(messagesResponse)
}

func (h *messageHandler) GetMessageByMsgId(c *fiber.Ctx) error {
	messageIDReceive, err := strconv.Atoi(c.Params("MsgID"))

	message, err := h.messageSer.GetMessageByMsgId(messageIDReceive)
	if err != nil {
		return err
	}

	messageResponse := dtos.MessageDataByMsgIdResponse{
		MsgID:            message.MsgID,
		SenderUserID:     message.SenderUserID,
		ReceiverUserID:   message.ReceiverUserID,
		MsgText:          message.MsgText,
		ConFromItemOwner: message.ConFromItemOwner,
		ConFromItemAsker: message.ConFromItemAsker,
	}

	return c.JSON(messageResponse)
}
