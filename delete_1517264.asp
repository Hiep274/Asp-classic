<!-- #include file="connect_1517264.asp" -->
<%
'Sinh vien xu ly delete chi trong truong hop dang nhap + chuyen sang ADODB.Command
    id = Request.QueryString("id")

    if trim(id) = "" or isnull(id) then
        Response.Write("<script>alert('Cannot delete');document.location='index_1517264.asp';</script>")
        Response.End
    end if

    strSQL = "DELETE FROM projects WHERE id=" & id

    connDB.execute(strSQL)
    Session("Success") = "Delete successfully"
    Response.Redirect("index_1517264.asp")
    Response.End

%>
