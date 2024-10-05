import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tls/core/api.dart';
import 'package:tls/core/errors/failures.dart';
import 'package:tls/features/models/notification_model.dart';
import 'package:tls/features/providers/notifications_provider.dart';
import 'package:tls/features/providers/user_provider.dart';

class NotificationControllers {

  static Map<String, String> requestHeaders = {
    'Content-type': 'application/json'
  };

  Future<Either<Failure, bool>> getNotifications(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var notificationProvider = Provider.of<NotificationProvider>(context, listen: false);

    Uri url = Uri.parse("$host$notificationsRoute");
    requestHeaders['userID'] = userProvider.getUser()!.id;
    var response = await http.get(url, headers: requestHeaders);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<NotificationModel> notifications = body['data']
          .map<NotificationModel>((json) => NotificationModel.fromJson(json))
          .toList();
      notificationProvider.loadNotifications(notifications);
      return const Right(true);
    } else {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, bool>> markNotificationAsRead(
      BuildContext context, String notificationId) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    Uri url = Uri.parse("$host$readNotificationRoute/$notificationId");
    requestHeaders['userID'] = userProvider.getUser()!.id;

    var response = await http.put(url, headers: requestHeaders);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      // Optionally, you can also update the notificationProvider here if needed
      var notificationProvider =
      Provider.of<NotificationProvider>(context, listen: false);

      notificationProvider.markAsRead(notificationId);

      return const Right(true);
    } else {
      return Left(ServerFailure());
    }
  }
}
