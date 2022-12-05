import '../LeaveModuleUserInterface/leavePredictionView.dart';
import '../LeaveModuleUserInterface/ReportsView.dart';
import '../LeaveModuleUserInterface/leaveHistory.dart';
import '../LeaveModuleUserInterface/ApplyforLeave.dart';
import '../LeaveModuleUserInterface/Myleavestatus.dart';
import '../LeaveModuleUserInterface/LeaveAuthorization.dart';
import '../LeaveModuleUserInterface/LeaveDashboard.dart';
import '../LeaveModuleUserInterface/Myleavestatus.dart';
import '../Pages/list_data.dart';
import '../Pages/list_country.dart';

// ignore: camel_case_types
class routes {
  static const String applyleave = FormScreen.routeName;
  static const String leavestatus = Myleavestatus.routeName;
  static const String leaveauthorization = LeaveAuthorization.routeName;
  static const String leaveDashboard = LeaveDashboard.routeName;

  static const String transaction = TransactionView.routeName;
  static const String categories = CategoriesView.routeName;
  static const String reports = ReportsView.routeName;
  static const String movies = PopularMovieListPages.routeName;
  static const String countries = PopularCountryListPages.routeName;
}
