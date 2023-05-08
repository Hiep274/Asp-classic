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
            cmdPrep.CommandText = "SELECT id,title,description,created_date FROM projects WHERE id=?"
            cmdPrep.parameters.Append cmdPrep.createParameter("id", 3, 1, , cint(id))
            
            Set Result = cmdPrep.execute

            if not Result.EOF then
                title = Result("title")
                description = Result("description")
                create_date = Result("created_date")
            End If

            Set Result = Nothing
        End If
    Else
        id = Request.form("id")
        title = Request.form("title")
        description = Request.form("description")
        create_date = Request.form("created_date")

        If (trim(id) = "") or (isnull(id)) then id = 0 end if

        if cint(id) = 0 then

            If (NOT isnull(title) and (title<>"")) and (NOT isnull(description) and (description<>"")) Then
                'strSQL="INSERT INTO NHANVIEN(HoTenNV,QueQuan) values ('" & name & "','" & hometown & "')"
                'connDB.execute(strSQL)

                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO projects(title,description,created_date) values (?,?,GETDATE())"
                cmdPrep.parameters.Append cmdPrep.createParameter("title", 202, 1, 50, title)
                cmdPrep.parameters.Append cmdPrep.createParameter("description", 202, 1, 200, description)
            
                cmdPrep.execute

                Session("Success")="Add a new project successfully"
                Response.redirect("/")
            Else
                Session("Error")="You have to input info"
            End if
        Else
            If (NOT isnull(title) and (title<>"")) and (NOT isnull(description) and (description<>""))  Then
                'strSQL="UPDATE NHANVIEN Set HoTenNV='" & name &"',QueQuan='" & hometown & "' WHERE MaNV=" & id
                'connDB.execute(strSQL)

                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE projects Set title=?,description=? WHERE id=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("title", 202, 1, 50, title)
                cmdPrep.parameters.Append cmdPrep.createParameter("description", 202, 1, 200, description)
                cmdPrep.parameters.Append cmdPrep.createParameter("id", 3, 1, , cint(id))
            
                cmdPrep.execute

                Session("Success")="Edit  successfully"
                Response.redirect("/")
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
            <form method="post" action="addedit_1517264.asp">
                <div class="mb-3">
                    <label for="title" class="form-label">Tiêu đề</label>
                    <input type="text" class="form-control" id="title" name="title" value="<%=title%>">
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Mô tả</label>
                    <input type="text" class="form-control" id="description" name="description" value="<%=description%>">
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
                        <a href="index_1517264.asp" class="btn btn-info">Cancel</a>
                    </div>
                </div>
            </form>
        </div>

        <script src="../assets/dist/js/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
    </body>
</html>