import requests
from pathlib import Path

current_dir = Path(__file__).parent


def download_img(width, nb_img, saving_dir):
    url = f"https://digi.vatlib.it/iiifimage/MSS_Vat.gr.1087/Vat.gr.1087_000{nb_img}.jp2/full/{width},/0/default.jpg"
    response = requests.get(url)
    if response.status_code == 200:
        with open(saving_dir / f"image{nb_img}.jpg", "wb") as f:
            f.write(response.content)
    print(f"Image {nb_img} téléchargée avec une largeur de {width} pixels")


download_img(300, 1, current_dir)
download_img(600, 2, current_dir)
download_img(1200, 3, current_dir)
download_img(1500, 4, current_dir)
