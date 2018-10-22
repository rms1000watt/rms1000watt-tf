package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/ses"
)

var (
	svcSES *ses.SES

	charSet = "UTF-8"
)

// Message is incoming from the website
type Message struct {
	Name    string `json:"name"`
	Email   string `json:"email"`
	Subject string `json:"subject"`
	Message string `json:"message"`
}

// Handler processes the API Gateway proxy request
func Handler(request events.APIGatewayProxyRequest) (res events.APIGatewayProxyResponse, err error) {
	fmt.Println("Start")
	defer fmt.Println("Done")

	msg := Message{}
	if err = json.Unmarshal([]byte(request.Body), &msg); err != nil {
		fmt.Println("Failed unmarshalling input:", err)
		return
	}

	fmt.Println("Email:", msg.Email)
	fmt.Println("Message:", msg.Message)

	if err = email(msg); err != nil {
		fmt.Println("Failed sending email:", err)
		return
	}

	res = events.APIGatewayProxyResponse{
		Body:       `{"success":true}`,
		StatusCode: http.StatusOK,
		Headers: map[string]string{
			"Access-Control-Allow-Origin": "*",
		},
	}

	return
}

func email(msg Message) (err error) {
	in := ses.SendEmailInput{
		Destination: &ses.Destination{
			ToAddresses: []*string{
				aws.String("rms1000watt@yahoo.com"),
			},
		},
		Message: &ses.Message{
			Subject: &ses.Content{
				Charset: aws.String(charSet),
				Data:    aws.String(msg.Subject),
			},
			Body: &ses.Body{
				Text: &ses.Content{
					Charset: aws.String(charSet),
					Data:    aws.String(msg.Message),
				},
			},
		},
		ReplyToAddresses: []*string{
			aws.String(msg.Email),
		},
		Source: aws.String("rms1000watt@yahoo.com"),
	}

	_, err = svcSES.SendEmail(&in)
	return
}

func main() {
	sess := session.New()
	svcSES = ses.New(sess)
	lambda.Start(Handler)
}
