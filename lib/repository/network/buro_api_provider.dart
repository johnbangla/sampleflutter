import 'dart:convert';

import 'package:buroleave/Models/LeaveModel.dart';
import 'package:buroleave/Models/Leaveinfo.dart';
import 'package:buroleave/Models/common_country/district.dart';
import 'package:buroleave/Models/common_country/thana.dart';
import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';

import '../../sessionmanager/session_manager.dart';
import '../../utilities/environments.dart';
import '../database/database_handler.dart';
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
import 'DioException.dart';

export 'package:dio/dio.dart';

class BuroApiProvider {
  Dio networkConfigWithAuth(String username, String password) {
    var dio = Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    dio.options = BaseOptions(headers: <String, String>{
      'authorization': basicAuth,
      //'Content-Type': 'application/json'
    }, baseUrl: environments.base_url, receiveDataWhenStatusError: true);

    /*dio.interceptors.add(
      // For Print API RESPONSE IN LOG
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );*/
    return dio;
  }

  Dio networkConfig() {
    var dio = Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;

    dio.options = BaseOptions(
        headers: <String, String>{},
        baseUrl: environments.base_url,
        receiveDataWhenStatusError: true);

    /* dio.interceptors.add(
      // For Print API RESPONSE IN LOG
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );*/
    return dio;
  }

  Dio networkConfigWithToken(String token) {
    var dio = Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;

    dio.options = BaseOptions(headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, baseUrl: environments.base_url, receiveDataWhenStatusError: true);

    /*dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );*/
    //dio..interceptors.add(new DialogInterceptor());
    //dio.interceptors.add( AuthTokenInterceptor(api));
    return dio;
  }

  Dio networkConfigWithHeader(String key, String value) {
    var dio = Dio();

    dio.options = BaseOptions(headers: <String, String>{
      key: value,
    }, baseUrl: environments.base_url, receiveDataWhenStatusError: true);

    /*dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );*/
    return dio;
  }

  Dio networkConfigWithoutAuth() {
    var dio = Dio();

    dio.options = BaseOptions(
        baseUrl: environments.base_url, receiveDataWhenStatusError: true);
    /* dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );*/
    return dio;
  }

  Dio networkConfigAuthNHeader(
      String headerKey, String headerValue, String username, String password) {
    var dio = Dio();

    dio.options.contentType = Headers.formUrlEncodedContentType;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("USer NAme $username Password $password");

    dio.options = BaseOptions(headers: <String, String>{
      'authorization': basicAuth,
      headerKey: headerValue,
    }, baseUrl: environments.base_url, receiveDataWhenStatusError: true);

    /*dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );*/
    return dio;
  }

  /*Future<LoginUser> authenticate(String username, String password) async {
    final response = await networkConfigWithAuth(username, password).post(
      environments.login_url,
      data: {
        "loginid": username,
        "pwd": password,
      },
    );

    final loginUser = LoginUser.fromJson(response.data);

    return loginUser;
  }*/

  Future<VerifyOtp> verifyOtp(String mobileOtp, String emailOtp) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    final response = await networkConfigWithToken(token).post(
      environments.submit_otp_login,
      data: {
        "mobileOtp": mobileOtp,
        "emailOtp": emailOtp,
      },
    );

    final verifyOtp = VerifyOtp.fromJson(response.data);

