package repository

import (
	"needful/internal/entities"

	"gorm.io/gorm"
)

type itemRepositoryDB struct {
	db *gorm.DB
}

func NewItemRepositoryDB(db *gorm.DB) itemRepositoryDB {
	return itemRepositoryDB{db: db}
}

func (r itemRepositoryDB) GetAllItem() ([]entities.Item, error) {
	items := []entities.Item{}
	result := r.db.Find(&items)
	if result.Error != nil {
		return nil, result.Error
	}
	return items, nil
}

func (r itemRepositoryDB) GetItemByUserId(userid int) ([]entities.Item, error) {
	items := []entities.Item{}
	result := r.db.Where("user_id = ?", userid).Find(&items)
	if result.Error != nil {
		return nil, result.Error
	}
	return items, nil
}

func (r itemRepositoryDB) GetItemByItemId(itemid int) (*entities.Item, error) {
	items := entities.Item{}
	result := r.db.Where("item_id = ?", itemid).Find(&items)
	if result.Error != nil {
		return nil, result.Error
	}
	return &items, nil
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

func (r itemRepositoryDB) GetItemDetailsByItemId(itemid int) (*entities.Item, error) {
	items := entities.Item{}
	result := r.db.Where("item_id = ?", itemid).Find(&items)
	if result.Error != nil {
		return nil, result.Error
	}
	return &items, nil
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

func (r itemRepositoryDB) GetAllItemOfCurrentUser(userid int) ([]entities.Item, error) {
	items := []entities.Item{}
	result := r.db.Where("user_id = ?", userid).Find(&items)
	if result.Error != nil {
		return nil, result.Error
	}
	return items, nil
}

func (r itemRepositoryDB) PostAddItem(item *entities.Item) error {
	result := r.db.Create(item)
	if result.Error != nil {
		return result.Error
	}
	return nil
}
