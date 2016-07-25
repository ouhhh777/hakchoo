<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/com/headerF.jsp"%>

<c:set var="userInfo" value="${sessionScope.USERINFO}" />
<style>
.form-control{
	display:block;
	width:100%;
	border-radius:5px !important;
	padding: 0px 12px;
}


</style>
<!-- Header ================================================== -->
    <header>

    <div class="container-fluid">
        <div class="row">
            <div class="col--md-4 col-sm-4 col-xs-4">
                <a href="index.jsp" id="logo">
                <img src="/img/logo_mobile_2x.png" width="59" height="23" alt="" data-retina="true" class="hidden-xs">
                <img src="/img/logo_mobile.png" width="59" height="23" alt="" data-retina="true" class="hidden-lg hidden-md hidden-sm">
                </a>
            </div>
            <nav class="col--md-8 col-sm-8 col-xs-8">
            <a class="cmn-toggle-switch cmn-toggle-switch__htx open_close" href="javascript:void(0);"><span>Menu mobile</span></a>
            <div class="main-menu">
                <div id="header_menu">
                    <img src="/img/logo.png" width="190" height="23" alt="" data-retina="true">
                </div>
                 <ul style="margin-right:100px;">
                    <li id="navigation"><a href="#filters_col">학원 목록</a></li>
                    <li id="navigation"><a href="#contacts">학원 정보 신청</a></li>
                    
                     <c:choose>
					<c:when test="${empty userInfo.user_email}">
                	<li><a href="#0" data-toggle="modal" data-target="#login_2">로그인</a></li>
                	<li><a href="#0" data-toggle="modal" data-target="#register" style="vertical-align:middle;">회원가입</a></li>
                	</c:when>
	                <c:otherwise>
	                <li><a href="/hak/Logout">로그아웃</a></li>
                    
	                </c:otherwise>
				</c:choose>
				
				
                </ul>
            </div><!-- End main-menu -->
            </nav>
        </div><!-- End row -->
    </div><!-- End container -->
    </header>
    <!-- End Header =============================================== -->

   
		<!-- Login modal -->   
		<div class="modal fade" id="login_2" tabindex="-1" role="dialog" aria-labelledby="myLogin" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content modal-popup">
					<a href="#" class="close-link"><i class="icon_close_alt2"></i></a>
					<form class="popup-form" id="myLogin" method="post">
		               	<div class="login_icon"><i class="icon_lock_alt"></i></div>
						<input type="text" class="form-control form-white" id="login_email" name="email" placeholder="Email" value="">
						<input type="password" class="form-control form-white" id="login_pwd" name="pwd" placeholder="암호" value="">
						<div id="check_login" class="col-md-12 col-sm-12"></div>
						<div class="text-left">
							<a href='javascript:void(0);' onclick="forgotPasswd()">비밀번호를 잃어 버렸어요?</a><br>
							<a href='javascript:void(0);' onclick="goToSignUp()">회원가입</a>
						</div>
						<button type="button" class="btn btn-submit" onclick="loginProcess()">로그인</button>
						
					</form>					
				</div>
			</div>
		</div><!-- End modal -->
		
		<!-- Register modal -->   
		<div class="modal fade" id="register" tabindex="-1" role="dialog" aria-labelledby="myRegister" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content modal-popup">
					<a href="#" class="close-link"><i class="icon_close_alt2"></i></a>
					<form class="popup-form" id="myRegister" name="myRegister" method="post">
		               	<div class="login_icon"><i class="icon_lock_alt"></i></div>
		                <div class="col-md-12 col-sm-12">
						<input type="email" class="form-control form-white" id="sign_user_email" name="user_email" placeholder="Email *" value="">
						<input type="password" class="form-control form-white" id="sign_user_password" name="user_password" placeholder="비밀번호 *" value="">
						<input type="password" class="form-control form-white" id="sign_user_password_confirm" name="user_password_confirm" placeholder="비밀번호 확인 *" value="">
						</div>
						<div class="col-md-7 col-sm-7">
							<input type="text" class="form-control form-white" id="sign_user_age" name="user_age" placeholder="나이 *" value="">
						</div>
						<div id="check_sign" class="col-md-7 col-sm-7"></div>
				        <div id="pass-info" class="clearfix"></div>
						
						<div class="checkbox-holder text-left">
							<div class="checkbox">
								<input type="checkbox" value="accept_2" id="check_2" name="check_2" />
								<label for="check_2"><span>동의 (<strong>회원가입 &amp; 이메일 수신</strong>)</span></label>
							</div>
						</div>
						<button type="button" id="goToRegister" class="btn btn-submit" onclick="signUp()" disabled>회원가입</button>
						
							
					</form>
				</div>
			</div>
		</div><!-- End Register modal -->
		
		<!-- Forgot Password modal -->   
		<div class="modal fade" id="forgotPassword" tabindex="-1" role="dialog" aria-labelledby="myLogin" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content modal-popup">
					<a href="#" class="close-link"><i class="icon_close_alt2"></i></a>
					<form class="popup-form" id="sendPassword" method="post">
		               	<div class="login_icon"><i class="icon_lock_alt"></i></div>
						<input type="text" class="form-control form-white" name="email" placeholder="Email" value="">
						<button type="button" class="btn btn-submit" onclick="sendTempPwd()">Submit</button>
						
					</form>
				</div>
			</div>
		</div><!-- End modal -->

		
		<script>
			
	$(function(){
	$("#check_2").click(function() {
		if($("input:checkbox[id='check_2']").is(":checked") == true)
		{
			$("#goToRegister").removeAttr('disabled');
		} else{
			$("#goToRegister").attr({
                'disabled': 'disabled'
            });
		}
	})
});
	
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//회원가입 프로세스
			 function signUp(){
			       	var regix_email = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
			       	var regix_pw = /^[a-z0-9]{6,12}$/;

					var user_email = document.getElementById("sign_user_email");
					var user_pw = document.getElementById("sign_user_password");
					var user_chk_pw = document.getElementById("sign_user_password_confirm");
					var user_age = document.getElementById("sign_user_age");
					var check_login = document.getElementById("check_sign");
					
			           if(user_email.value == ""){
			           	
			           	check_sign.style.textAlign="center";
			           	check_sign.style.color="#FF0000";
			           	check_sign.style.paddingTop="10px";
			           	check_sign.style.fontSize="0.8em"
			   			document.getElementById("sign_user_email").style.borderColor="red";
			           	check_sign.innerHTML = "이메일을 입력하세요.";
			               user_email.focus();
			               
			               return;
			           }
			           if(regix_email.test(user_email.value) != true){
			           	check_sign.style.textAlign="center";
			           	check_sign.style.color="#FF0000";
			           	check_sign.style.paddingTop="10px";
			           	check_sign.style.fontSize="0.8em"
			   			document.getElementById("sign_user_email").style.borderColor="red";
			   			document.getElementById("sign_user_password").style.borderColor="white";
			   			document.getElementById("sign_user_password_confirm").style.borderColor="white";
			   			document.getElementById("sign_user_age").style.borderColor="white";
			           	check_sign.innerHTML = "이메일 형식이 틀렸습니다. (xx@xx.xx)";
			               user_email.focus();
			               return;
			           }
			           if(user_pw.value == ""){
			           	check_sign.style.textAlign="center";
			           	check_sign.style.color="#FF0000";
			           	check_sign.style.paddingTop="10px";
			           	check_sign.style.fontSize="0.8em"
			       		document.getElementById("sign_user_email").style.borderColor="white";
			   			document.getElementById("sign_user_password").style.borderColor="red";
			   			document.getElementById("sign_user_password_confirm").style.borderColor="white";
			   			document.getElementById("sign_user_age").style.borderColor="white";
			           	check_sign.innerHTML = "비밀번호를 입력하세요.";
			               user_pw.focus();
			               return;
			           }
			           if(regix_pw.test(user_pw.value) != true){
			           	check_sign.style.textAlign="center";
			           	check_sign.style.color="#FF0000";
			           	check_sign.style.paddingTop="10px";
			           	check_sign.style.fontSize="0.8em"
			       		document.getElementById("sign_user_email").style.borderColor="white";
			   			document.getElementById("sign_user_password").style.borderColor="red";
			   			document.getElementById("sign_user_password_confirm").style.borderColor="red";
			   			document.getElementById("sign_user_age").style.borderColor="white";
			           	check_sign.innerHTML = "비밀번호 형식이 틀렸습니다. (영문 / 숫자 - 6~12글자)";
			           	user_pw.focus();
			               return;
			           }
			           if(user_chk_pw.value == ""){
			           	check_sign.style.textAlign="center";
			           	check_sign.style.color="#FF0000";
			           	check_sign.style.paddingTop="10px";
			           	check_sign.style.fontSize="0.8em"
			           	document.getElementById("sign_user_email").style.borderColor="white";
			       		document.getElementById("sign_user_password").style.borderColor="white";
			   			document.getElementById("sign_user_password_confirm").style.borderColor="red";
			   			document.getElementById("sign_user_age").style.borderColor="white";
			           	check_sign.innerHTML = "확인 비밀번호를 입력하세요.";
			               user_chk_pw.focus();
			               return;
			           }
			           if(!(user_pw.value == user_chk_pw.value)){
			           	check_sign.style.textAlign="center";
			           	check_sign.style.color="#FF0000";
			           	check_sign.style.paddingTop="10px";
			           	check_sign.style.fontSize="0.8em"
			               check_sign.innerHTML = "비밀번호와 확인 비밀번호가 일치하지 않습니다.";
			               document.getElementById("sign_user_email").style.borderColor="white";
			           	document.getElementById("sign_user_password").style.borderColor="red";
			           	document.getElementById("sign_user_password_confirm").style.borderColor="red";
			   			document.getElementById("sign_user_age").style.borderColor="white";
			           	user_chk_pw.focus();
			           	return;
			           }
			           if(user_age.value == ""){
				           	check_sign.style.textAlign="center";
				           	check_sign.style.color="#FF0000";
				           	check_sign.style.paddingTop="10px";
				           	check_sign.style.fontSize="0.8em"
				           	document.getElementById("sign_user_email").style.borderColor="white";
				       		document.getElementById("sign_user_password").style.borderColor="white";
				           	document.getElementById("sign_user_password_confirm").style.borderColor="white";
				   			document.getElementById("sign_user_age").style.borderColor="red";
				           	check_sign.innerHTML = "나이를 입력하세요.";
				           		user_age.focus();
				               return;
				           }
			           
			        var dataPack = new Object();
			       	dataPack.user_email = user_email.value;
			       	var ajaxResult = ajaxHelper("/hak/CheckAllEmail", {"paramPack" : JSON.stringify(dataPack)});

			       	ajaxResult.success(function(data){
			       		var memberVo = data.memberVo;
			       		if(memberVo.length > 0){
			       			
			       			check_sign.style.textAlign="center";
			               	check_sign.style.color="#FF0000";
			               	check_sign.style.paddingTop="10px";
			               	check_sign.style.fontSize="0.8em"
			                check_sign.innerHTML = "이미 가입된 이메일입니다.";
			                document.getElementById("sign_user_email").style.borderColor="red";
			               	document.getElementById("sign_user_password").style="white";
			               	document.getElementById("sign_user_password_confirm").style="white";
			               	document.getElementById("sign_user_age").style.borderColor="white";
			       			
			       			$("#sign_user_email").val("");
			       			$("#sign_user_email").focus();
			       			
			       		}else {
			       			$("#register").hide();
							signUpMember();
			       		}
			       	});
		}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//회원가입 실제 데이터 삽입
		function signUpMember(){
		    	  var dataPack = new Object();
		     		dataPack.user_email = document.getElementById("sign_user_email").value;
		         	dataPack.user_password = document.getElementById("sign_user_password").value;
		         	dataPack.user_age = document.getElementById("sign_user_age").value;
		         	var ajaxResult = ajaxHelper("/hak/SignMember", {"paramPack" : JSON.stringify(dataPack)});

		         	ajaxResult.success(function(data){
		         		var insertResult = data.insertResult;
		         		if(insertResult != "1"){
		         			alert("회원가입 오류");
		         		}else{
		         			var dataPack = new Object();
		        	       	dataPack.user_email = document.getElementById("sign_user_email").value;
		        	       	dataPack.user_password = document.getElementById("sign_user_password").value;
		        	       	var ajaxResult = ajaxHelper("/hak/CheckLogin", {"paramPack" : JSON.stringify(dataPack)});
		        	      	ajaxResult.success(function(data){
		        	       			location.reload();
		        	 		});
					}
		         });
}
		
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//로그인 프로세스
		function loginProcess() {
	        var regix_email = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
	       	var regix_pw = /^[a-z0-9]{6,12}$/;
	       	var user_email = document.getElementById("login_email");
			var user_pw = document.getElementById("login_pwd");
			var check_login = document.getElementById("check_login");
			
			if(user_email.value == ""){
				check_login.style.textAlign="center";
	   			check_login.style.color="#FF0000";
	   			check_login.style.paddingTop="10px";
	   			check_login.style.fontSize="0.8em"
	   			document.getElementById("login_email").style.borderColor="red";
	   			document.getElementById("login_pwd").style.borderColor="white";
	           	check_login.innerHTML = "이메일을 입력하세요.";
	               user_email.focus();
	               return;
	           }
	           if(regix_email.test(user_email.value) != true){
	           	check_login.style.textAlign="center";
	   			check_login.style.color="#FF0000";
	   			check_login.style.paddingTop="10px";
	   			check_login.style.fontSize="0.8em"
	   			document.getElementById("login_email").style.borderColor="red";
	   			document.getElementById("login_pwd").style.borderColor="white";
	           	check_login.innerHTML = "이메일 형식이 틀렸습니다. (xx@xx.xx)";
	               user_email.focus();
	               return;
	           }
	           if(user_pw.value == ""){
	           	check_login.style.textAlign="center";
	   			check_login.style.color="#FF0000";
	   			check_login.style.paddingTop="10px";
	   			check_login.style.fontSize="0.8em"
	       		document.getElementById("login_email").style.borderColor="white";
	   			document.getElementById("login_pwd").style.borderColor="red";
	           	check_login.innerHTML = "비밀번호를 입력하세요.";
	               user_pw.focus();
	               return;
	           }
	       	

	       	var dataPack = new Object();
	       	dataPack.user_email = user_email.value;
	       	dataPack.user_password = user_pw.value;
	       	var ajaxResult = ajaxHelper("/hak/CheckLogin", {"paramPack" : JSON.stringify(dataPack)});

	       	ajaxResult.success(function(data){
	       		var memberIdVO = data.memberIdVO;
	       		if(memberIdVO.length > 0){
	       			location.reload();
	       		}else {
	       			check_login.style.textAlign="center";
	       			check_login.style.color="#FF0000";
	       			check_login.style.paddingTop="10px";
	       			check_login.style.fontSize="0.8em"
					
	       			$("#login_pwd").val("");
	       			$("#login_pwd").focus();
		       		document.getElementById("login_email").style.borderColor="red ";
	               	document.getElementById("login_pwd").style.borderColor="red";
	               	check_login.innerHTML = "아이디 혹은 비밀번호가 유효하지 않습니다.";
	       		}
	       	});
		}
		
		function forgotPasswd()
		{
			$("#login_2").modal('hide');
			$("#forgotPassword").modal('show');
		}
	
		function goToSignUp(){
		 $("#login_2").modal('hide');
		 $("#register").modal('show'); 
		}
		</script>
