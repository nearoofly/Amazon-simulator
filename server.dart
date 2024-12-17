import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  // Middleware pour afficher les requêtes
  final handler = Pipeline().addMiddleware(logRequests()).addHandler((request) {
    return Response.ok('Flutter Server is running on port 3000\n');
  });

  // Démarrer le serveur sur localhost:3000
  final server = await io.serve(handler, InternetAddress.anyIPv4, 3000);
  print('Serving at http://${server.address.host}:${server.port}');
}
