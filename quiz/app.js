import {initializeApp} from 'https://www.gstatic.com/firebasejs/13.0.0/firebase-app.js';
import {
    getAuth,
    signInAnonymously,
    signInWithPopup,
    GoogleAuthProvider
} from 'https://www.gstatic.com/firebasejs/13.0.0/firebase-auth.js';
import {getDatabase, ref, onValue, set} from 'https://www.gstatic.com/firebasejs/13.0.0/firebase-database.js';

const FIREBASE_CONFIG = {
    apiKey: "AIzaSyBz5sBEWFdorlchg5zIIRHOHDrLPh1Ig7Y",
    authDomain: "course-quizz.firebaseapp.com",
    projectId: "course-quizz",
    storageBucket: "course-quizz.firebasestorage.app",
    messagingSenderId: "938684445854",
    appId: "1:938684445854:web:920d59943bc7f30339378f",
    databaseURL: 'https://course-quizz-default-rtdb.europe-west1.firebasedatabase.app/',
};

const params = new URLSearchParams(location.search);
const quizId = params.get('quiz');
const isHost = params.has('host');
const startAt = isHost && params.has('q') ? params.get('q') - 1 : null;

if (params.has('q')) {
    params.delete('q');
    history.replaceState(null, '', `?${params}`);
}

const auth = getAuth(initializeApp(FIREBASE_CONFIG));
const db = getDatabase();
const base = `quizzes/${quizId}/${new Date().toLocaleDateString('sv')}`;
const app = document.getElementById('app');

let quiz, state, index, screen, answers = [], unsubscribe = () => {
};

