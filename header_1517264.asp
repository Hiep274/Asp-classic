
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="/">Crud Example</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="/">Home</a>
                </li>
            </ul>
            <div class="d-flex">
                <%
                    If (NOT isnull(Session("email"))) AND (TRIM(Session("email"))<>"") Then
                %>
                    <span class="navbar-text">Welcome <%=Session("email")%>!</span>
                    <a href="/logout_1517264.asp" class="btn btn-light ms-3">Logout</a>
                <%                        
                    Else
                %>                
                        <a href="/login_1517264.asp" class="btn btn-light ms-3">Login</a>
                <%
                    End If
                %>
            </div>
        </div>
    </div>
</nav>
<div class="container">
    <%
        If (NOT isnull(Session("Success"))) AND (TRIM(Session("Success"))<>"") Then
    %>
            <div class="alert alert-success" role="alert">
                <%=Session("Success")%>
            </div>
    <%
            Session.Contents.Remove("Success")
        End If
    %>
    <%
        If (NOT isnull(Session("Error"))) AND (TRIM(Session("Error"))<>"") Then
    %>
            <div class="alert alert-danger" role="alert">
                <%=Session("Error")%>
            </div>
    <%
            Session.Contents.Remove("Error")
        End If
    %>
</div>