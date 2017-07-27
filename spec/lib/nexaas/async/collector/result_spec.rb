require "rails_helper"

describe Nexaas::Async::Collector::Result do
  let!(:file) { IO.binread("spec/fixtures/attachments/image.jpeg") }
  let(:not_ready_opts) {
    {
      collect_id: 'foo-not-ready',
      scope_id: 1892, content: nil
    }
  }
  let(:ready_opts) {
    {
      collect_id: 'foo-ready', scope_id: 1893,
      content: Base64.encode64('<html></html>')
    }
  }

  let(:file_opts) {
    {
      collect_id: 'file-data', scope_id: 1893, content: file,
      file: {
        content_type: 'text/html',
        name: 'index',
        extension: 'html'
      }
    }
  }

  before do
    Nexaas::Async::Collector::Persist.save(ready_opts)
    Nexaas::Async::Collector::Persist.save(not_ready_opts)
    Nexaas::Async::Collector::Persist.save(file_opts)
  end

  describe "#content_is_ready?" do
    context "when content is ready" do
      context "when scope_id is correctly" do
        subject { described_class.new(1893, 'foo-ready') }

        it { expect(subject.content_is_ready?).to be_truthy }
      end

      context "when scope_id is not correctly" do
        subject { described_class.new(1892, 'foo-ready') }

        it { expect(subject.content_is_ready?).to be_falsy }
      end
    end

    context "when content is not ready" do
      context "when scope_id is correctly" do
        subject { described_class.new(1892, 'foo-not-ready') }

        it { expect(subject.content_is_ready?).to be_falsy }
      end

      context "when scope_id is not correctly" do
        subject { described_class.new(1893, 'foo-not-ready') }

        it { expect(subject.content_is_ready?).to be_falsy }
      end
    end
  end

  describe "#content" do
    context "when content is ready" do
      context "when scope_id is correctly" do
        subject { described_class.new(1893, 'foo-ready') }

        it { expect(subject.content).to eq("PGh0bWw+PC9odG1sPg==\n") }

        context 'when content is binary' do
          subject { described_class.new(1893, 'file-data') }

          it 'does not scramble file data' do
            expect(subject.content).to eq(file)
          end
        end
      end

      context "when scope_id is not correctly" do
        subject { described_class.new(1892, 'foo-ready') }

        it { expect(subject.content).to be_nil }
      end
    end

    context "when content is not ready" do
      context "when scope_id is correctly" do
        subject { described_class.new(1892, 'foo-not-ready') }

        it { expect(subject.content).to be_nil }
      end

      context "when scope_id is not correctly" do
        subject { described_class.new(1893, 'foo-not-ready') }

        it { expect(subject.content).to be_nil }
      end
    end
  end

  describe "is_file?" do
    context "when data has file information" do
      subject { described_class.new(1893, 'file-data') }

      it { expect(subject.is_file?).to be_truthy }
    end

    context "when data does not have file information" do
      subject { described_class.new(1893, 'foo-not-ready') }

      it { expect(subject.is_file?).to be_falsy }
    end

    context "when data does not exist" do
      subject { described_class.new(1894, '') }

      it { expect(subject.is_file?).to be_falsy }
    end
  end

  describe "#filename" do
    context "when data has file information" do
      subject { described_class.new(1893, 'file-data') }

      it { expect(subject.filename).to eq('index') }
    end

    context "when data does not have file information" do
      subject { described_class.new(1893, 'foo-not-ready') }

      it { expect(subject.filename).to be_nil }
    end

    context "when data does not exist" do
      subject { described_class.new(1894, '') }

      it { expect(subject.filename).to be_nil }
    end
  end

  describe "#extension" do
    context "when data has file information" do
      subject { described_class.new(1893, 'file-data') }

      it { expect(subject.extension).to eq('html') }
    end

    context "when data does not have file information" do
      subject { described_class.new(1893, 'foo-not-ready') }

      it { expect(subject.extension).to be_nil }
    end

    context "when data does not exist" do
      subject { described_class.new(1894, '') }

      it { expect(subject.extension).to be_nil }
    end
  end

  describe "#content_type" do
    context "when data has file information" do
      subject { described_class.new(1893, 'file-data') }

      it { expect(subject.content_type).to eq('text/html') }
    end

    context "when data does not have file information" do
      subject { described_class.new(1893, 'foo-not-ready') }

      it { expect(subject.content_type).to be_nil }
    end

    context "when data does not exist" do
      subject { described_class.new(1894, '') }

      it { expect(subject.content_type).to be_nil }
    end
  end
end
