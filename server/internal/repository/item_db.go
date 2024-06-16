package repository

import (
	"needful/internal/dtos"
	"needful/internal/entities"
	"needful/internal/utils/v"

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

//func (r itemRepositoryDB) GetAllItemOfCurrentUser(userid int) ([]dtos.ItemsOfCurrentUserResponse, error) {
//	items := []dtos.ItemsOfCurrentUserResponse{}
//	result := r.db.
//		Table("items").
//		Select(`
//			items.*,
//			users.username,
//			users.user_pic,
//			(SELECT u.username FROM users u WHERE u.user_id = items.asked_by_user_id) AS username_asked_by_user_id
//		`).
//		Joins("JOIN users ON items.user_id = users.user_id").
//		Where("users.user_id = ?", userid).
//		Find(&items)
//	if result.Error != nil {
//		return nil, result.Error
//	}
//	return items, nil
//}

func (r itemRepositoryDB) GetAllItemOfCurrentUser(userid int) ([]dtos.ItemsOfCurrentUserResponse, error) {
	var items []struct {
		dtos.ItemsOfCurrentUserResponse
		UsernameOfAskedByUserID string
	}
	result := r.db.
		Table("items").
		Select(`
            items.*,
            users.username,
            users.user_pic,
            (SELECT username FROM users WHERE user_id = items.asked_by_user_id) AS username_of_asked_by_user_id
        `).
		Joins("JOIN users ON items.user_id = users.user_id").
		Where("users.user_id = ?", userid).
		Find(&items)
	if result.Error != nil {
		return nil, result.Error
	}
	// Merge the nested field into the main struct
	for i, item := range items {
		items[i].ItemsOfCurrentUserResponse.UsernameOfAskedByUserID = v.Ptr(item.UsernameOfAskedByUserID)
	}
	// Convert to the desired response type
	var itemsResponse []dtos.ItemsOfCurrentUserResponse
	for _, item := range items {
		itemsResponse = append(itemsResponse, item.ItemsOfCurrentUserResponse)
	}
	return itemsResponse, nil
}

func (r itemRepositoryDB) GetDonateItemsOfCurrentUser(userid int) ([]dtos.DonateItemsOfCurrentUserResponse, error) {
	var items []struct {
		dtos.DonateItemsOfCurrentUserResponse
		UsernameOfAskedByUserID string
	}
	result := r.db.
		Table("items").
		Select(`
            items.*,
            users.username,
            users.user_pic,
            (SELECT username FROM users WHERE user_id = items.asked_by_user_id) AS username_of_asked_by_user_id
        `).
		Joins("JOIN users ON items.user_id = users.user_id").
		Where("users.user_id = ?", userid).Where("offer_type = ?", "Donate").
		Find(&items)
	if result.Error != nil {
		return nil, result.Error
	}
	// Merge the nested field into the main struct
	for i, item := range items {
		items[i].DonateItemsOfCurrentUserResponse.UsernameOfAskedByUserID = v.Ptr(item.UsernameOfAskedByUserID)
	}
	// Convert to the desired response type
	var itemsResponse []dtos.DonateItemsOfCurrentUserResponse
	for _, item := range items {
		itemsResponse = append(itemsResponse, item.DonateItemsOfCurrentUserResponse)
	}
	return itemsResponse, nil
}

func (r itemRepositoryDB) GetReceiveItemsOfCurrentUser(userid int) ([]dtos.ReceiveItemsOfCurrentUserResponse, error) {
	var items []struct {
		dtos.ReceiveItemsOfCurrentUserResponse
		UsernameOfAskedByUserID string
	}
	result := r.db.
		Table("items").
		Select(`
            items.*,
            users.username,
            users.user_pic,
            (SELECT username FROM users WHERE user_id = items.asked_by_user_id) AS username_of_asked_by_user_id
        `).
		Joins("JOIN users ON items.user_id = users.user_id").
		Where("users.user_id = ?", userid).Where("offer_type = ?", "Receive").
		Find(&items)
	if result.Error != nil {
		return nil, result.Error
	}
	// Merge the nested field into the main struct
	for i, item := range items {
		items[i].ReceiveItemsOfCurrentUserResponse.UsernameOfAskedByUserID = v.Ptr(item.UsernameOfAskedByUserID)
	}
	// Convert to the desired response type
	var itemsResponse []dtos.ReceiveItemsOfCurrentUserResponse
	for _, item := range items {
		itemsResponse = append(itemsResponse, item.ReceiveItemsOfCurrentUserResponse)
	}
	return itemsResponse, nil
}

func (r itemRepositoryDB) PostAddItem(item *entities.Item) error {
	result := r.db.Create(item)
	if result.Error != nil {
		return result.Error
	}
	return nil
}

func (r itemRepositoryDB) DeleteItemByItemID(itemid int) error {
	items := entities.Item{}
	result := r.db.Where("item_id = ?", itemid).Unscoped().Delete(&items)
	if result.Error != nil {
		return result.Error
	}
	return nil
}
