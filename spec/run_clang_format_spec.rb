require 'fileutils'

describe Fastlane::Actions::RunClangFormatAction do
  describe 'Run clang format' do
    it 'should call run clang format with paths' do
      expect(Fastlane::Actions).to receive(:sh).with("path/run-clang-format.py source tests")

      Fastlane::Actions::RunClangFormatAction.run({
          script_path: "path/run-clang-format.py",
          paths: ["source", "tests"]
      })
    end

    it 'should call run clang format with -r' do
      expect(Fastlane::Actions).to receive(:sh).with("path/run-clang-format.py -r source tests")

      Fastlane::Actions::RunClangFormatAction.run({
          script_path: "path/run-clang-format.py",
          recursive: true,
          paths: ["source", "tests"]
      })
    end

    it 'should call run clang format with --extensions' do
      expect(Fastlane::Actions).to receive(:sh).with("path/run-clang-format.py --extensions h,m source tests")

      Fastlane::Actions::RunClangFormatAction.run({
          script_path: "path/run-clang-format.py",
          extensions: 'h,m',
          paths: ["source", "tests"]
      })
    end

    it 'should call run clang format with --clang_format_executable' do
      expect(Fastlane::Actions).to receive(:sh).with("path/run-clang-format.py --clang-format-executable path/clang-format source tests")

      Fastlane::Actions::RunClangFormatAction.run({
          script_path: "path/run-clang-format.py",
          executable: 'path/clang-format',
          paths: ["source", "tests"]
      })
    end

    it 'should call run clang format when run-clang-format.py is in directory and path is not specified' do
      File.new("run-clang-format.py", "w")
      expect(Fastlane::Actions).to receive(:sh).with("run-clang-format.py source tests")

      Fastlane::Actions::RunClangFormatAction.run({
          paths: ["source", "tests"]
      })

      File.delete("run-clang-format.py")
    end

    it 'should fail when there is no run-clang-format.py and path is not specified' do
      expect(Fastlane::UI).to receive(:user_error!).with("run-clang-format.py not found, add file or pass path to it")

      Fastlane::Actions::RunClangFormatAction.run({
          paths: ["source", "tests"]
      })
    end
  end
end
