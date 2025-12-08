let
    Source = Uncleaned_DS_jobs,
    #"Removed Other Columns" = Table.SelectColumns(Source,{"Size", "Min Sale", "Max Sale"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Removed Other Columns",{{"Min Sale", Currency.Type}, {"Max Sale", Currency.Type}}),
    #"Multiplied Column" = Table.TransformColumns(#"Changed Type", {{"Min Sale", each _ * 1000, Currency.Type}}),
    #"Multiplied Column1" = Table.TransformColumns(#"Multiplied Column", {{"Max Sale", each _ * 1000, Currency.Type}}),
    #"Grouped Rows" = Table.Group(#"Multiplied Column1", {"Size"}, {{"Job Count", each Table.RowCount(_), Int64.Type}, {"Average Min Salary", each List.Average([Min Sale]), type number}, {"Average Max Salary", each List.Average([Max Sale]), type number}, {"AllRows", each _, type table [Size=nullable text, Min Sale=number, Max Sale=number, Role Type=nullable text]}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Grouped Rows",{{"Average Min Salary", Currency.Type}, {"Average Max Salary", Currency.Type}}),
    #"Sorted Rows" = Table.Sort(#"Changed Type1",{{"Average Max Salary", Order.Descending}})
in
    #"Sorted Rows"
