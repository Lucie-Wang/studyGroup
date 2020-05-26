<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>New Profile</title>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<script type="text/javascript" src="/js/app.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="https://ajax.aspnetcdn.com/ajax/jquery.ui/1.10.3/themes/flick/jquery-ui.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<style type="text/css">
.ui-menu .ui-menu-item a, .ui-menu .ui-menu-item a.ui-state-hover,
	.ui-menu .ui-menu-item a.ui-state-active {
	font-weight: normal;
	margin: -1px;
	text-align: left;
	font-size: 14px;
}

.ui-autocomplete-loading {
	background: white url("http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/themes/smoothness/images/ui-anim_basic_16x16.gif") right center
		no-repeat;
}
</style>

<script type="text/javascript">
	jQuery(function() {
		jQuery("#f_elem_city")
				.autocomplete(
						{
							source : function(request, response) {
								jQuery
										.getJSON(
												"http://gd.geobytes.com/AutoCompleteCity?callback=?&sort=size&q="+request.term,
												function(data) {
													response(data);
												});
							},
							minLength : 3,
							select : function(event, ui) {
								var selectedObj = ui.item;
								jQuery("#f_elem_city").val(selectedObj.value);
								getcitydetails(selectedObj.value);
								return false;
							},
							open : function() {
								jQuery(this).removeClass("ui-corner-all")
										.addClass("ui-corner-top");
							},
							close : function() {
								jQuery(this).removeClass("ui-corner-top")
										.addClass("ui-corner-all");
							}
						});
		jQuery("#f_elem_city").autocomplete("option", "delay", 100);
	});
</script>
<script type="text/javascript">
	function getcitydetails(fqcn) {

		if (typeof fqcn == "undefined")
			fqcn = jQuery("#f_elem_city").val();

		cityfqcn = fqcn;

		if (cityfqcn) {

			jQuery
					.getJSON(
							"https://secure.geobytes.com/GetCityDetails?key=7c756203dbb38590a66e01a5a3e1ad96&callback=?&fqcn="
									+ cityfqcn, function(data) {
								jQuery("#geobytesinternet").val(
										data.geobytesinternet);
								jQuery("#geobytescountry").val(
										data.geobytescountry);
								jQuery("#geobytesregionlocationcode").val(
										data.geobytesregionlocationcode);
								jQuery("#geobytesregion").val(
										data.geobytesregion);
								jQuery("#geobyteslocationcode").val(
										data.geobyteslocationcode);
								jQuery("#geobytescity").val(data.geobytescity);
								jQuery("#geobytescityid").val(
										data.geobytescityid);
								jQuery("#geobytesfqcn").val(data.geobytesfqcn);
								jQuery("#geobyteslatitude").val(
										data.geobyteslatitude);
								jQuery("#geobyteslongitude").val(
										data.geobyteslongitude);
								jQuery("#geobytescapital").val(
										data.geobytescapital);
								jQuery("#geobytestimezone").val(
										data.geobytestimezone);
								jQuery("#geobytesnationalitysingular").val(
										data.geobytesnationalitysingular);
								jQuery("#geobytespopulation").val(
										data.geobytespopulation);
								jQuery("#geobytesnationalityplural").val(
										data.geobytesnationalityplural);
								jQuery("#geobytesmapreference").val(
										data.geobytesmapreference);
								jQuery("#geobytescurrency").val(
										data.geobytescurrency);
								jQuery("#geobytescurrencycode").val(
										data.geobytescurrencycode);
							});
		}
	}
</script>
<script>
	// character randomization variables

	//image randomization variables
	let randomImg = Math.floor((Math.random() * 350) + 14);
	let images = "";
	console.log(randomImg)

	// api calls
	const proxyurl = "https://cors-anywhere.herokuapp.com/";
	const url = "https://api-v3.igdb.com/character_mug_shots";
	console.log(proxyurl + url)

	$(document)
			.ready(
					function() {

						$
								.ajax(
										{
											"url" : proxyurl + url,
											"method" : "POST",
											"timeout" : 0,
											"headers" : {
												'Accept' : 'application/json',
												"user-key" : "d1ece28337f3ddb37326c7f5f08ebd86",
											},
											"data" : "fields image_id; where image_id!=(null); limit 374;"
										})
								.done(
										function(response) {
											console.log(response);
											for (let i = randomImg; i < randomImg + 14; i++) {
												images += '<img src= https://images.igdb.com/igdb/image/upload/t_thumb/' + response[i].image_id + '.jpg alt="character mug shot">'
											}
											$("#images").html(images);
										});

						$(document).ajaxComplete(function(e, xhr, settings) {
							$('img').click(function() {
								let picValue = $(this).attr("src");
								$("#picinput").attr("value", picValue);
								$("img").css("outline", "none");
								$(this).css("outline", "3px solid green");
							})
						})

					})
</script>
</head>

<body>
	<div class="wrapper">
		<div class="navwrapper">
			<div class="nav">
				<div class="nav1">
					<p class="llogo">Study Group</p>
				</div>
				<div></div>
				<div class="nav3">
					<a class="links" href="/logout">Logout</a>
				</div>
			</div>
		</div>

		<div class="navSpacer"></div>

		<div class="regLog newChar">
			<h1 class="header">Tell us who you are!</h1>
			<p class="error">
				<form:errors path="user.*" /> <c:out value="${error}"/>
			</p>
			<form:form class="form" action="/newprofile" method="post"
				modelAttribute="user">
				<form:input class="input" path="name"
					placeholder="What's your Name?"></form:input>
				<form:label class="input picture" path="picture">Select your avatar:</form:label>
				<div id="images"></div>
				<form:input id="picinput" type="hidden" class="input" path="picture"
					value="" />
				<form:label class="input picture" path="">Where are you located?</form:label>
				<input class="ff_elem" type="text" name="ff_nm_from[]" value="" id="f_elem_city"/>
				<form:input id="geobytescity" type="hidden" class="input" path="city"/>
				<form:input id="geobytesregion" type="hidden" class="input" path="region"/>
				<form:input id="geobytescountry" type="hidden" class="input" path="country"/>
				<form:label class="input picture" path="userInterests">What are you interested in?</form:label>
				<form:select class="input" path="userInterests">
					<c:forEach var="category" items="${allCategories}">
						<form:option value="${category.id}" label="${category.name}" />
					</c:forEach>
				</form:select>

				<input class="input submit" type="submit" value="Submit" />
			</form:form>
		</div>
	</div>
</body>

</html>