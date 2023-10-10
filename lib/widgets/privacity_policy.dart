import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Termos de Uso e Privacidade',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              "A sua privacidade é uma prioridade para nós. Esta política de privacidade explica como usamos e protegemos as informações pessoais que você fornece ao fazer login no nosso aplicativo."),
          SizedBox(
            height: 20,
          ),
          Text(
            'Coleta de Informações',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
              "Para fornecer acesso aos recursos do aplicativo, solicitamos que você forneça seu endereço de e-mail. Este endereço de e-mail é usado exclusivamente para fins de autenticação e para criar uma experiência personalizada no aplicativo."),
          SizedBox(
            height: 20,
          ),
          Text(
            'Uso das Informações',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
              "O seu endereço de e-mail é usado apenas para permitir que você faça login no aplicativo. Não compartilhamos suas informações com terceiros nem as utilizamos para fins de marketing sem a sua autorização expressa."),
          SizedBox(
            height: 20,
          ),
          Text(
            'Proteção de Dados',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
              "Tomamos medidas rigorosas para proteger suas informações pessoais e garantir a segurança dos dados durante o uso do nosso aplicativo. Implementamos práticas de segurança e protocolos avançados para proteger contra acesso não autorizado, divulgação ou alteração de suas informações."),
          SizedBox(
            height: 20,
          ),
          Text(
            'Alterações na Política de Privacidade',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
              "Reservamo-nos o direito de atualizar ou modificar esta política de privacidade a qualquer momento. Quaisquer alterações significativas serão comunicadas através do aplicativo ou por outros meios adequados."),
          SizedBox(
            height: 20,
          ),
          Text(
            'Entre em Contato Conosco',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
              "Se você tiver alguma dúvida ou preocupação relacionada à sua privacidade ou ao uso de suas informações pessoais, entre em contato conosco através do e-mail [seu endereço de e-mail de contato]."),
          SizedBox(
            height: 18,
          ),
          Text(
              "Ao utilizar nosso aplicativo, você concorda com os termos desta política de privacidade. Agradecemos por confiar em nós com suas informações pessoais e garantimos que faremos o possível para manter sua privacidade e segurança."),
        ],
      ),
    );
  }
}
