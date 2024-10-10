import * as Consts from "./consts.js"

document.addEventListener('DOMContentLoaded', function () {
	setInputValidity(Consts.Y_INPUT_ID, Consts.MIN_Y, Consts.MAX_Y);
	setScrollShadow('header', 'shadow', 5);
	setFormListener('#coordinates-form');
	setRadioButtonsListener();
	setHelpLineListener();
	setRadiusSelectListener();
	setPointListener();
});

function getCheckedRadioButton(radioSelector) {
	return document.querySelector(radioSelector + ':checked');
}

function setFormListener(form) {
	$(form).on('submit', function (event) {
		event.preventDefault();
		let x = parseFloat(getCheckedRadioButton(Consts.X_INPUT_SELECTOR).value);
		let y = parseFloat(document.getElementById(Consts.Y_INPUT_ID).value);
		let r = parseFloat(document.getElementById(Consts.R_INPUT_ID).value);
		sendRequest(x, y, r);
	});
}

function setRadiusSelectListener() {
	let radius = document.getElementById(Consts.R_INPUT_ID);
	radius.addEventListener('change', function () {
		if (getCheckedRadioButton(Consts.X_INPUT_SELECTOR) != null) {
			updateLine();
		}
		updateRadius(this.value);
	});
}

function setPointListener() {
	let point = document.getElementById(Consts.HELP_POINT_ID);
	point.addEventListener('click', function () {
		let cx = point.getAttribute('cx');
		let cy = point.getAttribute('cy');
		let r = parseFloat(document.getElementById(Consts.R_INPUT_ID).value);
		let x = parseFloat(((cx - Consts.SVG_WIDTH / 2) * r) / Consts.RADIUS_IN_PX);
		let y = parseFloat(((Consts.SVG_WIDTH / 2 - cy) * r) / Consts.RADIUS_IN_PX);
		sendRequest(x, y, r);
	});
}

function sendRequest(x, y, r) {
	$.ajax({
		url: Consts.BASE_URL,
		method: Consts.METHOD,
		data: JSON.stringify({
			x: x,
			y: y,
			r: r,
		}),
		statusCode: {
			400: function () {
				alert('Невалидные данные');
			},
		},
		success: function (data) {
			appendHitResult(x, y, r, data.hit);
		},
		complete: function () {
			updateCoordinates(x, y, r);
		},
	});
}

function setRadioButtonsListener() {
	let buttons = document.querySelectorAll(Consts.X_INPUT_SELECTOR);
	let previous = null;
	for (let i = 0; i < buttons.length; i++) {
		buttons[i].addEventListener('change', function () {
			if (
				this !== previous &&
				document.getElementById(Consts.R_INPUT_ID).checkValidity()
			) {
				previous = this;
				updateLine();
			}
		});
	}
}

function updateLine() {
	let line = document.getElementById(Consts.HELP_LINE_ID);
	let x = getCheckedRadioButton(Consts.X_INPUT_SELECTOR).value;
	let radius = document.getElementById(Consts.R_INPUT_ID).value;
	line.setAttribute('x1', Consts.SVG_WIDTH / 2 + (x * Consts.RADIUS_IN_PX) / radius);
	line.setAttribute('x2', Consts.SVG_WIDTH / 2 + (x * Consts.RADIUS_IN_PX) / radius);
	line.setAttribute('y1', Consts.SVG_WIDTH / 2 - (Consts.MAX_Y * Consts.RADIUS_IN_PX) / radius);
	line.setAttribute('y2', Consts.SVG_WIDTH / 2 - (Consts.MIN_Y * Consts.RADIUS_IN_PX) / radius);
	line.setAttribute('visibility', 'visible');
}

function setHelpLineListener() {
	let line = document.getElementById(Consts.HELP_LINE_ID);
	let dot = document.getElementById(Consts.HELP_POINT_ID);
	line.addEventListener('mouseenter', function (event) {
		let mouse = getSvgCoordinates(event);
		dot.setAttribute('cx', line.getAttribute('x1'));
		dot.setAttribute('cy', mouse.y);
		dot.setAttribute('visibility', 'visible');
	});
	line.addEventListener('mouseleave', function () {
		dot.setAttribute('visibility', 'hidden');
	});
}

function getSvgCoordinates(event) {
	const svg = document.querySelector(Consts.SVG_SELECTOR);
	const point = svg.createSVGPoint();
	point.x = event.clientX;
	point.y = event.clientY;
	return point.matrixTransform(svg.getScreenCTM().inverse());
}

function appendHitResult(x, y, r, hit) {
	let tbody = document.querySelector(Consts.RESULT_TABLE_SELECTOR).querySelector('tbody');
	x = document.createTextNode(x);
	y = document.createTextNode(y);
	r = document.createTextNode(r);
	let hitElement = document.createElement('span');
	hitElement.innerHTML = hit ? Consts.SUCCESS_HIT_MSG : Consts.FAIL_HIT_MSG;
	hitElement.classList.add(hit ? Consts.SUCCESS_HIT_CLASS : Consts.FAILT_HIT_CLASS);
	let counter = document.createTextNode('');
	const rowData = [counter, x, y, r, hitElement];
	let row = tbody.insertRow();
	for (let element of rowData) {
		let cell = row.insertCell();
		cell.appendChild(element);
	}
}

function updateCoordinates(x, y, r) {
	let dot = document.getElementById(Consts.POINT_ID);
	dot.setAttribute('cx', Consts.SVG_WIDTH / 2 + (x * Consts.RADIUS_IN_PX) / r);
	dot.setAttribute('cy', Consts.SVG_WIDTH / 2 - (y * Consts.RADIUS_IN_PX) / r);
	dot.setAttribute('visibility', 'visible');
	updateRadius(r);
}

function updateRadius(r) {
	document.querySelectorAll('.r').forEach((el) => (el.textContent = r));
	document.querySelectorAll('.-r').forEach((el) => (el.textContent = -r));
	document.querySelectorAll('.r-2').forEach((el) => (el.textContent = r / 2));
	document.querySelectorAll('.-r-2').forEach((el) => (el.textContent = -r / 2));
}

function setScrollShadow(selector, shadow, px) {
	window.addEventListener('scroll', function () {
		if (
			document.body.scrollTop > px ||
			document.documentElement.scrollTop > px
		) {
			document.querySelector(selector).classList.add(shadow);
		} else {
			document.querySelector(selector).classList.remove(shadow);
		}
	});
}

function setInputValidity(input_id, min, max) {
	let input = document.getElementById(input_id);
	let name = input.getAttribute('name').toUpperCase();
	input.addEventListener('input', () => {
		if (!isFinite(input.value)) {
			input.setCustomValidity(name + ' должен быть числом!');
		} else if (input.value <= min || input.value >= max) {
			input.setCustomValidity(
				name +
					' должен быть в пределах от ' +
					min +
					' до ' +
					max +
					' не включительно!'
			);
		} else {
			input.setCustomValidity('');
		}
	});
}
