import requests
from pathlib import Path

current_dir = Path(__file__).parent

NB, WIDTH = 1, 300
img = f"https://digi.vatlib.it/iiifimage/MSS_Vat.gr.1087/Vat.gr.1087_000{NB}.jp2/full/{WIDTH},/0/default.jpg"

# Télécharger une image en petit format
response = requests.get("https://digi.vatlib.it/iiifimage/MSS_Vat.gr.1087/Vat.gr.1087_0001.jp2/full/300,/0/default.jpg")
if response.status_code == 200:
    with open(current_dir / "image1.jpg", "wb") as f:
        f.write(response.content)
print("Image 1 téléchargée avec une largeur de 300 pixels")

# Télécharger une autre image en moyen format
response = requests.get("https://digi.vatlib.it/iiifimage/MSS_Vat.gr.1087/Vat.gr.1087_0002.jp2/full/600,/0/default.jpg")
if response.status_code == 200:
    with open(current_dir / "image2.jpg", "wb") as f:
        f.write(response.content)
print("Image 2 téléchargée avec une largeur de 600 pixels")

# Télécharger une troisième image en grand format
response = requests.get("https://digi.vatlib.it/iiifimage/MSS_Vat.gr.1087/Vat.gr.1087_0003.jp2/full/1200,/0/default.jpg")
if response.status_code == 200:
    with open(current_dir / "image3.jpg", "wb") as f:
        f.write(response.content)
print("Image 3 téléchargée en grand format")
