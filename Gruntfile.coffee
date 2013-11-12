module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      dev:
        expand: true
        cwd: './'
        dest: '<%= coffee.dev.cwd %>'
        ext: '.js'
        src: [
          '*.coffee'
        ]
        options:
          bare: true
          sourceMap: true
    coffeelint:
      all: [
        '*.coffee',
        'Gruntfile.coffee'
      ]
      options:
        max_line_length:
          value: 120
          level: 'warn'
    express:
      all:
        options:
          cmd: 'coffee'
          script: './server.coffee'
          port: 8000
    jade:
      dev:
        options:
          basePath: './'
          extension: '.html'
          client: false
          pretty: true
        files:
          './': [
            '*.jade'
          ]
    watch:
      coffee:
        files: [
          '<%= coffeelint.all %>'
        ]
        tasks: [
          'coffeelint'
          'coffee:dev'
        ]
        options:
          livereload: true
      jade:
        files: [
          '*.jade'
        ]
        tasks: [
          'jade'
        ]
        options:
          livereload: true

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-jade'

  grunt.registerTask 'default', 'run the server and watch for changes', [
    'coffee:dev'
    'jade:dev'
    'express'
    'watch'
  ]