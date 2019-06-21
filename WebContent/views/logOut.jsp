   <%
   session.removeAttribute("user");
   response.sendRedirect(request.getContextPath()+"/welcome.jsp");
   return;   
   %>