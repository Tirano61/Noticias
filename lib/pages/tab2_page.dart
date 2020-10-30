import 'package:flutter/material.dart';
import 'package:news_provider_app/models/category_model.dart';
import 'package:news_provider_app/services/news_service.dart';
import 'package:news_provider_app/theme/tema.dart';
import 'package:news_provider_app/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _ListasCategorias(),

            Expanded(child: ListaNoticias(newsService.getArticulosCategoriaSelecionada)),

          ],
        ),
      ),
    );
  }
}

class _ListasCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final cName = categories[index].name;

          return Container(
            width: 110,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _CategoryButton(categories[index]),
                  Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsSrevice = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        //En el evento tab va listen : false, porpque no lo tiene que redibujar
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.setSelectedCategory = categoria.name;
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.icon,
          color: (newsSrevice.getSelectedCategory == this.categoria.name)
              ? miThema.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
