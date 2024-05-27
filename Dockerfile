FROM mcr.microsoft.com/dotnet/sdk:6.0 as build
WORKDIR /app

# Copy the project file and restore any dependencies (use .csproj for the project name)
COPY *.csproj ./
RUN dotnet restore

COPY . .

RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0 as runtine
WORKDIR /app
COPY --from=build /app/out ./

EXPOSE 80
EXPOSE 5024

# Start the application
ENTRYPOINT ["dotnet", "simple-dotnet-api.dll"]