import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://pxsrqhljskoyyrjdoulo.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB4c3JxaGxqc2tveXlyamRvdWxvIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjczODEzMTAsImV4cCI6MTk4Mjk1NzMxMH0.GJ5UejiE8aoN8dq-jbu9TPZO5mAzPQVm70m9SykkmI8",
    debug: true,
  );
  runApp(const App());
}
