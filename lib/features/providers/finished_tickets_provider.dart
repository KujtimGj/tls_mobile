import 'package:flutter/material.dart';
import 'package:tls/features/models/ticket_model.dart';

class FinishedTicketsProvider extends ChangeNotifier {
  List<TicketModel> _finishedTickets = [];
  List<TicketModel> _finishedTicketsFilter = [];

  // Getter for finished tickets
  List<TicketModel> getFinishedTickets() => _finishedTickets;

  // Add a single ticket
  void addTicket(TicketModel ticketModel) async {
    for (var t in _finishedTicketsFilter) {
      if (ticketModel.id == t.id) {
        return; // Ticket already exists
      }
    }
    _finishedTickets.add(ticketModel);
    _finishedTicketsFilter.add(ticketModel);
    notifyListeners();
  }

  // Add multiple tickets
  void addTickets(List<TicketModel> tickets) {
    _finishedTickets = tickets;
    _finishedTicketsFilter = tickets;
    notifyListeners();
  }

  // Remove a single ticket
  void removeTicket(TicketModel ticketModel) {
    _finishedTickets.removeWhere((t) => t.id == ticketModel.id);
    _finishedTicketsFilter.removeWhere((t) => t.id == ticketModel.id);
    notifyListeners();
  }

  // Clear the list of tickets
  void clearList() {
    _finishedTickets = [];
    _finishedTicketsFilter = [];
    notifyListeners();
  }
}
