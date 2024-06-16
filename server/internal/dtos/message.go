package dtos

type MessageDataResponse struct {
	MsgID            *uint   `json:"msg_id" validate:"required"`
	SenderUserID     *uint   `json:"sender_user_id" validate:"required"`
	ReceiverUserID   *uint   `json:"receiver_user_id" validate:"required"`
	MsgText          *string `json:"msg_text" validate:"required"`
	ConFromItemOwner *bool   `json:"con_from_item_owner" validate:"required"`
	ConFromItemAsker *bool   `json:"con_from_item_asker" validate:"required"`
}

type MessageDataByUserIdResponse struct {
	MsgID            *uint   `json:"msg_id" validate:"required"`
	SenderUserID     *uint   `json:"sender_user_id" validate:"required"`
	ReceiverUserID   *uint   `json:"receiver_user_id" validate:"required"`
	MsgText          *string `json:"msg_text" validate:"required"`
	ConFromItemOwner *bool   `json:"con_from_item_owner" validate:"required"`
	ConFromItemAsker *bool   `json:"con_from_item_asker" validate:"required"`
}

type MessageDataByMsgIdResponse struct {
	MsgID            *uint   `json:"msg_id" validate:"required"`
	SenderUserID     *uint   `json:"sender_user_id" validate:"required"`
	ReceiverUserID   *uint   `json:"receiver_user_id" validate:"required"`
	MsgText          *string `json:"msg_text" validate:"required"`
	ConFromItemOwner *bool   `json:"con_from_item_owner" validate:"required"`
	ConFromItemAsker *bool   `json:"con_from_item_asker" validate:"required"`
}
