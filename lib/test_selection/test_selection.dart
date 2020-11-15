import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdsafe_defhacks/services/auth.dart';
import 'package:pdsafe_defhacks/shared/constants.dart';
import 'package:pdsafe_defhacks/widgets/home_button.dart';


class TestSelection extends StatelessWidget {
  static String id = 'TestSelection';

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text('Parkinsons detection',),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                child:
                    Tooltip(child: Icon(Icons.exit_to_app), message: "Logout"),
                onTap: () => _auth.signOut(),
              ),
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            ExpansionTile(
              backgroundColor: Colors.white,
              leading: SvgPicture.asset(
                'assets/spiral10.svg',
                height: 40,
                color: Colors.deepPurple,
              ),
              title: Text('Spiral Tests', style: textStyle.copyWith(color: Colors.deepPurple, fontSize: 16),),
              children: [
                HomeButton(
                  text: 'Take static spiral test',
                  color: Colors.deepPurpleAccent,
                  
                ),
                HomeButton(
                    text: 'Take dynamic spiral test',
                    color: Colors.deepPurpleAccent),
              ],
            ),
            ExpansionTile(
              backgroundColor: Colors.white,
              leading: 
              SvgPicture.asset(
                'assets/wave-normal-4.svg',
                height: 35,
                color: Colors.deepPurple,
              ),
              title: Text('Wave Tests', style: textStyle.copyWith(color: Colors.deepPurple, fontSize: 16),),
              children: [
                HomeButton(
                    text: 'Take static wave test',
                    color: Colors.deepPurpleAccent),
                HomeButton(
                    text: 'Take dynamic wave test',
                    color: Colors.deepPurpleAccent),
              ],
            ),
            // ListTile(
            //   leading:Icon(Icons.camera_alt, size: 35, color: Colors.deepPurple,) ,
            //   onTap: ,
            // ),
            ExpansionTile(
              backgroundColor: Colors.white,
              leading: Icon(Icons.camera_alt, size: 35, color: Colors.deepPurple,), 
              // SvgPicture.asset(
              //   'assets/wave-normal-4.svg',
              //   height: 35,
              //   color: Colors.deepPurple,
              // ),
              title: Text('Photo Tests', style: textStyle.copyWith(color: Colors.deepPurple, fontSize: 16),),
              children: [
                HomeButton(
                    text: 'Take spiral test',
                    color: Colors.deepPurpleAccent),
                    
                HomeButton(
                    text: 'Take wave test',
                    color: Colors.deepPurpleAccent),
              ],
            ),
            
            // Align(alignment: Alignment.bottomCenter,
            // child: HomeButton(text: 'Learn how to use this app', color: Colors.deepPurple)
            // )
          ],
        )
        // body: ListView.builder(
        //   itemCount: data.length,
        //   itemBuilder: (BuildContext context, int index) => EntryItem(
        //     data[index],
        //   ),
        // ),

        );
  }
}

// class Entry {
//   final String title;
//   final List<Entry>
//       children; // Since this is an expansion list ...children can be another list of entries
//   Entry(this.title, [this.children = const <Entry>[]]);
// }

// // This is the entire multi-level list displayed by this app
// final List<Entry> data = <Entry>[
//   Entry(
//     'Spiral Test',
//     <Entry>[
//       Entry('Static Spiral Test'),
//       Entry('Dynamic Spiral Test'),
//     ],
//   ),

//   // Second Row
//   Entry('wave Test', <Entry>[
//     Entry('Static Wave Test'),
//     Entry('Dynamic Wave Test'),
//   ]),
//   Entry(
//     'Handwriting Test',
//     <Entry>[
//       Entry('Handwriting camera test'),
//     ],
//   ),
// ];

// // Create the Widget for the row
// class EntryItem extends StatelessWidget {
//   const EntryItem(this.entry);
//   final Entry entry;

//   // This function recursively creates the multi-level list rows.
//   Widget _buildTiles(BuildContext context, Entry root) {
//     if (root.children.isEmpty) {
//       return ListTile(
//         onTap: () {
//           if (root.title == 'Static Spiral Test') {
//             Navigator.pushNamed(context, SpiralStatic.id);
//           } else {
//             Navigator.pushNamed(context, WaveStatic.id);
//           }

//         },
//         title: Text(root.title),
//         // onTap:,
//       );
//     }
//     return ExpansionTile(
//       leading: root.title == 'Spiral Test'
//           ? SvgPicture.asset(
//               'assets/spiral8.svg',
//               height: 35,
//             )
//           : root.title == 'wave Test'
//               ? SvgPicture.asset(
//                   'assets/wave-normal-4.svg',
//                   height: 30,
//                 )
//               : Icon(
//                   Icons.camera_alt,
//                   color: Colors.grey,
//                   size: 30,
//                 ),
//       key: PageStorageKey<Entry>(root),
//       title: Text(root.title),
//       children: root.children.map<Widget>(_buildTiles).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildTiles(context, entry);
//   }
// }
