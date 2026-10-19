const API = 'https://script.google.com/macros/s/AKfycbwq8xKLXVLKyoXe8eB6z_CbBToQ8g2mAOU5j9OZUoYwdIGER38uYaJDpFKfz74OoCs4/exec';

const params = new URLSearchParams(location.search);
const quizId = params.get('quiz');
const isHost = params.has('host');
const pid = localStorage.pid ??= crypto.randomUUID();
const app = document.getElementById('app');

if (params.get('host')) {
    localStorage.hostKey = params.get('host');
    params.set('host', '');
    history.replaceState(null, '', `?${params}`);
}

const startAt = isHost && params.has('q') ? params.get('q') - 1 : null;

if (params.get('host')) localStorage.hostKey = params.get('host');
if (isHost) {
    params.set('host', '');
    params.delete('q');
    history.replaceState(null, '', `?${params}`);
}

let quiz, state, index, timer;

const esc = s => String(s).replace(/[&<>"']/g, c => `&#${c.charCodeAt(0)};`);
const norm = s => String(s).trim().toLowerCase().normalize('NFD').replace(/\p{Diacritic}/gu, '');
const json = r => r.json().then(d => d.error ? Promise.reject(d.error) : d);
const get = (q = '') => fetch(`${API}?${new URLSearchParams({quiz: quizId, q})}`).then(json);
const post = body => fetch(API, {method: 'POST', body: JSON.stringify({quiz: quizId, ...body})}).then(json);
const setState = s => post({key: localStorage.hostKey, state: (state = s)});

const optionsOf = q => q.type === 'scale' ? Array.from({length: q.max - q.min + 1}, (_, i) => q.min + i) : q.choices;
const isCorrect = (q, value) => [q.answer ?? []].flat().map(norm).includes(norm(value));
const revealed = i => !state || state.q > i || (state.q === i && state.reveal);

const render = html => {
    clearTimeout(timer);
    app.innerHTML = html;
};
const fail = err => {
    app.querySelector('.notification')?.remove();
    app.insertAdjacentHTML('afterbegin', `<div class="notification is-danger">${esc(err)}</div>`);
};
const header = () => `<p class="has-text-grey mb-2">${esc(quiz.title)} · ${index + 1}/${quiz.questions.length}</p>
  <h1 class="title">${esc(quiz.questions[index].text)}</h1>`;

const tally = (q, answers) => {
    const isText = q.type === 'text';
    const counts = new Map(isText ? [] : optionsOf(q).map(o => [String(o), 0]));
    answers.flat()
        .map(a => isText ? norm(a) : String(a))
        .filter(k => k && (isText || counts.has(k)))
        .forEach(k => counts.set(k, (counts.get(k) ?? 0) + 1));
    return isText ? [...counts].sort((a, b) => b[1] - a[1]).slice(0, 40) : [...counts];
};

const renderTally = (q, answers) => {
    const reveal = revealed(index) && q.answer !== undefined;
    const color = k => reveal ? (isCorrect(q, k) ? 'is-success' : '') : 'is-info';
    const rows = tally(q, answers);
    const mean = q.type === 'scale' && answers.length
        ? `<p class="subtitle">Moyenne : ${(answers.reduce((sum, a) => sum + +a, 0) / answers.length).toFixed(1)}</p>` : '';
    if (q.type === 'text') {
        return `<div class="tags">${rows.map(([k, n]) =>
            `<span class="tag ${n === rows[0][1] ? 'is-large' : 'is-medium'} ${color(k)}">${esc(k)} (${n})</span>`).join('')}</div>`;
    }
    return mean + rows.map(([k, n]) => `<div class="is-flex is-justify-content-space-between"><span>${esc(k)}</span><strong>${n}</strong></div>
    <progress class="progress ${color(k)}" value="${n}" max="${answers.length || 1}"></progress>`).join('');
};

const showQuestion = i => {
    index = i;
    const q = quiz.questions[i];
    render(`${header()}${q.type === 'text'
        ? '<input class="input is-medium mb-4" id="text" maxlength="100">'
        : optionsOf(q).map((o, k) => `<button class="button is-fullwidth is-medium mb-2" data-k="${k}">${esc(o)}</button>`).join('')}
    <button class="button is-link is-medium mt-3" data-action="submit">${isHost ? 'Afficher les résultats' : 'Valider'}</button>`);
    if (isHost) setState({q: i, reveal: false}).catch(fail);
};

const showResults = async () => {
    const i = index;
    const {state: current, answers} = await get(i);
    if (i !== index) return;
    if (!isHost) state = current;
    const q = quiz.questions[i];
    const hasNext = i < quiz.questions.length - 1 && (isHost || !state || state.q > i);
    const buttons = [
        isHost ? !revealed(i) && q.answer !== undefined && ['reveal', 'Révéler la réponse'] : ['refresh', 'Actualiser'],
        hasNext && ['next', 'Question suivante'],
    ].filter(Boolean);
    render(`${header()}<p class="mb-4">${answers.length} réponse${answers.length > 1 ? 's' : ''}</p>${renderTally(q, answers)}
    <div class="buttons mt-5">${buttons.map(([action, label]) =>
        `<button class="button is-medium" data-action="${action}">${label}</button>`).join('')}</div>`);
    if (isHost) timer = setTimeout(() => showResults().catch(fail), 2000);
};

const actions = {
    submit: async () => {
        const q = quiz.questions[index];
        const picked = [...app.querySelectorAll('[data-k].is-link')].map(b => optionsOf(q)[b.dataset.k]);
        const answer = q.type === 'text' ? app.querySelector('#text').value.trim() : q.type === 'multiple' ? picked : picked[0];
        if (!isHost) {
            if (String(answer ?? '') === '') return fail('Choisissez une réponse');
            await post({q: index, pid, answer});
        }
        await showResults();
    },
    refresh: showResults,
    reveal: () => setState({...state, reveal: true}).then(showResults),
    next: () => showQuestion(index + 1),
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

fetch(`quizzes/${quizId}.json`)
    .then(r => r.ok ? r.json() : Promise.reject(`Quiz « ${quizId} » introuvable`))
    .then(async data => {
        quiz = data;
        document.title = quiz.title;
        ({state} = await get());
        showQuestion(startAt ?? state?.q ?? 0);
    })
    .catch(err => render(`<div class="notification is-danger">${esc(err)}</div>`));
