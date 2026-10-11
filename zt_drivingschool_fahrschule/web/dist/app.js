let currentQuestions = [];
let currentScore = 100;

window.addEventListener('message', (event) => {
    const data = event.data;
    if (data.action === 'openTheory') {
        currentQuestions = data.questions || [];
        renderQuestions();
        document.getElementById('container').classList.remove('hidden');
    }
});

function renderQuestions() {
    const quizDiv = document.getElementById('quiz');
    quizDiv.innerHTML = '';

    currentQuestions.forEach((q, qIndex) => {
        const block = document.createElement('div');
        block.className = 'question-block';

        const title = document.createElement('div');
        title.className = 'question-title';
        title.innerText = `${qIndex + 1}. ${q.question}`;
        block.appendChild(title);

        q.options.forEach((opt, optIndex) => {
            const label = document.createElement('label');
            label.className = 'option-label';

            const radio = document.createElement('input');
            radio.type = 'radio';
            radio.name = `question_${qIndex}`;
            radio.value = optIndex;

            label.appendChild(radio);
            label.appendChild(document.createTextNode(opt));
            block.appendChild(label);
        });

        quizDiv.appendChild(block);
    });
}

document.querySelectorAll('.nav-item').forEach(button => {
    button.addEventListener('click', () => {
        document.querySelectorAll('.nav-item').forEach(b => b.classList.remove('active'));
        document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));

        button.classList.add('active');
        const tabId = button.getAttribute('data-tab');
        document.getElementById(`tab-${tabId}`).classList.add('active');
    });
});

function updateClock() {
    const now = new Date();
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const el = document.getElementById('systemClock');
    if (el) el.innerText = `${hours}:${minutes}`;
}
setInterval(updateClock, 1000);
updateClock();

function addFault(points) {
    currentScore = Math.max(0, currentScore - points);
    const scoreEl = document.getElementById('currentScore');
    scoreEl.innerText = currentScore;
    if (currentScore < 60) {
        scoreEl.style.color = '#ef4444';
    } else {
        scoreEl.style.color = '#22c55e';
    }
}

function finishPractical(passed) {
    document.getElementById('container').classList.add('hidden');
    fetch(`https://${GetParentResourceName()}/finishPractical`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ passed: passed, score: currentScore })
    });
}

document.getElementById('closeBtn').addEventListener('click', () => {
    document.getElementById('container').classList.add('hidden');
    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({})
    });
});

document.getElementById('submitBtn').addEventListener('click', () => {
    let correctCount = 0;

    currentQuestions.forEach((q, qIndex) => {
        const selected = document.querySelector(`input[name="question_${qIndex}"]:checked`);
        if (selected && parseInt(selected.value, 10) === q.answer) {
            correctCount++;
        }
    });

    const passed = (correctCount === currentQuestions.length);

    document.getElementById('container').classList.add('hidden');
    fetch(`https://${GetParentResourceName()}/submitTheory`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ passed: passed })
    });
});
