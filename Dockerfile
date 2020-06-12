FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY ["PruebaDocker.csproj", ""]
RUN dotnet restore "./PruebaDocker.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "PruebaDocker.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "PruebaDocker.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
#ENV ASPNETCORE_URLS http://*:$PORT
ENTRYPOINT ["dotnet", "PruebaDocker.dll","--server.urls"]
