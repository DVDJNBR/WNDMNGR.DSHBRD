# Utilisation de l'image officielle Metabase
FROM metabase/metabase:latest

# Exposition du port 3000 (standard pour Metabase)
EXPOSE 3000

# Metabase se lance automatiquement via l'ENTRYPOINT de l'image de base
