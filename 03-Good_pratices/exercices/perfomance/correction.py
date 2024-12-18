from utils import timer, get_text

from collections import Counter
from typing import Dict

# Constants
FREQUENT_WORD_THRESHOLD = 5
SENTENCE_ENDINGS = {".", "!", "?"}


class TextAnalyzer:
    def __init__(self, text: str):
        self.text = text
        # Pré-calcul des données dont on aura besoin plusieurs fois
        self.words = text.split()
        self.word_counts = Counter(word.lower() for word in self.words)
        self.frequent_words = {
            word
            for word, count in self.word_counts.items()
            if count > FREQUENT_WORD_THRESHOLD
        }
        # Nettoie les mots une seule fois
        self.clean_words = {
            word: "".join(c for c in word if c.isalpha()) for word in self.words
        }

    @timer
    def count_sentences(self) -> int:
        """Compte le nombre de phrases dans le texte."""
        return sum(1 for char in self.text if char in SENTENCE_ENDINGS)

    @timer
    def get_word_count(self) -> int:
        """Retourne le nombre total de mots."""
        return len(self.words)

    @timer
    def get_frequent_words(self) -> Dict[str, int]:
        """Retourne les mots fréquents et leur nombre d'occurrences."""
        return {
            word: count
            for word, count in self.word_counts.items()
            if count > FREQUENT_WORD_THRESHOLD
        }

    @timer
    def calculate_avg_length(self) -> float:
        """Calcule la longueur moyenne des mots non fréquents."""
        non_frequent_words = [
            word for word in self.words if word.lower() not in self.frequent_words
        ]
        if not non_frequent_words:
            return 0
        return sum(len(word) for word in non_frequent_words) / len(non_frequent_words)

    @timer
    def find_longest_word(self) -> str:
        """Trouve le plus long mot (après nettoyage des caractères spéciaux)."""
        return max(self.clean_words.values(), key=len, default="")


@timer
def analyze_text(content: str) -> None:
    """Analyse un fichier texte et affiche les statistiques."""
    # Crée une seule instance qui maintient les données pré-calculées
    analyzer = TextAnalyzer(content)

    # Collecte toutes les statistiques
    stats = {
        "word_count": analyzer.get_word_count(),
        "sentence_count": analyzer.count_sentences(),
        "frequent_words": analyzer.get_frequent_words(),
        "avg_length": analyzer.calculate_avg_length(),
        "longest_word": analyzer.find_longest_word(),
    }

    # Affichage des résultats
    print(f"Nombre de mots: {stats['word_count']}")
    print(f"Nombre de phrases: {stats['sentence_count']}")

    print("\nMots fréquents:")
    for word, count in stats["frequent_words"].items():
        print(f"'{word}': {count} fois")

    print(
        f"\nLongueur moyenne des mots (hors mots fréquents): {stats['avg_length']:.1f}"
    )
    print(f"Plus long mot: {stats['longest_word']}")


if __name__ == "__main__":
    le_cid = get_text("https://www.theatre-classique.fr/pages/txt/CORNEILLEP_CID.txt")
    print("Analyse du texte avec l'algorithme optimisé...")
    analyze_text(le_cid)
