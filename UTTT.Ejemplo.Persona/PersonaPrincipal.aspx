<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaPrincipal.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaPrincipal"  debug=false%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>


      <link href="Content/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="Content/bootstrap-theme.min.css" rel="stylesheet" />
    <script type="text/javascript">
     <link href="Content/bootstrap-theme.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="Content/bootstrap-theme.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
</head>
<body>

    <div class="row" style="align-content:center">
            <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5"></div>
        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content:center"><h1 style="align-content:center">Persona</h1>
</div>
        </div> 
    <br />
    <form id="form1" runat="server">
    
    <asp:ScriptManager runat="server" ID="ScriptManager" EnablePageMethods="true"></asp:ScriptManager>
    
        
    <div class="row">

<div class="col-lg-3 col-md- col-sm-3 col-xs-3">
    <div class="row">

<div class="col-lg-3 col-md- col-sm-6 col-xs-6">
   <label >Nombre</label>
    </div>  
        
<div class="col-lg-3 col-md- col-sm-6 col-xs-6">
        <asp:TextBox ID="txtNombre" runat="server" Width="174px" 
            ViewStateMode="Disabled" AutoPostBack="true"></asp:TextBox>
        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionInterval="100" EnableCaching="false"
            MinimumPrefixLength="2" ServiceMethod="txtNombre_textChanged" TargetControlID="txtNombre"></ajaxToolkit:AutoCompleteExtender>
       </div>
        </div>
        </div>
        <br />
<div class="col-lg-3 col-md- col-sm-3 col-xs-3">
     <div class="row">

<div class="col-lg-3 col-md- col-sm-6 col-xs-6">
          <label>Sexo</label>
    </div>
         <div class="col-lg-3 col-md- col-sm-6 col-xs-6">
        <asp:DropDownList ID="ddlSexo" runat="server" Width="177px">
        </asp:DropDownList>
       </div>
        </div>
    </div>
        <br />
        <br />
        <div><br /></div>
        <div class="row">
            <br />
        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" 
            onclick="btnBuscar_Click" ViewStateMode="Disabled" Width="177px"/>
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnAgregar" runat="server" Text="Agregar" 
            onclick="btnAgregar_Click" ViewStateMode="Disabled" Width="177px"/>
    </div>
    </div>
        <br />
    <div>
    
     
    
    </div>
    <div style="font-weight: bold">
        
    
       
        <div>
        
        </div>
       
        <div>
        <br />
             <asp:GridView ID="dgvPersonas" runat="server" 
                AllowPaging="True" AutoGenerateColumns="False" DataSourceID="DataSourcePersona" 
                Width="1067px" CellPadding="3" GridLines="Horizontal" 
                onrowcommand="dgvPersonas_RowCommand" BackColor="White" 
                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                ViewStateMode="Disabled" OnSelectedIndexChanged="dgvPersonas_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <Columns>
                    <asp:BoundField DataField="strClaveUnica" HeaderText="Clave Unica" 
                        ReadOnly="True" SortExpression="strClaveUnica" />
                    <asp:BoundField DataField="strNombre" HeaderText="Nombre" ReadOnly="True" 
                        SortExpression="strNombre" />
                    <asp:BoundField DataField="strAPaterno" HeaderText="APaterno" ReadOnly="True" 
                        SortExpression="strAPaterno" />
                    <asp:BoundField DataField="strAMaterno" HeaderText="AMaterno" ReadOnly="True" 
                        SortExpression="strAMaterno" />
                    <asp:BoundField DataField="CatSexo" HeaderText="Sexo" 
                        SortExpression="CatSexo" />
                    <asp:TemplateField HeaderText="Editar">
                        <ItemTemplate>
                                    <asp:ImageButton runat="server" ID="imgEditar" CommandName="Editar" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/editrecord_16x16.png" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                    
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Eliminar" Visible="True">
                            <ItemTemplate>
                                <asp:ImageButton runat="server" ID="imgEliminar" CommandName="Eliminar" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/delrecord_16x16.png" OnClientClick="javascript:return confirm('¿Está seguro de querer eliminar el registro seleccionado?', 'Mensaje de sistema')"/>
                            </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>

                      <asp:TemplateField HeaderText="Direccion">
                        <ItemTemplate>
                                    <asp:ImageButton runat="server" ID="imgDireccion" CommandName="Direccion" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/editrecord_16x16.png" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                    
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <SortedAscendingCellStyle BackColor="#F4F4FD" />
                <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                <SortedDescendingCellStyle BackColor="#D8D8F0" />
                <SortedDescendingHeaderStyle BackColor="#3E3277" />
            </asp:GridView>
        </div>
        </div>
    <asp:LinqDataSource ID="DataSourcePersona" runat="server" 
        ContextTypeName="UTTT.Ejemplo.Linq.Data.Entity.DcGeneralDataContext" 
        onselecting="DataSourcePersona_Selecting" 
        Select="new (strNombre, strAPaterno, strAMaterno, CatSexo, strClaveUnica,id)" 
        TableName="Persona" EntityTypeName="">
    </asp:LinqDataSource>
    </form>
</body>
</html>
