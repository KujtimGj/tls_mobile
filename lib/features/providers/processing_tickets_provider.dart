import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tls/features/models/ticket_model.dart';
import 'package:tls/features/models/user_model.dart';

class ProcessingTicketsProvider extends ChangeNotifier{
  List<TicketModel> _processingTickets = [];
  List<TicketModel> _processingTicketsFilter = [];

  List<TicketModel> getProcessingTickets() => _processingTickets;

  addTicket(TicketModel ticketModel) async {
    for (var t in _processingTicketsFilter) {
      if(ticketModel.id == t.id){
        return;
      }
    }
    _processingTickets.add(ticketModel);
    _processingTicketsFilter.add(ticketModel);
    notifyListeners();
  }

  addTickets(List<TicketModel> tickets){

    _processingTickets = tickets;
    _processingTicketsFilter = tickets;
    notifyListeners();
  }

  clearList(){
    _processingTickets = [];
    _processingTicketsFilter = [];
    notifyListeners();
  }
}
