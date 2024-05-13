Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.Configuration
Imports System.Data
Imports System.Drawing
Imports System.Web.Security
Imports System.IO

Public Class frm_main
    Inherits System.Web.UI.Page

    Dim con As String = WebConfigurationManager.ConnectionStrings("pm").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strPrevPage As String = ""

        If Request.UrlReferrer = Nothing Then
            Response.Redirect("login.aspx")
        End If

        If strPrevPage = "" Then
            strPrevPage = Request.UrlReferrer.Segments(Request.UrlReferrer.Segments.Length - 1)
        End If

        If Not IsPostBack Then
            Dim SqlDataSource1 As New SqlDataSource()
            SqlDataSource1.ID = "SqlDataSource1"
            Me.Page.Controls.Add(SqlDataSource1)
            SqlDataSource1.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("pm").ConnectionString
            SqlDataSource1.SelectCommand = "SELECT * from tbl_philhealthmonitoring order by lname asc"
            GridView1.DataSource = SqlDataSource1
            GridView1.DataBind()
            lbltotalrecords.Text = "Total Number of Records: " & GridView1.Rows.Count
        End If

        If Not Me.Page.User.Identity.IsAuthenticated Then
            FormsAuthentication.RedirectToLoginPage()
        End If

        Dim sqlcon As New SqlConnection(con)
        sqlcon.Open()
        Dim sqlcom As New SqlCommand("select EmpName from tbl_users where Username = '" & System.Web.HttpContext.Current.User.Identity.Name & "'", sqlcon)
        Dim dr As SqlDataReader = sqlcom.ExecuteReader

        If dr.Read Then
            lbllogin.Text = dr.Item("EmpName").ToString
            dr.Close()
        End If
        sqlcon.Close()
    End Sub

    Private Function GetData(ByVal cmd As SqlCommand) As DataTable
        Dim dt As DataTable = New DataTable
        Dim sqlcon As SqlConnection = New SqlConnection(con)
        Dim sda As SqlDataAdapter = New SqlDataAdapter
        cmd.Connection = sqlcon
        sqlcon.Open()
        sda.SelectCommand = cmd
        sda.Fill(dt)
        Return dt
    End Function

    Protected Sub Add(ByVal sender As Object, ByVal e As EventArgs)
        'lblphilhealthno.Text = Request.QueryString("philhealthno")
        txtphilhealthno.Text = String.Empty
        txtlname.Text = String.Empty
        txtfname.Text = String.Empty
        txtmname.Text = String.Empty
        txtbday.Text = String.Empty
        txtmedschool.Text = String.Empty
        txtyeargraduated.Text = String.Empty
        txtsubspecialty.Text = String.Empty
        txtstatus.Text = String.Empty
        txtcode.Text = String.Empty
        txtprc.Text = String.Empty
        txtetd.Text = String.Empty
        txtexpiration.Text = String.Empty
        txtremarks.Text = String.Empty
        popup.Show()
    End Sub

    Protected Sub Edit(ByVal sender As Object, ByVal e As EventArgs)
        Dim row As GridViewRow = CType(CType(sender, LinkButton).Parent.Parent, GridViewRow)
        lblid.Text = row.Cells(0).Text
        txtphilhealthno.Text = row.Cells(1).Text.Replace("&nbsp;", "")
        txtlname.Text = row.Cells(2).Text.Replace("&nbsp;", "")
        txtfname.Text = row.Cells(3).Text.Replace("&nbsp;", "")
        txtmname.Text = row.Cells(4).Text.Replace("&nbsp;", "")
        txtbday.Text = row.Cells(5).Text.Replace("&nbsp;", "")
        txtmedschool.Text = row.Cells(6).Text.Replace("&nbsp;", "")
        txtyeargraduated.Text = row.Cells(7).Text.Replace("&nbsp;", "")
        txtsubspecialty.Text = row.Cells(8).Text.Replace("&nbsp;", "")
        txtstatus.Text = row.Cells(9).Text.Replace("&nbsp;", "")
        txtcode.Text = row.Cells(10).Text.Replace("&nbsp;", "")
        txtprc.Text = row.Cells(11).Text.Replace("&nbsp;", "")
        txtetd.Text = row.Cells(12).Text.Replace("&nbsp;", "")
        txtexpiration.Text = row.Cells(13).Text
        txtremarks.Text = row.Cells(14).Text.Replace("&nbsp;", "")
        popup.Show()
    End Sub

    Protected Sub Save(ByVal sender As Object, ByVal e As EventArgs)
        Dim com As SqlCommand = New SqlCommand
        com.CommandType = CommandType.StoredProcedure
        com.CommandText = "AddUpdatePhilhealth"
        com.Parameters.AddWithValue("@id", lblid.Text)
        com.Parameters.AddWithValue("@philhealthno", txtphilhealthno.Text)
        com.Parameters.AddWithValue("@lname", txtlname.Text.ToUpper)
        com.Parameters.AddWithValue("@fname", txtfname.Text.ToUpper)
        com.Parameters.AddWithValue("@mname", txtmname.Text.ToUpper)
        com.Parameters.AddWithValue("@bday", txtbday.Text)
        com.Parameters.AddWithValue("@medschool", txtmedschool.Text.ToUpper)
        com.Parameters.AddWithValue("@yeargraduated", txtyeargraduated.Text)
        com.Parameters.AddWithValue("@subspecialty", txtsubspecialty.Text.ToUpper)
        com.Parameters.AddWithValue("@status", txtstatus.Text.ToUpper)
        com.Parameters.AddWithValue("@code", txtcode.Text.ToUpper)
        com.Parameters.AddWithValue("@prc", txtprc.Text)
        com.Parameters.AddWithValue("@etd", txtetd.Text.ToUpper)
        com.Parameters.AddWithValue("@expiration", txtexpiration.Text)
        com.Parameters.AddWithValue("@remarks", txtremarks.Text.ToUpper)
        com.Parameters.AddWithValue("@logdatetime", DateTime.Now)
        com.Parameters.AddWithValue("@loguser", lbllogin.Text)
        GridView1.DataSource = Me.GetData(com)
        GridView1.DataBind()
        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub OnRowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim varExp As Date = (e.Row.Cells(13).Text)

            For Each cell As TableCell In e.Row.Cells
                If varExp < Date.Now Then
                    cell.BackColor = Color.Red
                    cell.ForeColor = Color.White
                ElseIf DateDiff(DateInterval.Month, Date.Now, varExp) <= "5" Then
                    cell.BackColor = Color.Orange
                    cell.ForeColor = Color.White
                End If
            Next
        End If
    End Sub

    Private Sub btnsearch_Click(sender As Object, e As EventArgs) Handles btnsearch.Click
        Dim SqlDataSource1 As New SqlDataSource()
        SqlDataSource1.ID = "SqlDataSource1"
        Me.Page.Controls.Add(SqlDataSource1)
        SqlDataSource1.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("pm").ConnectionString
        SqlDataSource1.SelectCommand = "SELECT * from tbl_philhealthmonitoring where lname like '%" & txtsearch.Text & "%' OR fname like '%" & txtsearch.Text & "%' order by lname asc"
        GridView1.DataSource = SqlDataSource1
        GridView1.DataBind()
        lbltotalrecords.Text = "Total Number of Records: " & GridView1.Rows.Count
    End Sub
End Class