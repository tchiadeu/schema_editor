# SchemaEditor
For visualize your Rails Apps DB.
You can find all the tables of your DB and their associated columns.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "schema_editor", git: "git@github.com:tchiadeu/schema_editor.git"
```

And then execute:
```bash
bundle install
```

Then add the following code into your `routes`:
```ruby
mount SchemaEditor::Engine => "/schema_editor" if Rails.env.development?
```

## Usage
Find the tool here:
```bash
http://localhost:3000/schema_editor
```

## Contributing
Feel free to make a PR if you want to contribute to this little project.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
