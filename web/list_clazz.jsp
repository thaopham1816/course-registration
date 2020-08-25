<!DOCTYPE html>
<%@page import="entity.Year"%>
<%@page import="entity.User"%>
<%@page import="entity.Semester"%>
<%@page import="dao.YearDAO"%>
<%@page import="dao.SemesterDAO"%>
<%@page import="entity.Course"%>
<%@page import="dao.CourseDAO"%>
<%@page import="entity.Clazz"%>
<%@page import="java.util.List"%>
<%@page import="dao.ClazzDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html lang="en">
    <head>
        <title>Student Management System</title>
        <link rel="stylesheet" href="css/reset.css" type="text/css" media="all">
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all">
        <script type="text/javascript" src="js/jquery-1.4.2.min.js" ></script>
        <script type="text/javascript" src="js/cufon-yui.js"></script>
        <script type="text/javascript" src="js/cufon-replace.js"></script>
        <script type="text/javascript" src="js/Myriad_Pro_300.font.js"></script>
        <script type="text/javascript" src="js/Myriad_Pro_400.font.js"></script>
        <script type="text/javascript" src="js/script.js"></script>
        <!--[if lt IE 7]>
             <link rel="stylesheet" href="css/ie/ie6.css" type="text/css" media="screen">
             <script type="text/javascript" src="js/ie_png.js"></script>
             <script type="text/javascript">
                ie_png.fix('.png, footer, header nav ul li a, .nav-bg, .list li img');
             </script>
        <![endif]-->
        <!--[if lt IE 9]>
                <script type="text/javascript" src="js/html5.js"></script>
          <![endif]-->
    </head>
    <%
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            response.sendRedirect("login.jsp");
        }

        int i = 0;
        SemesterDAO semesterDAO = new SemesterDAO();
        List<Semester> semesters = semesterDAO.findAllSemesters();

        YearDAO yearDAO = new YearDAO();
        List<Year> years = yearDAO.findAllYears();

        ClazzDAO clazzDAO = new ClazzDAO();
        Semester semester;
        Year year;
        try {
            semester = semesterDAO.findSemesterByID(Integer.parseInt(request.getParameter("semester")));
        } catch (NumberFormatException e) {
            semester = semesterDAO.findSemesterByID(1);
        }

        try {
            year = yearDAO.findYearByID(Integer.parseInt(request.getParameter("year")));
        } catch (NumberFormatException e) {
            year = yearDAO.findYearByID(1);
        }

        int total = clazzDAO.findClazzBySemester(semester, year).size();
        int numPerPage = 5;
        int pageNumber = 0;
        if (request.getParameter("pageNum") != null) {
            pageNumber = Integer.parseInt(request.getParameter("pageNum"));
        }
        List<Clazz> clazzes = clazzDAO.findClazzBySemester(semester, year, numPerPage, (pageNumber * numPerPage));

        String keyword = request.getParameter("keyword");
        if (keyword != null) {
            clazzes = clazzDAO.search(keyword, semester, year);
        }
    %>


    <body id="page1">
        <div class="wrap">
            <!-- header -->
            <header>
                <div class="container">
                    <h1><a href="index.jsp">Student's site</a></h1>
                    <nav>
                        <ul>
                            <li class="current"><a href="index.jsp" class="m1">Home 

                                    Page</a></li>
                            <li><a href="about-us.jsp" class="m2">About Us</a></li>
                            <li><a href="articles.jsp" class="m3">Our Articles</a></li>
                            <li><a href="contact-us.jsp" class="m4">Contact Us</a></li>
                            <li class="last"><a href="sitemap.jsp" class="m5">Site 

                                    Map</a></li>
                        </ul>
                    </nav>
                    <form action="" id="search-form">
                        <fieldset>
                            <div class="rowElem">
                                <input type="text" name="keyword"/>
                                <a href="#" onClick="document.getElementById('search-

                                                    form').submit()">Search</a></div>
                        </fieldset>
                    </form>
                </div>
            </header>
            <div class="container">
                <input type="button" name="btnLogin" value="Login" onclick="location.href='login.jsp'"/>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <form action="LogoutServlet">
                    <input id="btnLogout" name="btnLogout" type="submit" value="Logout"/>
                </form>
                <!-- aside -->
                <aside>
                    <h3>Categories</h3>
                    <ul class="categories">
                        <li><span><a href="list_faculty.jsp">Faculties</a></span></li>
                        <li><span><a href="list_major.jsp">Majors</a></span></li>
                        <li><span><a href="list_course.jsp">Courses</a></span></li>
                        <li><span><a href="list_clazz.jsp">Classes</a></span></li>
                        <li><span><a href="list_instructor.jsp">Instructors</a></span></li>
                        <li><span><a href="list_student.jsp">Students and 

                                    Registration</a></span></li>
                        <li><span><a href="manage_grade.jsp">Grade Management</a></span></li>
                        <li><span><a href="report_redirect.jsp">Reports</a></span></li>
                        <li><span><a href="list_user.jsp">Users</a></span></li>
                    </ul>
                    <form action="MailServlet" id="newsletter-form">
                        <fieldset>
                            <div class="rowElem">
                                <h2>Newsletter</h2>
                                <input type="email" value="Enter Your Email Here" onFocus="if
                                                            (this.value == 'Enter Your Email Here'){this.value = ''}" onBlur="if (this.value == '')

                                                                                        {this.value = 'Enter Your Email Here'}" >
                                <div class="clear"><a href="#" class="fright" 

                                                      onClick="document.getElementById('newsletter-form').submit()">Submit</a></div>
                            </div>
                        </fieldset>
                    </form>
                    <h2>Fresh <span>News</span></h2>
                    <ul class="news">
                        <li><strong>June 30, 2010</strong>
                            <h4><a href="#">Sed ut perspiciatis unde</a></h4>
                            Sed ut perspiciatis unde omnis iste natus error sit voluptatem 

                            accusantium doloremque. </li>
                        <li><strong>June 14, 2010</strong>
                            <h4><a href="#">Neque porro quisquam est</a></h4>
                            Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit 

                            aut fugit consequuntur magni. </li>
                        <li><strong>May 29, 2010</strong>
                            <h4><a href="#">Minima veniam, quis nostrum</a></h4>
                            Uis autem vel eum iure reprehenderit qui in ea voluptate velit 


                            esse quam nihil molestiae. </li>
                    </ul>
                </aside>
                <!-- content -->
                <section id="content">
                    <div class="inside">        
                        <!-- modification starts-->

                        <form name="fmClazz">
                            <label for="semester">Semester:</label>
                            <br/>
                            <select name="semester" onchange="submit()">
                                <%
                                    if (semesters != null && semesters.size() != 0 && years != null && years.size() != 0) {
                                        for (Semester each : semesters) {
                                            i++;
                                %>
                                <option value="<%=each.getId()%>"
                                        <%
                                            if (each.getId() == semester.getId()) {
                                                out.print(" selected ");
                                            }
                                        %>
                                        ><%=each.getName()%></option>
                                <%
                                    }
                                %>
                            </select>

                            <br/>
                            <select name="year" onchange="submit()">
                                <%
                                    for (Year each : years) {
                                        i++;
                                %>
                                <option value="<%=each.getId()%>"
                                        <%
                                            if (each.getId() == year.getId()) {
                                                out.print(" selected ");
                                            }
                                        %>
                                        ><%=each.getValue()%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>

                            <table class="myListTable">
                                <tr>
                                    <th>No.</th>
                                    <th>Class Name</th>
                                    <th>Course Name</th>
                                    <th>Course Description</th>
                                    <th>&nbsp;</th>
                                </tr>
                                <%
                                    if (clazzes != null && clazzes.size() != 0) {
                                        i = 0;
                                        for (Clazz each : clazzes) {
                                            i++;
                                %>
                                <tr>
                                    <td><%=i%></td>
                                    <td><a href="edit_clazz.jsp?id=<%=each.getId()%>"><%=each.getName()%></a></td>
                                    <td><%=each.getCourse().getName()%></td>
                                    <td><%=each.getCourse().getDescription()%></td>
                                    <td><a href="DeleteClazzServlet?id=<%=each.getId()%>">Delete</a></td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </table>
                            <%
                                int totalPages = (total / numPerPage);
                                if (total % numPerPage != 0) {
                                    totalPages++;
                                }
                                if (pageNumber != 0) {
                                    out.print("<a href='list_clazz.jsp?semester=" + semester.getId() + "&year=" + year.getId() + "&pageNum=" + (pageNumber - 1)
                                            + "'>Previous</a> ");
                                }
                                out.print("Page ");
                                for (int j = 0; j < totalPages; j++) {

                                    if (j != pageNumber) {
                                        out.print("<a href='list_clazz.jsp?semester=" + semester.getId() + "&year=" + year.getId() + "&pageNum=" + j
                                                + "'>" + (j + 1) + "</a> ");
                                    } else {
                                        out.print((j + 1) + " ");
                                    }
                                }
                                if (pageNumber != (totalPages - 1)) {
                                    out.print("<a href='list_clazz.jsp?semester=" + semester.getId() + "&year=" + year.getId() + "&pageNum=" + (pageNumber + 1)
                                            + "'>Next</a> ");
                                }
                            %>
                            <div>
                                <input type="button" name="btnToAdd" value="Add New Class" onclick="location.href = 'edit_clazz.jsp'" />
                            </div>
                        </form>
                        <p>${message}</p>



                        <!-- modification ends-->
                    </div>
                </section>
            </div>
        </div>
        <!-- footer -->
        <footer>
            <div class="container">
                <div class="inside">
                    <div class="wrapper">
                        <div class="fleft">24/7 Customer Service 

                            <span>8.800.146.56.7</span></div>
                        <div class="aligncenter"><a rel="nofollow" href="#" 

                                                    class="new_window">Website template</a> designed by TemplateMonster.com<br>
                            <a href="#" class="new_window">3D Models</a> provided by 

                            Templates.com</div>
                    </div>
                </div>
            </div>
        </footer>
        <script type="text/javascript"> Cufon.now();</script>
    </body>
</html>
