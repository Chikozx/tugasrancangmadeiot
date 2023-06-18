import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trmase/halamanutama/dataview.dart';
import 'package:trmase/main.dart';

class MyNotes extends StatefulWidget {
  const MyNotes({super.key});

  @override
  State<MyNotes> createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  final ref2 = FirebaseDatabase.instance.ref('uid/access');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var warna = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: warna.background,
      floatingActionButton: IconButton(
        onPressed: () async {
          final logout = await FirebaseAuth.instance.signOut();
          final test = await FirebaseAuth.instance.currentUser;
          print(test);
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login/', (route) => false);
        },
        icon: const Icon(
          Icons.logout,
          shadows: [Shadow(blurRadius: 10)],
        ),
        splashRadius: 0.1,
      ),
      body: SafeArea(
          child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: warna.outlineVariant,
            foregroundColor: warna.secondary,
            title: Row(
              children: const [
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Smart Door Lock',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              indicatorColor: warna.secondary,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: warna.secondary,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.history,
                    color: warna.secondary,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Scaffold(
                backgroundColor: warna.outlineVariant,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Theme.of(context).colorScheme.background,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text('Hello!',
                                  style:
                                      Theme.of(context).textTheme.displaySmall),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'List of registered card holder',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: FirebaseAnimatedList(
                      reverse: true,
                      query: ref2,
                      itemBuilder: (context, snapshot, animation, index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                          child: ListTile(
                            dense: true,
                            tileColor: Theme.of(context).colorScheme.background,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: warna.tertiary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            trailing: Text(snapshot.key.toString()),
                            title: Text(
                              snapshot.value.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: warna.tertiary),
                            ),
                          ),
                        );
                      },
                    ))
                  ],
                ),
              ),
              DataView(),
            ],
          ),
        ),
      )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text("Menu")),
            ListTile(
              title: Text("Data"),
              onTap: () async {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/dataview/', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
