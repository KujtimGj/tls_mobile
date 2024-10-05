import 'package:flutter/material.dart';
import 'package:tls/features/models/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> _notifications = [];
  List<NotificationModel> _notificationsFilter = [];

  // Getter to retrieve the notifications
  List<NotificationModel> get notifications => _notifications;
  List<NotificationModel> get notificationsFilter => _notificationsFilter;

  // Method to add a new notification
  void addNotification(NotificationModel notification) {
    _notifications.add(notification);
    _notificationsFilter.add(notification);
    notifyListeners(); // Notify listeners to rebuild UI
  }

  // Method to mark a notification as read
  void markAsRead(String id) {
    final index = _notifications.indexWhere((notif) => notif.id == id);
    if (index != -1) {
      _notifications[index] = NotificationModel(
        id: _notifications[index].id,
        userId: _notifications[index].userId,
        title: _notifications[index].title,
        body: _notifications[index].body,
        read: true,
        createdAt: _notifications[index].createdAt,
        updatedAt: DateTime.now(),
      );
      notificationsFilter[index] = _notifications[index];
      notifyListeners();
    }
  }

  // Method to remove a notification
  void removeNotification(String id) {
    _notifications.removeWhere((notif) => notif.id == id);
    _notificationsFilter.removeWhere((notif) => notif.id == id);
    notifyListeners();
  }

  // Method to load notifications from a data source (e.g., API or local storage)
  void loadNotifications(List<NotificationModel> notifications) {
    _notifications = notifications;
    _notificationsFilter = notifications;
    notifyListeners();
  }

  getUnreadNotifications(){
    int count = 0;
    notificationsFilter.forEach((n){
      if(n.read != true){
        count++;
      }
    });
    return count;
  }

  filter(String text) {
    _notifications = [];

    for (int i = 0; i < _notificationsFilter.length; i++) {
      if (notificationsFilter[i].title.toLowerCase().contains(text) ||
          notificationsFilter[i].body.toLowerCase().contains(text)) {
        _notifications.add(notificationsFilter[i]);
      }
    }
    notifyListeners();
  }
}
