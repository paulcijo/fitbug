import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateWorkoutWidget extends StatefulWidget {
  const CreateWorkoutWidget({Key key}) : super(key: key);

  @override
  _CreateWorkoutWidgetState createState() => _CreateWorkoutWidgetState();
}

class _CreateWorkoutWidgetState extends State<CreateWorkoutWidget> {
  DateTime datePicked;
  TextEditingController textController1;
  TextEditingController textController2;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).background,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
            child: TextFormField(
              controller: textController1,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Name your workout',
                hintText: 'Pushups...',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                suffixIcon: Icon(
                  Icons.directions_run,
                  color: FlutterFlowTheme.of(context).textColor,
                  size: 22,
                ),
              ),
              style: FlutterFlowTheme.of(context).subtitle1.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).textColor,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
            child: TextFormField(
              controller: textController2,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Pick a target Goal',
                hintText: 'Number of reps you\'d like to reach one day...',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0x00000000),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                ),
                suffixIcon: Icon(
                  Icons.donut_small_rounded,
                  color: FlutterFlowTheme.of(context).textColor,
                  size: 22,
                ),
              ),
              style: FlutterFlowTheme.of(context).subtitle1.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).textColor,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
            child: FFButtonWidget(
              onPressed: () async {
                await DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (date) {
                    setState(() => datePicked = date);
                  },
                  currentTime: getCurrentTimestamp,
                  minTime: getCurrentTimestamp,
                );
              },
              text: 'Choose Date',
              icon: Icon(
                Icons.date_range,
                color: FlutterFlowTheme.of(context).textColor,
                size: 15,
              ),
              options: FFButtonOptions(
                width: double.infinity,
                height: 40,
                color: FlutterFlowTheme.of(context).background,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: FlutterFlowTheme.of(context).textColor,
                    ),
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).textColor,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: FFButtonWidget(
              onPressed: () async {
                final workoutsCreateData = createWorkoutsRecordData(
                  name: textController1.text,
                  repGoal: int.parse(textController2.text),
                  dueDate: datePicked,
                  createdBy: currentUserReference,
                );
                await WorkoutsRecord.collection.doc().set(workoutsCreateData);
                Navigator.pop(context);
              },
              text: 'Save',
              options: FFButtonOptions(
                width: double.infinity,
                height: 40,
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Lexend Deca',
                      color: FlutterFlowTheme.of(context).textColor,
                    ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
