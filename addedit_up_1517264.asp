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
    ' get list of user for dropdown
    Set cmdPrep = Server.CreateObject("ADODB.Command")
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.Prepared = True
    cmdPrep.CommandText = "SELECT id,name FROM users"
    Set Result = cmdPrep.execute
    Dim user_id
    Dim user_id_list
    user_id_list = "<select name=""user_id"" id=""user_id"" class=""form-control"">"
    user_id_list = user_id_list & "<option value="""">-- Chọn nhân viên --</option>"
    while not Result.EOF
        user_id_list = user_id_list & "<option value=""" & Result("id") & """>" & Result("name") & "</option>"
        Result.MoveNext
    wend
    user_id_list = user_id_list & "</select>"
    Set Result = Nothing
    ' get list of project for dropdown
    Set cmdPrep = Server.CreateObject("ADODB.Command")
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.Prepared = True
    cmdPrep.CommandText = "SELECT id,title FROM projects"
    Set Result = cmdPrep.execute
    Dim project_id
    Dim project_id_list
    project_id_list = "<select name=""project_id"" id=""project_id"" class=""form-control"">"
    project_id_list = project_id_list & "<option value="""">-- Chọn dự án --</option>"
    while not Result.EOF
        project_id_list = project_id_list & "<option value=""" & Result("id") & """>" & Result("title") & "</option>"
        Result.MoveNext
    wend
    project_id_list = project_id_list & "</select>"

    
    If (Request.ServerVariables("Request_Method") = "GET") Then
        id = Request.QueryString("id")

        If (trim(id) = "") or (isnull(id)) then id = 0 end if
        If (cint(id) <> 0) Then

            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "SELECT  user_id,project_id FROM user_project inner join projects on user_project.project_id=projects.id inner join users on users.id=user_project.user_id  where projects.id=?"
            cmdPrep.parameters.Append cmdPrep.createParameter("id", 3, 1, , cint(id))
            
            Set Result = cmdPrep.execute

            if not Result.EOF then
                title = Result("title")
                name = Result("name")
                join_date = Result("join_date")
            End If

            Set Result = Nothing
        End If
    Else
        id = Request.form("id")
        user_id = Request.form("user_id")
        project_id = Request.form("project_id")
        join_date = Request.form("join_date")

        If (trim(id) = "") or (isnull(id)) then id = 0 end if

        if cint(id) = 0 then

            If (NOT isnull(user_id) ) and (NOT isnull(project_id) ) Then
               

                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO user_project values (?,?,GetDate())"
                cmdPrep.parameters.Append cmdPrep.createParameter("user_id", 202, 1, 50, user_id)
                cmdPrep.parameters.Append cmdPrep.createParameter("project_id", 202, 1, 200, project_id)
                cmdPrep.execute

                Session("Success")="Add a new successfully"
                Response.redirect("/index_up_1517264.asp")
            Else
                Session("Error")="You have to input info"
            End if
        Else
            If (NOT isnull(name) and (name<>"")) and (NOT isnull(title) and (title<>""))  Then
              

                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE user_project Set user_id=?,project_id=? WHERE id=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("user_id", 202, 1, 150, user_id)
                cmdPrep.parameters.Append cmdPrep.createParameter("project_id", 202, 1, 200, project_id)
                cmdPrep.parameters.Append cmdPrep.createParameter("id", 3, 1, , cint(id))
            
                cmdPrep.execute

                Session("Success")="Edit  successfully"
                Response.redirect("/index_up_1517264.asp")
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

        <div class="container mt-3">
            <form method="post" action="addedit_up_1517264.asp">
                <div class="mb-3 w-25">
                    <%=user_id_list%>
                </div>
                <div class="mb-3 w-25">
                    <%=project_id_list%>
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
                        <a href="index_up_1517264.asp" class="btn btn-info">Cancel</a>
                    </div>
                </div>
            </form>
        </div>

        <script src="../assets/dist/js/bootstrap.bundle.min.js"  crossorigin="anonymous"></script>
    </body>
</html>