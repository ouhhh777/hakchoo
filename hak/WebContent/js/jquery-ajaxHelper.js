function ajaxHelper(url, params, sucFunc, errFunc, addData){
	//alert(params.newDataObj.MENU_NM);
	return $.ajax({
        type: "POST"
        ,async: false
        ,url: url
        ,data: params
        ,dataType: "json"       
        ,contentType :"application/x-www-form-urlencoded;charset=UTF-8"
        ,success: function(data){
            if(sucFunc){
            	var successFunc = eval(sucFunc);
            	successFunc(data, addData);
            }
        }
        ,error : function(data, status, err) {
            alert('서버와의 통신이 실패했습니다.');
        	if(errFunc){
        		var errorFunc = eval(errFunc);
            	errorFunc(data, addData);
        	}
        }
	});
}