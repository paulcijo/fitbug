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

class EditWorkoutWidget extends StatefulWidget {
  const EditWorkoutWidget({
    Key key,
    this.workout,
  }) : super(key: key);

  final DocumentReference workout;

  @override
  _EditWorkoutWidgetState createState() => _EditWorkoutWidgetState();
}

class _EditWorkoutWidgetState extends State<EditWorkoutWidget> {
  DateTime datePicked;
  TextEditingController textController1;
  TextEditingController textController2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).background,
      ),
      child: StreamBuilder<WorkoutsRecord>(
        stream: WorkoutsRecord.getDocument(widget.workout),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: SpinKitPumpingHeart(
                  color: FlutterFlowTheme.of(context).primaryColor,
                  size: 40,
                ),
              ),
            );
          }
          final columnWorkoutsRecord = snapshot.data;
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: TextFormField(
                  controller: textController1 ??= TextEditingController(
                    text: columnWorkoutsRecord.name,
                  ),
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
                  controller: textController2 ??= TextEditingController(
                    text: columnWorkoutsRecord.repGoal.toString(),
                  ),
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
                      currentTime: columnWorkoutsRecord.dueDate,
                      minTime: columnWorkoutsRecord.dueDate,
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
                    final workoutsUpdateData = createWorkoutsRecordData(
                      name: textController1?.text ?? '',
                      repGoal: int.parse(textController2?.text ?? ''),
                      dueDate: datePicked,
                    );
                    await columnWorkoutsRecord.reference
                        .update(workoutsUpdateData);
                    Navigator.pop(context);
                  },
                  text: 'Update',
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
          );
        },
      ),
    );
  }
}
