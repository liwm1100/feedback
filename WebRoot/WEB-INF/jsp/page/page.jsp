<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="paging2">
    <p>共<c:if test="${page.pages==null}">0</c:if> <c:if test="${page.pages!=null}">${page.pages}</c:if>页/
		<c:if test="${page.total==null}">0</c:if> <c:if test="${page.total!=null}">${page.total}</c:if>条记录,当前第
		<c:if test="${page.pageNum==null}">0</c:if> <c:if test="${page.pageNum!=null}">${page.pageNum}</c:if>页</p>
    <ul class="pagingUl2">
    	<c:if test="${page.hasPreviousPage}">
    		<li><a href="javascript:go(${page.firstPage});">首页</a></li>
    	</c:if>
		<c:if test="${page.hasPreviousPage}">
    		<li><a href="javascript:void(0);" onclick="go('${page.prePage}')">上一页</a></li>
		</c:if>
		<c:if test="${page.hasNextPage}">
    		<li><a href="javascript:void(0);" onclick="go('${page.nextPage}')">下一页</a></li>
			</c:if>
		<c:if test="${page.hasNextPage}">
    		<li><a href="javascript:go(${page.lastPage});">末页</a></li>
		</c:if>
    	<li style="width: 80px;">转到第<input type="text" size="5" style="height: 20px; width: 30px;" name="textfield" id="goPage"></li>
    	<li><a href="javascript:void(0);" onclick="goPage();" style="cursor:pointer;">跳转</a></li>
    </ul>
</div>
<script type="text/javascript">
  var queryStr="?${queryString}";
  function go(page){  
  	queryStr = queryStr.replace(/&*(pageNum)\s*=\s*(\d*)/g,""); 
  	queryStr = queryStr+"&pageNum="+page;
  	queryStr = queryStr.replace("?&","?");
  	window.location=queryStr;
  }
  
   function goPage(){
  	var regex=new RegExp("^[0-9]*$");
  	var page = document.getElementById("goPage").value;
  	if(!regex.test(page)){
	  	alert("请输入数字！");
	  	return;
  	}
  	if(page > ${page.pages} || page < 1){
  		alert("请输入1~"+${page.pages}+"的页数！");
  		return;
  	}
  	queryStr = queryStr.replace(/&*(pageNum)\s*=\s*(\d*)/g,""); 
  	queryStr = queryStr+"&pageNum="+page;
  	queryStr = queryStr.replace("?&","?");
  	window.location=queryStr;
  }
 </script>