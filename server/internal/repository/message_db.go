package repository

import (
	"gorm.io/gorm"
	"needful/internal/entities"
)

type messageRepositoryDB struct {
	db *gorm.DB
}

func NewMessageRepositoryDB(db *gorm.DB) messageRepositoryDB {
	return messageRepositoryDB{db: db}
}

func (r messageRepositoryDB) GetAllMessage() ([]entities.Message, error) {
	messages := []entities.Message{}
	result := r.db.Find(&messages)
	if result.Error != nil {
		return nil, result.Error
	}
	return messages, nil
}

func (r messageRepositoryDB) GetMessageByUserId(userid int) ([]entities.Message, error) {
	messages := []entities.Message{}
	result := r.db.Where("sender_user_id = ? OR receiver_user_id = ?", userid, userid).Find(&messages)
	if result.Error != nil {
		return nil, result.Error
	}
	return messages, nil
}

func (r messageRepositoryDB) GetMessageByMsgId(messageid int) (*entities.Message, error) {
	messages := entities.Message{}
	result := r.db.Where("msg_id = ?", messageid).Find(&messages)
	if result.Error != nil {
		return nil, result.Error
	}
	return &messages, nil
}
