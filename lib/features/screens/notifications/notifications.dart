import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tls/features/controllers/notification_controllers.dart';
import 'package:tls/features/models/notification_model.dart';
import 'package:tls/features/providers/notifications_provider.dart';
import 'package:tls/features/screens/notifications/view_notification.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  getNotifications() {
    NotificationControllers notificationControllers = NotificationControllers();
    notificationControllers.getNotifications(context);
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var notificationProvider = Provider.of<NotificationProvider>(context);
    print(notificationProvider.notificationsFilter.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async{
            getNotifications();
          },
          child: ListView(
            children: [
              TextFormField(
                onChanged: (value){
                  notificationProvider.filter(value);
                },
                decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search,size: 30,color: Colors.grey[500],),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(35)
                    ),
                    filled: true,
                    fillColor: const Color(0xfff5f5f5)
                ),
              ),
              const SizedBox(height: 30),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index){
                  NotificationModel notification = notificationProvider.notifications[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ViewNotification(notificationModel: notification)));
                  },
                  child: Container(
                    color: notification.read == true ? Colors.transparent:Colors.grey[300],
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration:const BoxDecoration(
                              color: Color(0xffeaeaea),
                              shape: BoxShape.circle
                          ),
                          child: const Center(
                            child: Icon(Icons.notification_important_outlined,color: Colors.black,size: 30,),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(notification.body,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                              Text(DateFormat('EEEE MMM yyyy').format(notification.updatedAt),style: const TextStyle(color: Color(0xff909090)),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },itemCount: notificationProvider.notifications.length,)

            ],
          ),
        ),
      ),
    );
  }
}
