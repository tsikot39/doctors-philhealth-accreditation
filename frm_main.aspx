<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frm_main.aspx.vb" Inherits="philhealthmonitoring.frm_main" Theme="Theme1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <style type="text/css">
        .style1
        {
            font-family: Tahoma;
            font-size: 8pt;
        }
        .style2
        {
            font-family: Tahoma;
            font-size: 10pt;
        }
        .style3
        {
            font-family: Tahoma;
            font-size: 14pt;
        }           
        .modalBackground
        {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }
        .modalPopup
        {
            background-color: #FFFFFF;
            padding-top: 10px;
            padding-left: 10px;
            padding-right: 10px;
        }
        .hiddencol
          {
            display: none;
          }
        .uc
          {
           text-transform: uppercase;
           font-family: Tahoma;
           font-size: 8pt;
          }
</style>
<script type="text/javascript">
    function Hidepopup() {
        $find("popup").hide();
        return false;
    }
</script>
<script type="text/javascript">
        function CloseWindow() {
            window.close();
        }
</script>  
</head>
<body bgcolor="#EFF3FB">
    <form id="form1" runat="server">
    <div>
        <table width="100%">
            <tr>
                <td colspan="3" align="right">
                    <asp:Label ID="Label22" runat="server" Text="USER:" CssClass="style1" />
                    <asp:Label ID="lbllogin" runat="server" Text="Label" CssClass="style1"></asp:Label>
                    <asp:LoginName ID="LoginName1" runat="server" CssClass="style1" Visible="false" />|
                    <asp:LoginStatus ID="LoginStatus1" runat="server" LogoutText="LOGOUT" CssClass="style1" LogoutAction="RedirectToLoginPage" />
                </td>
            </tr>
            <tr>
                <td colspan="3" align="center">
                    <img src="logo.gif" alt="PCMC" style="vertical-align: top; height: 25px; width: 25px" />
                    <span class="style3">PHILIPPINE CHILDREN'S MEDICAL CENTER</span>
                    <br />
                    <asp:Label ID="Label1" runat="server" Text="Doctors Philhealth Accreditation Monitoring System" CssClass="style2" />
                </td>
            </tr>
            <tr>
                <td colspan="3">&nbsp;</td>
            </tr>
            <tr>
                <td width="33.3%"><asp:Label ID="lbltotalrecords" runat="server" CssClass="style1" /></td>
                <td width="33.3%" align="center">
                    <asp:Label ID="Label21" runat="server" Text="Search keyword:" CssClass="style1" />
                    <asp:TextBox ID="txtsearch" runat="server" CssClass="style1" Width="200px" />
                    <asp:Button ID="btnsearch" runat="server" Text="Search" CssClass="style1" />
                </td>
                <td width="33.3%" align="right">
                    <img src="active.png" alt="Active" style="vertical-align: middle; height: 10px; width: 10px" />
                    <span class="style1">Active</span>&nbsp;&nbsp;
                    <img src="expiring.png" alt="Expiring" style="vertical-align: middle; height: 10px; width: 10px" />
                    <span class="style1">Expiring</span>&nbsp;&nbsp;
                    <img src="expired.png" alt="Expired" style="vertical-align: middle; height: 10px; width: 10px" />
                    <span class="style1">Expired</span>&nbsp;&nbsp;
                    <asp:Button ID="btnAdd" runat="server" Text="Add New Doctor" OnClick="Add" CssClass="style1" />
                </td>
            </tr>
        </table>
    </div>
    <div align="center">        
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="100%" OnRowDataBound="OnRowDataBound" CssClass="style1">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="ID" HeaderStyle-Font-Bold="false" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol" />
                        <asp:BoundField DataField="philhealthno" HeaderText="Philhealth Number" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:BoundField DataField="lname" HeaderText="Last Name" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:BoundField DataField="fname" HeaderText="First Name" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:BoundField DataField="mname" HeaderText="Middle Name" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:BoundField DataField="bday" HeaderText="Birth Date" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:BoundField DataField="medschool" HeaderText="Medical School" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:BoundField DataField="yeargraduated" HeaderText="Year Graduated" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:BoundField DataField="subspecialty" HeaderText="Sub-speciality" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:BoundField DataField="status" HeaderText="Status" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:BoundField DataField="code" HeaderText="Code" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:BoundField DataField="prc" HeaderText="PRC" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:BoundField DataField="etd" HeaderText="ETD" HeaderStyle-Font-Bold="false" HtmlEncode="false"/>
                        <asp:BoundField DataField="expiration" HeaderText="Expiration" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:BoundField DataField="remarks" HeaderText="Remarks" HeaderStyle-Font-Bold="false" HtmlEncode="false" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" OnClick="Edit" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:Panel ID="pnlAddEdit" runat="server" CssClass="modalPopup" Style="display:none">
                    <table>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:Label ID="Label4" runat="server" Text="Doctor Information" CssClass="style1" />
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label18" runat="server" Text="ID" CssClass="style1" /></td>
                            <td><asp:Label ID="lblid" runat="server" Text="" CssClass="style1" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label7" runat="server" Text="Philhealth Number" CssClass="style1" /></td>
                            <td>
                                <asp:TextBox ID="txtphilhealthno" runat="server" Text="" CssClass="style1" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtphilhealthno" ErrorMessage="Philhealth Number should not be blank." Display="None" ValidationGroup="Group1" CssClass="style1"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lbllname" runat="server" Text="Last Name" CssClass="style1" /></td>
                            <td>
                                <asp:TextBox ID="txtlname" runat="server" Text="" CssClass="uc" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtlname" ErrorMessage="Last Name should not be blank." Display="None" ValidationGroup="Group1" CssClass="style1"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label5" runat="server" Text="First Name" CssClass="style1" /></td>
                            <td>
                                <asp:TextBox ID="txtfname" runat="server" Text="" CssClass="uc" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtfname" ErrorMessage="First Name should not be blank." Display="None" ValidationGroup="Group1" CssClass="style1"></asp:RequiredFieldValidator>
                            </td>                            
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label6" runat="server" Text="Middle Name" CssClass="style1" /></td>
                            <td><asp:TextBox ID="txtmname" runat="server" Text="" CssClass="uc" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label8" runat="server" Text="Birth Date" CssClass="style1" /></td>
                            <td>
                                <asp:TextBox ID="txtbday" runat="server" Text="" CssClass="style1" />     
                                <asp:CompareValidator ID="cvbday" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtbday" ErrorMessage="Birth Date should be in mm/dd/yyyy format." ValidationGroup="Group1" Display="None" />                                        
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label9" runat="server" Text="Medical School" CssClass="style1" /></td>
                            <td><asp:TextBox ID="txtmedschool" runat="server" Text="" CssClass="uc" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label10" runat="server" Text="Year Graduated" CssClass="style1" /></td>
                            <td><asp:TextBox ID="txtyeargraduated" runat="server" Text="" CssClass="style1" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label11" runat="server" Text="Sub-Specialty" CssClass="style1" /></td>
                            <td><asp:TextBox ID="txtsubspecialty" runat="server" Text="" CssClass="uc" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label12" runat="server" Text="Status" CssClass="style1" /></td>
                            <td><asp:TextBox ID="txtstatus" runat="server" Text="" CssClass="uc" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label13" runat="server" Text="Code" CssClass="style1" /></td>
                            <td><asp:TextBox ID="txtcode" runat="server" Text="" CssClass="uc" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label17" runat="server" Text="PRC" CssClass="style1" /></td>
                            <td><asp:TextBox ID="txtprc" runat="server" Text="" CssClass="style1" /></td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label14" runat="server" Text="ETD" CssClass="style1" /></td>
                            <td>
                                <asp:TextBox ID="txtetd" runat="server" Text="" CssClass="style1" />
                                <asp:CompareValidator ID="cv2" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtetd" ErrorMessage="ETD should be in mm/dd/yyyy format." ValidationGroup="Group1" Display="None" />
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label15" runat="server" Text="Expiration" CssClass="style1" /></td>
                            <td>
                                <asp:TextBox ID="txtexpiration" runat="server" Text="" CssClass="style1" />
                                <asp:CompareValidator ID="cv1" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtexpiration" ErrorMessage="Expiration Date should be in mm/dd/yyyy format." ValidationGroup="Group1" Display="None" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtexpiration" ErrorMessage="Expiration should not be blank." ValidationGroup="Group1" CssClass="style1" Display="None" />
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="Label16" runat="server" Text="Remarks" CssClass="style1" /></td>
                            <td><asp:TextBox ID="txtremarks" runat="server" Text="" CssClass="uc" /></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Group1" CssClass="style1" HeaderText="Warning!" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2" align="right">
                                <asp:Button ID="btnsave" runat="server" Text="Save" OnClick="Save" CssClass="style1" ValidationGroup="Group1" />
                                <asp:Button ID="btncancel" runat="server" Text="Cancel" OnClientClick="return Hidepopup()" CssClass="style1" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:LinkButton ID="lnkFake" runat="server" />
                <asp:ModalPopupExtender ID="popup" runat="server" DropShadow="false" PopupControlID="pnlAddEdit" TargetControlID="lnkFake" BackgroundCssClass="modalBackground" />
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="GridView1" />
                <asp:AsyncPostBackTrigger ControlID="btnsave" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <div align="center">
        <br />
        <asp:Label ID="Label2" runat="server" Text="Hospital Information Support Services | Developed by John Corpus | 2016 © Copyright" CssClass="style1" />
    </div>
    </form>
</body>
</html>
