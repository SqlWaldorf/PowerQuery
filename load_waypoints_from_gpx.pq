let
    Source = Xml.Tables(Web.Contents("http://www.topografix.com/fells_loop.gpx")),
    ChangedType = Table.TransformColumnTypes(Source,{{"time", type datetime}, {"Attribute:version", type number}, {"Attribute:creator", type text}}),
    #"Expand wpt" = Table.ExpandTableColumn(ChangedType, "wpt", {"ele", "time", "Attribute:lat", "Attribute:lon"}, {"wpt.ele", "wpt.time", "wpt.Attribute:lat", "wpt.Attribute:lon"}),
    RemovedOtherColumns = Table.SelectColumns(#"Expand wpt",{"wpt.ele", "wpt.time", "wpt.Attribute:lat", "wpt.Attribute:lon"}),
    ChangedType1 = Table.TransformColumnTypes(RemovedOtherColumns,{{"wpt.time", type datetime}}),
    ChangedTypeWithLocale = Table.TransformColumnTypes(ChangedType1, {{"wpt.ele", type number}, {"wpt.Attribute:lat", type number}, {"wpt.Attribute:lon", type number}}, "en-US")
in
    ChangedTypeWithLocale