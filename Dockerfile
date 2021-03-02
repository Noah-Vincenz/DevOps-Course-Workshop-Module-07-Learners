FROM mcr.microsoft.com/dotnet/sdk:5.0 as build-stage

RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs

WORKDIR /app
# want to explicitly copy into this directory and not use . so that we keep directory structure
COPY DotnetTemplate.Web DotnetTemplate.Web
COPY DotnetTemplate.Web.Tests DotnetTemplate.Web.Tests
COPY DotnetTemplate.sln .
RUN dotnet build
WORKDIR /app/DotnetTemplate.Web
RUN npm install && npm run build

FROM mcr.microsoft.com/dotnet/aspnet:5.0

WORKDIR /app
COPY --from=build-stage /app /app
WORKDIR /app/DotnetTemplate.Web
ENTRYPOINT ["./bin/Debug/net5.0/DotnetTemplate.Web"]
