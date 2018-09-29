import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:ultrasound_solutions/models/colors.dart';
import 'dart:async';

class EstimateFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new EstimateFormScreenState();
  }
}

class EstimateFormScreenState extends State<EstimateFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final listCount = 1;

  final TextEditingController _companyNameTC = new TextEditingController();
  final TextEditingController _addressTC = new TextEditingController();
  final TextEditingController _contactNameTC = new TextEditingController();
  final TextEditingController _contactNumberTC = new TextEditingController();
  final TextEditingController _serviceNotesTC = new TextEditingController();
  final TextEditingController _machineModelTC = new TextEditingController();
  final TextEditingController _machineMakeTC = new TextEditingController();
  final TextEditingController _machineSerialNumber = new TextEditingController();

  final emailTitle = "New Estimate Request";

  final submitEmail = "info@uscultrasound.com";

  final submitTitle = 'Submit Estimate';
  final submitContent =
      "This will submit your estimate to USC for review. Once submitted a representative will contact you shortly. Are you sure?";
  final submitTrue = "Submit";
  final submitFalse = "Cancel";

  File _serviceImage;
  bool _progressBarActive = false;
  var fileName = "";
  var serviceTimeFrame = "Select Time";
  var serviceDate = "Select Date";
  var setServiceDate = "Select Estimate Date";

  //final serviceEmail = "service@uscultrasound.com";
  //final submitEmail = "info@uscultrasound.com";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Request Estimate"),
      ),
      body: new Center(
        child: _buildServiceForm(),
      ),
    );
  }

  Widget _buildServiceForm() {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: new Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildProgressIndicator(),
                _buildTextFormTitleField("Company Name: "),
                _buildTextFormField(_companyNameTC),
                _buildTextFormTitleField("Address: "),
                _buildTextFormField(_addressTC),
                _buildTextFormTitleField("Machine Make"),
                _buildTextFormField(_machineMakeTC),
                _buildTextFormTitleField("Machine Model"),
                _buildTextFormField(_machineModelTC),
                _buildTextFormTitleField("Machine Serial Number"),
                _buildTextFormField(_machineSerialNumber),
                _buildTextFormTitleField("Contact Name: "),
                _buildTextFormField(_contactNameTC),
                _buildTextFormTitleField("Contact Phone Number: "),
                _buildTextFormField(_contactNumberTC),
                _buildTextFormTitleField("Describe Estimate Requirements:  "),
                _buildTextFormField(_serviceNotesTC),
                _buildFileText(),
                _buildPhotoButton(),
                _buildDatePicker(),
                _buildSubmitButton(),
              ],
            ),
          )),
    );
  }

  Widget _buildTextFormField(TextEditingController textController) {
    return new Container(
      color: kUltraSoundFormTextFieldGrey,
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textController,
        style: TextStyle(color: kUltraSoundPrimaryText),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        },
      ),
    );
  }

  Widget _buildPhotoButton() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Center(
        child: RaisedButton(
          onPressed: () {
            _buildImageChoiceDialog("Choose a method to upload an image.", "Upload Image");
          },
          child: Text(
            "Add Photos",
            style: TextStyle(color: kUltraSoundSurfaceWhite),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return !_progressBarActive ? new Container() : const Center(child: CircularProgressIndicator());
  }

  void toggleProgressIndicator(){
    setState(() {
      _progressBarActive = !_progressBarActive;
    });
  }

  Widget _buildFileText(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0.0),
      child: new Text(
          fileName,
          style: new TextStyle(fontSize: 12.0, color: Colors.grey)),
    );
  }

  Widget _buildSubmitButton() {
    return new Container(
      padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
      child: new Center(
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              //if the form is valid do something
              toggleProgressIndicator();
              _postEstimateRequest(
                  submitEmail,
                  emailTitle,
                  "Company Name: " +
                      _companyNameTC.text +
                      "\n\n" +
                      "Address: " +
                      _addressTC.text +
                      "\n\n" +
                      "Machine Make: " +
                      _machineMakeTC.text +
                      "\n\n" +
                      "Machine Model: " +
                      _machineModelTC.text +
                      "\n\n" +
                      "Machine Serial Number: " +
                      _machineSerialNumber.text +
                      "\n\n" +
                      "Contact Name: " +
                      " " +
                      _contactNameTC.text +
                      "\n\n" +
                      "Contact Number: " +
                      _contactNumberTC.text +
                      "\n\n" +
                      "Date and Time: " +
                      serviceDate + " " + serviceTimeFrame +
                      "\n\n" +
                      "Estimate Notes: " +
                      _serviceNotesTC.text +
                      "\n\n\n\n" +
                      "*this estimate was submitted using the mobile app",
                  _serviceImage, "uscappdevelopment@gmail.com");
            }
          },
          child: Text(
            "Submit",
            style: TextStyle(
              color: kUltraSoundSurfaceWhite,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormTitleField(String title) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: Text(title,
          style: TextStyle(fontSize: 16.0, color: kUltraSoundPrimaryText)),
    );
  }

  Widget _buildDatePicker() {
    return new Container(
      padding: new EdgeInsets.all(8.0),
      child: new Center(
        child: new RaisedButton(
            onPressed: () {
              _showDateSelectDialog();
            },
            child: new Text(setServiceDate,
                style: new TextStyle(fontSize: 14.0, color: Colors.white))),
      ),
    );
  }

  Future<Null> _showDateSelectDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text("Service Date"),
          children: <Widget>[
            new FlatButton(onPressed: () {
              _showDateDialog();
            }, child: new Text(serviceDate)),
            new FlatButton(onPressed: () {
              _showTimeDialog();
            }, child: new Text(serviceTimeFrame)),
            new FlatButton(onPressed: () {
              setState(() {
                setServiceDate = serviceDate + " " + serviceTimeFrame;
              });
              Navigator.pop(context);
            }, child: new Text("Ok", style: new TextStyle(fontSize: 14.0, color: kUltraSoundOrange600),))
          ],
        );
      },
    );
  }

  Future<Null> _showTimeDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: new Text("Pick Time Frame"),
          children: <Widget>[
            new FlatButton(onPressed: () {
              setTimeFrameState("8:30am - 12:30pm");
              Navigator.pop(context);
            }, child: new Text("8:30am - 12:30pm", style: new TextStyle(fontSize: 14.0, color: Colors.black))),
            new FlatButton(onPressed: () {
              setTimeFrameState("1:00pm - 5:00pm");
              Navigator.pop(context);
            }, child: new Text("1:00pm - 5:00pm", style: new TextStyle(fontSize: 14.0, color: Colors.black))),
          ],
        );
      },
    );
  }

  void setTimeFrameState(String timeFrame){
    setState(() {
      serviceTimeFrame = timeFrame;
    });
  }

  void setDateState(String date){
    setState(() {
      serviceDate = date;
    });
  }

  Future<Null> _showDateDialog() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().subtract(new Duration(days: 30)),
      lastDate: new DateTime.now().add(new Duration(days: 30)),
    );
    setDateState(picked.month.toString() + " / " + picked.day.toString() + " / " + picked.year.toString());
  }

