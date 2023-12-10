import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:news_app_malvoyant_pfe/views/pages/source_news.dart';

class HowToUse extends StatefulWidget {
  const HowToUse({Key? key}) : super(key: key);

  @override
  State<HowToUse> createState() => _HowToUseState();
}

class _HowToUseState extends State<HowToUse> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        dotsDecorator: DotsDecorator(
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          activeSize: const Size(20.0, 10.0),
        ),
        pages: [
          PageViewModel(
            image: Image.network(
                'https://t4.ftcdn.net/jpg/01/27/38/91/240_F_127389167_Z8PhSGbhlP2rowZOVa9gDnLInEtzeJx3.jpg'),
            title: 'Bienvenu sur votre application  ',
            body: 'YourNews est la meilleure application des actualités pour tous les personnes',
            footer: Text(
              "l\'actualité est entre vos mains maintenant",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: GoogleFonts.abel().fontFamily),
            ),
            decoration: pageDecor,
          ),
          PageViewModel(
            image: Image.network(
                'https://th.bing.com/th/id/R.faf281521c750e81ed6267445e7fabf2?rik=Ks0aFdyXbCUc2w&pid=ImgRaw&r=0&sres=1&sresct=1'),
            title: ' DONNER DES COMMANDE VOCALS',
            body: 'Vous prouver, faire des commande que veut ',
            footer: Text(
              'Parmi les commandes vocals il y a \'PAUSE\' pour arrete la lecture  \'LIRE\' pour demarer la lecture,  \'SUIVANT\' '
                  'pour passe à l\'actualités ou source suivant et  \'Precedent\',',
              style: TextStyle(color: Colors.grey),
            ),
            decoration: pageDecor,
          ),
          PageViewModel(
            image: Image.network(
                'https://th.bing.com/th/id/R.204418379aee08e2abc535dbe16951d0?rik=eIICUKn5ZFrmAw&pid=ImgRaw&r=0'),
            title: ' CHOISIR VOTRE SOURCE',
            body: 'Trouver l\'actualité qui vous avez besoin de voir  ',
            footer: Text(
              "Vous pouvez choisir une source d'actualites avec des commandes simplement mentionner le numéro de source.",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: GoogleFonts.abel().fontFamily),
            ),
            decoration: pageDecor,
          ),
          PageViewModel(
            image: Image.network(
                'https://th.bing.com/th/id/R.b0f9794ee247ca914bd2c57a92ff1af4?rik=C7w2kxan4ClEBw&riu=http%3a%2f%2fp6.storage.canalblog.com%2f65%2f12%2f646220%2f44270794.gif&ehk=m%2bixcnYOD0d3C'
                'gVLFyz2%2f5WnmGfjtkrr6c5cF1O0%2bQM%3d&risl=&pid=ImgRaw&r=0'),
            title: ' Écouter les actualités sans faire des efforts',
            body: 'la liste des actualités s\'affiche',
            footer: Text(
              'Dans cette page vous pouvez choisir une actualité avec des commandes simplement mentionner '
                  'le numéro d\'actualiré et aussi faire d\'autre commande',
              style: TextStyle(color: Colors.black),
            ),
            decoration: pageDecor,
          ),
        ],
        done: Text(
          'Done',
          style: TextStyle(color: Color(0xFF1E3A8A)),
        ),
        onDone: () => goToHome(context),
        showSkipButton: true,
        skip: Text(
          'Skip',
          style: TextStyle(color: Color(0xFF1E3A8A)),
        ),
        onSkip: () => goToHome(context),
        next: Icon(Icons.arrow_forward_outlined),
        showNextButton: true,
      ),
    );
  }

  var pageDecor = PageDecoration(
    titleTextStyle: PageDecoration().titleTextStyle.copyWith(
        fontFamily: GoogleFonts.montserrat().fontFamily, color: Colors.black),
    bodyTextStyle: PageDecoration().bodyTextStyle.copyWith(
        fontFamily: GoogleFonts.adamina().fontFamily, color: Colors.black),
  );
  // final pageDecor = PageDecoration(
  //     titleTextStyle: TextStyle(
  //         color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
  //     bodyTextStyle: TextStyle(color: Color(0xFF262626)),
  //     contentMargin: EdgeInsets.all(8));

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SourceNews()),
      );
}
