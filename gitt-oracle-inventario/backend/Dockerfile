FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY backend/GittInventario.Domain/GittInventario.Domain.csproj backend/GittInventario.Domain/
COPY backend/GittInventario.Application/GittInventario.Application.csproj backend/GittInventario.Application/
COPY backend/GittInventario.Infrastructure/GittInventario.Infrastructure.csproj backend/GittInventario.Infrastructure/
COPY backend/GittInventario.Api/GittInventario.Api.csproj backend/GittInventario.Api/
RUN dotnet restore backend/GittInventario.Api/GittInventario.Api.csproj
COPY backend/ backend/
RUN dotnet publish backend/GittInventario.Api/GittInventario.Api.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app/publish .
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "GittInventario.Api.dll"]
