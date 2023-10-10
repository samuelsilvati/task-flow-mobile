import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.help_outlined,
                size: 28,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              "Este aplicativo foi projetado para tornar o gerenciamento de tarefas simples e eficiente. Aqui estão algumas instruções para começar:"),
          SizedBox(
            height: 20,
          ),
          Text(
            'Criar uma Nova Tarefa',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
              'Para adicionar uma nova tarefa à sua lista, toque no botão flutuante (+) localizado na parte inferior da tela. Preencha o nome da tarefa e qualquer detalhe adicional que você desejar, depois toque em "Salvar".'),
          SizedBox(
            height: 20,
          ),
          Text(
            'Editar uma Tarefa Existente',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
              'Para editar uma tarefa existente, mantenha pressionado o card da tarefa que deseja modificar. Uma janela de edição será exibida, permitindo que você faça as alterações necessárias. Após concluir as edições, toque em "Salvar" para confirmar.'),
          SizedBox(
            height: 20,
          ),
          Text(
            'Excluir uma Tarefa',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
              "Para remover uma tarefa da sua lista, basta arrastar o card da tarefa para o lado (esquerda ou direita). A tarefa será excluída instantaneamente."),
          SizedBox(
            height: 20,
          ),
          Text(
              "Agora você está pronto para começar a usar seu App de Lista de Tarefas. Organize suas tarefas de forma eficaz e aumente sua produtividade."),
        ],
      ),
    );
  }
}
