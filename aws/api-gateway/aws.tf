variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "remoteURI" {
    type    = "string"
    default = "https://ifconfig.co"
}


provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-2"
}

resource "aws_api_gateway_rest_api" "TempAPI" {
  name        = "TempAPI"
  description = "This API was created by Terraform"
}

resource "aws_api_gateway_resource" "TempResource" {
  rest_api_id = "${aws_api_gateway_rest_api.TempAPI.id}"
  parent_id   = "${aws_api_gateway_rest_api.TempAPI.root_resource_id}"
  path_part   = "api"
}

resource "aws_api_gateway_method" "TempMethod" {
  rest_api_id   = "${aws_api_gateway_rest_api.TempAPI.id}"
  resource_id   = "${aws_api_gateway_resource.TempResource.id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "200" {
  rest_api_id = "${aws_api_gateway_rest_api.TempAPI.id}"
  resource_id = "${aws_api_gateway_resource.TempResource.id}"
  http_method = "${aws_api_gateway_method.TempMethod.http_method}"
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "TempIntegrationResponse200" {
  rest_api_id = "${aws_api_gateway_rest_api.TempAPI.id}"
  resource_id = "${aws_api_gateway_resource.TempResource.id}"
  http_method = "${aws_api_gateway_method.TempMethod.http_method}"
  status_code = "${aws_api_gateway_method_response.200.status_code}"
}


resource "aws_api_gateway_integration" "TempIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.TempAPI.id}"
  resource_id = "${aws_api_gateway_resource.TempResource.id}"
  http_method = "${aws_api_gateway_method.TempMethod.http_method}"
  type        = "HTTP"
  uri         = "${var.remoteURI}"     
  integration_http_method = "ANY"
  passthrough_behavior    = "WHEN_NO_TEMPLATES"
}

resource "aws_api_gateway_deployment" "TempDeployment" {
  depends_on = ["aws_api_gateway_integration.TempIntegration"]

  rest_api_id = "${aws_api_gateway_rest_api.TempAPI.id}"
  stage_name  = "dev"
}