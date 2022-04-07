<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaManager.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaManager" debug=false%>
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
    <script type="text/javascript">

        function validaNumeros(evt) {
            //valida que solo se ingresen numeros en la caja de texto
            var code = (evt.wich) ? evt.wich : evt.keyCode;
            if (code == 8) {
                return true;
            } else if (code >= 48 && code <= 57) {
                return true;
            } else {
                return false;
            }
        }

        function validaLetras(e) {
            //valida que solo ingrese letras y algunos caracteres especiales
            var regex = new RegExp("^[a-zA-Z ]+$");
            var key = String.fromCharCode(!e.charCode ? e.which : e.charCode);
            if (!regex.test(key)) {
                e.preventDefault();
                return false;

            }
        }

        function validaCurp(curp) {
            //valida letras y numeros pero si caracteres especiales ya que se trata del CURP
                var regex = new RegExp("^[a-zA-Z0-9 ]+$");
                var key = String.fromCharCode(!curp.charCode ? curp.which : curp.charCode);
                if (!regex.test(key)) {
                    curp.preventDefault();
                    return false;
                }
            }
        
    </script>
</head>
<body>


    <form id="form1" runat="server" style="align-content: center">

        <asp:ScriptManager runat="server" ID="ScriptManager" EnablePageMethods="true"></asp:ScriptManager>
        <div style="font-family: Arial; font-size: medium; font-weight: bold">
        </div>
        <div class="row">

            <div class="col-lg-5 col-md-5 col-sm-5 col-xs-5 col-xxs-2"></div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center">

                <asp:Label ID="lblAccion" runat="server" Text="Accion" Font-Bold="True" Font-Size="30px" Style="align-content: center"></asp:Label>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3"></div>


        </div>



        <br />
        <div>


            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">

                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>
                        <div class="col-lg-1 col-md-1 col-sm-2 col-xs-2" style="align-content: center">
                            <label style="align-content: center">Sexo</label>
                        </div>
                        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-6">
                            <asp:DropDownList ID="ddlSexo" runat="server"
                                Height="25px" Width="249px"
                                OnSelectedIndexChanged="ddlSexo_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </div>
                    </div>
             
                </ContentTemplate>
                <Triggers>

                    <asp:AsyncPostBackTrigger ControlID="ddlSexo" EventName="SelectedIndexChanged" />
                </Triggers>

            </asp:UpdatePanel>
        </div>
        <br />

        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>
            <div class="col-lg-1 col-md-1 col-sm-2 col-xs-2" style="align-content: center">
                <label>Clave Unica</label>
            </div>

            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center">
                <asp:TextBox ID="txtClaveUnica" runat="server"
                    Width="249px" ViewStateMode="Disabled"
                    onkeypress="return validaNumeros(event);" pattern=".{1,3}"></asp:TextBox>
            </div>
            <asp:RangeValidator ID="rvClaveUnica" runat="server" ControlToValidate="txtClaveUnica" ErrorMessage="*La clave única deberá de estar entre 1 y 999" MaximumValue="999" MinimumValue="1" Type="Integer"></asp:RangeValidator>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>

        </div>


        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>
            <div class="col-lg-1 col-md-1 col-sm-2 col-xs-2" style="align-content: center">
                <label>Nombre</label>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center">
                <asp:TextBox
                    ID="txtNombre" runat="server" Width="249px" ViewStateMode="Disabled"
                    onkeypress="return validaLetras(event)"></asp:TextBox>
            </div>


            <asp:RegularExpressionValidator ID="revNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="*Incluir solamente letras y espacios" ValidationExpression="[a-zA-Z ]{2,254}"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="*Nombre obligatorio"></asp:RequiredFieldValidator>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>
        </div>




        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>
            <div class="col-lg-1 col-md-1 col-sm-2 col-xs-2" style="align-content: center">

                <label>APaterno</label>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center">
                <asp:TextBox ID="txtAPaterno" runat="server" Width="249px" ViewStateMode="Disabled"
                    onkeypress="return validaLetras(event);"></asp:TextBox>
            </div>
                
                    <asp:RegularExpressionValidator ID="revAPaterno" runat="server" ControlToValidate="txtAPaterno" ErrorMessage="*Incluir solamente letras y espacios" ValidationExpression="[a-zA-Z ]{2,254}"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="rfvAPaterno" runat="server" ControlToValidate="txtAPaterno" ErrorMessage="*Apellido Paterno obligatorio"></asp:RequiredFieldValidator>
                
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>
            
        </div>


        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>
            <div class="col-lg-1 col-md-1 col-sm-2 col-xs-2" style="align-content: center">
                <label>AMaterno</label>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center">
                <asp:TextBox ID="txtAMaterno" runat="server" Width="248px"
                    ViewStateMode="Disabled"
                    onkeypress="return validaLetras(event);"></asp:TextBox>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center">
                <asp:RegularExpressionValidator ID="revAMaterno" runat="server" ControlToValidate="txtAMaterno" ErrorMessage="Incluir solamente letras y espacios" ValidationExpression="[a-zA-Z ]{2,254}"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="rfvAMaterno" runat="server" ControlToValidate="txtAMaterno" ErrorMessage="*Apellido Materno obligatorio"></asp:RequiredFieldValidator>

            </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>
        </div>



        
            <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>
            <div class="col-lg-1 col-md-1 col-sm-2 col-xs-2" style="align-content: center">
            <label>CURP</label>
                </div>
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center">

            <asp:TextBox ID="txtCURP" runat="server" MaxLength="18" Width="249px"
                onkeypress="return validaCurp(event);"></asp:TextBox>
                </div>
            <asp:RegularExpressionValidator ID="revCURP" runat="server" ControlToValidate="txtCURP" ErrorMessage="*La CURP es incorrecta" ValidationExpression="^([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)$"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="rfvCurp" runat="server" ControlToValidate="txtCURP" ErrorMessage="*Curp obligatorio"></asp:RequiredFieldValidator>
                </div>
        

        <div>
              <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>
            <div class="col-lg-1 col-md-1 col-sm-2 col-xs-2" style="align-content: center">
            <label>Fecha Nacimiento</label>
                </div>
                              <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center">
            <asp:TextBox ID="txtFechaNacmiento" runat="server" MaxLength="18" Width="249px"
                onkeypress="return validaCurp(event);">            </asp:TextBox>
                


            <i class="fa fa-calendar " id="imgPop"></i>
                                  </div>
            <ajaxToolkit:CalendarExtender ID="calendarExtender1" PopupButtonID="imgPop" runat="server" TargetControlID="txtFechaNacmiento"
                Format="dd/MM/yyyy" />
            <asp:RegularExpressionValidator ID="revFecha" runat="server" ControlToValidate="txtFechaNacmiento" ErrorMessage="la fecha es incorrecta" ValidationExpression="^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="rfvFecha" runat="server" ControlToValidate="txtFechaNacmiento" ErrorMessage="*Fecha obligatorio"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div>

            <br />
            <asp:Label ID="lblMensaje" runat="server" ForeColor="Red" Visible="False"></asp:Label>

        </div>
        <div>
            <div class="row">
                 <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>

                 <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center">
            <asp:Button ID="btnAceptar" runat="server" Text="Aceptar"
                OnClick="btnAceptar_Click" ViewStateMode="Disabled" CausesValidation="false" />
            &nbsp;&nbsp;&nbsp;
   
            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar"
                OnClick="btnCancelar_Click" ViewStateMode="Disabled" CausesValidation="false" />
               
                </div>
                 <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4" style="align-content: center"></div>
            </div>
        </div>
    </form>


</body>
</html>
