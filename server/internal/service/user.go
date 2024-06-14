package service

import (
	"needful/internal/dtos"
	"needful/internal/entities"
)

type UserService interface {
	GetUsers() ([]entities.User, error)
	GetUserById(int) (*entities.User, error)
	GetUserByToken(int) (*entities.User, error)

	////////////////////////////////////////////////////////////////////

	GetCurrentUser(int) (*entities.User, error)
	GetProfileOfCurrentUserById(int) (*entities.User, error)

	GetEditUserProfileById(int) (*entities.User, error)
	PatchEditUserProfileById(int, dtos.EditUserProfileByIdRequest) (*entities.User, error)

	Register(request dtos.RegisterRequest) (*dtos.UserResponse, error)
	Login(request dtos.LoginRequest, jwtSecret string) (*dtos.LoginResponse, error)
}
