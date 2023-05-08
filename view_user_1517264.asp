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

            ' get name,email of user
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "SELECT * FROM users WHERE id = " & id
            Set Result = cmdPrep.execute
            If (Not Result.EOF) Then
                name = Result("name")
                email = Result("email")
            End If
            ' get list project of user
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "SELECT p.title FROM projects p inner join user_project up on p.id = up.project_id WHERE up.user_id = " & id
            Set Result = cmdPrep.execute
            If (Not Result.EOF) Then
                list_project = ""
                Do While (Not Result.EOF)
                    list_project = list_project & Result("title") & ", "
                    Result.MoveNext
                Loop
                list_project = Left(list_project, Len(list_project) - 2)
            End If
        End If
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

        <div class="container mt-3">
            <form method="post" action="view_1517264.asp">
                <div class="mb-3">
                <h2>Thông tin nhân viên</h2><br>
                <div class="mb-3">
                    <h5 class="form-label">Tên nhân viên : <label style="color: red;font-weight: bold;"><%=name%></label></h5>
                </div><br>
                <div class="mb-3">
                    <h5 class="form-label">Email : <label style="color: red;font-weight: bold;"><%=email%></label></h5>
                </div><br>
                <div class="mb-3">
                    <h5 class="form-label">Danh sách dự án : <label style="color: red;font-weight: bold;"><%=list_project%></label></h5>
                </div><br>
                <div class="row">
                    <div class="form-group ">
                        <a href="index_1517264.asp" class="btn btn-info">Close</a>
                    </div>
                </div>
            </form>
        </div>

        <script src="../assets/dist/js/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
    </body>
</html>