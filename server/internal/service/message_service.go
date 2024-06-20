package service

import (
	"github.com/gofiber/fiber/v2"
	"log"
	"needful/internal/entities"
	"needful/internal/repository"
)

type messageService struct {
	messageRepo repository.MessageRepository
}

func NewMessageService(messageRepo repository.MessageRepository) messageService {
	return messageService{messageRepo: messageRepo}
}

func (s messageService) GetMessages() ([]entities.Message, error) {
	messages, err := s.messageRepo.GetAllMessage()
	if err != nil {
		log.Println(err)
		return nil, err
	}

	messageResponses := []entities.Message{}
	for _, message := range messages {
		messageResponse := entities.Message{
			MsgID:            message.MsgID,
			SenderUserID:     message.SenderUserID,
			ReceiverUserID:   message.ReceiverUserID,
			MsgText:          message.MsgText,
			ConFromItemOwner: message.ConFromItemOwner,
			ConFromItemAsker: message.ConFromItemAsker,
		}
		messageResponses = append(messageResponses, messageResponse)
	}
	return messageResponses, nil
}

func (s messageService) GetMessageByUserId(userid int) ([]entities.Message, error) {
	messages, err := s.messageRepo.GetMessageByUserId(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	messageResponses := []entities.Message{}
	for _, message := range messages {
		messageResponse := entities.Message{
			MsgID:            message.MsgID,
			SenderUserID:     message.SenderUserID,
			ReceiverUserID:   message.ReceiverUserID,
			MsgText:          message.MsgText,
			ConFromItemOwner: message.ConFromItemOwner,
			ConFromItemAsker: message.ConFromItemAsker,
		}
		messageResponses = append(messageResponses, messageResponse)
	}
	return messageResponses, nil
}

func (s messageService) GetMessageByMsgId(messageid int) (*entities.Message, error) {
	message, err := s.messageRepo.GetMessageByMsgId(messageid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	if *message == (entities.Message{}) {
		return nil, fiber.NewError(fiber.StatusNotFound, "message doesn't exist")
	}

	messageResponse := entities.Message{
		MsgID:            message.MsgID,
		SenderUserID:     message.SenderUserID,
		ReceiverUserID:   message.ReceiverUserID,
		MsgText:          message.MsgText,
		ConFromItemOwner: message.ConFromItemOwner,
		ConFromItemAsker: message.ConFromItemAsker,
	}
	return &messageResponse, nil
}

func (s messageService) GetMessagePageOfCurrentUser(userid int) ([]entities.MessagePageOfCurrentUserResponse, error) {
	messages, err := s.messageRepo.GetMessagePageOfCurrentUser(userid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	messageResponses := []entities.MessagePageOfCurrentUserResponse{}
	for _, message := range messages {
		messageResponse := entities.MessagePageOfCurrentUserResponse{
			UserID:         message.UserID,
			Username:       message.Username,
			Firstname:      message.Firstname,
			Lastname:       message.Lastname,
			UserPic:        message.UserPic,
			MsgID:          message.MsgID,
			SenderUserID:   message.SenderUserID,
			ReceiverUserID: message.ReceiverUserID,
			MsgText:        message.MsgText,
		}
		messageResponses = append(messageResponses, messageResponse)
	}
	return messageResponses, nil
}

func (s messageService) GetConversationOfCurrentUserByOtherID(userid int, otherid int) ([]entities.ConversationOfCurrentUserByOtherIDResponse, error) {
	messages, err := s.messageRepo.GetConversationOfCurrentUserByOtherID(userid, otherid)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	messageResponses := []entities.ConversationOfCurrentUserByOtherIDResponse{}
	for _, message := range messages {
		messageResponse := entities.ConversationOfCurrentUserByOtherIDResponse{
			UserID:         message.UserID,
			Username:       message.Username,
			Firstname:      message.Firstname,
			Lastname:       message.Lastname,
			UserPic:        message.UserPic,
			MsgID:          message.MsgID,
			SenderUserID:   message.SenderUserID,
			ReceiverUserID: message.ReceiverUserID,
			MsgText:        message.MsgText,
		}
		messageResponses = append(messageResponses, messageResponse)
	}
	return messageResponses, nil
}
