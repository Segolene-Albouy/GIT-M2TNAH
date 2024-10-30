import time
import requests
from functools import wraps


def measure_time(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()
        execution_time = end_time - start_time
        print(f"\nTemps d'exécution: {execution_time:.3f} secondes")
        return result

    return wrapper


def get_text(url):
    response = requests.get(url)
    if response.status_code == 200:
        return response.text
    return "Erreur lors de la récupération du texte."

