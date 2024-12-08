def count_word_occurrences(text: str, target_words: list[str]) -> dict[str, int]:
    """
    Count the occurrences of specific words in a given text.

    Args:
        text (str): The input text to analyze.
        target_words (list[str]): List of words to count in the text.

    Returns:
        dict[str, int]: A dictionary with words as keys and their counts as values.
    """
    word_counts = {}
    for word in text.split():
        if word in target_words:
            if word not in word_counts:
                word_counts[word] = 0
            word_counts[word] += 1
    return word_counts
