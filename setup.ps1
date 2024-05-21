# Define variables
$stackName = "stack"
$templateFile = "system.yml"

try {
    # Create stack
    aws cloudformation create-stack --stack-name $stackName --template-body file://$templateFile --capabilities CAPABILITY_IAM
    Write-Output "The creation of the stack is starting."
}
catch {
    Write-Output "Stage 1 - Failed to create the stack: $_"
    exit 1
}

try {
    # Wait for stack creation to complete
    aws cloudformation wait stack-create-complete --stack-name $stackName
    Write-Output "Stack has been made."
}
catch {
    Write-Output "Stage 2 - Failed to create the stack: $_"
    exit 1
}

try {
    # Get outputs from stack
    $stackOutputs = aws cloudformation describe-stacks --stack-name $stackName --query "Stacks[0].Outputs"

}
catch {
    Write-Output "Stage 3 - Failed to retrive the stack output: $_"
    exit 1
}

# Display outputs
Write-Host "Stack outputs:"
$stackOutputs | ConvertFrom-Json | ForEach-Object {
    Write-Host "$($_.OutputKey): $($_.OutputValue)"
}
