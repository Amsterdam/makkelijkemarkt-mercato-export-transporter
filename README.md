# Mercato Export transporter

Het Mercato systeem maakt export bestanden welke gebruikt worden door Makkelijke Markt en Decos. Mercato plaatst bestanden op een objectstore van Datapunt Gemeente Amsterdam.
Deze transporter applicatie heeft als doel de bestanden vanuit hier te ontdoen van de GPG/PGP versleuteling en door te sturen naar de Brievenbus van Gemeente Amsterdam t.b.v. Decos en de objectstore t.b.v. Makkelijke Markt.

# Hoe te gebruiken

Kopieer .env.dist naar .env en vul in .env de juiste waardes in voor de verschillende variabelen. De GPG public en private/secret sleutel moeten base64 encoded worden opgenomen (`cat private.key | base64 -w 0`)

Maak een Docker image

    docker build -t mercato-export-transporter .

Voer het export proces in `/app/main.sh` uit om het decrypten van bestanden en uploaden naar MakkelijkeMarkt en Brievenbus/Decos uit te voeren. Plaats dit commando bijvoorbeeld in een `cronjob`.

    docker run --env-file .env --rm mercato-export-transporter:latest /app/main.sh

# GPG sleutels vervangen

Indien de sleutels vervangen moeten worden onderneem de volgende stappen:

    gpg --gen-key
    gpg --list-secret-keys
    gpg --list-keys
    gpg --export-secret-key -a "uid" > private.gpg
    gpg --export -a "uid" > public.gpg

Tip: Om snel veel entropie te genereren indien nodig voer in een separate shell `dd if=/dev/sda of=/dev/zero` of gebruik `rndg`
