#region Using

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UTTT.Ejemplo.Linq.Data.Entity;
using System.Data.Linq;
using System.Linq.Expressions;
using System.Collections;
using UTTT.Ejemplo.Persona.Control;
using UTTT.Ejemplo.Persona.Control.Ctrl;
using System.Net.Mail;
using System.Threading;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using System.Net.Security;

#endregion

namespace UTTT.Ejemplo.Persona
{
    public partial class PersonaManager : System.Web.UI.Page
    {
        #region Variables

        private SessionManager session = new SessionManager();
        private int idPersona = 0;
        private UTTT.Ejemplo.Linq.Data.Entity.Persona baseEntity;
        private DataContext dcGlobal = new DcGeneralDataContext();
        private int tipoAccion = 0;

        #endregion

        #region Eventos

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.Response.Buffer = true;
                this.session = (SessionManager)this.Session["SessionManager"];
                this.idPersona = this.session.Parametros["idPersona"] != null ?
                    int.Parse(this.session.Parametros["idPersona"].ToString()) : 0;
                if (this.idPersona == 0)
                {
                    this.baseEntity = new Linq.Data.Entity.Persona();
                    this.tipoAccion = 1;
                }
                else
                {
                    this.baseEntity = dcGlobal.GetTable<Linq.Data.Entity.Persona>().First(c => c.id == this.idPersona);
                    this.tipoAccion = 2;
                }

                if (!this.IsPostBack)
                {
                    if (this.session.Parametros["baseEntity"] == null)
                    {
                        this.session.Parametros.Add("baseEntity", this.baseEntity);
                    }
                    List<CatSexo> lista = dcGlobal.GetTable<CatSexo>().ToList();
                    CatSexo catTemp = new CatSexo();
                    catTemp.id = -1;
                    catTemp.strValor = "Seleccionar";
                    lista.Insert(0, catTemp);
                    this.ddlSexo.DataTextField = "strValor";
                    this.ddlSexo.DataValueField = "id";
                    this.ddlSexo.DataSource = lista;
                    this.ddlSexo.DataBind();

                    
                    if (this.idPersona == 0)
                    {

                        this.lblAccion.Text = "Agregar";

                        CatSexo  catTemp_ = new CatSexo();
                        catTemp.id = -1;
                        catTemp.strValor="Seleccionar";
                        lista.Insert(0, catTemp);
                        this.ddlSexo.DataSource = lista;
                        this.ddlSexo.DataBind();
                    }
                    else
                    {
                        this.lblAccion.Text = "Editar";
                        this.txtNombre.Text = this.baseEntity.strNombre;
                        this.txtAPaterno.Text = this.baseEntity.strAPaterno;
                        this.txtAMaterno.Text = this.baseEntity.strAMaterno;
                        this.txtClaveUnica.Text = this.baseEntity.strClaveUnica;
                        this.txtCURP.Text = this.baseEntity.strCurp;
                        calendarExtender1.SelectedDate = this.baseEntity.dteFechaNacimiento;
                        this.ddlSexo.DataSource = lista;
                        this.ddlSexo.DataBind();
                        this.setItem(ref this.ddlSexo, baseEntity.CatSexo.strValor);
                    }

                    this.ddlSexo.SelectedIndexChanged += new EventHandler(ddlSexo_SelectedIndexChanged);
                    this.ddlSexo.AutoPostBack = true;
                }

            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un problema al cargar la página");
                this.Response.Redirect("~/PersonaPrincipal.aspx", false);
            }

        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
              //  var validoCU=this.rvClaveUnica.IsValid;
                this.revNombre.Validate();
                this.revAPaterno.Validate();
                this.revAMaterno.Validate();
                this.revCURP.Validate();
                this.revFecha.Validate();
                this.rfvNombre.Validate();
                this.rfvAPaterno.Validate();
                this.rfvAMaterno.Validate();
                this.rfvCurp.Validate();
                this.revFecha.Validate();
                string date = Request.Form[this.txtFechaNacmiento.UniqueID];
                DateTime fechaNacimiebto= Convert.ToDateTime(date);

