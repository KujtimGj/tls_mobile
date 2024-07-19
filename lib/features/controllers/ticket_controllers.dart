import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tls/core/api.dart';
import 'package:tls/core/errors/failures.dart';
import 'package:tls/features/models/ticket_model.dart';
import 'package:tls/features/providers/ticket_provider.dart';
import 'package:tls/features/providers/user_provider.dart';

class TicketControllers {
  static Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Either<Failure, List<TicketModel>>> getPendingTickets(
      BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var ticketProvider = Provider.of<TicketProvider>(context, listen: false);
    Uri url = Uri.parse("$host$pendingTicketsRoute");
    requestHeaders['userID'] = userProvider.getUser()!.id;

      var response = await http.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);


          List<TicketModel> tickets = body['tickets']
              .map<TicketModel>((json) => TicketModel.fromJson(json))
              .toList();

          ticketProvider.addTickets(tickets);
          return Right(tickets);

      } else {
        return Left(ServerFailure());
      }

  }
}
