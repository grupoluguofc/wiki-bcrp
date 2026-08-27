local lapis = require("lapis")
local app = lapis.Application()

app:enable("etlua")

-- Desliga o layout padrão do Lapis para usarmos o nosso próprio HTML completo
app.layout = false 

-- Rota principal: carrega o arquivo views/index.etlua
app:get("/", function(_)
  return { render = "index" }
end)

-- Rota dinâmica para os artigos da Wiki
app:get("/wiki/:slug", function(self)
  local artigo = self.params.slug
  
  -- Exemplo simples de resposta baseada no botão clicado
  if artigo == "regras" then
    return "<h1>Regras do Blox City RP</h1><p>1. Proibido VDM/RDM... (Adicione suas regras aqui)</p><br><a href='/'>Voltar</a>"
  elseif artigo == "comandos" then
    return "<h1>Comandos do Servidor</h1><p>/me, /do, /anuncio... (Adicione seus comandos aqui)</p><br><a href='/'>Voltar</a>"
  else
    return "<h1>Artigo não encontrado</h1><a href='/'>Voltar</a>"
  end
end)

return app
