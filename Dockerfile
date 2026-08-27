# Usa uma imagem do OpenResty que já vem com LuaRocks instalado de fábrica
FROM mileschou/openresty:alpine

# Instala as dependências de criptografia necessárias para o Lapis
RUN apk add --no-cache openssl-dev build-base

# Instala o framework Lapis
RUN luarocks install lapis

# Cria e define a pasta do projeto
WORKDIR /app

# Copia os arquivos do repositório para o servidor
COPY . .

# Libera a porta de internet
EXPOSE 80

# Inicia o servidor do site
CMD ["lapis", "server"]
