FROM mcr.microsoft.com/dotnet/sdk:5.0

RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs \
    && mkdir DotnetTemplate.Web

WORKDIR /app
COPY DotnetTemplate.Web DotnetTemplate.Web
COPY DotnetTemplate.Web.Tests DotnetTemplate.Web.Tests
COPY DotnetTemplate.sln .
RUN dotnet build
WORKDIR /app/DotnetTemplate.Web
RUN npm install && npm run build

ENTRYPOINT ["dotnet", "run"]
