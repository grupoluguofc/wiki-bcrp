# Usa o Ubuntu oficial como base estável
FROM ubuntu:22.04

# Evita perguntas travando a instalação no terminal
ENV DEBIAN_FRONTEND=noninteractive

# Instala as ferramentas básicas, OpenResty e LuaRocks
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    build-essential \
    libssl-dev \
    luarocks \
    && curl -fsSL https://openresty.org | apt-key add - \
    && echo "deb http://openresty.org jammy main" | tee /etc/apt/sources.list.d/openresty.list \
    && apt-get update && apt-get install -y openresty

# Garante que o comando openresty fique visível globalmente
RUN ln -s /usr/local/openresty/bin/openresty /usr/bin/openresty

# Instala o framework Lapis
RUN luarocks install lapis

# Define a pasta do projeto
WORKDIR /app

# Copia os seus arquivos da Wiki
COPY . .

# Libera a porta de internet
EXPOSE 80

# Inicia o servidor do site
CMD ["lapis", "server"]
