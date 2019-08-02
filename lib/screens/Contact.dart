import 'dart:async';
import '../app.dart';
import 'package:flutter/material.dart';
import '../models/Place.dart';
import '../widgets/drawer.dart';
import '../widgets/star.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

double current_latitude = contact_lat;
double current_longitude = contact_lng;
double current_zooom = contact_zoom;

List<Place> places = <Place>[
  Place(
    name: "ទីស្នាក់ការគណបក្សសម្ព័ន្ធដើម្បីប្រជាធិបតេយ្យ",
    shortDescription: "ការិយាល័យកណ្តាល",
    longDescription:
        "ទីស្នាក់ការគណបក្សសម្ព័ន្ធដើម្បីប្រជាធិបតេយ្យ ការិយាល័យកណ្តាល",
    latitude: 11.5714884,
    longitude: 104.8863495,
    isLocalImage: true,
    image: logo,
    star: 5,
  ),
  Place(
    name: "ទីស្នាក់ការគណបក្សសម្ព័ន្ធដើម្បីប្រជាធិបតេយ្យ",
    shortDescription: "សាខា ខេត្តសៀមរាប",
    longDescription:
        "ទីស្នាក់ការគណបក្សសម្ព័ន្ធដើម្បីប្រជាធិបតេយ្យ សាខា ខេត្តសៀមរាប",
    latitude: 13.3825006,
    longitude: 103.8543488,
    isLocalImage: true,
    image: logo,
    star: 5,
  ),
  Place(
    name: "ទីស្នាក់ការគណបក្សសម្ព័ន្ធដើម្បីប្រជាធិបតេយ្យ",
    shortDescription: "សាខា ខេត្តបាត់ដំបង",
    longDescription:
        "ទីស្នាក់ការគណបក្សសម្ព័ន្ធដើម្បីប្រជាធិបតេយ្យ សាខា ខេត្តបាត់ដំបង",
    latitude: 13.08292,
    longitude: 103.23295,
    isLocalImage: true,
    image: logo,
    star: 5,
  ),
];

CameraPosition _initialPosition = CameraPosition(
    target: LatLng(current_latitude, current_longitude), zoom: current_zooom);

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();

  List<Place> _places = [];

  @override
  void initState() {
    super.initState();
    _places = places;
  }

  Future<void> _onloadUrl(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(builder: (BuildContext context, Widget child) {
      return Padding(
          padding: EdgeInsets.only(bottom: 60),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: maincolor,
              centerTitle: true,
              titleSpacing: 0.0,
              title: Center(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Image.asset(
                      logo,
                      width: 45.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(short_appname),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.local_activity),
                  onPressed: () {
                    _onloadUrl("$contact_url");
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _onloadUrl("$contact_email");
                  },
                ),
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.call),
                  onPressed: () {
                    _onloadUrl("tel:$contact_phone");
                  },
                )
              ],
            ),
            drawer: CustomDrawer(),
            body: Stack(
              children: <Widget>[
                MapContainer(controller: _controller),
                ZoomContainer(controller: _controller),
                PlacesContainer(
                  controller: _controller,
                  places: _places,
                ),
              ],
            ),
          ));
    });
  }
}

//placebox widget
class PlaceBoxWidget extends StatefulWidget {
  final Place place;
  final Completer controller;

  const PlaceBoxWidget({Key key, this.place, this.controller})
      : super(key: key);

  @override
  _PlaceBoxWidgetState createState() => _PlaceBoxWidgetState();
}

class _PlaceBoxWidgetState extends State<PlaceBoxWidget> {
  Future<void> _movetoPlace(double lat, double lng) async {
    final GoogleMapController newcontroller =
        await this.widget.controller.future;
    CameraPosition _newPosition = CameraPosition(
        target: LatLng(lat, lng), zoom: 22, bearing: 45.0, tilt: 45.0);
    newcontroller.animateCamera(CameraUpdate.newCameraPosition(_newPosition));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, offset: Offset.zero, blurRadius: 3.0)
            ]),
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: this.widget.place.isLocalImage
                  ? Image.asset(this.widget.place.image)
                  : Image.network(this.widget.place.image),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      this.widget.place.name,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    StarsWidget(
                      star: this.widget.place.star,
                    ),
                    Text(
                      this.widget.place.shortDescription,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        current_latitude = this.widget.place.latitude;
        current_longitude = this.widget.place.longitude;

        _movetoPlace(this.widget.place.latitude, this.widget.place.longitude);
      },
    );
  }
}

//placescontainer
class PlacesContainer extends StatefulWidget {
  final List<Place> places;
  final Completer controller;

  const PlacesContainer({Key key, this.places, this.controller})
      : super(key: key);

  @override
  _PlacesContainerState createState() => _PlacesContainerState();
}

class _PlacesContainerState extends State<PlacesContainer> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.all(10.0),
        height: MediaQuery.of(context).size.height / 5,
        child: this.widget.places.length == 0
            ? Align(
                alignment: Alignment.topCenter,
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: this.widget.places.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return PlaceBoxWidget(
                    place: this.widget.places[index],
                    controller: this.widget.controller,
                  );
                },
              ),
      ),
    );
  }
}

//mapcontainer
class MapContainer extends StatefulWidget {
  final Completer controller;

  const MapContainer({Key key, this.controller}) : super(key: key);
  @override
  _MapContainerState createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
// Completer<GoogleMapController> _controller = Completer();

  List<Marker> _markers = <Marker>[];

  _loadPlacesMarker() {
    for (var place in places) {
      var p = Marker(
        markerId: MarkerId(UniqueKey().toString()),
        position: LatLng(place.latitude, place.longitude),
        infoWindow: InfoWindow(
          title: place.name.toString(),
          snippet: place.shortDescription.toString(),
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () => print(place.name),
        visible: true,
      );

      _markers.add(p);
    }
  }

  @override
  void initState() {
    _loadPlacesMarker();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    this.widget.controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      onMapCreated: _onMapCreated,
      initialCameraPosition: _initialPosition,
      markers: Set.from(_markers),

      // myLocationButtonEnabled: true,
      // myLocationEnabled: true,
      // markers: {_ldpsiemreap, _sampovmeas, _changeen, _gameshop},
    );
  }
}

//zoome container
class ZoomContainer extends StatefulWidget {
  final Completer controller;

  const ZoomContainer({Key key, this.controller}) : super(key: key);

  @override
  _ZoomContainerState createState() => _ZoomContainerState();
}

class _ZoomContainerState extends State<ZoomContainer> {
  Future<void> _onZoom() async {
    final GoogleMapController controller = await this.widget.controller.future;
    CameraPosition newPosition = CameraPosition(
        target: LatLng(current_latitude, current_longitude),
        zoom: current_zooom);
    controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(2),
            height: 45,
            width: 45,
            color: Colors.blue,
            child: IconButton(
                icon: Icon(Icons.zoom_in),
                color: Colors.white,
                onPressed: () {
                  current_zooom++;
                  _onZoom();
                }),
          ),
          Container(
            margin: EdgeInsets.all(2),
            height: 45,
            width: 45,
            color: Colors.blue,
            child: IconButton(
              icon: Icon(Icons.zoom_out),
              color: Colors.white,
              onPressed: () {
                current_zooom--;
                _onZoom();
              },
            ),
          ),
        ],
      ),
    );
  }
}
