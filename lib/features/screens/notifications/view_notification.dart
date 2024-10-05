import 'package:flutter/material.dart';
import 'package:tls/features/controllers/notification_controllers.dart';
import 'package:tls/features/models/notification_model.dart';

class ViewNotification extends StatefulWidget {
  final NotificationModel? notificationModel;
  const ViewNotification({super.key, required this.notificationModel});

  @override
  State<ViewNotification> createState() => _ViewNotificationState();
}

class _ViewNotificationState extends State<ViewNotification> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      NotificationControllers notificationControllers = NotificationControllers();
      notificationControllers.markNotificationAsRead(context,widget.notificationModel!.id);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.notificationModel!.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Text("${widget.notificationModel!.body}",style: TextStyle(fontSize: 20),),
      ),
    );
  }
}
