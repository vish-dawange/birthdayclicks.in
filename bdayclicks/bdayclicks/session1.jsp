<%  
    String name = request.getParameter("uname");
       session.setAttribute("username",name);
                response.sendRedirect("/bdayclicks/profile.jsp");
      
        %>