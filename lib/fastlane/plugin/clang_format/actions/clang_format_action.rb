require 'fastlane'

module Fastlane
  module Actions
    class ClangFormatAction < Action
      def self.run(params)
        clang_format_path = params[:clang_format_path]
        clang_format_path ||= 'clang-format'

        cmd = []
        cmd << clang_format_path
        inplace = params[:inplace]
        cmd << "-i" if inplace
        style = params[:style]
        cmd << "--style=#{style}" if style
        cmd << "--verbose" if params[:verbose]
        files = params[:files]
        Array(files).each do |file|
          cmd << file
        end
        Actions.sh(cmd.join(' '))
        UI.success('Everything is formatted correctly now! 💪')
      end

      def self.description
        "A tool to format C/C++/Java/JavaScript/Objective-C/Protobuf/C"
      end

      def self.details
        [
          'If no arguments are specified, it formats the code from standard input',
          'and writes the result to the standard output.',
          'If :files are given, it reformats the files. If :inplace is specified',
          'together with :files, the files are edited in-place. Otherwise, the',
          'result is written to the standard output'
        ].join(' ')
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :clang_format_path,
                                      env_name: 'FL_CLANG_FORMAT_PATH',
                                      description: 'Path to clang-format if you want use it from specific path',
                                      optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :inplace,
                                      env_name: 'FL_CLANG_FORMAT_INPLACE',
                                      description: 'Inplace edit :files, if specified',
                                      optional: true,
                                      default_value: false,
                                      type: Boolean),
          FastlaneCore::ConfigItem.new(key: :style,
                                      env_name: 'FL_CLANG_FORMAT_STYLE',
                                      description: [
                                        'Coding style, currently supports:',
                                        'LLVM, Google, Chromium, Mozilla, WebKit.',
                                        'Use style:file to load style configuration from',
                                        '.clang-format file located in one of the parent',
                                        'directories of the source file (or current',
                                        'directory for stdin).',
                                        'Use style:"{key: value, ...}" to set specific',
                                        'parameters, e.g.:',
                                        'style:"{BasedOnStyle: llvm, IndentWidth: 8}"'
                                      ].join(' '),
                                      optional: true,
                                      default_value: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                      env_name: 'FL_CLANG_FORMAT_VERBOSE',
                                      description: 'If true, shows the list of processed files',
                                      optional: true,
                                      default_value: false,
                                      type: Boolean),
          FastlaneCore::ConfigItem.new(key: :files,
                                      env_name: 'FL_CLANG_FORMAT_FILES',
                                      description: 'Array of files to check formatting',
                                      optional: false,
                                      type: Array)
        ]
      end

      def self.authors
        ["Marcin Stepnowski"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
