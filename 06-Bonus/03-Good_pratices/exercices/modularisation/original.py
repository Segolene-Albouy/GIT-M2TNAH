def f(x):
    # fait plein de calculs sur les notes
    res = 0
    nb = 0
    min = 20
    max = 0
    for n in x:
        if n >= 0 and n <= 20:
            res = res + n
            nb = nb + 1
            if n < min:
                min = n
            if n > max:
                max = n

    print("Résultats de la classe :")
    print("------------------------")

    m = res / nb
    print(f"Moyenne : {m}")
    print(f"Note minimale : {min}")
    print(f"Note maximale : {max}")

    print("\nDétail des notes :")
    for n in x:
        if n >= 0 and n <= 20:
            if n >= 10:
                print(f"- {n}/20 (Réussite)")
            else:
                print(f"- {n}/20 (Échec)")

    nb_pass = 0
    for n in x:
        if n >= 0 and n <= 20:
            if n >= 10:
                nb_pass = nb_pass + 1

    p = (nb_pass / nb) * 100
    print(f"\nTaux de réussite : {p}%")

    return m, min, max, p


# utilisation
notes = [15, 12, 8, 16, 9, 13, 7, 14]
resultat = f(notes)
