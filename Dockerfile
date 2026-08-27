# Usa a imagem oficial do OpenResty baseada em Debian (Super Estável)
FROM openresty/openresty:bullseye

# Instala o gerenciador LuaRocks e dependências básicas de compilação
RUN apt-get update && apt-get install -y \
    luarocks \
    build-essential \
    libssl-dev

# Instala o framework Lapis
RUN luarocks install lapis

# Define a pasta do projeto dentro da nuvem
WORKDIR /app

# Copia os arquivos da sua Wiki
COPY . .

# Libera a porta de internet padrão
EXPOSE 80

# Inicia o servidor do site
CMD ["lapis", "server"]
