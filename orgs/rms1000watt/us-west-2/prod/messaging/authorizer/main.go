package main

import (
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

// Handler processes the API Gateway proxy request
func Handler(request events.APIGatewayCustomAuthorizerRequestTypeRequest) (res events.APIGatewayCustomAuthorizerResponse, err error) {
	// Check request.Headers or something to authorize

	res = getRes()

	fmt.Println("Returning Policy")
	return
}

func getRes() (res events.APIGatewayCustomAuthorizerResponse) {
	res = events.APIGatewayCustomAuthorizerResponse{
		PolicyDocument: events.APIGatewayCustomAuthorizerPolicy{
			Version: "2012-10-17",
			Statement: []events.IAMPolicyStatement{
				{
					Effect:   "Allow",
					Action:   []string{"execute-api:Invoke"},
					Resource: []string{"*"},
				},
			},
		},
	}
	return
}

func main() {
	lambda.Start(Handler)
}
