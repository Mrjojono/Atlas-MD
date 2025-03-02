# Utilisez une image de base avec Node.js LTS et Debian Buster
FROM node:16-buster

# Définissez le répertoire de travail
WORKDIR /app

# Installez les dépendances système nécessaires
RUN apt-get update && \
    apt-get install -y \
    ffmpeg \
    imagemagick \
    webp && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

# Installez Yarn globalement
RUN npm install -g yarn

# Copiez les fichiers de dépendances
COPY package.json .
COPY yarn.lock .

# Installez les dépendances du projet avec Yarn
RUN yarn install --frozen-lockfile

# Copiez le reste de l'application
COPY . .

# Exposez le port nécessaire (remplacez 3000 par le port utilisé par votre application)
EXPOSE 3000

# Démarrez l'application avec PM2
CMD ["pm2-runtime", "start", "index.js"]  # Remplacez "index.js" par le point d'entrée de votre application
