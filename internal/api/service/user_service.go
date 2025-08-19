package service

import "gluten/internal/db"

type UserService struct {
	Querier *db.Queries
}
