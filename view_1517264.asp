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

            ' get title, description of project
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "SELECT title, description FROM projects WHERE id = " & id
            Set Result = cmdPrep.execute
            If (Not Result.EOF) Then
                title = Result("title")
                description = Result("description")
            End If
            ' get list user of project
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "SELECT u.name FROM users u INNER JOIN user_project up ON u.id = up.user_id WHERE up.project_id = " & id
            Set Result = cmdPrep.execute
            If (Not Result.EOF) Then
                list_user = ""
                Do While (Not Result.EOF)
                    list_user = list_user & Result("name") & ", "
                    Result.MoveNext
                Loop
                list_user = Left(list_user, Len(list_user) - 2)
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
                    <h2>Chi tiết dự án</h1>
                </div>
                <div class="mb-3">
                    <h5 class="form-label">Tiêu đề : <label style="color: red;font-weight: bold;"><%=title%></label>
                    </h5>
                </div><br>
                <div class="mb-3">
                    <h5 class="form-label">Mô tả : <label style="color: red;font-weight: bold;"><%=description%></label>
                </div><br>
                <div class="mb-3">
                    <h5 class="form-label">Người tham gia: <label style="color: red;font-weight: bold;"><%=list_user%></label>
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