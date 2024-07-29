import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tls/core/api.dart';
import 'package:tls/core/dimensions.dart';
import 'package:tls/features/controllers/images_controllers.dart';
import 'package:tls/features/models/storage_model.dart';

class TicketImages extends StatefulWidget {
  final bool before;
  final StorageModel? storageModel;
  const TicketImages({super.key, required this.storageModel, required this.before});

  @override
  State<TicketImages> createState() => _TicketImagesState();
}

class _TicketImagesState extends State<TicketImages> {


  // getImages() async {
  //   ImagesControllers imagesControllers = ImagesControllers();
  //   var res =
  //       await imagesControllers.getTicketImages(context, widget.storageId!);
  //   res.fold((failure) {}, (storage) {
  //     _storageModel = storage;
  //     print(storage.toJson());
  //     setState(() {});
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                size: 25,
              )),
          title: const Text("Images"),
        ),
        body: Container(
          color: Colors.white,
          child: widget.storageModel == null
              ? const SizedBox()
              : GridView.builder(
                  itemCount: widget.before == true ? widget.storageModel?.getFilesBeforeLength():widget.storageModel?.getFilesAfterLength(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    String image;
                    if(widget.before == true){
                      image = widget.storageModel!.filesBefore![index];
                    }
                    else{
                      image = widget.storageModel!.filesAfter![index];
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => FullScreenImage(image: image)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: CachedNetworkImage(
                            width: 100,
                            height: 100,
                            imageUrl: "$uploads$image",
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, name, progress) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black,
                              ));
                            },
                            errorWidget: (context, a, b) {
                              return Icon(
                                Icons.image_not_supported,
                                size: 60,
                                color: Colors.grey[300],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),
        ));
  }
}

class FullScreenImage extends StatefulWidget {
  final String? image;
  const FullScreenImage({super.key, required this.image});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 25,
            )),
        title: const Text("Image"),
      ),
      body: Container(
        width: getPhoneWitdth(context),
        height: getPhoneHeight(context),
        child: Image.network("$uploads${widget.image!}"),
      ),
    );
  }
}
