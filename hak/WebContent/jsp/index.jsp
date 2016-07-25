<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/jsp/com/headerF.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <jsp:include page="/jsp/com/top_declare.jsp"/>

	
	
</head>

<body>


	<div id="preloader">
        <div class="sk-spinner sk-spinner-wave" id="status">
            <div class="sk-rect1"></div>
            <div class="sk-rect2"></div>
            <div class="sk-rect3"></div>
            <div class="sk-rect4"></div>
            <div class="sk-rect5"></div>
        </div>
    </div>
    <!-- End Preload -->


<jsp:include page="/jsp/com/header.jsp"/>
<jsp:include page="/jsp/com/sub_header.jsp"/>
<jsp:include page="/jsp/com/search_header.jsp"/> 
  



<!-- Content ================================================== -->
<div class="container margin_60_35">
	<div class="row">
    
		<div class="col-md-3">
		
			<div id="filters_col">
				<a data-toggle="collapse" href="#collapseFilters" aria-expanded="false" aria-controls="collapseFilters" id="filters_col_bt">검색 <i class="icon-plus-1 pull-right"></i></a>
				<div class="collapse" id="collapseFilters">
					<div class="filter_type">
                    	<h6>학업 과정</h6>
                    	<ul>
							<li><label><input type="checkbox" name="type_all" value="type_all" checked class="icheck" onclick="filter('type', 'all')">모두 선택 <small></small></label></li>
							<li><label><input type="checkbox" name="type" value="type_1" class="icheck" onclick="filter('type', '1')">초등 <small></small></label><i class="color_1"></i></li>
							<li><label><input type="checkbox" name="type" value="type_2" class="icheck" onclick="filter('type', '2')">중등 <small></small></label><i class="color_2"></i></li>
							<li><label><input type="checkbox" name="type" value="type_3" class="icheck" onclick="filter('type', '3')">고등 <small></small></label><i class="color_3"></i></li>
							<!-- 
							<li><label><input type="checkbox" class="icheck">재수 <small></small></label><i class="color_4"></i></li>
							 -->
						</ul>
					</div>
					<div class="filter_type">
						<h6>과목</h6>
						<ul>
							<li><label><input type="checkbox" name="subject_all" value="subject_all" checked class="icheck" onclick="filter('subject', 'all')">모두 선택 <small></small></label></li>
							<li><label><input type="checkbox" name="subject" value="subject_1" class="icheck" onclick="filter('subject', '1')">종합 <small></small></label><i class="color_1"></i></li>
							<li><label><input type="checkbox" name="subject" value="subject_2" class="icheck" onclick="filter('subject', '2')">영어 <small></small></label><i class="color_1"></i></li>
							<li><label><input type="checkbox" name="subject" value="subject_3" class="icheck" onclick="filter('subject', '3')">수학 <small></small></label><i class="color_2"></i></li>
							<li><label><input type="checkbox" name="subject" value="subject_4" class="icheck" onclick="filter('subject', '4')">국어 <small></small></label><i class="color_3"></i></li>
							<!-- 
							<li><label><input type="checkbox" class="icheck">과학 <small></small></label><i class="color_4"></i></li>
							<li><label><input type="checkbox" class="icheck">사회 <small></small></label><i class="color_5"></i></li>
							<li><label><input type="checkbox" class="icheck">한국사 <small></small></label><i class="color_6"></i></li>
							 -->
						</ul>
					</div>
					<div class="filter_type">
						<h6>나의 성적</h6>
						<ul>
							<li><label><input type="checkbox" name="my_grade_all" value="my_grade_all" checked class="icheck" onclick="filter('my_grade', 'all')">모두 선택 <small></small></label></li>
							<li><label><input type="checkbox" name="my_grade" value="my_grade_1" class="icheck" onclick="filter('my_grade', '1')">최상위권 <small></small></label><i class="color_1"></i></li>
							<li><label><input type="checkbox" name="my_grade" value="my_grade_2" class="icheck" onclick="filter('my_grade', '2')">상위권 <small></small></label><i class="color_2"></i></li>
							<li><label><input type="checkbox" name="my_grade" value="my_grade_3" class="icheck" onclick="filter('my_grade', '3')">중위권 <small></small></label><i class="color_2"></i></li>
							<li><label><input type="checkbox" name="my_grade" value="my_grade_4" class="icheck" onclick="filter('my_grade', '4')">하위권 <small></small></label><i class="color_4"></i></li>
						</ul>
					</div>
					<div class="filter_type">
						<h6>수업방식</h6>
						<ul>
							<li><label><input type="checkbox" name="teaching_type_all" checked class="icheck" onclick="filter('teaching_type', 'all')">모두 선택 <small></small></label></li>
							<li><label><input type="checkbox" name="teaching_type" value="teaching_type_1" class="icheck" onclick="filter('teaching_type', '1')">대규모 강의식(30명 이상) <small></small></label><i class="color_1"></i></li>
							<li><label><input type="checkbox" name="teaching_type" value="teaching_type_2" class="icheck" onclick="filter('teaching_type', '2')">중규모 강의식(15명 이상) <small></small></label><i class="color_1"></i></li>
							<li><label><input type="checkbox" name="teaching_type" value="teaching_type_3" class="icheck" onclick="filter('teaching_type', '3')">소규모 강의식(10명 이상) <small></small></label><i class="color_2"></i></li>
							<li><label><input type="checkbox" name="teaching_type" value="teaching_type_4" class="icheck" onclick="filter('teaching_type', '4')">과외식 <small></small></label><i class="color_3"></i></li>
						</ul>
					</div>
				
				</div><!--End collapse -->
			</div><!--End filters col-->
		</div><!--End col-md -->
        
		<div class="col-md-9">
        
				<div class="row" >
					<div class="col-md-3 col-sm-3 col-xs-6">
						<div class="input-group col-md-12" style="margin-bottom:10px">
		                   <input class="form-control input-lg" style="width:605%; height:48px; margin-right:0px; padding-top: 0px; padding-bottom: 0px; margin-top: 0px;" type="text" placeholder="학원 이름">
		                    <span class="input-group-btn">
		                        <button class="btn btn-info btn-lg" style="background-color:rgba(132, 200, 156, 1); border-color:rgba(132, 200, 156, 1); margin-left:1110%; height:48px; padding-top: 5px; padding-bottom: 5px;" type="button">
		                            <i class="icon-search-1"></i>
		                        </button>
		                    </span>
		                </div>
					</div>
				</div>
        
       		 <div id="hak_info"></div>
            
            <a href="#0" class="load_more_bt wow fadeIn" data-wow-delay="0.2s">더보기</a>  
		</div><!-- End col-md-9-->
        
	</div><!-- End row -->
