import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tls/features/models/ticket_model.dart';
import 'package:tls/features/models/user_model.dart';

class TicketProvider extends ChangeNotifier{
  List<TicketModel> _pendingTickets = [];
  List<TicketModel> _pendingTicketsFilter = [];

  List<TicketModel> getPendingTickets() => _pendingTickets;

  addTicket(TicketModel ticketModel) async {
    _pendingTickets.add(ticketModel);
    _pendingTicketsFilter.add(ticketModel);
    notifyListeners();
  }

  addTickets(List<TicketModel> tickets){

    _pendingTickets = tickets;
    _pendingTicketsFilter = tickets;
    notifyListeners();
  }

  clearList(){
    _pendingTickets = [];
    _pendingTicketsFilter = [];
    notifyListeners();
  }
}
