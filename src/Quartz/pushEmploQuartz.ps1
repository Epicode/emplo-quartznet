$ghToken = $Env:GITHUB_TOKEN

if ([string]::IsNullOrEmpty($ghToken)) {
    throw "GitHub token (GITHUB_TOKEN) is not set in environmental variables."
}

# 1. Pack the project first to create the .nupkg file
# This ensures you are pushing the latest build artifacts
dotnet pack .\Quartz.csproj -c Release -o ./.dist

# 2. Push the generated package
# We use a wildcard to grab the .nupkg from the output folder
dotnet nuget push ".\dist\*.nupkg" `
    --source "https://nuget.pkg.github.com/Epicode/index.json" `
    --api-key $ghToken `
    --skip-duplicate