</div><!-- End container -->
<!-- End Content =============================================== -->


<jsp:include page="/jsp/com/footer.jsp"/>

<div class="layer"></div><!-- Mobile menu overlay mask -->
 

<script src="/js/ion.rangeSlider.js"></script>
<script>
    $(function () {
		 'use strict';
        $("#range").ionRangeSlider({
            hide_min_max: true,
            keyboard: true,
            min: 0,
            max: 15,
            from: 0,
            to:5,
            type: 'double',
            step: 1,
            prefix: "Km ",
            grid: true
        });
    });
    
    function filter(type, sep){
    	if(sep == 'all'){				//모두 선택 눌렀을 때
    		switch(type){
    		case 'type':
    			 $('input:checkbox[name="type"]').each(function() {
    			            this.checked = false; 
    			 });
    			break;
    		case 'subject':
	   			 $('input:checkbox[name="subject"]').each(function() {
			            this.checked = false; 
			 	});
	   			 break;
    		case 'my_grade':
	   			 $('input:checkbox[name="my_grade"]').each(function() {
			            this.checked = false; 
			 	});
    			break;
    		case 'teaching_type':
	   			 $('input:checkbox[name="teaching_type"]').each(function() {
			            this.checked = false; 
			 	});
    			break;
    		}
    	}else{							//일반 항목 눌렀을 때
    		switch(type){
    		case 'type':
    			 $('input:checkbox[name="type_all"]').each(function() {
    			            this.checked = false; 
    			 });
    			break;
    		case 'subject':
	   			 $('input:checkbox[name="subject_all"]').each(function() {
			            this.checked = false; 
			 	});
	   			 break;
    		case 'my_grade':
	   			 $('input:checkbox[name="my_grade_all"]').each(function() {
			            this.checked = false; 
			 	});
    			break;
    		case 'teaching_type':
	   			 $('input:checkbox[name="teaching_type_all"]').each(function() {
			            this.checked = false; 
			 	});
    			break;
    		}
    	}
		
    }
</script>
</body>
</html>
