# Usa uma imagem oficial do OpenResty com LuaRocks já instalada
FROM openresty/openresty:alpine

# Instala o framework Lapis e dependências de rede
RUN apk add --no-cache openssl-dev build-base \
    && luarocks install lapis

# Cria a pasta do site dentro do servidor da nuvem
WORKDIR /app

# Copia os arquivos da sua pasta no PC para dentro da nuvem
COPY . .

# Expõe a porta de internet que configuramos
EXPOSE 80

# Comando para iniciar o site de forma definitiva
CMD ["lapis", "server"]
