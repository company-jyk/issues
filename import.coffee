@OldIssues = new Mongo.Collection 'OldIssues'
OldIssues.allow
  insert: (userId)->
    userId?


AdminConfig.collections.OldIssues =
  label: 'OldIssues'
  #icon: 'pencil'
  tableColumns: [
    {label: '緩急',name:'緩急'}
    {label:'狀態',name:'狀態'}
    {label:'用戶界面',name:'用戶界面'}
    {label: '一級菜單', name:'一級菜單'}
    {label: '二級菜單', name:'二級菜單'}
    {label: '詳細位置', name:'詳細位置'} #模仿 提交者但不行?
    {label: '問題描述',name:'問題描述'}
    {label: '備註',name:'備註'}
    {label: '提交日期',name:'提交日期'}
    {label:'提交者',name:'提交者', collection: 'Users'}
  ]

if Meteor.isClient
  Meteor.subscribe "oldIssuesChannel"
  Template.import.events
    'click #import': (e,t)->
      #file= (($ '#files')[0].files)[0]
      #console.log @, file
      #start = performance.now()

      config =
        delimiter: ",",	#// auto-detect
        newline: "",	#// auto-detect
        header: true,
        dynamicTyping: false,
        preview: 0,
        encoding: "utf-8",
        worker: false,
        comments: false,
        step: undefined,
        complete: undefined,
        error: undefined,
        download: false,
        skipEmptyLines: false,
        chunk: undefined,
        fastMode: undefined

      parsed = Papa.parse csv, config
      issue = {}

      for iss in parsed.data
        OldIssues.insert iss

  Template.import.helpers

    fields:['緩急','狀態','用戶界面','一級菜單','二級菜單','詳細位置','問題描述','備註']

if Meteor.isServer
  Meteor.publish "oldIssuesChannel" , ()->
    OldIssues.find()
