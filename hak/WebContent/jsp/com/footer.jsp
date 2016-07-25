<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/com/headerF.jsp"%>
<c:set var="userInfo" value="${sessionScope.USERINFO}" />

<script>

	function submit_contact_form(type){
		var user_email = "${userInfo.user_email}";
		if(user_email == null){
			alert("로그인 후 이용 부탁드립니다.");			
		}
		var contact_type = type;
		var content = $('#contact_form').val();
		var dataPack = new Object();
		dataPack.type = contact_type;
		dataPack.email = user_email;
		dataPack.content = content;
    	var ajaxResult = ajaxHelper("/hak/RequestContact", {"paramPack" : JSON.stringify(dataPack)});
    	ajaxResult.success(function(data){
    		location.reload();
    	});
    	
		
		
	}

</script>  
  <!-- Footer ================================================== -->
	<footer>
        <div class="container">
            <div class="row">
                <!-- Content ================================================== -->
			<div class="container margin_60_35">
				<div class="row" id="contacts">
			    	<div class="col-md-6 col-sm-6">
			        	<div class="box_style_2">
			            	<h2 class="inner">문의</h2>
			                <p class="add_bottom_30">원하시는 학원 정보를 요청하시면 신속하게 확인하여 이메일로 연락드리겠습니다. <br>기존의 정보와 다른 새로운 분야의 학원 정보도 요청 가능 합니다.<br><br><strong>문자로 정보를 받고 싶으신 분은 연락처를 함께 남겨 주세요.</strong></p>
			                <textarea id="contact_form" class="form-control" rows="10"></textarea>
		                    <span class="input-group-btn" style="text-align:right">
		                        <button onclick="submit_contact_form(0);" class="btn btn-info btn-lg" style="margin-top:10px; padding-top: 5px; padding-bottom: 5px; background-color:rgba(120, 206, 206, 1); border-color:rgba(120, 206, 206, 1);" type="button">
		                            	문의 제출
		                        </button>
		                    </span>
			                <p class="nopadding"><i class="icon-mail-3"></i>ouhhh777@naver.com</p>
			            </div>
			    	</div>
			        <div class="col-md-6 col-sm-6">
			        	<div class="box_style_2">
			            	<h2 class="inner">학원 정보 등록 문의</h2>
			                <p class="add_bottom_30"><strong>학원 정보 등록, 수정</strong>을 원하시는 담당자분께서는 아래 메일로 연락 주시면 간편하게 등록하실 수 있게 친절하게 도와드리겠습니다.</p>
			                 <textarea id="contact_form"  class="form-control" rows="10"></textarea>
		                    <span class="input-group-btn" style="text-align:right">
		                        <button onclick="submit_contact_form(1)" class="btn btn-info btn-lg" style="margin-top:10px; padding-top: 5px; padding-bottom: 5px; background-color:rgba(120, 206, 206, 1); border-color:rgba(120, 206, 206, 1);" type="button">
		                            	문의 제출
		                        </button>
		                    </span>
			                <p class="nopadding"><i class="icon-mail-3"></i>ouhhh777@naver.com</p>
			            </div>
			    	</div>
			    </div><!-- End row -->
			</div><!-- End container -->
			<!-- End Content =============================================== -->
                
            </div><!-- End row -->
       </div>
            <div class="row">
                <div class="col-md-12">
                    <div id="social_footer">
                        <ul>
                           
                        </ul>
                        <p>Â© Aiden Kim 2016</p>
                    </div>
                </div>
            </div><!-- End row -->
        </div><!-- End container -->
    </footer>
<!-- End Footer =============================================== -->
</body>
</html>