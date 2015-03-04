@Discussion = new Mongo.Collection 'Discussion'
Discussion.allow
  insert: (userId)->
    userId?

Schemas.Discussion = new SimpleSchema [


    "主題":
      type: String
      label: '主題'
      max:80
      optional:true

    "內容":
      type: String
      label: '內容'
      min: 2
      max: 580


    "備註":
      type: String
      label: '備註'
      max:150
      optional:true

    "提交者":
      type: String
      regEx: SimpleSchema.RegEx.Id
      autoValue: ->
        if this.isInsert
          return Meteor.userId()
      autoform:
        options: ->
          _.map Meteor.users.find().fetch(), (user)->
            label: user.emails[0].address
            value: user._id

    "提交日期":
      type: Date
      label: '提交日期'
      autoValue: ->
        if this.isInsert
          return new Date()



  ]

Discussion.attachSchema Schemas.Discussion

AdminConfig.collections.Discussion =
  label: 'Discussion'
  #icon: 'pencil'
  tableColumns: [
    {label: '主題',name:'主題'}
    {label:'內容',name:'內容'}
    {label: '備註',name:'備註'}
    {label: '提交日期',name:'提交日期'}
    {label:'提交者',name:'提交者', collection: 'Users'}
  ]

if Meteor.isClient
  Meteor.subscribe "DiscussionChannel"

if Meteor.isServer
  Meteor.publish "DiscussionChannel" , ()->
    Discussion.find()
