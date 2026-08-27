# Usa o Ubuntu oficial como base estável
FROM ubuntu:22.04

# Evita perguntas travando a instalação no terminal
ENV DEBIAN_FRONTEND=noninteractive

# Instala ferramentas básicas e dependências de compilação
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    build-essential \
    libssl-dev \
    luarocks

# Baixa a chave oficial do OpenResty usando o formato moderno de segurança
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://openresty.org | gpg --dearmor -o /etc/apt/keyrings/openresty.gpg

# Adiciona o repositório correto linkado à chave segura
RUN echo "deb [signed-by=/etc/apt/keyrings/openresty.gpg] http://openresty.org jammy main" | tee /etc/apt/sources.list.d/openresty.list

# Atualiza a lista e instala o OpenResty
RUN apt-get update && apt-get install -y openresty

# Garante que o comando openresty fique visível globalmente no sistema
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
