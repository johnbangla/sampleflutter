

import '../models/ApprovedPlan.dart';
import '../models/apply_submit.dart';
import '../models/approval_action.dart';
import '../models/approval_request.dart';
import '../models/approval_request_details.dart';
import '../models/bill_download_info.dart';
import '../models/bill_request.dart';
import '../models/bill_request_details.dart';
import '../models/bill_submit_model.dart';
import '../models/branch.dart';
import '../models/change_pass_model.dart';
import '../models/generate_otp.dart';
import '../models/login_user.dart';
import '../models/module.dart';
import '../models/my_plan.dart';
import '../models/my_request.dart';
import '../models/my_request_details.dart';
import '../models/plan_approval_details_model.dart';
import '../models/plan_approval_request.dart';
import '../models/plan_detail_model.dart';
import '../models/request_cancel.dart';
import '../models/request_cancel_all.dart';
import '../models/sub_module.dart';
import '../models/user_authenticate.dart';
import '../models/verify_otp.dart';
import 'buro_api_provider.dart';

class BuroRepository {
  final _provider = BuroApiProvider();

  /*Future<LoginUser> authenticate(String username, String password) async {
    return await _provider.authenticate(username, password);
  }*/

  Future<VerifyOtp> verifyOtp(String mobileOtp, String emailOtp) async {
    return await _provider.verifyOtp(mobileOtp, emailOtp);
  }

  Future<Module?> getModule() async {
    return await _provider.getModule();
  }

  Future<SubModule> getSubModule(String moduleId) async {
    return await _provider.getSubModule(moduleId);
  }

  Future<MyRequest> getRequestList() async {
    return await _provider.getMyRequest();
  }

  Future<MyRequestDetails> getRequestDetail(int applicationId) async {
    return await _provider.getRequestDetails(applicationId);
  }

  Future<RequestCancel> cancelRequest(
      int appDetailsId, int applicationId) async {
    return await _provider.requestCancel(appDetailsId, applicationId);
  }

  Future<RequestCancelAll> cancelAllRequest(int applicationId) async {
    return await _provider.requestCancelAll(applicationId);
  }

  Future<ApprovalRequest> getApprovalRequest() async {
    return await _provider.getApprovalRequest();
  }

  Future<ApprovalRequestDetails> getApprovalDetails(int applicationID) async {
    return await _provider.getApprovalDetails(applicationID);
  }

  Future<ApprovalAction> approvalAction(
      int appDetailsId, int applicationId, String actionType) async {
    return await _provider.approvalAction(
        appDetailsId, applicationId, actionType);
  }

  Future<ApprovalAction> approvalActionAll(
      int applicationId, String actionType) async {
    return await _provider.approvalActionAll(applicationId, actionType);
  }

  Future<ApplySubmit> submitApplyList(List applyList,int planId) async {
    return await _provider.submitApplyList(applyList,planId);
  }

  Future<ChangePasswordModel> changePassword(String oldPass,String newPass,String confirmPass) async {
    return await _provider.changePassword(oldPass,newPass,confirmPass);
  }

  Future<Branch> getBranchList() async {
    return await _provider.getAllBranch();
  }

  Future<GenerateOTP> getOtp(String userId) async {
    return await _provider.getOtp(userId);
  }

  Future<VerifyOtp> submitOtpForgotPass(String mobileOtp, String emailOtp) async {
    return await _provider.submitOtpForgotPass(mobileOtp, emailOtp);
  }

  Future<BillRequest> getBillRequest() async {
    return await _provider.getBillRequest();
  }

  Future<ChangePasswordModel> resetPassword(String oldPass,String newPass,String confirmPass) async {
    return await _provider.resetPassword(oldPass,newPass,confirmPass);
  }


  Future<BillRequestDetails> getBillRequestDetails(int applicationId) async {
    return await _provider.getBillDetails(applicationId);
  }

  Future<BillSubmitModel> billSubmit(List billingList) async {
    return await _provider.billSubmit(billingList);
  }
  Future<BillDownloadInfo?> getBillDownloadInfo(int applicationId) async {
    return await _provider.getBillDownloadInfo(applicationId);
  }

  Future<MyPlan> getMyPlan() async {
    return await _provider.getMyPlan();
  }

  Future<PlanApprovalRequest> getPlanApproval() async {
    return await _provider.getPlanApproval();
  }

  Future<PlanDetailModel> getPlanDetails(int planId) async {
    return await _provider.getPlanDetail(planId);
  }


  Future<PlanApprovalDetailsModel> getPlanApprovalDetails(int planId) async {
    return await _provider.getPlanApprovalDetail(planId);
  }

  /*Future<PlanApprovalDetailsModel> getPlanApprovalDetails(int planId) async {
    return await _provider.getPlanApprovalDetail(planId);
  }*/

  Future<ApprovalAction> planApprovalActionIndividual( // plan approval action from list
      int planDetailsId, int planId, String actionType) async {
    print('tttttttttt planDetailsID $planDetailsId planID $planId');

    return await _provider.planApprovalActionIndividual(
        planDetailsId, planId, actionType);
  }

  Future<ApprovalAction> planApprovalActionAll( // plan approval action from details
      int applicationId, String actionType) async {
    return await _provider.planApprovalActionAll(applicationId, actionType);
  }

  Future<RequestCancel> cancelPlanRequestIndividual(
      int planDetailsId) async {
    return await _provider.cancelPlanReqIndividual(planDetailsId);
  }

  Future<RequestCancel> cancelPlanRequestAll(int planId) async {
    return await _provider.cancelPlanRequestAll(planId);
  }

  Future<ApplySubmit> submitPlan(var plan) async {
    return await _provider.submitPlan(plan);
  }

  Future<ApprovedPlan> getApprovedPlanList() async {
    return await _provider.getApprovedPlan();
  }


  Future<void> setUserData(LoginUser user) async {
    /* await setAccessToken(tokens.accessToken);
    await setRefreshToken(tokens.refreshToken);*/
  }


  Future<UserAthenticate> getToken(String username,String password) async{
    return await _provider.getToken(username, password);

  }

  Future<LoginUser> authenticateWithToken(String token) async {
    return await _provider.authenticateWithToken(token);
  }


}
