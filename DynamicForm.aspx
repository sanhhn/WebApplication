<%@ Page Title="" Language="C#" MasterPageFile="~/Template.Master" AutoEventWireup="true" CodeBehind="DynamicForm.aspx.cs" Inherits="SVHRISWeb.Common.DynamicForm" %>

<%@ Register Src="~/Common/ButtonGroup.ascx" TagPrefix="uc1" TagName="ButtonGroup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHeadTitle" runat="server">
    Màn hình lưới động
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHeadStyle" runat="server">
    <link href="../assets/global/plugins/bootstrap-multiselect/css/bootstrap-multiselect.css" rel="stylesheet" />
    <style type="text/css">
        .dropdown-menu {
            box-shadow: none;
        }

        [role="tabpanel"] {
            padding: 0px !important;
            margin: 0px !important;
        }

        .item-config .lang {
            margin-left: 35px !important;
            margin-top: -10px !important;
        }

        .item-config {
            padding: 1px 0px;
        }

            .item-config:hover {
                background: #FCF4D5 !important;
                border: 1px solid #F88A01;
                font-weight: bolder;
                color: #000;
            }

        #divDialog {
            padding: 0px;
            overflow: hidden;
        }

        #divConfigGrid {
            padding: 0px;
            overflow: hidden;
        }

        #divSearchInfo {
            padding: 0px;
            overflow: hidden;
        }

        #divEmpList {
            padding: 0px;
            overflow: hidden;
        }

        .caret {
            margin-top: 0px !important;
        }
        /* canh search */
        .btn-group > .multiselect {
            height: 24px!important;
            padding-top:0px!important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBodyPageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphBodyPageToolbar" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphBodyPageContent" runat="server">
    <uc1:ButtonGroup runat="server" ID="ButtonGroup" />

    <div class="row" style="padding-bottom: 8px;">
        <div class="col-md-9">
            <div class="row" id="divParameterDynamicForm" style="padding-left: 5px; padding-right: 5px; padding-top: 3px;">
            </div>
            <div class="row" id="divProcessData" style="padding-left: 5px; padding-right: 5px; padding-top: 3px; display: none">
                <div class="col-md-4">
                    <div class="row" style="margin-top: 5px">
                        <div class="col-md-3">
                            <label class="control-label k-label">Tên cột</label>
                        </div>
                        <div class="col-md-6">
                            <input id="cboProcessField" class="ProcessData" style="width: 100%" data-field="field" />
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="row" style="margin-top: 5px">
                        <div class="col-md-3">
                            <label class="control-label k-label">Giá trị</label>
                        </div>
                        <div class="col-md-6" id="divProcessValue">
                            <input id="txtProcessValue" class="ProcessData k-textbox" style="width: 100%" data-field="value" />
                        </div>
                        <div class="col-md-3" style="padding: 0px">
                            <a class="k-button" style="width: 85px" onclick="return ProcessData();"><i class="fa fa-tasks" aria-hidden="true"></i><span class="lang" style="padding-left: 5px">Xử lý</span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <!-----------------grid search and config----------------->
            <div class="row">
                <div class="col-md-5" style="height: 25px !important">
                    <select id="cboSearchGrid" style="width: 100%!important; display: none;" multiple="multiple" class="k-widget k-dropdown k-header k-state-border-down"></select>
                </div>
                <div class="col-md-6">
                    <input class="k-textbox" id="txtSearch_SearchOnGrid" style="width: 100%!important;" placeholder="Search..." onkeyup="execSeachGridByCellParam(event, this)" />
                </div>
                <div class="col-md-1">
                    <div class="k-link dropdown pull-right" style="width: 95%">
                        <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                            <span class="caret" style="margin-right: 10px;"></span>
                        </a>
                        <div class="dropdown-menu" style="margin-top: 9px; min-height: 216px; min-width: 230px; margin-right: 5px">
                            <div style="min-height: 222px; position: relative; float: left; width: 36px; opacity: .5; border-right: 1px solid #eee" class="k-toolbar k-state-border"></div>
                            <div class="item-config">
                                <div class="md-checkbox" style="margin: 7px">
                                    <input type="checkbox" id="chkProcessData" class="md-check" />
                                    <label for="chkProcessData">
                                        <span class="check"></span>
                                        <span class="box"></span><span class="lang">Gán nhanh dữ liệu</span>
                                    </label>
                                </div>
                            </div>
                            <div class="item-config">
                                <div class="md-checkbox" style="margin: 7px;">
                                    <input type="checkbox" id="chkFilterByCell" class="md-check" />
                                    <label for="chkFilterByCell">
                                        <span class="check"></span>
                                        <span class="box"></span><span class="lang">Lọc theo cột</span>
                                    </label>
                                </div>
                            </div>
                            <div class="item-config" onclick="return ConfigGridColumn();">
                                <div style="margin: 9px;">
                                    <span class="lang k-label" style="margin-left: 6px !important;">Cấu hình lưới</span>
                                </div>
                            </div>
                            <div class="item-config">
                                <div class="md-checkbox" style="margin: 7px;">
                                    <input type="checkbox" id="chkGroupByCell" class="md-check" />
                                    <label for="chkGroupByCell">
                                        <span class="check"></span>
                                        <span class="box"></span><span class="lang">Nhóm số liệu(group)</span>
                                    </label>
                                </div>
                            </div>
                            <div class="item-config" onclick="return ShowChangeWidthCell();">
                                <div style="margin: 9px;">
                                    <span class="lang k-label" style="margin-left: 6px !important;">Độ rộng cột</span>
                                </div>
                            </div>
<%--                            <div class="item-config" onclick="return RefreshList();">
                                <div style="margin: 9px;">
                                    <span class="lang k-label" style="margin-left: 6px !important;">Refresh danh mục</span>
                                </div>
                            </div>--%>
                            <div class="item-config">
                                <div class="md-checkbox" style="margin: 7px;">
                                    <input type="checkbox" id="chkChangeForm" class="md-check" />
                                    <label for="chkChangeForm">
                                        <span class="check"></span>
                                        <span class="box hidden"></span><span class="lang">Chọn màn hình</span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-----------------endgrid search and config--------------->
            </div>
        </div>
    </div>

        <div class="row k-content">
            <div class="col-md-12">
                <div id="divDynamicGrid" class="gridList">
                </div>
            </div>
        </div>
        <div class="row hidden">
            <input id="hfFormKey" type="hidden" />
        </div>
        <div class="row hidden">
            <div id="divDialog">
                <div style="height: 100%;">
                    <!--calc(100% - 46px);-->
                    <div style="overflow: hidden; height: 100%" class="k-content" id="divDialogContent">
                    </div>
                </div>
            </div>

            <div id="divEmpList">
                <div style="height: 100%;">
                    <!--calc(100% - 46px);-->
                    <div style="overflow: hidden; height: 100%" class="k-content" id="divEmpListContent">
                    </div>
                </div>
            </div>

            <div id="divAddressList">
                <div style="height: 100%;">
                    <!--calc(100% - 46px);-->
                    <div style="overflow: hidden; height: 100%" class="k-content" id="divAddressListContent">
                    </div>
                </div>
            </div>

            <div id="divConfigGrid">
                <div style="height: 100%;">
                    <!--calc(100% - 46px);-->
                    <div style="overflow: hidden; height: 100%;" class="k-content" id="divConfigGridContent">
                    </div>
                </div>
            </div>

            <!--Div cong thuc bang luong-->
            <div id="divGetDataSalaryDetail">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row" style="margin: 5px 0px 0px 0px">
                            <div class="col-md-12">
                                <%--<label class="control-label SetDataSalaryDetail" data-field="Name"></label>--%>
                                <textarea class="SetDataSalaryDetail" data-field="Name" style="width: 100%; resize: none" disabled="disabled" rows="2"></textarea>
                            </div>
                        </div>
                        <div class="row" style="margin: 0px">
                            <div class="col-md-2" style="margin-top: 5px">
                                <label class="control-label">Công thức</label>
                            </div>
                            <div class="col-md-10" style="margin-top: 5px">
                                <textarea class="k-textbox SetDataSalaryDetail GetDataSalaryDetail" data-field="Formula" rows="4" style="width: 100%; resize: none"></textarea>
                            </div>
                        </div>
                        <div class="row" style="margin: 5px 0px 0px 0px">
                            <div class="col-md-2" style="margin-top: 5px">
                                <label class="control-label">Công thức code</label>
                            </div>
                            <div class="col-md-10" style="margin-top: 5px">
                                <textarea class="k-textbox SetDataSalaryDetail GetDataSalaryDetail" data-field="FormulaCode" rows="4" style="width: 100%; resize: none"></textarea>
                            </div>
                        </div>
                        <div class="row" style="margin: 5px 0px 0px 0px">
                            <div class="col-md-2" style="margin-top: 5px">
                                <label class="control-label">Giá trị</label>
                            </div>
                            <div class="col-md-2" style="margin-top: 5px">
                                <input class="k-textbox SetDataSalaryDetail GetDataSalaryDetail" value="0" style="width: 100%; text-align: right; padding-right: 5px!important; text-indent: 5px;" onfocus="this.select();" onkeyup="return common_formatCurency(this)" data-field="Value" />
                            </div>
                        </div>
                        <div class="row" style="margin: 5px 0px 0px 0px">
                            <div class="col-md-2" style="margin-top: 5px">
                                <label class="control-label">Ghi chú</label>
                            </div>
                            <div class="col-md-10" style="margin-top: 5px">
                                <input class="k-textbox SetDataSalaryDetail GetDataSalaryDetail" style="width: 100%;" id="txtNote" data-field="Note" />
                            </div>
                        </div>
                        <div style="margin-top: 10px" class="row k-toolbar k-widget k-toolbar-resizable">
                            <div class="col-md-6">
                                <a class="k-button" onclick="return UpdateItem();">
                                    <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                    <span style="padding-left: 5px" class="lang">Lưu tất cả</span>
                                </a>
                            </div>
                            <div class="col-md-6" style="text-align: right">
                                <a class="k-button" onclick="return  UpdateSalaryItem();">
                                    <i class="fa fa-floppy-o" aria-hidden="true"></i>
                                    <span style="padding-left: 5px" class="lang">Lưu</span>
                                </a>
                                <a class="k-button" onclick="return CloseDialog()">
                                    <i class="fa fa-times" aria-hidden="true"></i>
                                    <span style="padding-left: 5px" class="lang">Bỏ qua</span>
                                </a>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Điều kiện lọc và lưới-->
        <div class="row hidden">
            <input id="hfRowUniqueID" type="hidden" />
            <input id="hfIdsTemp" type="hidden" /><!--Lưu uid để xử lý cho những field editable = false-->
            <input id="hfListMenu" type="hidden" />
            <input id="hfGridID" type="hidden" />
            <input id="hfRowTemp" type="hidden" />
            <div id="treeTempMenu"></div>
        </div>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="cphBodyPageScript" runat="server">
    <script type="text/javascript" src="../assets/admin/pages/scripts/accounting.js"></script>
    <script type="text/javascript" src="../assets/admin/pages/scripts/buttonGroup.js?version=<%= DateTime.Now.ToString("yyyyMMddHHmm") %>"></script>
    <script type="text/javascript" src="../assets/admin/pages/scripts/dynamicForm.js?version=<%= DateTime.Now.ToString("yyyyMMddHHmm") %>"></script>
    <script type="text/javascript" src="../assets/global/plugins/bootstrap-multiselect/js/bootstrap-multiselect.js"></script>
    <%-- <script type="text/javascript" src="../assets/admin/pages/scripts/sv-grid-columns-control.js"></script>--%>
    <script type="text/javascript">
        var treeDept_DynamicForm = null;

        var mstrMonth = null;
        var mstrYear = null;
        var strCurrentYear = (new Date()).getFullYear();
        var strCurrentMonth = (new Date()).getMonth() + 1;
        var mstrMenuID = common_getParamByName("menuid");

        $(document).ready(function () {
            if (mstrFormKey === null || mstrFormKey === undefined || mstrFormKey === "") {
                mstrFormKey = "";
            }
            if (mstrFormKey !== "") {
                var strFormKeyID = mstrFormKey;
                var dtDynamicForm = GetDataByGridKey(mstrFormKey);
                dtDynamicForm.done(function (data) {
                    if (data != null) {
                        var objDynamicForm = JSON.parse(data)[0];
                        mstrStoreInfo = (objDynamicForm["StoreInfo"] == "" || objDynamicForm["StoreInfo"] == null || objDynamicForm["StoreInfo"] == undefined) ? "" : objDynamicForm["StoreInfo"];
                        mstrFilterInfo = (objDynamicForm["FilterInfo"] == "" || objDynamicForm["FilterInfo"] == null || objDynamicForm["FilterInfo"] == undefined) ? "" : objDynamicForm["FilterInfo"];
                        mstrDeleteInfo = (objDynamicForm["DeleteInfo"] == "" || objDynamicForm["DeleteInfo"] == null || objDynamicForm["DeleteInfo"] == undefined) ? "" : objDynamicForm["DeleteInfo"];
                        mstrButtonInfo = (objDynamicForm["ButtonInfo"] == "" || objDynamicForm["ButtonInfo"] == null || objDynamicForm["ButtonInfo"] == undefined) ? "" : objDynamicForm["ButtonInfo"];
                        mstrImportInfo = (objDynamicForm["ImportInfo"] == "" || objDynamicForm["ImportInfo"] == null || objDynamicForm["ImportInfo"] == undefined) ? "" : objDynamicForm["ImportInfo"];
                        mstrReportInfo = (objDynamicForm["ReportInfo"] == "" || objDynamicForm["ReportInfo"] == null || objDynamicForm["ReportInfo"] == undefined) ? "" : objDynamicForm["ReportInfo"];
                        mintFixLeft = objDynamicForm["FixLeft"];
                        mintFixRight = objDynamicForm["FixRight"];
                        if (mstrReportInfo != "") {
                            LoadReportControl();
                        }

                        if (mstrImportInfo != "") {
                            LoadImportControl();
                        }

                        GetFixParam(mstrFormKey, mstrProjectCode);
                        //common_GetListMenu();
                        //sv_CreateGridControlColumns();


                        $.when(LoadFilterControls(mstrFormKey)).then(function () {
                            $.when(CreateGrid("divDynamicGrid")).then(function () {
                                ReloadFormByGridKey();

                                LoadButtonDynamic();
                            });
                        });
                    }
                });
            }

            common_GetListMenu();
            CreateDivDialog();
            CreateDivSearchInfo();
            CreateDivConfigGrid();
            CreateDivEmpList();
            CreateDivAddressList();

            if (getCookie("Month") != "" && getCookie("Month") != null && getCookie("Month") != undefined) {
                strCurrentMonth = getCookie("Month");
                strCurrentYear = getCookie("Year");
            }

            $('#lblMM').text(strCurrentMonth);
            $('#lblYYYY').text(strCurrentYear);

            //20180725: thai them, xet gia tri lan dau khi load thang
            mstrMonth = strCurrentMonth;
            mstrYear = strCurrentYear;

            if (mstrMenuID == "mnuPayrollCollection") {
                $("#btnAddEmployee").find("span").text("Khóa lương");
                $("#btnAddEmployee").find("i").removeClass("fa-plus");
                $("#btnAddEmployee").find("i").addClass("fa-lock");
            }
        });//$(document).ready(function () {

        //Xu ly phim
        var body = document.querySelector('body');

        body.onkeydown = function (e) {
            //if (!e.metaKey) {
            //    e.preventDefault();
            //}
            var keyCode = e.keyCode || e.which;

            if (keyCode === 115) {
                if (mstrFormKey.toLowerCase() === "pr_payroll") {
                    ShowPopUpF4();
                }
            }
        }//body.onkeydown = function (e) {

        function ProcessData() {
            var grid = $("#divDynamicGrid").data('kendoGrid');
            var dtGrid = grid.dataSource._data;
            if (dtGrid.length === 0) {
                sweetAlert("Lỗi", "Vui lòng tải dữ liệu trong bảng trước", "error");
            } else {
                var dtProcess = jQuery.extend(true, [], dtGrid);
                dtProcess = $.grep(dtProcess, function (item) {
                    return $('#chk-divDynamicGrid' + item["uid"]).is(":checked") == true;
                });
                if (dtProcess.length > 0) {
                    var objProcess = new Object();
                    common_GetData('ProcessData', objProcess);
                    $.each(dtGrid, function (i, item) {
                        $.each(dtProcess, function (k, ktem) {
                            if (ktem["uid"] === item["uid"]) {
                                item[objProcess["field"]] = objProcess["value"];
                            }
                        })
                    });
                    grid.dataSource.data(dtGrid);
                } else {
                    sweetAlert("Lỗi", "Vui lòng chọn dòng cần xử lý", "error");
                }
            }
        }//function ProcessData() {

        function AddNew() {
            mblnSaveResult = true;
            //Bấm thêm mới là tạo 10 dòng trống
            var grid = $("#divDynamicGrid").data("kendoGrid");
            var leng = grid.dataSource._data.length;

            var dtProcess = grid.dataSource.data();
            var objCol = new Object();

            if (dtProcess.length > 0) {
                if (dtProcess[0] != undefined) {
                    $.each(dtProcess[0], function (i, item) {
                        if (typeof item == "function") {
                            delete item;
                        } else {
                            for (var objectName in item) {
                                if (isNaN(objectName) == false) {
                                    delete objectName;
                                } else if (objectName == "isValid" || objectName == "lsbankbranchID" || objectName == "change" || objectName == "formatMoney") {
                                    delete objectName;
                                }
                                else {
                                    objCol[objectName] = "";
                                }
                            }
                        }
                    });
                }
            }//if (dtProcess.length > 0) {

            for (var i = 0; i < 10; i++) {
                //grid.dataSource.insert(leng, objCol);
                var idx = grid.dataSource.indexOf(grid.dataItem(grid.select()));
                grid.dataSource.insert(idx + 1, objCol);
            }
        }//function AddNew() {

        $(".item-config").click(function (e) {
            //e.preventDefault();
            var $element = $(this);
            var $input = $($element.find("input"));
            //$input.trigger("click");
            var id = $input.attr("id");
            var checked = $input.is(":checked");
            if (checked === false) {
                switch (id) {
                    case 'chkProcessData':
                        $("#divProcessData").hide();
                        $("#divParameterDynamicForm").show();
                        break;
                    case 'chkFilterByCell':
                        $("#divDynamicGrid").data("kendoGrid").setOptions({
                            filterable: false
                        });
                        break;
                    case 'chkChangeForm':
                        break;
                    case 'chkGroupByCell':
                        $("#divDynamicGrid").data("kendoGrid").setOptions({
                            groupable: false
                        });
                        break
                }
            } else {
                switch (id) {
                    case 'chkProcessData':
                        $("#divProcessData").show();
                        $("#divParameterDynamicForm").hide();
                        break;
                    case 'chkFilterByCell':
                        $("#divDynamicGrid").data("kendoGrid").setOptions({
                            //columnMenu: true,
                            filterable: {
                                //mode: "menu row",
                                //mode: "menu",
                                //mode: "row",
                                operators: {
                                    string: {
                                        contains: "Chứa",
                                        eq: "Bằng",
                                        neq: "Không bằng",
                                        startswith: "Bắt đầu bằng",
                                        doesnotcontain: "Không chứa",
                                        endswith: "Kết thúc bằng",
                                        isnull: "Rỗng",
                                        isnotnull: "Không rỗng",
                                        isempty: "Trống",
                                        isnotempty: "Không trống"
                                    }
                                }
                            }
                        });
                        break;
                    case 'chkChangeForm':
                        break;
                    case 'chkGroupByCell':
                        $("#divDynamicGrid").data("kendoGrid").setOptions({
                            groupable: true
                        });
                        break;
                }
            }
        });//$(".item-config").click(function (e) {

        function ViewExcelReport(strFileName, strStore, blnUseFilterParam) {
            try {
                var strStoreInputs = "";
                strStore = strStore.replace("&UserID", "'" + mstrUserID + "'");

                //if (mstrSearchParams.indexOf("UseEmpHeadSearch=1") !== -1) {
                var strDeptIDsParam = common_GetDeptParam();
                strStoreInputs = strStoreInputs + strDeptIDsParam;
                //}

                if (mstrSearchParams.indexOf("UseGridKey=1") >= 0)///su dung gridkey
                    strStoreInputs = strStoreInputs + "',@FormKey='" + mstrFormKey + "'";
                if (mstrSearchParams.indexOf("UseProjectCode=1") >= 0)//su dung projectcode
                    strStoreInputs = strStoreInputs + ",@ProjectCode='" + mstrProjectCode + "'";
                if (mstrSearchParams.indexOf("UseLanguageID=1") >= 0)
                    strStoreInputs = strStoreInputs + ",@LanguageID='" + mstrLanguageID + "'";
                if (mstrSearchParams.indexOf("UseLanguage=1") >= 0)
                    strStoreInputs = strStoreInputs + ",@Language='" + mstrLanguageID + "'";
                //if (strMonth != "" && strMonth != "0")
                //    strStoreInputs = strStoreInputs + ",@MM='" + strMonth + "'";//neu la man hinh thang nam -> cong them thang
                //if (strYear != "")
                //    strStoreInputs = strStoreInputs + ",@YYYY='" + strYear + "'";//neu la man hinh thang nam -> cong them nam

                if (blnUseFilterParam) {
                    var objFilterParam = new Object();//GridFilter
                    common_GetData('GridFilter', objFilterParam)
                    //mstrDinamicCondition
                    for (var field in objFilterParam) {
                        strStoreInputs += " ,@" + field + "=N'" + objFilterParam[field] + "'";
                    }
                }


                var strParamFields = "";
                var strParamValues = "";

                var strStoreName = strStore; //"PR_sprpt01SalaryDetail ";//dtList.Rows[dtList.Rows.Count-1]["ID"].ToString().Trim();
                //strStoreName += strStoreInputs;
                var strStoreInfoT = strStoreName.trim();
                if (strStoreInfoT.indexOf("@") > 0 && strStoreInfoT.substring(strStoreInfoT.length - 1) != ",")
                    strStoreName += ", " + strStoreInputs;
                else
                    strStoreName += strStoreInputs;

                if (mstrFormKey.toLowerCase() === "pr_payroll") {
                    var strMM = "00" + $("#lblMM").text();
                    strStoreName += ", @Period = '" + strMM.substring(strMM.length - 2) + "/" + $("#lblYYYY").text() + "'"
                }

                setCookie('ReportStore', strStoreName);
                setCookie('ReportFile', strFileName);
                setCookie('ReportType', 'ExcelReport'); //WordReport    ExcelReport
                window.open('<%= ResolveUrl("~/Reports/ShowReport.aspx")%>');
                return false;

            }
            catch (err) {
                console.log(err);
            }
        }//function ViewExcelReport(strFileName, strStore, blnUseFilterParam) {

        function WordReport(strFileName, strStore, strColumnKeyName) {
            try {
                var strStoreInputs = "";
                var strParamListField = "";
                var strParamList = "";///tham so mang vd empids='1,2,3,4'
                var strParam = "";       //[@IDs=&ID]

                if (strStore.indexOf('[') > 0) //PR_sprpt06PaySlit [@IDs=&ID]
                {
                    strStoreInputs = strStore.substring(0, strStore.indexOf('['));
                    strParamList = strStore.substring(strStore.indexOf('['), (strStore.indexOf(']') + 1));
                    strParam = strParamList;
                    strParamListField = strParamList.substring(1, strParamList.indexOf('&') - 1);
                    strParamList = strParamList.substring(strParamList.indexOf('&') + 1, strParamList.indexOf(']'));
                }

                var strIDs = "";
                var tableName = $(".gridList").attr("id");
                var dtGrid = $("#" + tableName).data('kendoGrid').dataSource._data;
                var arrDataGrid = jQuery.extend(true, [], dtGrid);//Khong dung den data goc--tranh loi

                arrDataGrid = $.grep(arrDataGrid, function (item) {
                    return ($("#chk-" + tableName + item.uid).is(":checked") === true);
                });

                //20180730: thai them, xu rieng cho man hinh tinh luong
                var strEmpIDs = "";
                $.each(arrDataGrid, function (i, item) {
                    var strID = item[strParamList];
                    if (strID != "") {
                        strIDs += $.trim(strID) + ",";
                    }

                    if (mstrFormKey.toLowerCase() === "pr_payroll") {
                        strEmpIDs += item["EmpID"] + ",";
                    }

                });

                strStoreInputs = strStore.replace(strParam, strParamListField + "=N'" + strIDs + "'");

                if (strIDs === "") {
                    var strTitle = (mstrLanguageID === null || mstrLanguageID === undefined || mstrLanguageID === "" || mstrLanguageID === "VN") ? "Thông báo lỗi" : "Error";
                    var strText = (mstrLanguageID === null || mstrLanguageID === undefined || mstrLanguageID === "" || mstrLanguageID === "VN") ? "Chọn dòng cần xử lý!" : "Select row to process!";
                    sweetAlert(strTitle, strText, "error");

                    return;
                }

                if (mstrFormKey.toLowerCase() === "pr_payroll") {
                    var strMM = "00" + $("#lblMM").text();
                    //PR_sprpt06PaySlit @Period ='06/2018', @EmpIDs = 'HO1004,',@projectcode='POONGIN'
                    strStoreInputs = strStore + " @ProjectCode='" + mstrProjectCode + "', @Period = '" + strMM.substring(strMM.length - 2) + "/" + $("#lblYYYY").text() + "', @EmpIDs = '" + strEmpIDs + "'"
                }

                //console.log('strFileName:' + strFileName + '\n', 'strStoreInputs:' + strStoreInputs + '\n', 'strColumnKeyName:' + strColumnKeyName + '\n');
                setCookie('ReportStore', strStoreInputs);
                setCookie('ReportFile', strFileName);
                setCookie('ReportType', 'WordReport'); //WordReport    ExcelReport
                setCookie('OpenMode', 'HTML'); //WordReport    ExcelReport
                window.open('<%= ResolveUrl("~/Reports/ShowReport.aspx")%>');
                return false;

            } catch (err) {
                console.log(err);
            }
        }//function WordReport(strFileName, strStore, strColumnKeyName) {

        function EditData() {

        }//function EditData() {

        //20180725: thai them, xu li rieng cho man hinh tinh luong
        function CheckCalulate_PayRoll() {
            var blnReturn = true;
            var strCurMonth = "";
            var strCalMonth = "";
            var strMM = "00" + mstrMonth;
            var dtpNewDate = new Date();

            if (dtpNewDate.getDate() < 8) {
                strCurMonth = moment(dtpNewDate).add(-1, 'month').format("MM/YYYY");
            }
            else {
                strCurMonth = moment(dtpNewDate).format("MM/YYYY");
            }

            strCurMonth = strCurMonth.substring(0, 2) + "/01/" + strCurMonth.substring(3);//=> MM/DD/YYYY
            strCalMonth = strMM.substring(strMM.length - 2) + "/" + mstrYear;
            strCalMonth = strCalMonth.substring(0, 2) + "/01/" + strCalMonth.substring(3);

            var intR = 0;
            if (strCalMonth != strCurMonth) {
                //dieu chinh cho phep tinh luong truoc 1 thang , >2 thang thi bao
                if (new Date(moment(strCalMonth, "MM/DD/YYYY")) > new Date(moment(strCurMonth, "MM/DD/YYYY").add(1, 'month')))
                    intR = 1;

                if (new Date(moment(strCalMonth, "MM/DD/YYYY")) < new Date(moment(strCurMonth, "MM/DD/YYYY")))
                    intR = 0;

                if (intR == 1) {
                    swal("Thông báo", "Sai tháng lương, tháng lương hiện tại là tháng " + strCurMonth.replace("01/", ""), "error");
                    blnReturn = false;
                }
                else if (intR == 0) {
                    var strMess = "Tháng lương hiện tại là tháng " + strCurMonth.replace("01/", "") + ", bạn muốn tính tháng " + strMM.substring(strMM.length - 2) + "/" + mstrYear + "?";

                    var answer = confirm(strMess);

                    if (answer) {
                        blnReturn = true;
                    }
                    else {
                        blnReturn = false;
                    }
                }
            }

            return blnReturn;
        }//function CheckCalulate_PayRoll() {

        //20180724: thai them, nut xu ly 
        function fProcessData() {
            var strDeptIDsParam = common_GetDeptParam();
            var strParameter = "";
            var blnProcessData = true;
            var blnLockPR = false;

            var strMM = "00" + $("#lblMM").text();
            var strYYYY = $("#lblYYYY").text();

            blnProcessData = CheckCalulate_PayRoll();

            //kiem tra luong da khoa hay chua
            var pr = CheckLockPayroll();

            if (pr != null) {
                pr.done(function (data) {
                    if (data != null && data.length > 0) {
                        if (data[0]["Lock"] == true && data[0]["Module"] == "PR") {
                            blnLockPR = true;
                        }
                    }

                    if (blnLockPR == true) {
                        swal("Thông báo", "Bảng lương tháng " + strMM.substring(strMM.length - 2) + "/" + strYYYY + " đã khóa!", "warning");
                        return;

                        blnProcessData = false;
                    } else {
                        blnProcessData = true;
                    }

                    if (blnProcessData == true) {
                        var strDataGrid = $("#divDynamicGrid").data("kendoGrid");
                        var objDataGrid = strDataGrid.dataSource.data();
                        var dtProcess = jQuery.extend(true, [], objDataGrid);

                        dtProcess = $.grep(dtProcess, function (item) {
                            return ($('#chk-divDynamicGrid' + item["uid"]).is(":checked") == true);
                        });

                        var obj = strMM.substring(strMM.length - 2);

                        if ((obj == null || obj == '' || obj == undefined) != true) {
                            strParameter += (strParameter == '' ? "" : ", ") + "@MM = '" + obj + "'";
                        }

                        obj = strYYYY;

                        if ((obj == null || obj == '' || obj == undefined) != true) {
                            strParameter += (strParameter == '' ? "" : ", ") + "@YYYY = '" + obj + "'";
                        }

                        strParameter += ", " + strDeptIDsParam;

                        //xu li tung dong
                        if (dtProcess.length > 0) {
                            dtProcess = JSON.parse(JSON.stringify(dtProcess));

                            common_wait(0).then(() => {

                                dtProcess = $.each(dtProcess, function (i, item) {
                                    var strParameter2 = "";
                                    var strParameter3 = "";

                                    strParameter3 = strParameter.substr(0, strParameter.lastIndexOf(","));

                                    if (item["strSQLSum"] != null && item["strSQLSum"] != "") {
                                        strParameter2 += " @MM = '" + strMM.substring(strMM.length - 2) + "' ";
                                        strParameter2 += ", @YYYY = '" + strYYYY + "' ";
                                        strParameter2 += ", @EmpID = '" + item["EmpID"] + "' ";
                                        strParameter2 += ", @strSQLSum = '" + item["strSQLSum"].replace("#", "") + "' ";
                                        strParameter2 += ", @FromDate = '" + (item["FromDateStr"] == undefined ? "" : item["FromDateStr"]) + "' ";
                                        strParameter2 += ", @ToDate = '" + (item["ToDateStr"] == undefined ? "" : item["ToDateStr"]) + "' ";

                                        $.ajax({
                                            type: "GET",
                                            url: "../api/SalaryDetail/SaveSalary",
                                            data: {
                                                'strParameter': strParameter2,
                                                'strProjectCode': mstrProjectCode
                                            },
                                            dataType: "json",
                                            error: function (request, status, error) {
                                                console.log(request);
                                            }
                                        });
                                    }//if (item["strSQLSum"] != null && item["strSQLSum"] != "") {

                                    strParameter3 += ", @EmpID = '" + item["EmpID"] + "' ";

                                    $.ajax({
                                        type: "GET",
                                        url: "../api/SalaryDetail/CalculateSalary",
                                        data: {
                                            'strParameter': strParameter3,
                                            'strProjectCode': mstrProjectCode
                                        },
                                        dataType: "json",
                                        error: function (request, status, error) {
                                            // common_ShowErrorMessage(request, status, error);
                                            console.log(request);
                                        }
                                    });
                                });

                                return common_wait(500);
                            }).then(() => {
                                swal("Thông báo", "Tính lương thành công!!!", "success");
                                LoadGridData();
                            });
                        } else {

                            $.ajax({
                                type: "GET",
                                url: "../api/SalaryDetail/CalculateSalary",
                                beforeSend: function () {
                                    $.blockUI({
                                        message: '<div style="margin: 10px; vertical-align:middle; height:75px">'
                                            + '<div class="row"><img src="../assets/admin/pages/img/ajax-loader.gif" style="vertical-align:middle; padding-top:15px"/></div>'
                                            + '<div class="row" style="padding-top:10px"><span style="font-size:18px">&nbsp;Đang lấy dữ liệu...</span></div>'
                                            + '</div>'
                                    });
                                },
                                complete: function () {
                                    $.unblockUI();
                                },
                                data: {
                                    'strParameter': strParameter,
                                    'strProjectCode': mstrProjectCode
                                },
                                dataType: "json",
                                success: function (response) {
                                    swal("Thông báo", "Tính lương thành công!!!", "success");
                                    LoadGridData();
                                },
                                error: function (request, status, error) {
                                    common_ShowErrorMessage(request, status, error);
                                }
                            });
                        }
                    }
                    //});
                });
            }//if (pr != null) {
        }//function fProcessData() {

        //ham kiem tra bang luong da khoa hay chua
        function CheckLockPayroll() {
            var strDeptIDsParam = common_GetDeptParam();
            var strParameter = "";
            var strMM = "00" + mstrMonth;

            var obj = strMM.substring(strMM.length - 2) + "/" + mstrYear;

            if ((obj == null || obj == '' || obj == undefined) != true) {
                strParameter += (strParameter == '' ? "" : ", ") + "@Month = '" + obj + "'";
            }

            strParameter += ", " + strDeptIDsParam;

            return $.ajax({
                type: "GET",
                url: "../api/SalaryDetail/CheckLockPayroll",
                data: {
                    'strParameter': strParameter
                },
                dataType: "json",
                success: function (response) {
                },
                error: function (request, status, error) {
                    common_ShowErrorMessage(request, status, error);
                }
            });
        }//function CheckLockPayroll() {

        function AddNewEmp() {
            var strDeptIDsParam = common_GetDeptParam();
            var strParameter = "";
            var strMM = "00" + mstrMonth;

            var obj = strMM.substring(strMM.length - 2) + "/" + mstrYear;

            if ((obj == null || obj == '' || obj == undefined) != true) {
                strParameter += (strParameter == '' ? "" : ", ") + "@Month = '" + obj + "'";
            }


            obj = mstrUserID;

            if ((obj == null || obj == '' || obj == undefined) != true) {
                strParameter += (strParameter == '' ? "" : ", ") + "@UserUnLock = '" + obj + "'";
            }

            strParameter += ", " + strDeptIDsParam;

            $.ajax({
                type: "GET",
                url: "../api/SalaryDetail/LockPayroll",
                beforeSend: function () {
                    $.blockUI({
                        message: '<div style="margin: 10px; vertical-align:middle; height:75px">'
                            + '<div class="row"><img src="../assets/admin/pages/img/ajax-loader.gif" style="vertical-align:middle; padding-top:15px"/></div>'
                            + '<div class="row" style="padding-top:10px"><span style="font-size:18px">&nbsp;Đang lấy dữ liệu...</span></div>'
                            + '</div>'
                    });
                },
                complete: function () {
                    $.unblockUI();
                },
                data: {
                    'strParameter': strParameter
                },
                dataType: "json",
                success: function (response) {
                    swal("Thông báo", "Khóa thành công!!!", "success");
                },
                error: function (request, status, error) {
                    common_ShowErrorMessage(request, status, error);
                }
            });
        }//function AddNewEmp() {

        //ham xoa luong 
        function DeleteData_PayRoll(objPayRoll) {
            var strMM = $("#lblMM").text();
            var strYYYY = $("#lblYYYY").text();
            var blnLockPR = false;
            var blnDeletePayRoll = true;
            var blnSuccess = true;
            var strErr = "";

            //kiem tra luong da khoa hay chua
            var pr = CheckLockPayroll();

            if (pr != null) {
                pr.done(function (data) {
                    if (data != null && data.length > 0) {
                        if (data[0]["Lock"] == true && data[0]["Module"] == "PR") {
                            blnLockPR = true;
                        }
                    }

                    if (blnLockPR == true) {
                        swal("Thông báo", "Bảng lương tháng " + strMM + "/" + strYYYY + " đã khóa!", "warning");
                        return;

                        blnDeletePayRoll = false;
                    } else {
                        blnDeletePayRoll = true;
                    }

                    if (blnDeletePayRoll == true) {
                        swal({
                            title: "Bạn có chắc chắn?",
                            text: "Dữ liệu đã xóa không thể khôi phục !",
                            type: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "Xóa đi !",
                            cancelButtonText: "Quay lại"
                            //closeOnConfirm: true
                        }).then(function () {
                            $.each(objPayRoll, function (i, item) {
                                var strParameter = "";
                                strParameter += "@MM = '" + strMM + "' ";
                                strParameter += ", @YYYY = '" + strYYYY + "' ";
                                strParameter += ", @FromDateDetail = '" + moment(item["FromDate"]).format("DD/MM/YYYY") + "' ";
                                strParameter += ", @ToDateDetail = '" + moment(item["ToDate"]).format("DD/MM/YYYY") + "' ";
                                strParameter += ", @EmpID = '" + item["EmpID"] + "' ";
                                strParameter += ", @ProjectCode = '" + mstrProjectCode + "' ";

                                var strUrl = "../api/SalaryDetail/Delete" + "?" + $.param({ "strParameter": strParameter, "strUserID": mstrUserID });
                                var fDelete = fDelete_PayRoll(strUrl);

                                if (fDelete != null) {
                                    fDelete.done(function (data) {
                                        blnSuccess = true;
                                    });

                                    fDelete.error(function (request, status, error) {
                                        blnSuccess = false;
                                        strErr += request;
                                    });
                                };
                            });

                            if (blnSuccess == true) {
                                swal("Thông báo", "Xóa thành công", "success");
                                LoadGridData();
                            } else {
                                swal("Thông báo", strErr, "error");
                            }
                        });
                    }//if (blnDeletePayRoll == true) {
                });
            }//if (pr != null) {
        }//function DeleteData_PayRoll() {

        function fDelete_PayRoll(strUrl) {
            return $.ajax({
                type: "DELETE",
                url: strUrl,
                dataType: 'json',
                //error: function (request, status, error) {
                //    common_ShowErrorMessage(request, status, error);
                //}
            });
        }
    </script>
</asp:Content>