    return verifyOtp;
  }

  // After Login In App API collection

  Future<Module> getModule() async {
    print('Get Module called ');
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var module;

    try {
      final response = await networkConfigWithToken('$token').get(
        environments.get_module,
      );
      print('Response Status Code ${response.statusCode}');
      //print('RESPONSE ${response.data}');
      module = Module.fromJson(response.data);
    } on DioError catch (e) {
      print('Get Module on error');
      final errorMessage = DioException.fromDioError(e).toString();

      if (errorMessage == 'Authentication failed.') {
        print('Authentication failed error');
        await getToken(user, password);
        return getModule();
      }
      throw DioException.fromDioError(e);
    }

    return module;
  }

  Future<SubModule> getSubModule(String moduleId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var submodule;

    try {
      final response = await networkConfigWithToken('$token').get(
        '${environments.sub_module}$moduleId',
      );
      submodule = SubModule.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getSubModule(moduleId);
      }
      throw DioException.fromDioError(e);
    }

    return submodule;
  }

  Future<MyRequest> getMyRequest() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var requestList;

    try {
      final response = await networkConfigWithToken('$token').get(
        environments.my_request_list,
      );

      requestList = MyRequest.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getMyRequest();
      }
      throw DioException.fromDioError(e);
    }

    return requestList;
  }

  Future<MyRequestDetails> getRequestDetails(int applicationId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    var requestDetailsList;

    try {
      final response = await networkConfigWithToken('$token').post(
        environments.my_request_details,
        data: {"applicationID": applicationId},
      );

      requestDetailsList = MyRequestDetails.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getRequestDetails(applicationId);
      }
      throw DioException.fromDioError(e);
    }

    return requestDetailsList;
  }

  Future<RequestCancel> requestCancel(
      int appDetailsId, int applicationId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    var requestCancel;

    try {
      final response = await networkConfigWithToken('$token').put(
        environments.my_request_cancel_single,
        data: {
          "appDetailsID": appDetailsId,
          "applicationID": applicationId,
        },
      );

      requestCancel = RequestCancel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return requestCancel(appDetailsId, applicationId);
      }
      throw DioException.fromDioError(e);
    }

    return requestCancel;
  }

  Future<RequestCancelAll> requestCancelAll(int applicationId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    var requestCancelAll;

    try {
      final response = await networkConfigWithToken('$token').put(
        environments.my_request_cancel_all,
        data: {
          "applicationID": applicationId,
        },
      );

      requestCancelAll = RequestCancelAll.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return requestCancelAll(applicationId);
      }
      throw DioException.fromDioError(e);
    }

    return requestCancelAll;
  }

  Future<ApprovalRequest> getApprovalRequest() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var requestList;

    try {
      final response = await networkConfigWithToken('$token').get(
        environments.approval_request_list,
      );

      requestList = ApprovalRequest.fromJson(response.data);
    } on DioError catch (e) {
      print('Get Sub Module on error');
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        print('Authentication failed error');
        await getToken(user, password);
        return getApprovalRequest();
      }
      throw DioException.fromDioError(e);
    }

    return requestList;
  }

  Future<ApprovalRequestDetails> getApprovalDetails(int applicationId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var requestDetailList;

    try {
      final response = await networkConfigWithToken('$token').post(
        environments.approval_request_details,
        data: {"applicationID": applicationId},
      );

      requestDetailList = ApprovalRequestDetails.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getApprovalDetails(applicationId);
      }
      throw DioException.fromDioError(e);
    }

    return requestDetailList;
  }

  Future<ApprovalAction> approvalAction(
      int appDetailsId, int applicationId, String actionType) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var actionResponse;

    try {
      final response = await networkConfigWithToken('$token').put(
        environments.approval_action_single,
        data: {
          "appDetailsID": appDetailsId,
          "applicationID": applicationId,
          "ApprovalStatus": actionType
        },
      );

      actionResponse = ApprovalAction.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return approvalAction(appDetailsId, applicationId, actionType);
      }
      throw DioException.fromDioError(e);
    }

    return actionResponse;
  }

  Future<ApprovalAction> approvalActionAll(
      int applicationId, String actionType) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    var approvalActionResponse;

    try {
      final response = await networkConfigWithToken('$token').put(
        environments.approval_action_all,
        data: {"applicationID": applicationId, "ApprovalStatus": actionType},
      );

      approvalActionResponse = ApprovalAction.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return approvalActionAll(applicationId, actionType);
      }
      throw DioException.fromDioError(e);
    }

    return approvalActionResponse;
  }

  Future<ApplySubmit> submitApplyList(List applyList, int planId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    var submitResponse;

    try {
      final response = await networkConfigWithToken('$token').post(
        '${environments.submit_apply}/$planId',
        data: applyList,
      );

      submitResponse = ApplySubmit.fromJson(response.data);
    } on DioError catch (e) {
      print('Get Sub Module on error');
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return submitApplyList(applyList, planId);
      }
      throw DioException.fromDioError(e);
    }

    return submitResponse;
  }

  Future<ChangePasswordModel> changePassword(
      String oldPass, String newPass, String confirmPass) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    var response;

    try {
      final getResponse = await networkConfigWithToken('$token').post(
        environments.change_pass,
        data: {
          "oldPassword": oldPass,
          "newPassword": newPass,
          "confirmPassword": confirmPass
        },
      );

      response = ChangePasswordModel.fromJson(getResponse.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return changePassword(oldPass, newPass, confirmPass);
      }
      throw DioException.fromDioError(e);
    }
    return response;
  }

  Future<Branch> getAllBranch() async {
    var db = DataBaseHandler();
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    late Branch branchList;
    var count = 0;

    try {
      final response = await networkConfigWithToken('$token').get(
        environments.branch_list,
      );

      branchList = Branch.fromJson(response.data);

      branchList.data!.forEach((element) {
        count++;
        var item = Item(element.branchCode!, element.branchName!);
        addBranchItem(item);
      });
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getAllBranch();
      }
      throw DioException.fromDioError(e);
    }

    return branchList;
  }

  Future<GenerateOTP> getOtp(String userId) async {
    final response = await networkConfigWithHeader(
            'BUROBD-GP_OTP', 'WgIvOJvZIdiXjiLgQa0wDaLit7WZuif4lksL9y')
        .post(
      environments.generate_otp,
      data: {
        "loginid": userId,
      },
    );

    print('UserId $userId');

    final data = GenerateOTP.fromJson(response.data);

    return data;
  }

  Future<void> addBranchItem(Item item) async {
    var handler = DataBaseHandler();
    var result;
    var count;
    handler.initializeDBBranch().whenComplete(() async => {
          result = await handler.insertBranchItem(item),
        });
  }

  Future<VerifyOtp> submitOtpForgotPass(
      String mobileOtp, String emailOtp) async {
    // This method used for submit OTP verify at forgot password

    var user = await sessionManager.userID;
    var otp = mobileOtp.isEmpty ? emailOtp : mobileOtp;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    late VerifyOtp verifyOtp;

    try {
      final response = await networkConfigWithoutAuth().post(
        environments.submit_otp_forgot,
        data: {"loginID": user, "mobileOtp": mobileOtp, "emailOtp": emailOtp},
      );

      verifyOtp = VerifyOtp.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return verifyOtp;
  }

  Future<BillRequest> getBillRequest() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var requestList;

    try {
      final response = await networkConfigWithToken('$token').get(
        environments.my_bill_req_list,
      );

      requestList = BillRequest.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getBillRequest();
      }
      throw DioException.fromDioError(e);
    }

    return requestList;
  }

  Future<ChangePasswordModel> resetPassword(
      String oldPass, String newPass, String confirmPass) async {
    var user = await sessionManager.userID;

    var response;

    try {
      final getResponse = await networkConfig().post(
        environments.changePassForgot,
        data: {
          "loginID": user,
          "oldPassword": oldPass,
          "newPassword": newPass,
          "confirmPassword": confirmPass
        },
      );

      response = ChangePasswordModel.fromJson(getResponse.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return response;
  }

  Future<BillRequestDetails> getBillDetails(int applicationId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var requestDetails;

    try {
      final response = await networkConfigWithToken('$token').post(
        environments.my_bill_req_details,
        data: {
          "applicationID": applicationId,
        },
      );

      requestDetails = BillRequestDetails.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getBillDetails(applicationId);
      }
      throw DioException.fromDioError(e);
    }

    return requestDetails;
  }

  Future<BillSubmitModel> billSubmit(List list) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var requestDetails;

    try {
      final response = await networkConfigWithToken('$token')
          .post(environments.my_bill_submit, data: list);

      requestDetails = BillSubmitModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return billSubmit(list);
      }
      throw DioException.fromDioError(e);
    }

    return requestDetails;
  }

  Future<BillDownloadInfo> getBillDownloadInfo(int applicationId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var billDetails;

    try {
      final response = await networkConfigWithToken('$token').post(
        environments.my_bill_download_info,
        data: {
          "reportType": "pdf/ word/ excel",
          "applicationID": applicationId
        },
      );

      billDetails = BillDownloadInfo.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getBillDownloadInfo(applicationId);
      }
      throw DioException.fromDioError(e);
    }

    return billDetails;
  }

  Future<PlanApprovalRequest> getPlanApproval() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var planList;

    try {
      final response = await networkConfigWithToken('$token').get(
        environments.approval_plan_list,
      );

      planList = PlanApprovalRequest.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getPlanApproval();
      }
      throw DioException.fromDioError(e);
    }

    return planList;
  }

  Future<PlanDetailModel> getPlanDetail(int planId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var planDetail;

    try {
      final response = await networkConfigWithToken('$token').get(
        '${environments.my_plan_detail}$planId',
      );

      planDetail = PlanDetailModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getPlanDetail(planId);
      }
      throw DioException.fromDioError(e);
    }

    return planDetail;
  }

  Future<PlanApprovalDetailsModel> getPlanApprovalDetail(int planId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var planApprovalDetail;

    try {
      final response = await networkConfigWithToken('$token').get(
        '${environments.approval_plan_details}$planId',
      );

      planApprovalDetail = PlanApprovalDetailsModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getPlanApprovalDetail(planId);
      }
      throw DioException.fromDioError(e);
    }

    return planApprovalDetail;
  }

  Future<RequestCancel> cancelPlanReqIndividual(int planId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    var requestCancel;

    try {
      final response = await networkConfigWithToken('$token').put(
        '${environments.individual_plan_cancel}$planId',
      );

      requestCancel = RequestCancel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return cancelPlanReqIndividual(planId);
      }
      throw DioException.fromDioError(e);
    }

    return requestCancel;
  }

  Future<RequestCancel> cancelPlanRequestAll(int planId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    var requestCancelAll;

    try {
      final response = await networkConfigWithToken('$token').put(
        '${environments.all_plan_cancel}$planId',
      );

      requestCancelAll = RequestCancel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return cancelPlanRequestAll(planId);
      }
      throw DioException.fromDioError(e);
    }

    return requestCancelAll;
  }

  Future<ApprovalAction> planApprovalActionAll(
      // Plan action from list
      int planID,
      String actionType) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    var actionResponse;

    try {
      final response = await networkConfigWithToken('$token').put(
          environments.all_plan_action,
          data: {"PlanID": planID, "ActivityName": actionType});

      actionResponse = PlanDetailModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return planApprovalActionAll(planID, actionType);
      }
      throw DioException.fromDioError(e);
    }

    return actionResponse;
  }

  Future<ApprovalAction> planApprovalActionIndividual(
      // Plan action from details
      int planDetailsID,
      int planID,
      String actionType) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    var approvalActionResponse;

    try {
      final response = await networkConfigWithToken('$token').put(
        environments.individual_plan_action,
        data: {
          "PlanDetailsID": planDetailsID,
          "PlanID": planID,
          "ActivityName": actionType
        },
      );

      approvalActionResponse = ApprovalAction.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return planApprovalActionIndividual(planDetailsID, planID, actionType);
      }
      throw DioException.fromDioError(e);
    }

    return approvalActionResponse;
  }

  Future<MyPlan> getMyPlan() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var planList;

    try {
      final response = await networkConfigWithToken('$token').get(
        environments.my_plan_list,
      );

      planList = MyPlan.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();

      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getMyPlan();
      }
      throw DioException.fromDioError(e);
    }

    return planList;
  }

  Future<ApplySubmit> submitPlan(var data) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    var submitResponse;

    try {
      final response = await networkConfigWithToken('$token')
          .post(environments.submit_plan, data: data);

      submitResponse = ApplySubmit.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return submitPlan(data);
      }
      throw DioException.fromDioError(e);
    }

    return submitResponse;
  }

  Future<ApprovedPlan> getApprovedPlan() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var planList;

    try {
      final response = await networkConfigWithToken('$token').get(
        environments.plan_list_approved,
      );

      planList = ApprovedPlan.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getApprovedPlan();
      }
      throw DioException.fromDioError(e);
    }

    return planList;
  }

  Future<UserAthenticate> getToken(String username, String password) async {
    late UserAthenticate authenticate;
    try {
      final response = await networkConfig().post(
        environments.userAuthenticate,
        data: {"loginID": username, "password": password},
      );

      authenticate = UserAthenticate.fromJson(response.data);
      await sessionManager.setToken(authenticate.token);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return authenticate;
  }

  Future<LoginUser> authenticateWithToken(String token) async {
    final response = await networkConfigWithToken(token).post(
      environments.userLoginWithToken,
    );

    final loginUser = LoginUser.fromJson(response.data);

    return loginUser;
  }

  Future<VerifyOtp> submitOtpForgot(String mobileOtp, String emailOtp) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    final response = await networkConfigWithToken(token).post(
      environments.submit_otp_forgot,
      data: {"loginID": user, "mobileOtp": mobileOtp, "emailOtp": emailOtp},
    );

    final verifyOtp = VerifyOtp.fromJson(response.data);

    return verifyOtp;
  }

  //Leave Type with details 21/11/2022
  Future<Leaveinfo> getLeavetList() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var testuserid = "/" + user;
    var leaveList;

    try {
      final response = await networkConfigWithToken('$token').get(
        //The below line will be changed it would be user
        environments.my_leave_list + testuserid ,
      );

      leaveList = Leaveinfo.fromJson(response.data); //ntc
      print('testing');
      print(leaveList);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();

      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return getLeavetList();
      }
      throw DioException.fromDioError(e);
    }

    return leaveList;
  }


  //Leave data sent to db 
 //This is For post request of Employee
  // Future<bool> createPostRequest(LeaveModel data1) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/applyforleave/'),
  //     headers: {"content-type": "application/json"},
  //     body: LeaveModelToJson(data1),
  //   );
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

