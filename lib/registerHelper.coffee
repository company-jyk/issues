if Meteor.isClient
  Template.registerHelper 'AppName', -> AppName
  Template.registerHelper 'wlisted', -> "#{Meteor.user()?.wlisted()}"
  Template.registerHelper 'Schemas', Schemas 
  #Template.splash.helpers
  #  AppName: -> 'AppName'
