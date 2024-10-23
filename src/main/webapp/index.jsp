<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="ru.itmo.app.HitResponse" %>


<!DOCTYPE html>
<html lang="ru">
	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" href="resources/styles.css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<script src="resources/script.js" type="module"></script>
	</head>
	<body>
		<header id="header" class="header-wrapper">
			<span class="logo">веб-программирование</span>
			<span class="variant">вариант 4587</span>
			<span class="creator-name">Байрамгулов Мунир Ниязович, P3218</span>
		</header>
		<table class="layout-table">
			<tr class="main">
				<td class="coordinates-form-cell">
					<form id="coordinates-form">
						<span class="form-info">заполните параметры</span>
						<table class="coordinates-form-table">
							<tr>
								<td class="x-form-table">
								<div class="radio-inputs">
                                    <label class="radio">
                                        <input type="radio" name="x-radio" value="-4">
                                        <span class="name">-4</span>
                                    </label>
									<label class="radio">
                                        <input type="radio" name="x-radio" value="-3">
                                        <span class="name">-3</span>
                                    </label>
                                    <label class="radio">
                                        <input type="radio" name="x-radio" value="-2">
                                        <span class="name">-2</span>
                                    </label>
                                    <label class="radio">
                                        <input type="radio" name="x-radio" value="-1">
                                        <span class="name">-1</span>
                                    </label>
                                    <label class="radio">
                                        <input type="radio" name="x-radio" value="0">
                                        <span class="name">0</span>
                                    </label>
                                    <label class="radio">
                                        <input type="radio" name="x-radio" value="1">
                                        <span class="name">1</span>
                                    </label>
                                    <label class="radio">
                                        <input type="radio" name="x-radio" value="2">
                                        <span class="name">2</span>
                                    </label>
                                    <label class="radio">
                                        <input type="radio" name="x-radio" value="3">
                                        <span class="name">3</span>
                                    </label>
                                    <label class="radio">
                                        <input type="radio" name="x-radio" value="4">
                                        <span class="name">4</span>
                                    </label>
                                </div>
								</td>
							</tr>
							<tr>
								<td class="y-form-table">
									<input
										type="text"
										id="y-text"
										name="y"
										placeholder="введите Y"
									/>
								</td>
							</tr>
							<tr>
								<td class="r-form-table">
									<select id="r-select" name="r">
										<option value="">-- выберите R из списка</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
									</select>
								</td>
							</tr>
						</table>
						<button type="submit">проверить</button>
					</form>
				</td>
				<td>
					<svg height="300" width="300" xmlns="http://www.w3.org/2000/svg">

						<line stroke="black" x1="0" x2="300" y1="150" y2="150"></line>
						<line stroke="black" x1="150" x2="150" y1="0" y2="300"></line>
						<polygon
							fill="black"
							points="150,0 144,15 156,15"
							stroke="black"
						></polygon>
						<polygon
							fill="black"
							points="300,150 285,156 285,144"
							stroke="black"
						></polygon>

						<line stroke="black" x1="200" x2="200" y1="155" y2="145"></line>
						<line stroke="black" x1="250" x2="250" y1="155" y2="145"></line>

						<line stroke="black" x1="50" x2="50" y1="155" y2="145"></line>
						<line stroke="black" x1="100" x2="100" y1="155" y2="145"></line>

						<line stroke="black" x1="145" x2="155" y1="100" y2="100"></line>
						<line stroke="black" x1="145" x2="155" y1="50" y2="50"></line>

						<line stroke="black" x1="145" x2="155" y1="200" y2="200"></line>
						<line stroke="black" x1="145" x2="155" y1="250" y2="250"></line>

						<text class="r-2" fill="black" x="195" y="140">R/2</text>
						<text class="r" fill="black" x="245" y="140">R</text>

						<text class="-r" fill="black" x="40" y="140">-R</text>
						<text class="-r-2" fill="black" x="90" y="140">-R/2</text>

						<text class="r" fill="black" x="160" y="55">R</text>
						<text class="r-2" fill="black" x="160" y="105">R/2</text>

						<text class="-r-2" fill="black" x="160" y="205">-R/2</text>
						<text class="-r" fill="black" x="160" y="255">-R</text>

						<text fill="black" x="285" y="140">X</text>
						<text fill="black" x="160" y="15">Y</text>

						<rect
							x="150"
							y="150"
							width="100"
							height="50"
							fill-opacity="0.4"
							stroke="#00da72"
							fill="#56c18d"
						></rect>
						<path
							d="M 150 150 L 50 150 C 50 130 60 60 150 50 Z"
							fill-opacity="0.4"
							stroke="#00da72"
							fill="#56c18d"
						></path>
						<polygon
							points="150,150 150,50 200,150"
							fill-opacity="0.4"
							stroke="#00da72"
							fill="#56c18d"
						></polygon>
						<line 
							id="help-line" 
							stroke="orange" 
							stroke-width="7"
							style="opacity:0.6" 
							x1="150" 
							x2="150" 
							y1="0" 
							y2="300" 
							visibility="hidden">
						</line>
                        <circle
							id="point"
							r="5"
							cx="150"
							cy="150"
							fill="red"
							visibility="hidden"></circle>
                        <circle
							id="help-point"
							r="5"
							cx="150"
							cy="150"
							fill="red"
							visibility="hidden"></circle>
						<% if (request.getSession().getAttribute("results") != null) { %>
						<% ArrayList<HitResponse> array = (ArrayList<HitResponse>) request.getSession().getAttribute("results");%>
						<% for (int i = 0; i < array.size(); i++) { %>
						<circle
								id="point"
								r="5"
								cx="<%=150 + (array.get(i).x * 100) / array.get(i).r%>"
								cy="<%=150 - (array.get(i).y * 100) / array.get(i).r%>"
								fill="red"
								visibility="visible"></circle>
						<% } %>
						<% } %>
					</svg>
				</td>
			</tr>
			<tr class="error-messages none">
                <td class="error-message" colspan="2">
                    <div class="error">ошибка</div>
                </td>
            </tr>
			<tr class="aside">
				<td class="result-table-cell" colspan="2">
					<table class="result-table">
						<thead>
							<tr>
								<th>попытка</th>
								<th>X</th>
								<th>Y</th>
								<th>R</th>
								<th>результат</th>
							</tr>
						</thead>
						<tbody>
							<% DecimalFormat format = new DecimalFormat("0.######"); %>
                            <% if (request.getSession().getAttribute("results") != null) { %>
                        <% ArrayList<HitResponse> array = (ArrayList<HitResponse>) request.getSession().getAttribute("results");%>
                        <% for (int i = 0; i < array.size(); i++) { %>
                            <tr>
								<td></td>
                                <td><%= format.format(array.get(i).x) %></td>
                                <td><%= format.format(array.get(i).y) %></td>
                                <td><%= format.format(array.get(i).r) %></td>
                                <td><%= array.get(i).hit ? "<span class='success-hit'>попадание</span>" : "<span class='fail-hit'>промах</span>"%></td>
                            </tr>
                        <% } %>
                    <% } %>
                        </tbody>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>