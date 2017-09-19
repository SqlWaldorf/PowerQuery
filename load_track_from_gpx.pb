let
    Source = Xml.Tables(File.Contents("c:\MyGPXFile.gpx")),
    #"Expand trk" = Table.ExpandTableColumn(Source, "trk", {"name", "desc", "number", "http://www.topografix.com/GPX/Private/TopoGrafix/0/1", "trkseg"}, {"trk.name", "trk.desc", "trk.number", "trk.http://www.topografix.com/GPX/Private/TopoGrafix/0/1", "trk.trkseg"}),
    #"Expand trk.trkseg" = Table.ExpandTableColumn(#"Expand trk", "trk.trkseg", {"trkpt"}, {"trk.trkseg.trkpt"}),
    #"Expand trk.trkseg.trkpt1" = Table.ExpandTableColumn(#"Expand trk.trkseg", "trk.trkseg.trkpt", {"Attribute:lat", "Attribute:lon"}, {"trk.trkseg.trkpt.Attribute:lat", "trk.trkseg.trkpt.Attribute:lon"}),
    RemovedOtherColumns = Table.SelectColumns(#"Expand trk.trkseg.trkpt1",{"trk.trkseg.trkpt.Attribute:lat", "trk.trkseg.trkpt.Attribute:lon"}),
    ChangedTypeWithLocale = Table.TransformColumnTypes(RemovedOtherColumns, {{"trk.trkseg.trkpt.Attribute:lat", type number}, {"trk.trkseg.trkpt.Attribute:lon", type number}}, "en-US")
in
    ChangedTypeWithLocale