//  void _postEstimateRequest(String toMailId, String subject, String body) {
//    var url = 'mailto:$toMailId?subject=$subject&body=$body';
//    launch(url);
//  }

  void _postEstimateRequest(String toMailId, String subject, String body, File attachment, String senderMailId) {
    var options = new GmailSmtpOptions()
      ..username = 'uscappdev@gmail.com'
      ..password = 'Test@1234';

    var emailTransport = new SmtpTransport(options);

    var envelope = new Envelope()
      ..from = senderMailId
      ..recipients.add(toMailId)
      ..subject = subject
      ..attachments.add(new Attachment(file: attachment))
      ..text = body;

    emailTransport.send(envelope)
        .then((envelope) => _buildSendDialog("Request has been submitted successfully", "Success!"))
        .catchError((e) => _buildSendDialog("Request has failed to send because of " + e, "Failed"));

    toggleProgressIndicator();
  }

  Future<Null> _buildSendDialog(String message, String title) async{
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Success!'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Null> _buildImageChoiceDialog(String message, String title) async{
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(title),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Gallery'),
              onPressed: () {
                _buildImagePicker();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('Camera'),
              onPressed: () {
                _buildCamera();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future _buildImagePicker() async {
    _serviceImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      fileName = "Attachment:: " + _serviceImage.path;
    });
  }

  Future _buildCamera() async {
    _serviceImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      fileName = "Attachment:: " + _serviceImage.path;
    });
  }

  Future<Null> _neverSatisfied() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(
            submitTitle,
            style: new TextStyle(color: kUltraSoundPrimaryText, fontSize: 18.0),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(
                  submitContent,
                  style: new TextStyle(
                    color: kUltraSoundPrimaryText,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text(
                  submitFalse,
                  style: new TextStyle(
                    color: kUltraSoundPrimaryText,
                    fontSize: 14.0,
                  ),
                )),
            new FlatButton(
                onPressed: () {
                  _postEstimateRequest(
                      submitEmail,
                      emailTitle,
                      "Company Name: " +
                          _companyNameTC.text +
                          "\n\n" +
                          "Address: " +
                          _addressTC.text +
                          "\n\n" +
                          "Machine Make: " +
                          _machineMakeTC.text +
                          "\n\n" +
                          "Machine Model: " +
                          _machineModelTC.text +
                          "\n\n" +
                          "Machine Serial Number: " +
                          _machineSerialNumber.text +
                          "\n\n" +
                          "Contact Name: " +
                          " " +
                          _contactNameTC.text +
                          "\n\n" +
                          "Contact Number: " +
                          _contactNumberTC.text +
                          "\n\n" +
                          "Estimate Notes: " +
                          _serviceNotesTC.text +
                          "\n\n\n\n" +
                          "*this estimate was submitted using the mobile app",
                  _serviceImage, "uscappdevelopment@gmail.com");
                  Navigator.of(context).pop();
                },
                child: new Text(
                  submitTrue,
                  style: new TextStyle(color: kUltraSoundOrange600),
                ))
          ],
        );
      },
    );
  }
}
