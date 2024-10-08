describe RailsExam do
  describe "datadog gem result" do
    let(:files) { {"Gemfile" => gemfile_data} }
    let(:project) { double(:project, files: files) }

    context "when the gemfile data is nil" do
      let(:gemfile_data) { nil }

      it "returns nil" do
        exam = RailsExam.new(project)
        datadog_gem = exam.results[:datadog_gem]
        expect(datadog_gem).to eq nil
      end
    end

    context "when the gemfile data is an empty string" do
      let(:gemfile_data) { "" }

      it "returns nil" do
        exam = RailsExam.new(project)
        datadog_gem = exam.results[:datadog_gem]
        expect(datadog_gem).to eq nil
      end
    end

    context "when the gemfile data has no datadog gem" do
      let(:gemfile_data) { 'gem "gris"' }

      it "returns nil" do
        exam = RailsExam.new(project)
        datadog_gem = exam.results[:datadog_gem]
        expect(datadog_gem).to eq nil
      end
    end

    context "when the gemfile data has the ddtrace gem" do
      let(:gemfile_data) { 'gem "ddtrace"' }

      it "returns ddtrace" do
        exam = RailsExam.new(project)
        datadog_gem = exam.results[:datadog_gem]
        expect(datadog_gem).to eq "ddtrace"
      end
    end

    context "when the gemfile data has the datadog gem" do
      let(:gemfile_data) { 'gem "datadog"' }

      it "returns datadog" do
        exam = RailsExam.new(project)
        datadog_gem = exam.results[:datadog_gem]
        expect(datadog_gem).to eq "datadog"
      end
    end
  end

  describe "framework defaults result" do
    let(:files) { {"config/application.rb" => config_application_data} }
    let(:project) { double(:project, files: files) }

    context "when the config application data is nil" do
      let(:config_application_data) { nil }

      it "returns nil" do
        exam = RailsExam.new(project)
        framework_defaults = exam.results[:framework_defaults]
        expect(framework_defaults).to eq nil
      end
    end

    context "when the config application data is an emtpy string" do
      let(:config_application_data) { "" }

      it "returns nil" do
        exam = RailsExam.new(project)
        framework_defaults = exam.results[:framework_defaults]
        expect(framework_defaults).to eq nil
      end
    end

    context "when the config application data has no framework defaults" do
      let(:config_application_data) { 'require "rails/all"' }

      it "returns nil" do
        exam = RailsExam.new(project)
        framework_defaults = exam.results[:framework_defaults]
        expect(framework_defaults).to eq nil
      end
    end

    context "when the config application data has framework defaults" do
      let(:config_application_data) { "config.load_defaults 7.1" }

      it "returns that framework defaults value" do
        exam = RailsExam.new(project)
        framework_defaults = exam.results[:framework_defaults]
        expect(framework_defaults).to eq "7.1"
      end
    end

    context "when the config application data has framework defaults as a string" do
      let(:config_application_data) { 'config.load_defaults "7.1"' }

      it "returns that framework defaults value" do
        exam = RailsExam.new(project)
        framework_defaults = exam.results[:framework_defaults]
        expect(framework_defaults).to eq "7.1"
      end
    end
  end

  describe "kinetic version result" do
    let(:files) { {"Gemfile.lock" => gemfile_lock_data} }
    let(:project) { double(:project, files: files) }

    context "when the gemfile lock data is nil" do
      let(:gemfile_lock_data) { nil }

      it "returns nil" do
        exam = RailsExam.new(project)
        kinetic_version = exam.results[:kinetic_version]
        expect(kinetic_version).to eq nil
      end
    end

    context "when the gemfile lock data is an emtpy string" do
      let(:gemfile_lock_data) { "" }

      it "returns nil" do
        exam = RailsExam.new(project)
        kinetic_version = exam.results[:kinetic_version]
        expect(kinetic_version).to eq nil
      end
    end

    context "when the gemfile lock data has no kinetic version" do
      let(:gemfile_lock_data) { "rails (6.1.7.8)" }

      it "returns nil" do
        exam = RailsExam.new(project)
        kinetic_version = exam.results[:kinetic_version]
        expect(kinetic_version).to eq nil
      end
    end

    context "when the gemfile lock data has a kinetic version" do
      let(:gemfile_lock_data) do
        "remote: https://github.com/artsy/kinetic.git\nrevision: 33e2d6e4d59a3629040c7de76a866d23a37b8e72"
      end

      it "returns that kinetic version" do
        exam = RailsExam.new(project)
        kinetic_version = exam.results[:kinetic_version]
        expect(kinetic_version).to eq "33e2d6e"
      end
    end

    context "when the gemfile lock data has kinetic and watt versions" do
      let(:gemfile_lock_data) do
        <<-EOF
          remote: https://github.com/artsy/kinetic.git
          revision: 33e2d6e4d59a3629040c7de76a866d23a37b8e72
          remote: https://github.com/artsy/watt.git
          revision: cd86646e71a4557f962b06f04513c8b1dcc29968
        EOF
      end

      it "returns that kinetic version" do
        exam = RailsExam.new(project)
        kinetic_version = exam.results[:kinetic_version]
        expect(kinetic_version).to eq "33e2d6e"
      end
    end
  end

  describe "rails version result" do
    let(:files) { {"Gemfile" => gemfile_data} }
    let(:project) { double(:project, files: files) }

    context "when Gemfile data is nil" do
      let(:gemfile_data) { nil }

      it "returns nil for rails version" do
        exam = RailsExam.new(project)
        rails_version = exam.results[:rails_version]
        expect(rails_version).to eq nil
      end
    end

    context "when Gemfile data is an empty string" do
      let(:gemfile_data) { "" }

      it "returns nil for rails version" do
        exam = RailsExam.new(project)
        rails_version = exam.results[:rails_version]
        expect(rails_version).to eq nil
      end
    end

    context "with Gemfile data that has no rails" do
      let(:gemfile_data) { 'gem "gris"' }

      it "returns nil for rails version" do
        exam = RailsExam.new(project)
        rails_version = exam.results[:rails_version]
        expect(rails_version).to eq nil
      end
    end

    context "with Gemfile data that has a rails" do
      let(:gemfile_data) { 'gem "rails", "7.1.2"' }

      it "returns that rails version" do
        exam = RailsExam.new(project)
        rails_version = exam.results[:rails_version]
        expect(rails_version).to eq "7.1.2"
      end
    end
  end

  describe "sentry gems result" do
    let(:files) { {"Gemfile" => gemfile_data} }
    let(:project) { double(:project, files: files) }

    context "when the gemfile data is nil" do
      let(:gemfile_data) { nil }

      it "returns nil" do
        exam = RailsExam.new(project)
        sentry_gems = exam.results[:sentry_gems]
        expect(sentry_gems).to eq nil
      end
    end

    context "when the gemfile data is an empty string" do
      let(:gemfile_data) { nil }

      it "returns nil" do
        exam = RailsExam.new(project)
        sentry_gems = exam.results[:sentry_gems]
        expect(sentry_gems).to eq nil
      end
    end

    context "when the gemfile data has no sentry gems" do
      let(:gemfile_data) { 'gem "gris"' }

      it "returns nil" do
        exam = RailsExam.new(project)
        sentry_gems = exam.results[:sentry_gems]
        expect(sentry_gems).to eq nil
      end
    end

    context "when the gemfile data has a sentry gem" do
      let(:gemfile_data) { 'gem "sentry-ruby"' }

      it "returns that sentry gem name" do
        exam = RailsExam.new(project)
        sentry_gems = exam.results[:sentry_gems]
        expect(sentry_gems).to eq "sentry-ruby"
      end
    end

    context "when the gemfile data has a few sentry gems" do
      let(:gemfile_data) do
        <<-EOF
          gem "sentry-ruby"
          gem "sentry-rails"
          gem "sentry-sidekiq"
        EOF
      end

      it "returns those sentry gems joined with a pipe" do
        exam = RailsExam.new(project)
        sentry_gems = exam.results[:sentry_gems]
        expect(sentry_gems).to eq "sentry-ruby|sentry-rails|sentry-sidekiq"
      end
    end
  end

  describe "watt version result" do
    let(:files) { {"Gemfile.lock" => gemfile_lock_data} }
    let(:project) { double(:project, files: files) }

    context "when the gemfile lock data is nil" do
      let(:gemfile_lock_data) { nil }

      it "returns nil" do
        exam = RailsExam.new(project)
        watt_version = exam.results[:watt_version]
        expect(watt_version).to eq nil
      end
    end

    context "when the gemfile lock data is an emtpy string" do
      let(:gemfile_lock_data) { "" }

      it "returns nil" do
        exam = RailsExam.new(project)
        watt_version = exam.results[:watt_version]
        expect(watt_version).to eq nil
      end
    end

    context "when the gemfile lock data has no watt version" do
      let(:gemfile_lock_data) { "rails (6.1.7.8)" }

      it "returns nil" do
        exam = RailsExam.new(project)
        watt_version = exam.results[:watt_version]
        expect(watt_version).to eq nil
      end
    end

    context "when the gemfile lock data has a watt version" do
      let(:gemfile_lock_data) do
        "remote: https://github.com/artsy/watt.git\nrevision: cd86646e71a4557f962b06f04513c8b1dcc29968"
      end

      it "returns that watt version" do
        exam = RailsExam.new(project)
        watt_version = exam.results[:watt_version]
        expect(watt_version).to eq "cd86646"
      end
    end

    context "when the gemfile lock data has kinetic and watt versions" do
      let(:gemfile_lock_data) do
        <<-EOF
          remote: https://github.com/artsy/kinetic.git
          revision: 33e2d6e4d59a3629040c7de76a866d23a37b8e72
          remote: https://github.com/artsy/watt.git
          revision: cd86646e71a4557f962b06f04513c8b1dcc29968
        EOF
      end

      it "returns that watt version" do
        exam = RailsExam.new(project)
        watt_version = exam.results[:watt_version]
        expect(watt_version).to eq "cd86646"
      end
    end
  end
end
