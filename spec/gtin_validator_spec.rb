require 'spec_helper'

describe GtinValidator do
  it 'has a version number' do
    expect(GtinValidator::VERSION).not_to be nil
  end

  describe '#valid_gtin?' do
    it 'correct GTIN-14 should be true' do
      expect(GtinValidator.valid_gtin? "00012345600012".to_i).to be_truthy
    end
    it 'correct GTIN-13 should be true' do
      expect(GtinValidator.valid_gtin? "0123456789012".to_i).to be_truthy
    end
    it 'correct GTIN-12 should be true' do
      expect(GtinValidator.valid_gtin? "012345678905".to_i).to be_truthy
    end
    it 'correct GTIN-8 should be true' do
      expect(GtinValidator.valid_gtin? "96385074".to_i).to be_truthy
    end
    it 'random numbers (invalid GTIN) should be false' do
      expect(GtinValidator.valid_gtin? "123456".to_i).to be_falsey
    end
  end

  describe '#calculate_checkdigit' do
    it 'whit correct string should see checkdigit' do
      expect(GtinValidator.calculate_checkdigit "0001234560001".to_i).to eq(2)
      expect(GtinValidator.calculate_checkdigit "012345678901".to_i).to eq(2)
      expect(GtinValidator.calculate_checkdigit "01234567890".to_i).to eq(5)
      expect(GtinValidator.calculate_checkdigit "9505000".to_i).to eq(3)
    end

    it 'whit incorrect string should see false' do
      expect(GtinValidator.calculate_checkdigit "01234567".to_i).to be_falsey
      expect(GtinValidator.calculate_checkdigit "012".to_i).to be_falsey
    end
  end

  describe '#what_gtin_is?' do
    describe 'GTIN-8' do
      it 'valid' do
        expect(GtinValidator.what_gtin_is? "95050003".to_i).to eq("GTIN-8")
      end
      it 'invalid' do
        expect(GtinValidator.what_gtin_is? "01234567".to_i).to be_falsey
      end
    end
    describe 'GTIN-12' do
      it 'valid' do
        expect(GtinValidator.what_gtin_is? "012345678905".to_i).to eq("GTIN-12")
      end
      it 'invalid' do
        expect(GtinValidator.what_gtin_is? "012345678901".to_i).to be_falsey
      end
    end
    describe 'GTIN-13' do
      it 'valid' do
        expect(GtinValidator.what_gtin_is? "0123456789012".to_i).to eq("GTIN-13")
      end
      it 'invalid' do
        expect(GtinValidator.what_gtin_is? "0123456789000".to_i).to be_falsey
      end
    end
    describe 'GTIN-14' do
      it 'valid' do
        expect(GtinValidator.what_gtin_is? "00012345600012".to_i).to eq("GTIN-14")
      end
      it 'invalid' do
        expect(GtinValidator.what_gtin_is? "00012345678901".to_i).to be_falsey
      end
    end
    describe 'without GTIN' do
      it 'should see false' do
        expect(GtinValidator.what_gtin_is? "01234".to_i).to be_falsey
      end
    end
  end

  describe '#gtin_8?' do
    it 'corect GTIN should be true' do
      expect(GtinValidator.gtin_8? "95050003").to be_truthy
    end

    it 'incorect GTIN should be false' do
      expect(GtinValidator.gtin_8? "01234567").to be_falsey
      expect(GtinValidator.gtin_8? "00012345600012").to be_falsey
    end

    it 'alias' do
      expect(GtinValidator.ean_8? "95050003").to be_truthy
      expect(GtinValidator.is_gtin_8? "95050003").to be_truthy
    end
  end

  describe '#gtin_12?' do
    it 'corect GTIN should be true' do
      expect(GtinValidator.gtin_12? "012345678905").to be_truthy
    end

    it 'incorect GTIN should be false' do
      expect(GtinValidator.gtin_12? "012345678900").to be_falsey
      expect(GtinValidator.gtin_12? "95050003").to be_falsey
    end

    it 'alias' do
      expect(GtinValidator.upc? "012345678905").to be_truthy
      expect(GtinValidator.is_upc? "012345678905").to be_truthy
      expect(GtinValidator.upc_12? "012345678905").to be_truthy
      expect(GtinValidator.is_gtin_12? "012345678905").to be_truthy
    end
  end

  describe '#gtin_13?' do
    it 'corect GTIN should be true' do
      expect(GtinValidator.gtin_13? "0123456789012").to be_truthy
    end

    it 'incorect GTIN should be false' do
      expect(GtinValidator.gtin_13? "0123456789001").to be_falsey
      expect(GtinValidator.gtin_13? "012345678905").to be_falsey
    end

    it 'alias' do
      expect(GtinValidator.ean? "0123456789012").to be_truthy
      expect(GtinValidator.is_ean? "0123456789012").to be_truthy
      expect(GtinValidator.ean_13? "0123456789012").to be_truthy
      expect(GtinValidator.is_gtin_13? "0123456789012").to be_truthy
    end
  end

  describe '#gtin_14?' do
    it 'corect GTIN should be true' do
      expect(GtinValidator.gtin_14? "00012345600012").to be_truthy
    end

    it 'incorect GTIN should be false' do
      expect(GtinValidator.gtin_14? "00012345600001").to be_falsey
      expect(GtinValidator.gtin_14? "0123456789012").to be_falsey
    end

    it 'alias' do
      expect(GtinValidator.is_gtin_14? "00012345600012").to be_truthy
    end
  end
end
