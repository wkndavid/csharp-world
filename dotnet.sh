#!/bin/bash
set -e

# Script de instalação do .NET Core no Ubuntu
# Autor: David Jesus (Caianos)
# Data: 15/05/2025
# Este script instala o .NET Core SDK e ferramentas necessárias para desenvolvimento C# no Ubuntu

echo "🚀 Iniciando instalação do .NET Core no Ubuntu..."
echo "---------------------------------------------"

# Verificar se está rodando como root
if [ "$EUID" -ne 0 ] && [[ "$0" != *"sudo"* ]]; then
  echo "⚠️ Este script precisa ser executado como root ou com sudo."
  exit 1
fi

# Detectar a versão do Ubuntu
UBUNTU_VERSION=$(lsb_release -rs)
echo "🖥️ Versão do Ubuntu detectada: $UBUNTU_VERSION"

# Atualizar repositórios
echo "🔧 Atualizando pacotes..."
sudo apt update

# Instalar pré-requisitos
echo "📦 Instalando pré-requisitos..."
sudo apt install -y wget apt-transport-https ca-certificates software-properties-common

# Baixar e configurar o pacote Microsoft
echo "🌐 Baixando repositório da Microsoft..."
wget https://packages.microsoft.com/config/ubuntu/$UBUNTU_VERSION/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# Atualizar repositórios novamente com os pacotes Microsoft
echo "🔄 Atualizando pacotes após adicionar repositório..."
sudo apt update

# Instalar o SDK do .NET
echo "🧰 Instalando .NET SDK 8.0..."
sudo apt install -y dotnet-sdk-8.0

# Instalar o runtime do ASP.NET Core (opcional)
echo "🌐 Instalando ASP.NET Core Runtime 8.0..."
sudo apt install -y aspnetcore-runtime-8.0

# Instalar o runtime do .NET (opcional, já incluído no SDK)
echo "⚙️ Instalando .NET Runtime 8.0..."
sudo apt install -y dotnet-runtime-8.0

# Instalar dependências extras para ASP.NET/Blazor
echo "📚 Instalando dependências extras para ASP.NET/Blazor..."
sudo apt install -y libssl-dev libicu-dev zlib1g libkrb5-dev

# Instalar extensão C# no VS Code
echo "🧩 Instalando extensão C# no VS Code..."
code --install-extension ms-dotnettools.csharp

echo "✅ Instalação concluída com sucesso!"
echo "--------------------------------"

# Exibir versões instaladas
echo "🔍 Versão do .NET instalada:"
dotnet --version
echo "📋 SDKs do .NET instalados:"
dotnet --list-sdks
echo "🔧 Runtimes do .NET instalados:"
dotnet --list-runtimes

echo ""
echo "🚀 Para começar a desenvolver, execute os seguintes comandos como usuário normal (não root):"
echo "  dotnet new console -n MeuPrimeiroProjeto"
echo "  cd MeuPrimeiroProjeto"
echo "  dotnet run"
echo ""
echo "💡 Comandos úteis para desenvolvimento:"
echo "  dotnet new --list          # Lista todos os templates disponíveis"
echo "  dotnet new webapi -n MeuAPI           # Cria uma Web API"
echo "  dotnet new blazorserver -n MeuBlazor  # Cria um app Blazor Server"
echo "  dotnet new mvc -n MeuMVC              # Cria um app ASP.NET MVC"
echo "  dotnet add package [NomePacote]       # Adiciona um pacote NuGet"
echo "  dotnet sln [SLN] add [PROJ]           # Adiciona projeto à solução"
echo ""
echo "🎉 Feliz codificação!"
