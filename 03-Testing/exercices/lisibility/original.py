def nb_w(t, words):
    nb = {}
    for w in t.split():
        if w in words:
            if w not in nb:
                nb[w] = 0
            nb[w] += 1
    return nb
