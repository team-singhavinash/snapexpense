import 'package:auto_route/auto_route_annotations.dart';
import 'package:snapexpenses/template/addrecords.dart';
import 'package:snapexpenses/template/home.dart';
import 'package:snapexpenses/template/imageView.dart';

@autoRouter
class $Router{
  @initial
  Home home;
  AddRecord addRecord;
  ImageViewer imageViewer;
}