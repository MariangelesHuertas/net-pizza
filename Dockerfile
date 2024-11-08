# Usa la imagen de .NET SDK 8 como base
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia los archivos de proyecto y restaura las dependencias
COPY . ./
RUN dotnet restore

# Publica la aplicación
RUN dotnet publish -c Release -o /app/publish

# Usa la imagen de ASP.NET Core para ejecutar la aplicación publicada
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Exponer el puerto en el que la aplicación se ejecutará
EXPOSE 5000

# Comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "BlazingPizza.dll"]
