FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
ENV ASPNETCORE_ENVIRONMENT=Development
ENV ASPNETCORE_URLS=https://+:443;http://+:80
ENV ASPNETCORE_Kestrel__Certificates__Default__Password=password
ENV ASPNETCORE_Kestrel__Certificates__Default__Path=/https/PruebaDocker.pfx

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
ENTRYPOINT ["dotnet", "PruebaDocker.dll"]
