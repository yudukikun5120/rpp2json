Factor
  = "<" _ tag:Tag _ attrs:Attributes _ ">" { return ({key: tag, value:attrs}) }

Tag
  = "ITEM"
  / "SOURCE WAVE"
  
Attribute
  = _ key:([A-Z])+ _ value:Value { return ({key: key.join(""), value: value}); }
  / factor:(_ Factor) { return factor[1]}
  
Attributes
  = attributes:Attribute* { return attributes.reduce((acc, {
    key,
    value
  }) => {
    acc[key] = value;
    return acc;
  }, {}); }

Value
 = "{"guid:([A-Z|0-9|-]+)"}" { return guid.join("") }
 / Float
 / v:([A-Z|a-z|"//|0-9|.| |{|}|-]+) { return v.join("") }
 / String

String "string"
  = [a-z|A-Z]+

Integer "integer"
  = _ [0-9] + { return parseInt(text(), 10); }
  
Float "float" = _[0-9] + "." [0-9] + {
  return parseFloat(text());
}

_ "whitespace"
  = [ \t\n\r]*
