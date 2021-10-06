class Remoteok {
  String? slug;
  String? id;
  String? epoch;
  String? date;
  String? company;
  String? companyLogo;
  String? position;
  List<String>? tags;
  String? logo;
  String? description;
  String? location;
  String? url;
  String? applyUrl;

  Remoteok(
      {this.slug,
      this.id,
      this.epoch,
      this.date,
      this.company,
      this.companyLogo,
      this.position,
      this.tags,
      this.logo,
      this.description,
      this.location,
      this.url,
      this.applyUrl});

  factory Remoteok.fromJson(Map<String, dynamic> json) => Remoteok(
        slug: json['slug'],
        id: json['id'],
        epoch: json['epoch'],
        date: json['date'],
        company: json['company'],
        companyLogo: json['company_logo'],
        position: json['position'],
        tags: json['tags']==null?null:json['tags'].cast<String>(),
        logo: json['logo'],
        description: json['description'],
        location: json['location'],
        url: json['url'],
        applyUrl: json['apply_url'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['id'] = id;
    data['epoch'] = epoch;
    data['date'] = date;
    data['company'] = company;
    data['company_logo'] = companyLogo;
    data['position'] = position;
    data['tags'] = tags;
    data['logo'] = logo;
    data['description'] = description;
    data['location'] = location;
    data['url'] = url;
    data['apply_url'] = applyUrl;
    return data;
  }
}
