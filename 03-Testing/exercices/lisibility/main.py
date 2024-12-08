import requests
from original import nb_w

if __name__ == "__main__":
    response = requests.get("https://www.theatre-classique.fr/pages/txt/CORNEILLEP_CID.txt")
    if response.status_code != 200:
        print("Failed to load text")
        exit(1)
    text = response.text
    words = ["flamme", "colère", "ardeur", "raison", "victoire", "amour"]

    nb_words = nb_w(text, words)
    for word, count in nb_words.items():
        print(f"'{word}': {count} times")