                DataContext dcGuardar = new DcGeneralDataContext();
                UTTT.Ejemplo.Linq.Data.Entity.Persona persona = new Linq.Data.Entity.Persona();
                if (this.idPersona == 0)
                {
                  

                    persona.strClaveUnica = this.txtClaveUnica.Text.Trim();
                    persona.strNombre = this.txtNombre.Text.Trim();
                    persona.strAMaterno = this.txtAMaterno.Text.Trim();
                    persona.strAPaterno = this.txtAPaterno.Text.Trim();
                    persona.strCurp = this.txtCURP.Text.Trim();
                    persona.idCatSexo = int.Parse(this.ddlSexo.Text);
                    persona.dteFechaNacimiento = fechaNacimiebto;

                    String mensaje = String.Empty;
                    if (this.Bacio(persona))
                    {

                        this.regresar();
                    }
                  //  !this.revCURP.IsValid
                    if (!formatosValidos(ref  mensaje))
                    {
                        
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }
                    



                    if (!this.validacion(persona, ref mensaje))
                    {
                        ////Validacion de datos correctos desde código
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }

              

                    dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>().InsertOnSubmit(persona);
                    dcGuardar.SubmitChanges();
                    this.showMessage("El registro se agrego correctamente.");
                    this.Response.Redirect("~/PersonaPrincipal.aspx", false);

                }
                if (this.idPersona > 0)
                {

                    persona = dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>().First(c => c.id == idPersona);
                    persona.strClaveUnica = this.txtClaveUnica.Text.Trim();
                    persona.strNombre = this.txtNombre.Text.Trim();
                    persona.strAMaterno = this.txtAMaterno.Text.Trim();
                    persona.strAPaterno = this.txtAPaterno.Text.Trim();
                    persona.strCurp = this.txtCURP.Text.Trim();
                    persona.idCatSexo = int.Parse(this.ddlSexo.Text);
                    persona.strCurp = this.txtCURP.Text.Trim();
                    persona.dteFechaNacimiento = fechaNacimiebto;
                    ////////////////////////////
                    //editar///////////////////
                    ///////////////////////////
                    String mensaje = String.Empty;
                    if (this.Bacio(persona))
                    {

                        this.regresar();
                    }
                    //  !this.revCURP.IsValid
                    if (!formatosValidos(ref mensaje))
                    {

                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }




                    if (!this.validacion(persona, ref mensaje))
                    {
                        ////Validacion de datos correctos desde código
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }






                    


                    dcGuardar.SubmitChanges();
                    this.showMessage("El registro se edito correctamente.");
                    this.Response.Redirect("~/PersonaPrincipal.aspx", false);
                }
            }
            catch (Exception _e)
            {
                this.showMessageException(_e.Message);
                          

            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            try
            {              
                this.Response.Redirect("~/PersonaPrincipal.aspx", false);
            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        protected void ddlSexo_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int idSexo = int.Parse(this.ddlSexo.Text);
                Expression<Func<CatSexo, bool>> predicateSexo = c => c.id == idSexo;
                predicateSexo.Compile();
                List<CatSexo> lista = dcGlobal.GetTable<CatSexo>().Where(predicateSexo).ToList();
                CatSexo catTemp = new CatSexo();            
                this.ddlSexo.DataTextField = "strValor";
                this.ddlSexo.DataValueField = "id";
                this.ddlSexo.DataSource = lista;
                this.ddlSexo.DataBind();
            }
            catch (Exception)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        #endregion

        #region Metodos

        public void setItem(ref DropDownList _control, String _value)
        {
            foreach (ListItem item in _control.Items)
            {
                if (item.Value == _value)
                {
                    item.Selected = true;
                    break;
                }
            }
            _control.Items.FindByText(_value).Selected = true;
        }

        #endregion

        #region Validación Código
        ///<summary>
        ///Valida datos básicos
        ///</summary>
        ///<param name="_persona"></param>
        ///<param name="_mensaje"></param>
        ///<returns></returns>

        public bool validacion(UTTT.Ejemplo.Linq.Data.Entity.Persona _persona, ref String _mensaje)
        {
            if(_persona.idCatSexo == -1)
            {
                _mensaje = "Seleccione Masculino o Femenino";
                return false;
            }
            int i = 0;
            
            if((int.TryParse(_persona.strClaveUnica, out i) == false))
            {
                _mensaje = "La Clave Unica no es un número";
                return false;
            }
          
           if(int.Parse(_persona.strClaveUnica) < 100 || int.Parse(_persona.strClaveUnica) > 999)
            {
                _mensaje = "La Clave Unica esta fuera de rango";
                return false;
            }
            if (_persona.strNombre.Equals(String.Empty))
            {
                _mensaje = "El campo Nombre está vacio";
                return false;
            }
            if (_persona.strNombre.Length > 50)
            {
                _mensaje = "Los caracteres permitidos para nombre rebasan lo establecido de 50";
                return false;
            }

            if (_persona.strNombre.Length <3)
            {
                _mensaje = "el nombre deve tener mas de 4 caracteres";
                return false;
            }

            if (_persona.strAPaterno.Equals(String.Empty))
            {
                _mensaje = "El campo APaterno esta vacio";
                return false;
            }

            if (_persona.strAPaterno.Length > 50)
            {
                _mensaje = "Los caracteres permitidos para Apaterno rebasan lo establecido de 50 para A Paterno";
                return false;
            }


            if (_persona.strAPaterno.Length <3)
            {
                _mensaje = "los caracteres minimos para APaterno son 4";
                return false;
            }

            if (_persona.strAMaterno.Equals(String.Empty))
            {
                _mensaje = "El campo AMaterno esta vacio";
                return false;
            }

            if (_persona.strAMaterno.Length > 50)
            {
                _mensaje = "Los caracteres permitidos para nombre rebasan lo establecido de 50 para A Materno";
                return false;
            }

            if (_persona.strAMaterno.Length < 3)
            {
                _mensaje = "los caracteres minimos para AMaterno son 4";
                return false;
            }

            if (_persona.strCurp.Equals(String.Empty))
            {
                _mensaje = "El campo Curp esta vacio";
                return false;
            }

            if (_persona.strCurp.Length != 18)
            {
                _mensaje = "el numero de caracteres para la cuerp deven ser 18";
                return false;
            }

            if (!calendario(_persona.dteFechaNacimiento))
            {
                _mensaje = "La fecha es incorrecta";
                return false;

            }
            return true;

           

        }
        public bool Bacio(UTTT.Ejemplo.Linq.Data.Entity.Persona _persona)
        {

            try
            {

                if (_persona.idCatSexo != -1) {
                    return false;
                
                }

                if (!(_persona.strClaveUnica.Equals(string.Empty))) { 
                return false;
                
                }

                if (!(_persona.strNombre.Equals(string.Empty))) {

                    return false;
                
                }

                if (!(_persona.strAPaterno.Equals(string.Empty))) {
                    return false;
                }

                if (!(_persona.strAMaterno.Equals(string.Empty))) {

                    return false;
                }

                if (!(_persona.strCurp.Equals(string.Empty))) {
                    return false;
                }

                if (!(_persona.dteFechaNacimiento.Equals(string.Empty)))
                {
                    return false;
                }

                return true;
                

            }
            catch (Exception e)
            {
               

            }
            return false;
        }

        public void regresar()
        {
            this.Response.Redirect("~/PersonaPrincipal.aspx", false);

        }
        #endregion
        public bool formatosValidos(ref String _mensaje) {

           
            if (!this.rvClaveUnica.IsValid) {
                _mensaje = "Formato de Clave Unica invalido asp";
                return false;
            
            }


            if (!this.revNombre.IsValid) {
                _mensaje = "Formato de Nombre invalido";
                return false;
            }

            if (!this.rfvNombre.IsValid) {
                _mensaje = "Formato de Nombre invalido";
                return false;
            }

            if (!this.revAPaterno.IsValid) {
                _mensaje = "Formato de APaterno invalido";
                return false;

            }

            if (!this.rfvAPaterno.IsValid) {
                _mensaje = "Formato de APaterno invalido";
                return false;
            }
            if (!this.revAMaterno.IsValid ) {
                _mensaje = "Formato de AMaterno invalido";
                return false;

            }

            if (!this.rfvAMaterno.IsValid) {
                _mensaje = "Formato de AMaterno invalido";
                return false;

            }
            if (!this.revCURP.IsValid) {
                _mensaje = "Formato de CURP invalido";
                return false;
            }

            if (!this.rfvCurp.IsValid) {
                _mensaje = "Formato de CURP invalido";
                return false;
            }



            ///////////////////////
            if (!this.revFecha.IsValid)
            {
                _mensaje = "Formato de CURP invalido";
                return false;
            }

            if (!this.rfvFecha.IsValid)
            {
                _mensaje = "Formato de CURP invalido";
                return false;
            }
            return true;
        }


        public bool calendario(DateTime ? fechaPersona)
        {
            var fecha = fechaPersona.Value;
            var fechaactual = DateTime.Now;

            if (fecha.Year >= fechaactual.Year)
            {
                return false;

            }
            bool mesYAnioCorrecto = false;

            if ((fecha.Month==1||fecha.Month==3 || fecha.Month==5||fecha.Month==7 || fecha.Month == 8 || fecha.Month == 10 || fecha.Month==12)&&(fecha.Day>0||fecha.Day<=31)) {

                mesYAnioCorrecto = true;
            }
            if ((fecha.Month == 4 || fecha.Month == 6 || fecha.Month == 9 || fecha.Month == 11) && (fecha.Day > 0 || fecha.Day <= 30))
            {

                mesYAnioCorrecto = true;
            }
            if ((fecha.Month == 2 ) && (fecha.Day > 0 || fecha.Day <= 29))
            {

                mesYAnioCorrecto = true;
            }

            return mesYAnioCorrecto;

        }
    }


   
}