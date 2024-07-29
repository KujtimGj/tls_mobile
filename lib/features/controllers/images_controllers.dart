import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tls/core/api.dart';
import 'package:tls/core/errors/failures.dart';
import 'package:tls/features/models/storage_model.dart';
import 'package:tls/features/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class ImagesControllers {

  static Map<String, String> requestHeaders = {
    'Content-type': 'application/json'
  };

  Future<Either<Failure, StorageModel>> uploadImages(
      BuildContext context, String ticketId, List<XFile> images,String type) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    Uri url = Uri.parse("$host$uploadTicketImagesRoute/$ticketId");
    requestHeaders['userID'] = userProvider.getUser()!.id;

    var request = http.MultipartRequest('PUT', url)
      ..headers.addAll(requestHeaders);

    // Add images to the request
    for (var image in images) {
      var stream = http.ByteStream(Stream.castFrom(image.openRead()));
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'images', // Field name on the server
        stream,
        length,
        filename: image.name,
      );
      request.files.add(multipartFile);
      request.fields['type'] = type;
    }

    // Send the request and handle the response
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    StorageModel storageModel = StorageModel.fromJson(jsonDecode(responseBody)['storage']);
    print(type);
    if (response.statusCode == 200) {
      return Right(storageModel);
    } else {
      return Left(ServerFailure());
    }
  }


  Future<Either<Failure, StorageModel>> getTicketImages(
      BuildContext context,String storageId) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    Uri url = Uri.parse("$host$ticketImagesRoute/${storageId}");
    requestHeaders['userID'] = userProvider.getUser()!.id;

    var response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body)['image'];
      StorageModel ticket = StorageModel.fromJson(body);


      return Right(ticket);

    } else {
      return Left(ServerFailure());
    }
  }
}
