import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import 'package:hemopa_app/models/user.dart';


class AgendamentoDoacao extends StatefulWidget {

  final User user;

  const AgendamentoDoacao({Key key, this.user}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<AgendamentoDoacao> {
  DateTime data;
  String hora;
  String local;

  String nomeUnidade = "";
  var _unidades = [
    'Batista Campos',
    'Castanheira',
    'Patio Belém',
    'Movel'
  ];
  var _tipoSanguineo = [
    'Não sei',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];
  var _tipoSangueSelecionado = 'Não sei';
  var _unidadeSelecionada = 'Batista Campos';
  var _horarios = [
    '07:30',
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
    '18:00'
  ];
  var _horarioSelecionado = '07:30';

  DateTime _data = new DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Agendar Doação",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.red[800],
      ),
      body: criaDropDownButton(),
    );
  }

  criaDropDownButton() {
    return Container(
      padding: EdgeInsets.all(0),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset('imagem/logo.png'),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Tipo Sanguíneo:",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5,
          ),
          DropdownButton<String>(
            //dropdownColor: Color.fromARGB(255, 255, 50, 0),
              items: _tipoSanguineo.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      )),
                );
              }).toList(),
              onChanged: (String novoItemSelecionado) {
                _dropDownTipoSanguineo(novoItemSelecionado);
                setState(() {
                  this._tipoSangueSelecionado = novoItemSelecionado;
                });

              },

              value: _tipoSangueSelecionado),

          SizedBox(
            height: 5,
          ),
          Text(
            "Unidade de Coleta:",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5,
          ),
          DropdownButton<String>(
            //dropdownColor: Color.fromARGB(255, 255, 50, 0),
            items: _unidades.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    )),
              );
            }).toList(),
            onChanged: (String novoItemSelecionado) {
              _dropDownItemSelected(novoItemSelecionado);
              setState(() {
                this._unidadeSelecionada = novoItemSelecionado;
                local = _unidadeSelecionada;
              });
            },

            value: _unidadeSelecionada,

          ),


          SizedBox(
            height: 5,
          ),

          Text(
            "Data: ",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text(
              '${formatDate(_data, [dd, '-', mm, '-', yyyy])}',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () async {
              final dtPick = await showDatePicker(
                  context: context,
                  initialDate: new DateTime.now(),
                  firstDate: new DateTime.now(),
                  lastDate: new DateTime(2100));

              if (dtPick != null && dtPick != _data) {
                setState(() {
                  data =  _data = dtPick;
                  print("Data:" + '${formatDate(data, [dd, '-', mm, '-', yyyy])}');
                });
              }

            },

          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Horário:",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          DropdownButton<String>(
            items: _horarios.map((String dropDownStringHorario) {
              return DropdownMenuItem<String>(
                value: dropDownStringHorario,
                child: Text(dropDownStringHorario,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    )),
              );
            }).toList(),
            onChanged: (String novoHorarioSelecionado) {
              _dropDownHorarioSelected(novoHorarioSelecionado);
              setState(() {
                this._horarioSelecionado = novoHorarioSelecionado;
                print("Horario:" + _horarioSelecionado);
                hora = _horarioSelecionado;
              });
            },
            value: _horarioSelecionado,
          ),

          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red[800],
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),

            height: 40,
            width: 200,
            child: FlatButton(
              child: Text(
                "Agendar Doação",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () => {

                printer(hora,data,local),
                Navigator.pop(context)

              },
            ),
          ),
        ],
      ),
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      this._unidadeSelecionada = novoItem;
    });
  }
  void _dropDownHorarioSelected(String novoHorario) {
    setState(() {
      this._horarioSelecionado = novoHorario;
    });
  }
  void _dropDownTipoSanguineo(String novoTipo) {
    setState(() {
      this._tipoSangueSelecionado = novoTipo;
    });
  }
  void printer(String hora,DateTime data,String local) {
    print("Data:" + '${formatDate(data, [dd, '-', mm, '-', yyyy])}');
    print("Hora:" + hora);
    print("Local:" + local);
  }
}
