let
    Source = #"Organized Dataset",
    #"Removed Other Columns" = Table.SelectColumns(Source,{"Size", "Min Salary Estimate", "Max Salary Estimate"}),
    #"Grouped Rows" = Table.Group(#"Removed Other Columns", {"Size"}, {{"Job Count", each Table.RowCount(_), Int64.Type}, {"Average Min Salary", each List.Average([Min Salary Estimate]), type number}, {"Average Max Salary", each List.Average([Max Salary Estimate]), type number}, {"AllRows", each _, type table [Size=nullable text, Min Salary Estimate=number, Max Salary Estimate=number]}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Grouped Rows",{{"Average Min Salary", Currency.Type}, {"Average Max Salary", Currency.Type}})
in
    #"Changed Type"
