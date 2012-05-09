# Spurs

Spurs is a library that adds some bells and whistles to the Twitter Bootstrap GUI framework. I consists mostly of helpers and javascript, and thus is ORM agnostic.

## Flash Messages

Put this in your layout file wherever you want to render the flash messages
  
    <%= spurs_flash_helper %>

and flash messages will be automatically rendered on page loads

### From the rails side

By default, you can create four types of messages
    
    flash_addItem(:notices,"A message about something successfully happening!")
    flash_addItem(:warnings, "Something is unusual, but not absolutely critical")
    flash_addItem(:errors, "Something critical has happened")
    flash_addItem(:infos, "Here's some information")

You can also create multiple messages for each type
    
    flash_addItem(:errors, "Problem validating phone number")
    flash_addItem(:errors, "Problem validating street address")

### From the javascript side

You can also create matching flash messages via javascript
  
    spurs.flash.alert("Something has gone wrong!","error");

for the singular versions of each of the four types above ("info", "warning", "error", "notice")

## Navigation

Spurs makes creation of bootstrap navigation easy!.

    spurs_nav :type => :pills do |nav|
      
      # a simple nav item as a regular link
      nav.tab :user, :icon => :user, :href => "#user"
      
      # a nav item that runs some javascript
      nav.tab :settings, :icon => :cog, :onclick => "alert('hello');"
      
      # a nav item that only shows its icon (not its name)
      nav.tab :secure, :icon => :lock, :icon_only => true
      
      # a dropdown menu with two actions
      nav.dropdown :menu, 
                    :icon => :cog, 
                    :icon_only => true,
                    :actions => [ {:name => "one", :icon => :plus, :href => "#one"},
                                 {:name => "two", :icon => :minus, :href => "#two"}]

will generate a menu like this...

![image](https://github.com/TrueNorth/spurs/raw/master/docs/img/pic1.png)

or in HTML...
  
    <ul class="nav nav-pills  ">
      <li>
        <a href="#user">
          <i class="icon-user"></i>User
        </a>
      </li>
      <li>
        <a onclick="alert('hello');">
          <i class="icon-cog"></i>Settings
        </a>
      </li>
      <li>
        <a>
          <i class="icon-lock"></i>Secure
        </a>
      </li>
      <li class="dropdown" data-dropdown="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown">
          <i class="icon-cog"></i>
          <b class="caret"></b>
        </a>
        <ul class="dropdown-menu">
          <li>
            <a href="#one">
              <i class="icon-plus"></i>No Name
            </a>
          </li>
          <li>
            <a href="#two">
              <i class="icon-minus"></i>No Name
            </a>
          </li>
        </ul>
      </li>
    </ul>

You can specify some active criteria for menu items

    spurs_nav :type => :pills do |nav|
  
      # force this to be active with a boolean
      nav.tab :user, :icon => :user, :href => "#user", 
              :active => true
      
      # controller criteria (if controller_name == :settings)
      nav.tab :settings, :icon => :cog, :onclick => "alert('hello');", 
              :active => {:controller => :settings}
  
      # controller and action criteria (if controller_name == :settings && action_name == ;edit)
      nav.tab :settings, :icon => :cog, :onclick => "alert('hello');", 
              :active => {:controller => :settings, :action => :edit}
  
      # multiple controller/action criteria (if (controller_name == :settings && action_name == :edit) || (controller_name == :user && action_name == :edit)
      nav.tab :settings, :icon => :cog, :onclick => "alert('hello');", 
              :active => [{:controller => :settings, :action => :edit},
                          {:controller => :users, :action => :edit}]
