package main

import (
	"encoding/json"
	"net/http"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

// Player represents a player in the game
type Player struct {
	ID        string      `json:"id"`
	Username  string      `json:"username"`
	Location  GeoLocation `json:"location,omitempty"`
	Birthdate string      `json:"birthdate,omitempty"`
	Avatar    string      `json:"avatar,omitempty"`
	Score     int         `json:"score"`
}

// GeoLocation represents a geographic location
type GeoLocation struct {
	Latitude         float64 `json:"latitude"`
	Longitude        float64 `json:"longitude"`
	Accuracy         float64 `json:"accuracy,omitempty"`
	Altitude         float64 `json:"altitude,omitempty"`
	AltitudeAccuracy float64 `json:"altitudeaccuracy,omitempty"`
}

// Handler handles incoming API Gateway requests
func Handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	switch request.HTTPMethod {
	case "GET":
		return handleGetPlayers()
	case "POST":
		return handleCreatePlayer(request)
	default:
		return events.APIGatewayProxyResponse{
			StatusCode: http.StatusMethodNotAllowed,
			Body:       "Method not allowed",
		}, nil
	}
}

// handleGetPlayers handles GET /players
func handleGetPlayers() (events.APIGatewayProxyResponse, error) {
	players := []Player{
		{ID: "1", Username: "Player1", Score: 1000},
		{ID: "2", Username: "Player2", Score: 1500},
	}

	body, err := json.Marshal(players)
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusInternalServerError}, err
	}

	return events.APIGatewayProxyResponse{
		StatusCode: http.StatusOK,
		Body:       string(body),
	}, nil
}

// handleCreatePlayer handles POST /players
func handleCreatePlayer(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	var player Player
	err := json.Unmarshal([]byte(request.Body), &player)
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusBadRequest}, err
	}

	player.ID = "new-id" // Generate a new ID for the player
	responseBody, err := json.Marshal(player)
	if err != nil {
		return events.APIGatewayProxyResponse{StatusCode: http.StatusInternalServerError}, err
	}

	return events.APIGatewayProxyResponse{
		StatusCode: http.StatusCreated,
		Body:       string(responseBody),
	}, nil
}

func main() {
	lambda.Start(Handler)
}
