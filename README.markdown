# Spurs
# An insignificant change
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

From the rails side, you can create four types of messages: `:notice`, `:warning`, `:info` and `:error`

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

## Alerts
Alerts are styled to match flash messages. Creating an in-place alert is done as follows
```haml
= spurs_alert_box do
  This is a basic alert
```
[More...](https://github.com/TrueNorth/spurs/wiki/Alerts)

## Asynchronous Modals
Spurs can present a modal as a response to an asynchronous request. 

For example, if your request is
```javascript
$.get({url: '/blogs/MY_BLOG/posts/new.js'});
```
Your controller response might look like
```ruby
@blog = Blog.find(params[:blog_id])
respond_to do |format|
  format.js {
    spawn_modal("Create a new blog post",  #Title of the modal
                "blogs/posts/new", # Path to a partial to render in the modal body.
                @blog, # Object that the partial is rendering. Can be nil if the previous argument is not a partial
                :title_icon => '/assets/new_blog_post_icon.png' # Path to an icon shown in the title bar of the modal
                :modal_options => {} # A hash passed to the partial as local variables
                ) 
  }
end
```
You can also use a method
```ruby
spawn_form_modal(...) #same arguments as spawn_modal
```
which will show a modal with an "OK" button in the footer. Pressing this button will submit any form in the .modal-body div.


