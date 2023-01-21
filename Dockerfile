FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
EXPOSE 5001
EXPOSE 5000
WORKDIR /src
COPY ["./GatewayAPI/GatewayAPI.csproj", "GatewayAPI/"]
RUN dotnet restore "GatewayAPI/GatewayAPI.csproj"
COPY . .
WORKDIR "/src/GatewayAPI"
RUN dotnet dev-certs https --clean
RUN dotnet dev-certs https --verbose
RUN dotnet dev-certs https --trust
RUN dotnet build "GatewayAPI.csproj" -c Release -o /app/build
RUN dotnet publish "GatewayAPI.csproj" -c Release -o /app/publish /p:UseAppHost=false
WORKDIR /app
ENTRYPOINT ["dotnet", "run"]