//The below code is responsible for posting Leave data to the server via api
    Future<bool> createLeaveRequest(LeaveModel data) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;

    var submitResponse;

    try {
      final response = await networkConfigWithToken('$token')
          .post(environments.my_leave_post_request, data: data);

      submitResponse = LeaveModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        await getToken(user, password);
        return createLeaveRequest(data);
      }
      throw DioException.fromDioError(e);
    }

    return submitResponse;
  }
  //Leave Data sent to db

  // common country division district thana
//  Future<District> getDistricttList() async {
    
//   }

//The below code is responsible for fetching country list 
//  Future<Country> getCountrytList() async {
//     var user = await sessionManager.userID;
//     var password = await sessionManager.password;
//     var token = await sessionManager.token;
//     var requestList;

//     try {
//       final response = await networkConfigWithToken('$token').get(
//         environments.my_leave_get_country,
//       );

//       requestList = Country.fromJson(response.data);
//     } on DioError catch (e) {
//       print('Get Sub Module on error');
//       final errorMessage = DioException.fromDioError(e).toString();
//       if (errorMessage == 'Authentication failed.') {
//         print('Authentication failed error');
//         await getToken(user, password);
//         return  getCountrytList();
//       }
//       throw DioException.fromDioError(e);
//     }

//     return requestList;
//   }
//The below code is responsible for fetching country list 

