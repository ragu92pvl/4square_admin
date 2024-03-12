

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverLiveTracking extends StatefulWidget {


  const DriverLiveTracking();

  @override
  State<DriverLiveTracking> createState() => _DriverLiveTrackingState();
}

class _DriverLiveTrackingState extends State<DriverLiveTracking> {

  GoogleMapController mapController;
  final LatLng _center = const LatLng(37.7749, -122.4194); // Initial map center
  final Set<Marker> _markers = {}; // Set to hold markers

  // Function to handle map creation
  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)), // Adjust size as per your marker icon size
      'assets/img/bike.png',
    );
      // Add marker when map is created
      FirebaseFirestore.instance.collection("driverLiveTracking").get().then(
              (value) {
            value.docs.forEach(
                    (element) {
                      setState(()  {

                        print(element.data());
                        var dataList = element.data();
                        if(dataList['latitude']!=null && dataList['longitude']!=null) {
                          double latitude = dataList['latitude'];
                          double longitude = dataList['longitude'];
                          String name = dataList['name'];
                          String mobile = dataList['mobile'];
                          String id = dataList['id'];
                          _markers.add(
                            Marker(
                              icon: customIcon,
                              markerId: MarkerId('Marker'),
                              position: LatLng(latitude, longitude),
                              infoWindow: InfoWindow(
                                title: 'Driver Id: '+id,
                                snippet: 'Driver Name: '+name+" / Mobile: "+mobile,
                              ),
                            ),
                          );
                        }
                      });
                },
              );
         },
      );

  }

  @override
  void initState() {
    super.initState();

  }

  // Future<void> _onMapCreated(GoogleMapController controller) async {
  //   mapController = controller;
  //   setState(() {
  //     FirebaseFirestore.instance.collection("driverLiveTracking").get().then(
  //           (value) {
  //         value.docs.forEach(
  //               (element) {
  //             print(element.data());
  //             // var dataList = element.data();
  //             // if(dataList['latitude']!=null && dataList['longitude']!=null) {
  //             //   print(dataList['longitude']);
  //             //   double latitude = dataList['latitude'];
  //             //   double longitude = dataList['longitude'];
  //             //   _markers.add(
  //             //     Marker(
  //             //       markerId: MarkerId('Marker'),
  //             //       position: LatLng(37.7749, -122.4194),
  //             //       infoWindow: InfoWindow(
  //             //         title: 'San Francisco',
  //             //         snippet: 'Welcome to San Francisco!',
  //             //       ),
  //             //     ),
  //             //   );
  //             // }
  //           },
  //         );
  //       },
  //     );
  //   });

  //   // CollectionReference _collectionRef =
  //   // FirebaseFirestore.instance.collection('driverLiveTracking');
  //   // QuerySnapshot snapshot = await _collectionRef.get();
  //   //
  //   // setState(() {
  //   //   // Add marker when map is created
  //   //   _markers.clear(); // Clear existing markers
  //   //   snapshot.docs.forEach((doc) {
  //   //     print(doc['latitude']);
  //   //     print(doc['longitude']);
  //   //     double latitude = doc['latitude'];
  //   //     double longitude = doc['longitude'];
  //   //     _markers.add(
  //   //       Marker(
  //   //         markerId: MarkerId('Marker'),
  //   //         position: _center,
  //   //         infoWindow: InfoWindow(
  //   //           title: 'San Francisco',
  //   //           snippet: 'Welcome to San Francisco!',
  //   //         ),
  //   //       ),
  //   //     );
  //   //   });
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Tracking'),
      ),
      body:  GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(11.1271,78.6569),
          zoom: 8.0,
        ),
        markers: _markers,
      )
    );
  }
}
