describe Fastlane::Actions::ClangFormatAction do
  describe 'clang format' do
    it 'should call clang format' do
      expect(Fastlane::Actions).to receive(:sh).with("clang-format")

      Fastlane::Actions::ClangFormatAction.run({})
    end

    it 'should call clang format with -i' do
      expect(Fastlane::Actions).to receive(:sh).with("clang-format -i")

      Fastlane::Actions::ClangFormatAction.run({
        inplace: true
      })
    end

    it 'should call clang format with --verbose' do
      expect(Fastlane::Actions).to receive(:sh).with("clang-format --verbose")

      Fastlane::Actions::ClangFormatAction.run({
        verbose: true
      })
    end

    it 'should call clang format with --style' do
      expect(Fastlane::Actions).to receive(:sh).with("clang-format --style=file")

      Fastlane::Actions::ClangFormatAction.run({
        style: "file"
      })
    end

    it 'should call clang format with files' do
      expect(Fastlane::Actions).to receive(:sh).with("clang-format **.h **.m")

      Fastlane::Actions::ClangFormatAction.run({
        files: ["**.h", "**.m"]
      })
    end

    it 'should call clang format with files set from remaining arguments' do
      expect(Fastlane::Actions).to receive(:sh).with("clang-format -i --style=file --verbose **.h **.m")

      Fastlane::Actions::ClangFormatAction.run({
        inplace: true,
        verbose: true,
        style: "file",
        files: ["**.h", "**.m"]
      })
    end

    it 'should call path to clang format instead of clang-format' do
      expect(Fastlane::Actions).to receive(:sh).with("path/clang-format")

      Fastlane::Actions::ClangFormatAction.run({
        clang_format_path: "path/clang-format"
      })
    end

    it 'should call path to clang format instead of clang-format if provided as the first argument' do
      expect(Fastlane::Actions).to receive(:sh).with("path/clang-format -i --style=file --verbose **.h **.m")

      Fastlane::Actions::ClangFormatAction.run({
        clang_format_path: "path/clang-format",
        inplace: true,
        verbose: true,
        style: "file",
        files: ["**.h", "**.m"]
      })
    end
  end
end
