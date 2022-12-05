import 'package:buroleave/LeaveModuleUserInterface/LeaveAuthorization.dart';
import 'package:buroleave/LeaveModuleUserInterface/LeaveDashboard.dart';
import 'package:buroleave/LeaveModuleUserInterface/Myleavestatus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../repository/models/ApprovalRequestInfo.dart';
import '../repository/models/apply_request.dart';
import '../repository/models/generate_otp.dart';
import '../repository/models/login_user.dart';
import '../views/admin_panel/create_role.dart';
import '../views/admin_panel/create_user.dart';
import '../views/field_visit/add_bill/bill_req_list.dart';
import '../views/field_visit/add_bill/bill_submit.dart';
import '../views/field_visit/apply/apply_list.dart';
import '../views/field_visit/apply/apply_page.dart';
import '../views/field_visit/approvalrequest/approval_details.dart';
import '../views/field_visit/approvalrequest/approval_list.dart';
import '../views/field_visit/field_visit_main.dart';
import '../views/field_visit/myPlanList/my_plan_detail.dart';
import '../views/field_visit/myPlanList/my_plan_list.dart';
import '../views/field_visit/myrequest/request_details.dart';
import '../views/field_visit/myrequest/request_list.dart';
import '../views/field_visit/plan/plan_submit.dart';
import '../views/field_visit/planApprovalRequst/plan_approval_details.dart';
import '../views/field_visit/planApprovalRequst/plan_approval_list.dart';
import '../views/home/home_page.dart';
import '../views/login/forget_password.dart';
import '../views/login/forgotpass_verification.dart';
import '../views/login/login_screen.dart';
import '../views/login/login_verification.dart';
import '../views/login/reset_password.dart';
import '../views/login/splash_screen.dart';
import '../LeaveModuleUserInterface/ApplyforLeave.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    print("routeSettings ${routeSettings.name} ${routeSettings.arguments}");

    switch (routeSettings.name) {

      //Leave Module Screen Here
      case FormScreen.routeName:
        return FormScreen.route();
      case Myleavestatus.routeName: //Added on 5/12/2022
        return Myleavestatus.route();
      case LeaveAuthorization.routeName: //Added on 5/12/2022
        return LeaveAuthorization.route();
      case LeaveDashboard.routeName:
        return LeaveDashboard.route();

      //Leave Module Screen End Here

      case HomeScreen.routeName:
        return HomeScreen.route();
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case SplashScreen.routeName:
        return SplashScreen.route();
      case LoginVerification.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) =>
                    LoginVerification(routeSettings.arguments as LoginUser));
          else
            break;
        }

      case LandingScreen.routeName:
        {
          return MaterialPageRoute(
              builder: (_) => LandingScreen(
                    title: '',
                  ));
        }

      case FieldVisitMain.routeName:
        {
          return MaterialPageRoute(builder: (_) => FieldVisitMain());
        }

      case Apply.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) => Apply(routeSettings.arguments as ApplyRequest));
          else
            return MaterialPageRoute(builder: (_) => Apply());
        }

      case ApplyList.routeName:
        return ApplyList.route();

      case ApprovalList.routeName:
        return ApprovalList.route();

      case ApprovalDetails.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) => ApprovalDetails(
                    routeSettings.arguments as ApprovalRequestInfo));
          else
            break;
        }

      case RequestList.routeName:
        return RequestList.route();

      case RequestDetails.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) => RequestDetails(routeSettings.arguments as int));
          else
            break;
        }
      case BillSubmit.routeName:
        {
          {
            if (routeSettings.arguments != null)
              return MaterialPageRoute(
                  builder: (_) => BillSubmit(routeSettings.arguments as int));
            else
              break;
          }
        }

      case CreateRole.routeName:
        return CreateRole.route();

      case CreateUser.routeName:
        return CreateUser.route();

      case BillReqList.routeName:
        return BillReqList.route();

      case ForgotPassVerification.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) => ForgotPassVerification(
                    routeSettings.arguments as GenerateOTP));
          else
            break;
        }

      case ResetPassword.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) =>
                    ResetPassword(routeSettings.arguments as String));
          else
            //return ResetPassword.route();
            break;
        }

      case PlanSubmit.routeName:
        return PlanSubmit.route();

      case PlanApprovalList.routeName:
        return PlanApprovalList.route();

      case MyPlanList.routeName:
        return MyPlanList.route();

      case MyPlanDetail.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) => MyPlanDetail(routeSettings.arguments as int));
          else
            break;
        }

      case PlanApprovalDetails.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) => PlanApprovalDetails(
                    routeSettings.arguments as ApprovalRequestInfo));
          else
            break;
        }

      case '/forgetPasswordNew':
        {
          print('In Switch case');
          return ForgetPassword.routensj();

          // return MaterialPageRoute(builder: (_)=> ForgetPassword());
          break;
        }

      default:
        return SplashScreen.route();
    }
  }
}
