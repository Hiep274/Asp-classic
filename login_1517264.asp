<!-- #include file="connect_1517264.asp" -->
<%
    If (Not isnull(Session("email"))) AND (Trim(Session("email"))<>"") Then
        Response.redirect("/")
    End If
    email = Request.form("email")
    password = Request.form("password")
    If (NOT isnull(email) AND Trim(email)<>"") AND (NOT isnull(password) AND Trim(password)<>"") Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "SELECT * FROM users WHERE email=? AND password=?"
            cmdPrep.parameters.Append cmdPrep.createParameter("email", 202, 1, 255, email)
            cmdPrep.parameters.Append cmdPrep.createParameter("password", 202, 1, 255, password)
            
            Set Result = cmdPrep.execute

            if not Result.EOF then
                email=Result("email")
                userid = Result("id")
                role = Result("role")
                Session("email")=email
                Session("user_id")=userid
                Session("role")=role
                Session("Success")="Login successfully"
                If (NOT isnull(Session("CurrentPage"))) AND (TRIM(Session("CurrentPage"))<>"") Then
                    Response.redirect(Session("CurrentPage"))
                    Session.Contents.Remove("CurrentPage")
                Else
                    Response.redirect("/")
                End If
            Else
                Session("Error")="Wrong email or password"
            End if
    Else
        If (Request.ServerVariables("Request_Method") = "POST") Then
            Session("Error") = "You need to input information"
        End If
    End If
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet"  crossorigin="anonymous">
        <title>CRUD Example</title>
    </head>
    <body>

        <!-- #include file="header_1517264.asp" -->
        <div class="container">
            <form method="post" action="login_1517264.asp">
                <div class="mb-3">
                    <label for="name" class="form-label">Email</label>
                    <input type="text" class="form-control" id="email" name="email" value="<%=email%>">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password">
                </div>
                <button type="submit" class="btn btn-primary">Login</button>
            </form>
        </div>

        <script src="../assets/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    </body>
</html>