//The below code is responsible for fetching division list 
//  Future<Division> getDivisionListBycountry(var country) async {
//     var user = await sessionManager.userID;
//     var password = await sessionManager.password;
//     var token = await sessionManager.token;
//     var requestList;

//     try {
//       final response = await networkConfigWithToken('$token').get(
//         environments.my_leave_getdivisionby_country,
//       );

//       requestList = Division.fromJson(response.data);
//     } on DioError catch (e) {
//       print('Get Sub Module on error');
//       final errorMessage = DioException.fromDioError(e).toString();
//       if (errorMessage == 'Authentication failed.') {
//         print('Authentication failed error');
//         await getToken(user, password);
//         return  getDivisiontList();
//       }
//       throw DioException.fromDioError(e);
//     }

//     return requestList;
//   }
//The below code is responsible for fetching division list 


//The below code is responsible to fetch district by division
    Future<District> getDistricttList() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var requestList;

    try {
      final response = await networkConfigWithToken('$token').get(
        environments.my_leave_getdistrict_bydivision,
      );

      requestList = District.fromJson(response.data);
    } on DioError catch (e) {
      print('Get Sub Module on error');
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        print('Authentication failed error');
        await getToken(user, password);
        return  getDistricttList();
      }
      throw DioException.fromDioError(e);
    }

    return requestList;
  }
// Future<Thana> getThanaListbydistrict() async {
   
//   }
//The below code is responsible for fetching thana by providing District
 Future<Thana> getThanaListbydistrict(var district) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var token = await sessionManager.token;
    var requestList;
     var districtname = "/" + district;

    try {
      final response = await networkConfigWithToken('$token').get(
        environments.my_leave_getthanaby_city + districtname,
      );

      requestList = Thana.fromJson(response.data);
    } on DioError catch (e) {
      print('Get Sub Module on error');
      final errorMessage = DioException.fromDioError(e).toString();
      if (errorMessage == 'Authentication failed.') {
        print('Authentication failed error');
        await getToken(user, password);
        return  getThanaListbydistrict(districtname);
      }
      throw DioException.fromDioError(e);
    }

    return requestList;
  }
  //common 
}
