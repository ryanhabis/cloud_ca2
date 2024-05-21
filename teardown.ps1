# Define stack name
$stackName = "stack"

try {
    # Delete stack
    aws cloudformation delete-stack --stack-name $stackName
    Write-Output "Deletion of the stack initiated. Please wait..."
}
catch {
    Write-Output "Failed to delete the stack: $_"
    exit 1
}

try {
    # Wait for stack deletion to complete
    Write-Output "Stack deletion completed successfully."
}
catch {
    Write-Output "Failed to delete the stack: $_"
    exit 1
}
aws cloudformation wait stack-delete-complete --stack-name $stackName
