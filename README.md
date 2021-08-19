# Budgets Control

A simple CLI budget control written using Ruby without frameworks and saving the data inside a simple csv file (to be converted in excel format in the future).

## Options

- Add payables
- Add receivables
- Show month report
- - Show year report

## Examples

### Open CLI menu typping 1

https://user-images.githubusercontent.com/8007754/129572698-83143c41-c5d0-4a82-8f6b-963079c98402.mp4

### Add a account payable

https://user-images.githubusercontent.com/8007754/129572762-d62c82b2-1777-45ba-b9d8-5d8cbd70b592.mp4

### Add a account receivable

https://user-images.githubusercontent.com/8007754/129572881-85b19f03-40bf-4c72-84db-feb1775a15b8.mp4

### Show a month report

https://user-images.githubusercontent.com/8007754/129572936-c44f728b-29d7-4c5b-9111-8f2b63ac4931.mp4

### Show a year report

https://user-images.githubusercontent.com/8007754/129574488-1d1613bd-8248-4103-9068-012852aea612.mp4

## Dependencies

- readline-rb
- terminal-table

## Testing

```terminal
bundle exec rspec
```

## Code Design Tips

- Rubocop

## TODO

- write more specs
- add a table module
- add a bigdecimal handler module
