Rails.application.config.to_prepare { DataLoader.new.load_all! }
