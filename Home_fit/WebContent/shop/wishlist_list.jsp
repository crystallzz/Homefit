<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
let alldelchk=[];
let allpurchk=[];

$(function(){
	$('.wishdelete').click(function(){
		let wishlist_no=$(this).attr("data-value");
		//$('#wishlist_no').val(wishlist_no);
		console.log(wishlist_no);
		console.log('나오겠지?');
		$.ajax({
			type:'post',
			url:'../shop/wishlist_cancel.do',
			data:{"wishlist_no":wishlist_no},
			success:function(result){
				$('#wishlist_list').html(result);
			}
		})
	})
	
	$('#check_all').click( function() {
         $('.cb').prop( 'checked', this.checked );
    });
	
	$('#listdelete').click(function(){
		// 체크박스의 선택여부 확인 => radio
		//checkbox의 name값이 cb이면서 체크되어 있는 함수를 each함수로 호출한다. 
		$(".cb:checked").each(function() { 
			alldelchk.push($(this).val());
			});
	});
	
// 	$('#listpurchase').click(function(){
// 		// 체크박스의 선택여부 확인 => radio
// 		let len=$('.cb:checked').length;
// 		if(len==0)
// 		{
// 		   alert("승인할 대상을 선택하세요!!");
// 		}
// 		else
// 		{
// 			$('#frm').submit();//submit효과 => form태그의 action에등록 파일로 데이터 전송
// 		}
// 	});
	
});
</script>
</head>
<body >




				<table class="table">
					<thead>
                          <tr>
                          	  <th scope="col" style="width:15%">
                          	  <h7>전체선택 </h7><input type="checkbox" id="check_all"/>
          					  </th>
                              <th scope="col" style="width:40%">제품</th>
                              <th scope="col" style="width:15%">가격</th>
                              <th scope="col" style="width:10%">수량</th>
                              <th scope="col" style="width:15%">합계</th>
                              <th scope="col" style="width:5%"></th>
                          </tr>
                      </thead>
					<tbody>
                      	<c:forEach var="vo" items="${list }">
                          <tr>
                          	  <td class="text-center">
				                <c:if test="${vo.iswish=='n' }">
				                  <input type="checkbox" value="${vo.wishlist_no }" class="cb" name=cb>
				                </c:if>
				              </td>
                              <td style="width:50%">
                                  <div class="media">
                                      <div class="d-flex" style="width:20%">
                                      	<a href="../shop/shop_detail.do?shop_no=${vo.shop_no }">
                                          <img src="${vo.svo.poster }" style="width:90%">
                                        </a>
                                      </div>
                                      <div class="media-body" style="width:70%">
                                      	<a href="../shop/shop_detail.do?shop_no=${vo.shop_no }">${vo.svo.title }</a>
                                      </div>
                                  </div>
                              </td>
                              <td style="width:15%">
                                  <h5>${vo.svo.price }</h5>
                              </td>
                              <td>
                                  <div class="product_count">
                                      <input type="text" name="qty" id="sst" maxlength="12" value="1" title="Quantity:"
                                          class="input-text qty">
                                      <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst )) result.value++;return false;"
                                          class="increase items-count" type="button"><i class="lnr lnr-chevron-up"></i></button>
                                      <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst ) &amp;&amp; sst > 0 ) result.value--;return false;"
                                          class="reduced items-count" type="button"><i class="lnr lnr-chevron-down"></i></button>
                                  </div>
                              </td>
                              <!-- 
                              <td>
                                  <div class="product_count">
                                      <input type="text" name="qty" id="sst" maxlength="12" value="1" title="Quantity:"
                                          class="input-text qty">
                                      <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst )) result.value++;return false;"
                                          class="increase items-count" type="button"><i class="lnr lnr-chevron-up"></i></button>
                                      <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst ) &amp;&amp; sst > 0 ) result.value--;return false;"
                                          class="reduced items-count" type="button"><i class="lnr lnr-chevron-down"></i></button>
                                  </div>
                              </td>
                               -->
                              <td style="width:15%">
                                  <h5>합계</h5>
                              </td>
                              <td style="width:5%">
                                 <c:if test="${vo.iswish=='n' }">
                                 	<button class="btn btn-sm btn-primary wishdelete" data-value="${vo.wishlist_no}" >삭제</button>
					             </c:if>
                              </td>
                          </tr>
                          </c:forEach>
                          

                      </tbody>
              </table>
              
              <button class="btn btn-sm btn-danger" id="alldelete">삭제</button>
              <button onclick="location.href='../shop/shop.do'" class="btn btn-sm btn-primary">목록</button>
              <button class="btn btn-sm btn-success" id="allpurchase">구매하기</button>
             
              
</body>
</html>