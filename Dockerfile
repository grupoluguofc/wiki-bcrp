# Usa a imagem oficial do LuaRocks rodando sobre o Linux Alpine
FROM luarocks/luarocks:3.11.1-alpine3.19

# Instala o OpenResty e dependências de compilação do sistema
RUN apk add --no-cache openresty openresty-tools openssl-dev build-base

# Instala o framework Lapis
RUN luarocks install lapis

# Define a pasta do projeto
WORKDIR /app

# Copia os arquivos do seu site
COPY . .

# Libera a porta de internet
EXPOSE 80

# Inicia o servidor do site
CMD ["lapis", "server"]
