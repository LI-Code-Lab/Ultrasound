import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ultrasound_solutions/models/colors.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';

class ServiceFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ServiceFormScreenState();
  }
}

class ServiceFormScreenState extends State<ServiceFormScreen> {
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

  final emailTitle = "New Service Request";
  final submitEmail = "service@uscultrasound.com";
  final submitTitle = 'Submit Service';
  final submitContent =
      "This will submit your service request to USC for review. Once submitted a representative will contact you shortly. Are you sure?";
  final submitTrue = "Submit";
  final submitFalse = "Cancel";

  File _serviceImage;
  bool _progressBarActive = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Request Service"),
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
                _buildTextFormTitleField("Describe Service Required: "),
                _buildTextFormField(_serviceNotesTC),
                _buildPhotoButton(),
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

  Widget _buildSubmitButton() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Center(
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              //if the form is valid do something
              _postServiceRequest(
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
                      "Service Required Description: " +
                      _serviceNotesTC.text +
                      "\n\n\n\n" +
                      "*this service request was submitted using the mobile app",
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
          style: TextStyle(fontSize: 14.0, color: kUltraSoundPrimaryText)),
    );
  }

//  void _postServiceRequest(String toMailId, String subject, String body) {
//    var url = 'mailto:$toMailId?subject=$subject&body=$body';
//    launch(url);
//  }

  void _postServiceRequest(String toMailId, String subject, String body, File attachment, String senderMailId) {
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

  void toggleProgressIndicator(){
    setState(() {
      _progressBarActive = !_progressBarActive;
    });
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
  }

  Future _buildCamera() async {
    _serviceImage = await ImagePicker.pickImage(source: ImageSource.camera);
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
                    fontSize: 14.0,
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
                  _postServiceRequest(
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
                              "Service Required Description: " +
                              _serviceNotesTC.text +
                              "\n\n\n\n" +
                              "*this service request was submitted using the mobile app",
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
