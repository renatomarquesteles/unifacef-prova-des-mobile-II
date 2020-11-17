class Aviao {
  int _id;
  String _modelo;
  String _ano;
  String _companhia;
  String _passageiros;

  // Construtor da classe
  Aviao(this._modelo, this._ano, this._companhia, this._passageiros);

  // Converte dados de vetor para objeto
  Aviao.map(dynamic obj) {
    this._id = obj['id'];
    this._modelo = obj['modelo'];
    this._ano = obj['ano'];
    this._companhia = obj['companhia'];
    this._passageiros = obj['passageiros'];
  }

  // Encapsulamento
  int get id => _id;
  String get modelo => _modelo;
  String get ano => _ano;
  String get companhia => _companhia;
  String get passageiros => _passageiros;

  // Converte o objeto em um map
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['modelo'] = _modelo;
    map['ano'] = _ano;
    map['companhia'] = _companhia;
    map['passageiros'] = _passageiros;
    return map;
  }

  // Converte map em um objeto
  Aviao.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._modelo = map['modelo'];
    this._ano = map['ano'];
    this._companhia = map['companhia'];
    this._passageiros = map['passageiros'];
  }
}
