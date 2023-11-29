import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/provider/providerClass.dart';

class createTrips extends StatefulWidget {
  const createTrips({super.key});

  @override
  State<createTrips> createState() => _createTripsState();
}

class _createTripsState extends State<createTrips> {
  final _formKey = GlobalKey<FormState>();
  int activeIndex = 0;
  final controller = CarouselController();
  File? imagePath;
  final urlImages = [
    'assets/images/planTrip.jpg',
    'assets/images/planTrip1.jpg',
    'assets/images/planTrip2.jpg',
    'assets/images/planTrip3.jpg',
    'assets/images/planTrip4.jpg',
  ];
  TextEditingController placeName = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController items = TextEditingController();
  TextEditingController members = TextEditingController();
      DateTime _date = DateTime.now();
    void _datepicker(context)async{
    final selectedDate = await showDatePicker(
      context: context,
     firstDate: DateTime(2000),
      lastDate:DateTime(2050), 
      initialDate: DateTime.now(),
      );
      if(selectedDate != null){
        setState(() {
          _date = selectedDate;
        });
      }
  }
  String formatDate(DateTime dateTime) {
  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(dateTime);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 35, 35, 35),
        title: Text(
          'MAKE YOUR TRIP WITH US',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      body: Padding(
        padding: EdgeInsets.only(
          top: 40,
          left: 15,
          right: 15,
        ),
        child: SingleChildScrollView(
          child: Container(
            height: 800,
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 250,
                    width: double.infinity,
                    child: CarouselSlider.builder(
                      carouselController: controller,
                      itemCount: urlImages.length,
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = urlImages[index];
                        return buildImage(urlImage, index);
                      },
                      options: CarouselOptions(
                        height: 250,
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(seconds: 2),
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: CustomTextFeild('Enter your destination', 'Destination', placeName, TextInputType.text)
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: CustomTextFeild('Enter your budget amount', 'Amount', amount, TextInputType.number)
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: CustomTextFeild('Enter your items', 'Neccessary items for your trip', items, TextInputType.text)
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: CustomTextFeild('Enter your number of members', 'Members', members, TextInputType.number)
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            TextButton(
                            onPressed: (){
                              _datepicker(context);
                            },
                             child: Text('Date'),
                             ),
                             Text(formatDate(_date),
                             style: TextStyle(color: Colors.white),),
                          ],
                        )
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white,)
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){
                          pickImage(ImageSource.camera);
                        }, child: Text(
                          'Camera',
                        )),
                        Text(
                          '|',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        TextButton(onPressed: (){
                          pickImage(ImageSource.gallery);
                        }, child: Text(
                          'Gallery',
                        )),
                      ],
                    ),
                  ),
                  Text(
                    'Upload your destination image',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'kanit',
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        final username = userProvider.username;
                        if (username != null) {
                           final tripInfo = UserPlannedTrips(
                            plannedPlace: placeName.text,
                            plannedDate: formatDate(_date),
                            plannedImages: imagePath!.path,
                            plannedMembers: members.text,
                            plannedAmount: amount.text,
                            plannedThings: items.text,
                          );
                          final userBox = await Hive.openBox<User>('users');
                          final currentUser = userBox.get(username.username);
                          if(currentUser != null){
                            if(currentUser.plannedTrips!.any((p) => p.plannedPlace == tripInfo.plannedPlace)){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(
                                  'Trip is already exist, Please check'
                                ),
                                ),
                              );
                            }else{
                              Provider.of<TripStateNotifier>(context, listen: false).setShouldRefresh(true);
                              currentUser.plannedTrips!.add(tripInfo);
                              userBox.put(username.username, currentUser);
                              getPlannedTrip();
                              Fluttertoast.showToast(
                                msg: 'Trip added to list',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              );
                              placeName.clear();
                              amount.clear();
                              members.clear();
                              items.clear();
                            }
                          }
                        }
                      }
                    },
                    label: Text('Create Trip'),
                    icon: Icon(Icons.check),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField CustomTextFeild(String retMsg, String labelTxt, TextEditingController controller, TextInputType type) {
    return TextFormField(
      keyboardType:type ,
      style: TextStyle(
        color: Colors.white,
      ),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return retMsg;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelTxt,
        labelStyle: TextStyle(color: Colors.blue[50]),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        )
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
  onDotClicked: animateToSlide,
  effect: ExpandingDotsEffect(
  dotWidth: 5, dotHeight: 5, activeDotColor: Colors.blue),
  activeIndex: activeIndex,
  count: urlImages.length,
  );

  void animateToSlide(int index) => controller.animateToPage(index);

  Widget buildImage(String urlImage, int index) => Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        urlImage,
        fit: BoxFit.cover,
      ),
    ),
  );

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() => this.imagePath = imagePermanent);
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

    Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

}
