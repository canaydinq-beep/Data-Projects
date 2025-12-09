let
    Source = Excel.CurrentWorkbook(){[Name="Raw_Dataset"]}[Content],
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"index", Int64.Type}, {"Job Title", type text}, {"Salary Estimate", type text}, {"Job Description", type text}, {"Rating", Int64.Type}, {"Company Name", type text}, {"Location", type text}, {"Headquarters", type text}, {"Size", type text}, {"Founded", Int64.Type}, {"Type of ownership", type text}, {"Industry", type text}, {"Sector", type text}, {"Revenue", type text}, {"Competitors", type text}}),
    #"Extracted Text Before Delimiter" = Table.TransformColumns(#"Changed Type", {{"Salary Estimate", each Text.BeforeDelimiter(_, " ("), type text}}),
    #"Inserted Text Between Delimiters" = Table.AddColumn(#"Extracted Text Before Delimiter", "Min Salary Estimate", each Text.BetweenDelimiters([Salary Estimate], "$", "K"), type text),
    #"Inserted Text Between Delimiters1" = Table.AddColumn(#"Inserted Text Between Delimiters", "Max Salary Estimate", each Text.BetweenDelimiters([Salary Estimate], "$", "K", 1, 0), type text),
    #"Changed Type1" = Table.TransformColumnTypes(#"Inserted Text Between Delimiters1",{{"Min Salary Estimate", Currency.Type}, {"Max Salary Estimate", Currency.Type}}),
    #"Multiplied Column" = Table.TransformColumns(#"Changed Type1", {{"Min Salary Estimate", each _ * 1000, Currency.Type}}),
    #"Multiplied Column1" = Table.TransformColumns(#"Multiplied Column", {{"Max Salary Estimate", each _ * 1000, Currency.Type}}),
    #"Added Custom" = Table.AddColumn(#"Multiplied Column1", "Role Type", each if Text.Contains([Job Title], "Data Scientist") then "Data Scientist"
else if Text.Contains([Job Title], "Data Analyst") then "Data Analyst"
else if Text.Contains([Job Title], "Data Engineer") then "Data Engineer"
else if Text.Contains([Job Title], "Machine Learning Engineer") then "Machine Learning Engineer"
else "Other"),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Added Custom", "Location", Splitter.SplitTextByDelimiter(", ", QuoteStyle.Csv), {"Location", "Abbreviation"}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Location", type text}, {"Abbreviation", type text}}),
    #"Filtered Rows" = Table.SelectRows(#"Changed Type2", each ([Abbreviation] <> null)),
    #"Replaced Value" = Table.ReplaceValue(#"Filtered Rows","Anne Arundel","MD",Replacer.ReplaceText,{"Abbreviation"}),
    #"Merged Queries" = Table.NestedJoin(#"Replaced Value", {"Abbreviation"}, states, {"2-letter USPS"}, "states", JoinKind.LeftOuter),
    #"Expanded states" = Table.ExpandTableColumn(#"Merged Queries", "states", {"Full Name"}, {"Location Correction"}),
    #"Changed Type3" = Table.TransformColumnTypes(#"Expanded states",{{"Role Type", type text}})
in
    #"Changed Type3"
