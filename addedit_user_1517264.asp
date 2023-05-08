<!-- #include file="connect_1517264.asp" -->
<%  
    If (isnull(Session("email"))) OR (Trim(Session("email"))="") Then
        If (isnull(Request.ServerVariables("Query_String"))) OR (Trim(Request.ServerVariables("Query_String"))="") Then
            Session("CurrentPage")=Request.ServerVariables("URL")
        Else
            Session("CurrentPage")=Request.ServerVariables("URL") & "?" & Request.ServerVariables("Query_String")
        End If
        Response.redirect("/login_1517264.asp")
    End If
    If (Request.ServerVariables("Request_Method") = "GET") Then
        id = Request.QueryString("id")

        If (trim(id) = "") or (isnull(id)) then id = 0 end if
        If (cint(id) <> 0) Then

            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "SELECT id,name,email,password,role FROM users WHERE id=?"
            cmdPrep.parameters.Append cmdPrep.createParameter("id", 3, 1, , cint(id))
            
            Set Result = cmdPrep.execute

            if not Result.EOF then
                name = Result("name")
                email = Result("email")
                password = Result("password")
                role = Result("role")
            End If

            Set Result = Nothing
        End If
    Else
        id = Request.form("id")
        name = Request.form("name")
        email = Request.form("email")
        password = Request.form("password")
        role = Request.form("role")

        If (trim(id) = "") or (isnull(id)) then id = 0 end if

        if cint(id) = 0 then

            If (NOT isnull(name) and (name<>"")) and (NOT isnull(email) and (email<>"")) and (NOT isnull(password) and (password<>"")) and (NOT isnull(role))  Then
               

                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO users(name,email,password,role) values (?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("name", 202, 1, 50, name)
                cmdPrep.parameters.Append cmdPrep.createParameter("email", 202, 1, 200, email)
                cmdPrep.parameters.Append cmdPrep.createParameter("password", 202, 1, 200, password)
                cmdPrep.parameters.Append cmdPrep.createParameter("role", 202, 1, 200, role)
            
                cmdPrep.execute

                Session("Success")="Add a new user successfully"
                Response.redirect("/index_user_1517264.asp")
            Else
                Session("Error")="You have to input info"
            End if
        Else
            If (NOT isnull(name) and (name<>"")) and (NOT isnull(email) and (email<>"")) and (NOT isnull(password) and (password<>"")) and (NOT isnull(role))  Then
                'strSQL="UPDATE NHANVIEN Set HoTenNV='" & name &"',QueQuan='" & hometown & "' WHERE MaNV=" & id
                'connDB.execute(strSQL)

                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE users Set name=?,email=?,password=?,role=? WHERE id=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("name", 202, 1, 150, name)
                cmdPrep.parameters.Append cmdPrep.createParameter("email", 202, 1, 200, email)
                cmdPrep.parameters.Append cmdPrep.createParameter("password", 202, 1, 200, password)
                cmdPrep.parameters.Append cmdPrep.createParameter("role", 202, 1, 200, role)
                cmdPrep.parameters.Append cmdPrep.createParameter("id", 3, 1, , cint(id))
            
                cmdPrep.execute

                Session("Success")="Edit  successfully"
                Response.redirect("/index_user_1517264.asp")
            Else
                Session("Error")="You have to input info"
            End if            
        End if
    End if
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <title>CRUD Example</title>
    </head>
    <body>
        <!-- #include file="header_1517264.asp" -->

        <div class="container">
            <form method="post" action="addedit_user_1517264.asp">
                <div class="mb-3">
                    <label for="name" class="form-label">Tên nhân viên</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%=name%>">
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="text" class="form-control" id="email" name="email" value="<%=email%>">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <input type="text" class="form-control" id="password" name="password" value="<%=password%>">
                </div>
                <div class="mb-3">
                    <label for="role" class="form-label">Role</label>
                    <input type="number" class="form-control" id="role" name="role" value="<%=role%>">
                </div>
                <div class="row">
                    <div class="form-group">
                        <input type="hidden" name="id" id="id" value="<%=id%>">
                        <button type="submit" class="btn btn-primary">
                            <%
                                if (id=0) then
                                    Response.write("Create")
                                else
                                    Response.write("Edit")
                                end if
                            %>
                        </button>
                        <a href="index_user_1517264.asp" class="btn btn-info">Cancel</a>
                    </div>
                </div>
            </form>
        </div>

        <script src="../assets/dist/js/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
    </body>
</html>