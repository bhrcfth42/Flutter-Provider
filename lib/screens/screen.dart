import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remoteokio/models/remoteok.dart';
import 'package:remoteokio/states/remoteok_state.dart';

class RemoteokScreen extends StatefulWidget {
  const RemoteokScreen({Key? key}) : super(key: key);

  @override
  _RemoteokScreenState createState() => _RemoteokScreenState();
}

class _RemoteokScreenState extends State<RemoteokScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<RemoteokState>(context, listen: false).fetchRemoteok(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const InternetBaglantiHatasi();
          case ConnectionState.active:
            return const Text('');
          case ConnectionState.waiting:
            return const LoadingScreen();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Text("Hata");
            } else {
              return const Body();
            }
        }
      },
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RemoteokState>(
        builder: (context, state, widget) {
          var remoteoks = state.remoteoks;
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('images/background.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.dstATop),
                    ),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Arama",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      state.searchData(value);
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: ItemList(remoteoks),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemList extends StatelessWidget {
  List<Remoteok>? remoteoks;
  ItemList(this.remoteoks, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Remoteok remoteok = remoteoks![index];
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          remoteok.position!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(remoteok.description!),
                      ],
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(8),
                );
              },
            );
          },
          child: Container(
            height: 120.0,
            margin: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 124.0,
                  margin: const EdgeInsets.only(left: 46.0),
                  padding: const EdgeInsets.only(left: 46.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF333366),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          remoteok.position!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          remoteok.location!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: remoteok.tags!.map<Widget>((e) {
                              return Container(
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white54,
                                  ),
                                ),
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  alignment: FractionalOffset.centerLeft,
                  child: remoteok.companyLogo == ""
                      ? const SizedBox.shrink()
                      : ClipOval(
                          child: Image.network(
                            remoteok.companyLogo!,
                            fit: BoxFit.contain,
                            width: 90.0,
                            height: 90.0,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: remoteoks?.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/loading.gif"),
            ),
          ),
        ),
      ),
    );
  }
}

class InternetBaglantiHatasi extends StatelessWidget {
  const InternetBaglantiHatasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/connection_error.gif"),
                ),
              ),
            ),
            const Text(
              'İnternet Bağlantınızı Kontrol Ediniz',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VeriGetirmeHatasi extends StatelessWidget {
  const VeriGetirmeHatasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/data_error.gif"),
                ),
              ),
            ),
            const Text(
              'Verilerde Hata Oluştu.\nLütfen Daha Sonra Tekrar Deneyiniz.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
