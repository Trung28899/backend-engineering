import type { APIGatewayProxyHandlerV2 } from "aws-lambda";
import GoodByeService from "@services/GoodByeService";
import HelloService from "@services/HelloService";

console.log("hi how are you doing today?");
const goodbyeService = new GoodByeService();
const helloService = new HelloService();
// Payload formats
// https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations-lambda.html

export const handler: APIGatewayProxyHandlerV2 = async (event, ctx) => {
  console.log("Cloudwatch logs", event, ctx);

  helloService.sayHello();
  goodbyeService.sayGoodbye();

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "Hello from my amazing Lambda of destiny how are you doing!",
    }),
  };
};
