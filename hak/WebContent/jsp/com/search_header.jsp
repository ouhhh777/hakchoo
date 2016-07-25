<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/com/headerF.jsp"%>

<c:set var="addressVo" value="${resultMap.addressVo}" />

	<script type="text/javascript">
//////////////////////////////////////////////////////////////////////////////////////
//select 박스 동적 변경
		function doChange(srcE, targetId){
	
			
			    var val = srcE.options[srcE.selectedIndex].value;
			if(val != 'default'){
			    var targetE = document.getElementById(targetId);
			    removeAll(targetE);
			    
			    var dataPack = new Object();
			    dataPack.address_name = val;
			    if(targetId == 'selTwo'){
			    	var ajaxResult = ajaxHelper("/hak/Find_gu_info", {"paramPack" : JSON.stringify(dataPack)});
			    	ajaxResult.success(function(data){
				    	var addressVo = data.addressVo;
				    	for(var i in addressVo){
				    		addOption(addressVo[i].gu_name, targetE);
				    	}
				    });
			    }else{
			    	var ajaxResult = ajaxHelper("/hak/Find_dong_info", {"paramPack" : JSON.stringify(dataPack)});
			    	ajaxResult.success(function(data){
				    	var addressVo = data.addressVo;
				    	for(var i in addressVo){
				    		addOption(addressVo[i].dong_name, targetE);
				    	}
				    });
			    }
			}
		}
		
		function addOption(value, e){
		    var o = new Option(value);
		    try{
		        e.add(o);
		    }catch(ee){
		        e.add(o, null);
		    }
		}
		
		function removeAll(e){
		    for(var i = 0, limit = e.options.length; i < limit - 1; ++i){
		        e.remove(1);
		    }
		}
		
		
		
	</script>
	
            <div class="searchheader">
            	<div style="text-algin:center; margin-left:30%">
                 	<div class="search-select styled-select">
                        <select name="selOne" id="selOne" class="form-control" onchange="doChange(this, 'selTwo')">
                        	<option value="default">도시 선택</option>
                        	<c:forEach var = "addressVo" items="${addressVo}" varStatus="status">
                            	<option value="${addressVo.si_name}">${addressVo.si_name}</option>
                            </c:forEach>
                        </select>
                    </div>
					<div class="search-select styled-select">
                        <select name="selTwo" id="selTwo" class="form-control" onchange="doChange(this, 'selThree')">
                        	<option value="default">지역 선택</option>
                        </select>
                    </div>
                    <div class="search-select styled-select">
                        <select name="selThree" id="selThree" class="form-control">
                        	<option value="default">세부 지역 선택</option>
                        </select>
                    </div>
                        <button class="btn_1" style="margin-top:13px; margin-right:42%" onclick="search();">검색</button>
                    
               </div>  
            </div><!-- End main-menu -->
 
	<script>
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		var dataPack = new Object();
		dataPack.swX = swArray[0];
		dataPack.swY = swArray[1];
		dataPack.neX = neArray[0];
		dataPack.neY = neArray[1];
		
    	var ajaxResult = ajaxHelper("/hak/RequestHakData", {"paramPack" : JSON.stringify(dataPack)});
    	ajaxResult.success(function(data){
    		var hakInfo = data.hakInfo;
    		
    		$('#hak_info').empty();
			  var html ="";
	    		html+='<div id="hak_info"class="strip_list wow fadeIn" data-wow-delay="0.1s">';
	    		html+='<div class="ribbon_1">';
	    		html+='Popular';
	   			html+='</div>';
				html+='<div class="row">';
				html+='<div class="col-md-9 col-sm-9">';
				html+='	<div class="desc">';
				html+='		<div class="thumb_strip">';
				html+='			<a href="detail_page.html"><img src="/img/thumb_restaurant.jpg" alt=""></a>';
				html+='		</div>';
				html+='				<div class="rating">';
				html+='						<i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star"></i> (<small><a href="#0">98 reviews</a></small>)';
				html+='					</div>';
				html+='				<h3>Taco Mexican</h3>';
				html+='					<div class="type">';
				html+='				Mexican / American';
				html+='				</div>';
				html+='			<div class="location">';
				html+='					135 Newtownards Road, Belfast, BT4. <span class="opening">Opens at 17:00.</span> Minimum order: $15';
				html+='			</div>';
				html+='			<ul>';
				html+='				<li>Take away<i class="icon_check_alt2 ok"></i></li>';
				html+='				<li>Delivery<i class="icon_check_alt2 no"></i></li>';
				html+='			</ul>';
				html+='		</div>';
				html+='	</div>';
				html+='	<div class="col-md-3 col-sm-3">';
				html+='		<div class="go_to">';
				html+='			<div>';
				html+='				<a href="detail_page.html" class="btn_1">View Menu</a>';
				html+='				</div>';
				html+='			</div>';
				html+='		</div>';
				html+='	</div><!-- End row-->';
				html+='</div';
				$('#hak_info').append(html);
    	});
				
	</script>
