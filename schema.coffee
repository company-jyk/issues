@Issues = new Mongo.Collection "Issues"
Issues.allow
  insert: (userId)->
    userId?

Schemas.Issues = new SimpleSchema [
  "緩急":
    type: String
    allowedValues:['待定','急','中','緩']

  "狀態":
    type: String
    allowedValues: ['未解決','待測試','已解決','解決不了']

  "用戶界面":
    type: String
    label: '用戶界面'
    max:20

  "一級菜單":
    type: String
    label: '一級菜單'
    max:20

  "二級菜單":
    type: String
    label: '二級菜單'
    max:40
    #optional: true

  "詳細位置":
    type: String
    label: '詳細位置'
    max:80
    optional:true

  "問題描述":
    type: String
    label: '問題描述'
    min: 2
    max: 280


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


Issues.attachSchema Schemas.Issues


AdminConfig.collections.Issues = {
  label: 'Issues'
  #icon: 'pencil'

  tableColumns: [
    {label: '緩急', name:'緩急'}
    {label:'狀態', name:'狀態'}
    {label:'用戶界面', name:'用戶界面'}
    {label: '一級菜單', name:'一級菜單'}
    {label: '二級菜單', name:'二級菜單'}
    {label: '詳細位置', name:'詳細位置'} #模仿 提交者但不行?
    {label: '問題描述', name:'問題描述'}
    {label: '備註', name:'備註'}
    {label: '提交日期', name:'提交日期'}
    {label:'提交者', name:'提交者', collection: 'Users'}
  ]
  ###

  templates:
    new:
      name: 'postWYSIGEditor'
      data:
        post: Session.get 'admin_doc'
    edit:
      name: 'postWYSIGEditor'
      data:
        post: Session.get 'admin_doc'
  ###
}


if Meteor.isClient
  Meteor.subscribe "issuesChannel"
  Template.home.helpers
    fields:['狀態','用戶界面','一級菜單','二級菜單','詳細位置','問題描述','備註']

if Meteor.isServer
  Meteor.publish "issuesChannel" , ()->
    Issues.find()
