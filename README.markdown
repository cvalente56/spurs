# Spurs

Spurs is a library that adds some bells and whistles to the Twitter Bootstrap GUI framework. I consists mostly of helpers and javascript, and thus is ORM agnostic.

## Flash Messages

Put this in your layout file wherever you want to render the flash messages
```erb
<%= spurs_flash_helper %>
```
and flash messages will be automatically rendered on page loads

From the rails side, you can create four types of messages

* :notice
* :warning
* :info
* :error

```ruby
flash_addItem(:notices,"A message about something successfully happening!")
```

You can also use JavaScript to generate matching messages
```javascript
spurs.flash.alert("Something has gone wrong!","error");
```
[More...](https://github.com/TrueNorth/spurs/wiki/Flash-Messages)

## Navigation

Spurs makes creation of bootstrap navigation easy!.
```haml
= spurs_nav :type => :pills do |nav|
    = nav.tab :user, :icon => :user, :href => "#user"
    = nav.tab :settings, :icon => :cog, :onclick => "alert('hello');"
```
[More...](https://github.com/TrueNorth/spurs/wiki/Navigation)