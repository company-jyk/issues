if Meteor.isClient
  Template.import.events
    'click #import': (e,t)->
      #file= (($ '#files')[0].files)[0]
      #console.log @, file
      #start = performance.now()

      config =
        delimiter: ",",	#// auto-detect
        newline: "",	#// auto-detect
        header: true,
        dynamicTyping: true,
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
      console.log parsed
      for issue in parsed
        Issues.insert parsed
