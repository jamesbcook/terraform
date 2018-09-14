output "InvokeURL" {
    value = "${aws_api_gateway_deployment.TempDeployment.invoke_url}/${aws_api_gateway_resource.TempResource.path_part}"
}