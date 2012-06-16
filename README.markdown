# Spurs

Spurs is a library that adds some bells and whistles to the Twitter Bootstrap GUI framework.

## Installation
There are many independent components of spurs, and some require more set up than others.

To get started, in your gemfile, add

```ruby
gem 'spurs'
```

and then run

```ruby
bundle install
```

## Flash Messages

From the rails side, you can create four types of messages: 
* :notice
* :warning
* :info
* :error

```ruby
flash_addItem(:notices,"A message about something successfully happening!")
```
It's especially easy to add model errors as flash messages. Here's a typical use
```ruby
m = Message.new(:title => "hello", :body => "world!")
if !m.save
  flash_addModelErrors(m)
end
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