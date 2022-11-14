import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../localization/Language/languages.dart';
import '../../../repository/bloc/plan_detail_cubit/plan_detail_cubit.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import '../../../utilities/common_methods.dart';
import 'my_plan_list.dart';

class MyPlanDetail extends StatefulWidget {
  static const routeName = '/myPlanDetail';

  //const BillSubmit({Key? key}) : super(key: key);
  //static route() => MaterialPageRoute(builder: (_) => MyPlanDetail());

  late final int arguments;

  MyPlanDetail(this.arguments, {Key? key}) : super(key: key);

  @override
  _MyPlanDetailState createState() => _MyPlanDetailState();
}

class _MyPlanDetailState extends State<MyPlanDetail> {
  var selectedLang;
  late PlanDetailCubit bloc;

  @override
  void initState() {
    // super.initState();
    CommonMethods.getSelectedLang().then(
        (value) => {selectedLang = value, print('Selecetdlang $selectedLang')});
    bloc = context.read<PlanDetailCubit>();
    bloc.getPlanDetails(widget.arguments);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //analytics.setCurrentScreen('Approval Details', 'Stateful widget');
  }

  Future refresh() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        //bloc = context.read<RequestDetailsCubit>();
        //bloc.getRequestDetails(widget.arguments);
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // animationController.dispose() instead of your controller.dispose
  }

  @override
  Widget build(BuildContext context) {
    print('Plan Id ${widget.arguments}');

    bloc = context.read<PlanDetailCubit>();
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorResources.APP_THEME_COLOR,
            title: Center(
              child: Text(
                Languages.of(context)!.planDetails,
                style: Styles.appBarTextStyle,
              ),
            ),
          ),
          body: BlocConsumer<PlanDetailCubit, PlanDetailState>(
            listener: (context, state) {
              if (state is PlanDetailErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(Languages.of(context)!.internetErrorText),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is PlanDetailInitialState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PlanDetailLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PlanDetailLoadedState) {
                var list = state.planDetail.data;
                return list.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: refresh,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      var item = list[index];
                                      String formattedStartDate =
                                          DateTime.parse(item.tourDate)
                                              .format(DateTimeFormats.american);

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          left: 25,
                                          right: 25,
                                          top: 25,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorResources.WHITE,
                                            border: Border.all(
                                                color: ColorResources
                                                    .LIST_BORDER_WHITE,
                                                width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                              10,
                                            )),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '$formattedStartDate',
                                                        style: Styles
                                                            .listHeaderTextStyle,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text('Status: ',
                                                              style: GoogleFonts.inter(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  color: ColorResources
                                                                      .GREY_SIXTY)),
                                                          CommonMethods
                                                              .getStatus(item
                                                                  .activityName),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              item.activityName == 'Pending'
                                                  ? Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(18.0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  ColorResources
                                                                      .WHITE,
                                                              border: Border.all(
                                                                  color: ColorResources
                                                                      .LIST_BORDER_WHITE,
                                                                  width: 1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                10,
                                                              )),
                                                            ),
                                                            width:
                                                                double.infinity,
                                                            height: 40,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                elevation: 0,
                                                                primary:
                                                                    ColorResources
                                                                        .CANCEL_BUTTON_COLOR,
                                                                // minimumSize: const Size.fromHeight(50), // NEW
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                showLoaderDialog(
                                                                    context);

                                                                try {
                                                                  final result =
                                                                      await InternetAddress
                                                                          .lookup(
                                                                              'google.com');
                                                                  if (result
                                                                          .isNotEmpty &&
                                                                      result[0]
                                                                          .rawAddress
                                                                          .isNotEmpty) {
                                                                    bloc
                                                                        .cancelPlanRequestIndividual(item
                                                                            .planDetailsID)
                                                                        .then((value) =>
                                                                            {
                                                                              if (selectedLang.toString().isEmpty)
                                                                                {
                                                                                  Navigator.pop(context),
                                                                                  CommonMethods.showMessage(context, value!.messageEn, Colors.green),
                                                                                  initState()
                                                                                }
                                                                              else
                                                                                {
                                                                                  Navigator.pop(context),
                                                                                  CommonMethods.showMessage(context, selectedLang == 'en' ? value!.messageEn : value!.messageBn, Colors.green),
                                                                                  initState()
                                                                                }
                                                                            });

                                                                    //print('connected');
                                                                  }
                                                                } on SocketException catch (_) {
                                                                  print(
                                                                      'not connected');
                                                                  Navigator.pop(
                                                                      context);
                                                                  CommonMethods.showMessage(
                                                                      context,
                                                                      Languages.of(
                                                                              context)!
                                                                          .internetErrorText,
                                                                      Colors
                                                                          .red);
                                                                }
                                                              },
                                                              child: Text(
                                                                '${Languages.of(context)!.cancel}',
                                                                style: Styles
                                                                    .cancelButtonTextStyle,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox()
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(Languages.of(context)!.noDataFound),
                      );
              } else {
                // (state is WeatherError)
                return Center(
                  child: Container(
                    child: Text('Network Error'),
                  ),
                );
              }
            },
          )),
    );
  }

  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Connecting...")),
        ],
      ),
    );

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> _willPopCallback() async {
    Navigator.pushNamed(context, MyPlanList.routeName);
    return true;
  }
}