const esc = s => String(s).replace(/[&<>"']/g, c => `&#${c.charCodeAt(0)};`);
const norm = s => String(s).trim().toLowerCase().normalize('NFD').replace(/\p{Diacritic}/gu, '');
const setState = s => set(ref(db, `${base}/state`), s)
    .catch(() => fail(`Accès présentateur refusé. Votre identifiant : ${auth.currentUser.uid}`));

const optionsOf = q => q.type === 'scale' ? Array.from({length: q.max - q.min + 1}, (_, i) => q.min + i) : q.choices;
const isCorrect = (q, value) => [q.answer ?? []].flat().map(norm).includes(norm(value));
const revealed = i => !state || state.q > i || (state.q === i && state.reveal);

const fail = err => {
    app.querySelector('.notification')?.remove();
    app.insertAdjacentHTML('afterbegin', `<div class="notification is-danger">${esc(err.message ?? err)}</div>`);
};
const header = () => `<p class="has-text-grey mb-2">${esc(quiz.title)} · ${index + 1}/${quiz.questions.length}</p>
  <h1 class="title">${esc(quiz.questions[index].text)}</h1>`;

const tally = q => {
    const isText = q.type === 'text';
    const counts = new Map(isText ? [] : optionsOf(q).map(o => [String(o), 0]));
    answers.flat()
        .map(a => isText ? norm(a) : String(a))
        .filter(k => k && (isText || counts.has(k)))
        .forEach(k => counts.set(k, (counts.get(k) ?? 0) + 1));
    return isText ? [...counts].sort((a, b) => b[1] - a[1]).slice(0, 40) : [...counts];
};

const renderTally = q => {
    const reveal = revealed(index) && q.answer !== undefined;
    const color = k => reveal ? (isCorrect(q, k) ? 'is-success' : '') : 'is-link';
    const rows = tally(q);
    const count = rows.reduce((sum, [, n]) => sum + n, 0);
    const mean = q.type === 'scale' && count
        ? `<p class="subtitle">Moyenne : ${(rows.reduce((sum, [k, n]) => sum + k * n, 0) / count).toFixed(1)}</p>` : '';
    if (q.type === 'text') {
        return `<div class="tags">${rows.map(([k, n]) =>
            `<span class="tag ${n === rows[0][1] ? 'is-large' : 'is-medium'} ${color(k)}">${esc(k)} (${n})</span>`).join('')}</div>`;
    }
    return mean + rows.map(([k, n]) => `<div class="is-flex is-justify-content-space-between"><span>${esc(k)}</span><strong>${n}</strong></div>
    <progress class="progress ${color(k)}" value="${n}" max="${answers.length || 1}"></progress>`).join('');
};

const plural = n => `${n} réponse${n > 1 ? 's' : ''}`;
const listenAnswers = callback => {
    unsubscribe();
    unsubscribe = onValue(ref(db, `${base}/answers/${index}`), snapshot => {
        answers = Object.values(snapshot.val() ?? {}).flatMap(a => {
            try {
                return [JSON.parse(a)];
            } catch {
                return [];
            }
        });
        callback();
    }, fail);
};

const showQuestion = i => {
    unsubscribe();
    index = i;
    screen = 'question';
    const q = quiz.questions[i];
    app.innerHTML = `${header()}${q.type === 'text'
        ? '<input class="input is-medium mb-4" id="text" maxlength="100">'
        : optionsOf(q).map((o, k) => `<button class="button is-fullwidth is-medium mb-2" data-k="${k}">${esc(o)}</button>`).join('')}
    <button class="button is-link is-medium mt-3" data-action="submit">${isHost ? 'Afficher les résultats' : 'Valider'}</button>
    ${isHost ? '<p class="subtitle mt-4" id="count"></p>' : ''}`;
    if (!isHost) return;
    setState({q: i, reveal: false});
    listenAnswers(() => app.querySelector('#count').textContent = plural(answers.length));
};

const renderResults = () => {
    const q = quiz.questions[index];
    const hasNext = index < quiz.questions.length - 1 && (isHost || !state || state.q > index);
    const buttons = [
        isHost && !revealed(index) && q.answer !== undefined && ['reveal', 'Révéler la réponse'],
        hasNext && ['next', 'Question suivante'],
    ].filter(Boolean);
    app.innerHTML = `${header()}<p class="mb-4">${answers.length} réponse${answers.length > 1 ? 's' : ''}</p>${renderTally(q)}
    <div class="buttons mt-5">${buttons.map(([action, label]) =>
        `<button class="button is-medium" data-action="${action}">${label}</button>`).join('')}</div>`;
};

const showResults = () => {
    screen = 'results';
    listenAnswers(renderResults);
};

const followHost = () => onValue(ref(db, `${base}/state`), snapshot => {
    state = snapshot.val();
    if (index === undefined) return showQuestion(startAt ?? state?.q ?? 0);
    if (screen !== 'results') return;
    if (!isHost && state?.q > index) return showQuestion(index + 1);
    renderResults();
}, fail);

const actions = {
    submit: async () => {
        const q = quiz.questions[index];
        const picked = [...app.querySelectorAll('[data-k].is-link')].map(b => optionsOf(q)[b.dataset.k]);
        const answer = q.type === 'text' ? app.querySelector('#text').value.trim() : q.type === 'multiple' ? picked : picked[0];
        if (!isHost) {
            if (String(answer ?? '') === '') return fail('Choisissez une réponse');
            await set(ref(db, `${base}/answers/${index}/${auth.currentUser.uid}`), JSON.stringify(answer));
        }
        showResults();
    },
    reveal: () => setState({...state, reveal: true}),
    next: () => showQuestion(index + 1),
    login: () => signInWithPopup(auth, new GoogleAuthProvider()).then(followHost),
};

app.addEventListener('click', ({target}) => {
    const button = target.closest('button');
    if (button?.dataset.k) {
        if (quiz.questions[index].type !== 'multiple') app.querySelectorAll('[data-k]').forEach(b => b !== button && b.classList.remove('is-link'));
        return button.classList.toggle('is-link');
    }
    if (!button?.dataset.action) return;
    button.classList.add('is-loading');
    Promise.resolve(actions[button.dataset.action]()).catch(fail).finally(() => button.classList.remove('is-loading'));
});

try {
    const response = await fetch(`quizzes/${quizId}.json`);
    if (!response.ok) throw new Error(`Quiz « ${quizId} » introuvable`);
    quiz = await response.json();
    document.title = quiz.title;
    await auth.authStateReady();
    if (isHost && (auth.currentUser?.isAnonymous ?? true)) {
        app.innerHTML = '<button class="button is-link is-medium" data-action="login">Se connecter avec Google</button>';
    } else {
        if (!auth.currentUser) await signInAnonymously(auth);
        followHost();
    }
} catch (err) {
    app.innerHTML = '';
    fail(err);
}
