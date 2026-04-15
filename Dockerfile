FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app
COPY Portfolio/Portfolio.csproj ./Portfolio/
COPY Portfolio/ ./Portfolio/
RUN cd Portfolio && dotnet restore && dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "Portfolio.dll"]
