require 'fastlane'

module Fastlane
  module Actions
    class RunClangFormatAction < Action
      def self.run(params)
        script_path = params[:script_path]
        script_path ||= Dir['run-clang-format.py'].first
        UI.user_error!('run-clang-format.py not found, add file or pass path to it') if script_path.to_s.empty?

        cmd = []
        cmd << script_path
        extensions = params[:extensions]
        cmd << "--extensions" if extensions
        cmd << extensions if extensions
        clang_format_executable = params[:executable]
        cmd << "--clang-format-executable" if clang_format_executable
        cmd << clang_format_executable if clang_format_executable
        cmd << '-r' if params[:recursive]
        paths = params[:paths]
        Array(paths).each do |path|
          cmd << path
        end
        Actions.sh(Shellwords.join(cmd))
        UI.success('Everything is formatted correctly, all good! 💪')
      end

      def self.description
        'Run clang format python script: https://github.com/Sarcasm/run-clang-format'
      end

      def self.details
        [
          'A wrapper script around clang-format, suitable for linting multiple files and',
          'to use for continuous integration. This is an alternative API for the clang-format',
          'command line. It runs over multiple files and directories in parallel.',
          'A diff output is produced and a sensible exit code is returned.'
        ].join(' ')
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :script_path,
                                       env_name: 'FL_RUN_CLANG_FORMAT_SCRIPT_PATH',
                                       description: 'Optional, you must specify the path to run-clang-format.py if it is not in the project root directory',
                                       optional: true,
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :extensions,
                                       env_name: 'FL_RUN_CLANG_FORMAT_EXTENSIONS',
                                       description: 'Comma separated list of file extensions (default: c,h,C,H,cpp,hpp,cc,hh,c++,h++,cxx,hxx)',
                                       optional: true,
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :recursive,
                                       env_name: 'FL_RUN_CLANG_FORMAT_RECURSIVE',
                                       description: 'Run recursively over directories',
                                       optional: true,
                                       default_value: true,
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :paths,
                                       env_name: 'FL_RUN_CLANG_FORMAT_PATHS',
                                       description: 'Array of path to check formatting',
                                       optional: false,
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :executable,
                                       env_name: 'FL_RUN_CLANG_FORMAT_EXECUTABLE',
                                       description: 'Path to the clang-format executable',
                                       optional: false,
                                       is_string: true)
        ]
      end

      def self.is_supported?(_platform)
        true
      end

      def self.authors
        ["Marcin Stepnowski"]
      end
    end
  end
end
