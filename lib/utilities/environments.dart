class _Environments {
  final base_url = 'http://192.168.1.14'; //for BURO H/O network

  //final base_url =
    //  'http://123.200.2.189'; // when doing work at home , out of BURO network like mobile data, home wifi
  //http://192.168.1.14/burobd
  //final base_url_new = '';

  //-----------New API Collection with new base url------------------

  // Login
  final userAuthenticate = '/bbhrm_app/api/Authentication/authenticate';
  final userLoginWithToken = '/bbhrm_app/api/User/LoginUser';
  final submit_otp_login = '/bbhrm_app/api/User/OTPSubmit';

  // Forgot Password
  final generate_otp = '/bbhrm_app/api/User/OTP_Generate';
  final changePassForgot = '/bbhrm_app/api/User/ChangePasswordIfForgot';

  //Home Page
  final get_module = '/bbhrm_app/api/Home/GetModulePermission';
  final sub_module = '/bbhrm_app/api/Home/GetModuleUIPermission/';
  final my_request_list = '/bbhrm_app/api/FieldVisit/MyRequestList';
  final my_request_details = '/bbhrm_app/api/FieldVisit/MyRequestDetails';
  final my_request_cancel_single = '/bbhrm_app/api/FieldVisit/MyRequestCancel';
  final my_request_cancel_all = '/bbhrm_app/api/FieldVisit/MyRequestCancelAll';

  //plan
  final my_plan_list = '/bbhrm_app/api/FieldVisit/MyPlanList';
  final my_plan_detail = '/bbhrm_app/api/FieldVisit/MyPlanDetails/';

  //bill and Report
  final my_bill_req_list = '/bbhrm_app/api/FieldVisitBill/MyRequestList';
  final my_bill_req_details = '/bbhrm_app/api/FieldVisitBill/MyRequestDetails';
  final plan_list_approved = '/bbhrm_app/api/FieldVisit/ApprovedPlanList';
  final submit_plan = '/bbhrm_app/api/FieldVisit/PlanSubmit';
  final all_plan_cancel = '/bbhrm_app/api/FieldVisit/PlanCancelAll/';
  final individual_plan_cancel = '/bbhrm_app/api/FieldVisit/PlanDetailsCancel/';
  final submit_apply = '/bbhrm_app/api/FieldVisit/ApplicationSubmit/';
  final branch_list = '/bbhrm_app/api/BasicData/BranchList';
  final change_pass = '/bbhrm_app/api/User/ChangePassword';
  final my_bill_submit = '/bbhrm_app/api/FieldVisitBill/ApplicationSubmit';
  final my_bill_download_info =
      '/bbhrm_app/api/Report_FieldVisit/BillDownload'; // this Url is Used for download bill Info
  final approval_plan_list = '/bbhrm_app/api/FieldVisit/ApprovalPlanList';
  final approval_plan_details =
      '/bbhrm_app/api/FieldVisit/ApprovalPlanDetails/';
  final all_plan_action = '/bbhrm_app/api/FieldVisit/ApprovalPlanAction';
  final individual_plan_action = '/bbhrm_app/api/FieldVisit/ApprovalPlanDetailsAction';

  final approval_request_list = '/bbhrm_app/api/FieldVisit/ApprovalRequestList';
  final approval_request_details =
      '/bbhrm_app/api/FieldVisit/ApprovalRequestLDetails';
  final approval_action_single =
      '/bbhrm_app/api/FieldVisit/ApprovalListDetailsAction';
  final approval_action_all = '/bbhrm_app/api/FieldVisit/ApprovalListAction';
  final submit_otp_forgot = '/bbhrm_app/api/User/OTPSubmitIfForgot';



}

_Environments environments = _Environments();
