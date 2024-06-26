﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.18408
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

// 
// This source code was auto-generated by Microsoft.VSDesigner, Version 4.0.30319.18408.
// 
#pragma warning disable 1591

namespace FMS.FMS_Helper {
    using System;
    using System.Web.Services;
    using System.Diagnostics;
    using System.Web.Services.Protocols;
    using System.Xml.Serialization;
    using System.ComponentModel;
    using System.Data;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="FMS_HelperSoap", Namespace="http://tempuri.org/")]
    public partial class FMS_Helper : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        private System.Threading.SendOrPostCallback check_UsernameOperationCompleted;
        
        private System.Threading.SendOrPostCallback check_userIDOperationCompleted;
        
        private System.Threading.SendOrPostCallback get_group_codeOperationCompleted;
        
        private System.Threading.SendOrPostCallback get_vehicleOperationCompleted;
        
        private System.Threading.SendOrPostCallback get_customerOperationCompleted;
        
        private System.Threading.SendOrPostCallback get_a_tracksOperationCompleted;
        
        private bool useDefaultCredentialsSetExplicitly;
        
        /// <remarks/>
        public FMS_Helper() {
            this.Url = global::FMS.Properties.Settings.Default.FMS_FMS_Helper_FMS_Helper;
            if ((this.IsLocalFileSystemWebService(this.Url) == true)) {
                this.UseDefaultCredentials = true;
                this.useDefaultCredentialsSetExplicitly = false;
            }
            else {
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        public new string Url {
            get {
                return base.Url;
            }
            set {
                if ((((this.IsLocalFileSystemWebService(base.Url) == true) 
                            && (this.useDefaultCredentialsSetExplicitly == false)) 
                            && (this.IsLocalFileSystemWebService(value) == false))) {
                    base.UseDefaultCredentials = false;
                }
                base.Url = value;
            }
        }
        
        public new bool UseDefaultCredentials {
            get {
                return base.UseDefaultCredentials;
            }
            set {
                base.UseDefaultCredentials = value;
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        /// <remarks/>
        public event check_UsernameCompletedEventHandler check_UsernameCompleted;
        
        /// <remarks/>
        public event check_userIDCompletedEventHandler check_userIDCompleted;
        
        /// <remarks/>
        public event get_group_codeCompletedEventHandler get_group_codeCompleted;
        
        /// <remarks/>
        public event get_vehicleCompletedEventHandler get_vehicleCompleted;
        
        /// <remarks/>
        public event get_customerCompletedEventHandler get_customerCompleted;
        
        /// <remarks/>
        public event get_a_tracksCompletedEventHandler get_a_tracksCompleted;
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/check_Username", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public System.Data.DataSet check_Username(string username) {
            object[] results = this.Invoke("check_Username", new object[] {
                        username});
            return ((System.Data.DataSet)(results[0]));
        }
        
        /// <remarks/>
        public void check_UsernameAsync(string username) {
            this.check_UsernameAsync(username, null);
        }
        
        /// <remarks/>
        public void check_UsernameAsync(string username, object userState) {
            if ((this.check_UsernameOperationCompleted == null)) {
                this.check_UsernameOperationCompleted = new System.Threading.SendOrPostCallback(this.Oncheck_UsernameOperationCompleted);
            }
            this.InvokeAsync("check_Username", new object[] {
                        username}, this.check_UsernameOperationCompleted, userState);
        }
        
        private void Oncheck_UsernameOperationCompleted(object arg) {
            if ((this.check_UsernameCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.check_UsernameCompleted(this, new check_UsernameCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/check_userID", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public System.Data.DataSet check_userID(int user_id) {
            object[] results = this.Invoke("check_userID", new object[] {
                        user_id});
            return ((System.Data.DataSet)(results[0]));
        }
        
        /// <remarks/>
        public void check_userIDAsync(int user_id) {
            this.check_userIDAsync(user_id, null);
        }
        
        /// <remarks/>
        public void check_userIDAsync(int user_id, object userState) {
            if ((this.check_userIDOperationCompleted == null)) {
                this.check_userIDOperationCompleted = new System.Threading.SendOrPostCallback(this.Oncheck_userIDOperationCompleted);
            }
            this.InvokeAsync("check_userID", new object[] {
                        user_id}, this.check_userIDOperationCompleted, userState);
        }
        
        private void Oncheck_userIDOperationCompleted(object arg) {
            if ((this.check_userIDCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.check_userIDCompleted(this, new check_userIDCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/get_group_code", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public int[] get_group_code(int user_id) {
            object[] results = this.Invoke("get_group_code", new object[] {
                        user_id});
            return ((int[])(results[0]));
        }
        
        /// <remarks/>
        public void get_group_codeAsync(int user_id) {
            this.get_group_codeAsync(user_id, null);
        }
        
        /// <remarks/>
        public void get_group_codeAsync(int user_id, object userState) {
            if ((this.get_group_codeOperationCompleted == null)) {
                this.get_group_codeOperationCompleted = new System.Threading.SendOrPostCallback(this.Onget_group_codeOperationCompleted);
            }
            this.InvokeAsync("get_group_code", new object[] {
                        user_id}, this.get_group_codeOperationCompleted, userState);
        }
        
        private void Onget_group_codeOperationCompleted(object arg) {
            if ((this.get_group_codeCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.get_group_codeCompleted(this, new get_group_codeCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/get_vehicle", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public System.Data.DataSet get_vehicle(int _group_code) {
            object[] results = this.Invoke("get_vehicle", new object[] {
                        _group_code});
            return ((System.Data.DataSet)(results[0]));
        }
        
        /// <remarks/>
        public void get_vehicleAsync(int _group_code) {
            this.get_vehicleAsync(_group_code, null);
        }
        
        /// <remarks/>
        public void get_vehicleAsync(int _group_code, object userState) {
            if ((this.get_vehicleOperationCompleted == null)) {
                this.get_vehicleOperationCompleted = new System.Threading.SendOrPostCallback(this.Onget_vehicleOperationCompleted);
            }
            this.InvokeAsync("get_vehicle", new object[] {
                        _group_code}, this.get_vehicleOperationCompleted, userState);
        }
        
        private void Onget_vehicleOperationCompleted(object arg) {
            if ((this.get_vehicleCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.get_vehicleCompleted(this, new get_vehicleCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/get_customer", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public System.Data.DataSet get_customer(int _group_code) {
            object[] results = this.Invoke("get_customer", new object[] {
                        _group_code});
            return ((System.Data.DataSet)(results[0]));
        }
        
        /// <remarks/>
        public void get_customerAsync(int _group_code) {
            this.get_customerAsync(_group_code, null);
        }
        
        /// <remarks/>
        public void get_customerAsync(int _group_code, object userState) {
            if ((this.get_customerOperationCompleted == null)) {
                this.get_customerOperationCompleted = new System.Threading.SendOrPostCallback(this.Onget_customerOperationCompleted);
            }
            this.InvokeAsync("get_customer", new object[] {
                        _group_code}, this.get_customerOperationCompleted, userState);
        }
        
        private void Onget_customerOperationCompleted(object arg) {
            if ((this.get_customerCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.get_customerCompleted(this, new get_customerCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/get_a_tracks", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public System.Data.DataSet get_a_tracks(int _vid) {
            object[] results = this.Invoke("get_a_tracks", new object[] {
                        _vid});
            return ((System.Data.DataSet)(results[0]));
        }
        
        /// <remarks/>
        public void get_a_tracksAsync(int _vid) {
            this.get_a_tracksAsync(_vid, null);
        }
        
        /// <remarks/>
        public void get_a_tracksAsync(int _vid, object userState) {
            if ((this.get_a_tracksOperationCompleted == null)) {
                this.get_a_tracksOperationCompleted = new System.Threading.SendOrPostCallback(this.Onget_a_tracksOperationCompleted);
            }
            this.InvokeAsync("get_a_tracks", new object[] {
                        _vid}, this.get_a_tracksOperationCompleted, userState);
        }
        
        private void Onget_a_tracksOperationCompleted(object arg) {
            if ((this.get_a_tracksCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.get_a_tracksCompleted(this, new get_a_tracksCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        public new void CancelAsync(object userState) {
            base.CancelAsync(userState);
        }
        
        private bool IsLocalFileSystemWebService(string url) {
            if (((url == null) 
                        || (url == string.Empty))) {
                return false;
            }
            System.Uri wsUri = new System.Uri(url);
            if (((wsUri.Port >= 1024) 
                        && (string.Compare(wsUri.Host, "localHost", System.StringComparison.OrdinalIgnoreCase) == 0))) {
                return true;
            }
            return false;
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    public delegate void check_UsernameCompletedEventHandler(object sender, check_UsernameCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class check_UsernameCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal check_UsernameCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public System.Data.DataSet Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((System.Data.DataSet)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    public delegate void check_userIDCompletedEventHandler(object sender, check_userIDCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class check_userIDCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal check_userIDCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public System.Data.DataSet Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((System.Data.DataSet)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    public delegate void get_group_codeCompletedEventHandler(object sender, get_group_codeCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class get_group_codeCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal get_group_codeCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public int[] Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((int[])(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    public delegate void get_vehicleCompletedEventHandler(object sender, get_vehicleCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class get_vehicleCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal get_vehicleCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public System.Data.DataSet Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((System.Data.DataSet)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    public delegate void get_customerCompletedEventHandler(object sender, get_customerCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class get_customerCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal get_customerCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public System.Data.DataSet Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((System.Data.DataSet)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    public delegate void get_a_tracksCompletedEventHandler(object sender, get_a_tracksCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18408")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class get_a_tracksCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal get_a_tracksCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public System.Data.DataSet Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((System.Data.DataSet)(this.results[0]));
            }
        }
    }
}

#pragma warning restore 1591