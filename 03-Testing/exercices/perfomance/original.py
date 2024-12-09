from utils import timer, get_text


@timer
@log_exception
def analyze_text(path):
    # lit le fichier et fait des stats
    f = open(path, "r", encoding="utf-8")
    content = f.read()
    f.close()

    # compte les mots
    words = content.split()
    print(f"Nombre de mots: {len(words)}")

    # compte les phrases
    sentences = 0
    for c in content:
        if c == "." or c == "!" or c == "?":
            sentences += 1
    print(f"Nombre de phrases: {sentences}")

    # cherche les mots fréquents
    frequent = []
    for w in words:
        count = 0
        # recompte chaque mot à chaque fois
        for other_w in words:
            if w.lower() == other_w.lower():
                count += 1
        if count > 5:  # cherche les mots qui apparaissent plus de 5 fois
            # vérifie à chaque fois si le mot est déjà dans la liste
            already_in = False
            for existing in frequent:
                if existing.lower() == w.lower():
                    already_in = True
            if not already_in:
                frequent.append(w)

    print("\nMots fréquents:")
    for w in frequent:
        # recompte encore une fois pour l'affichage
        count = 0
        for check_w in words:
            if w.lower() == check_w.lower():
                count += 1
        print(f"'{w}': {count} fois")

    # calcule la longueur moyenne des mots
    total_length = 0
    for w in words:
        # recalcule pour chaque mot s'il est dans les fréquents
        is_frequent = False
        for f in frequent:
            if w.lower() == f.lower():
                is_frequent = True
        # ne compte que les mots non fréquents
        if not is_frequent:
            total_length += len(w)

    # recompte encore une fois les mots non fréquents
    normal_words = 0
    for w in words:
        is_frequent = False
        for f in frequent:
            if w.lower() == f.lower():
                is_frequent = True
        if not is_frequent:
            normal_words += 1

    if normal_words > 0:
        avg_length = total_length / normal_words
        print(f"\nLongueur moyenne des mots (hors mots fréquents): {avg_length:.1f}")

    # trouve le plus long mot
    longest = ""
    for w in words:
        # vérifie à chaque fois tous les caractères spéciaux
        clean_word = ""
        for c in w:
            if c.isalpha():
                clean_word += c
        if len(clean_word) > len(longest):
            longest = clean_word

    print(f"Plus long mot: {longest}")


if __name__ == "__main__":
    sample_text = get_text(
        "https://www.theatre-classique.fr/pages/txt/CORNEILLEP_CID.txt"
    )
    with open("temp.txt", "w", encoding="utf-8") as f:
        f.write(sample_text)

    print("Analyse du texte avec l'algorithme non optimisé...")
    analyze_text("temp.txt")
