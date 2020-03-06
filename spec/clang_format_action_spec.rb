describe Fastlane::Actions::ClangFormatAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The clang_format plugin is working!")

      Fastlane::Actions::ClangFormatAction.run(nil)
    end
  end
end
