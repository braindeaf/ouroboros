# frozen_string_literal: true

RSpec.describe Ouroboros::Array do
  it "has a version number" do
    expect(Ouroboros::VERSION).not_to be nil
  end
  
  subject(:array) { [1, 2, 3, 4, 5].to_ouroboros }
  
  describe '#at' do
    it 'returns the value at a position as if it were circular' do
      expect(array[0]).to eq(1)
      expect(array[5]).to eq(1)
      expect(array[1]).to eq(2)
      expect(array[6]).to eq(2)
      expect(array[-1]).to eq(5)
      expect(array[-6]).to eq(5)
    end
  end

  describe "#[]" do  
    context "#[index]" do
      it "returns value as if the array was circular" do
        expect(array[0]).to eq(1)
        expect(array[5]).to eq(1)
        expect(array[1]).to eq(2)
        expect(array[6]).to eq(2)
        expect(array[-1]).to eq(5)
        expect(array[-6]).to eq(5)
      end
    end

    context "#[start, length]" do
      it 'returns an Ouroboros::Array' do
        expect(array[0..1]).to be_an(Ouroboros::Array)
      end

      it "returns" do
        expect(array[0, 1]).to eq([1])
        expect(array[1, 6]).to eq([2, 3, 4, 5, 1, 2])
        expect(array[5, 6]).to eq([1, 2, 3, 4, 5, 1])
        expect(array[0, 4]).to eq([1, 2, 3, 4])
        expect(array[0, 5]).to eq([1, 2, 3, 4, 5])
        expect(array[5, 9]).to eq([1, 2, 3, 4, 5, 1, 2, 3, 4])
        expect(array[0, 10]).to eq([1, 2, 3, 4, 5, 1, 2, 3, 4, 5])
        expect(array[5, 10]).to eq([1, 2, 3, 4, 5, 1, 2, 3, 4, 5])
      end
    end

    context "#[range]" do
      it 'returns an Ouroboros::Array' do
        expect(array[0..1]).to be_an(Ouroboros::Array)
      end

      it "returns" do
        expect(array[0..1]).to eq([1, 2])
        expect(array[1..2]).to eq([2, 3])
        expect(array[2..3]).to eq([3, 4])
        expect(array[5..6]).to eq([1, 2])
        expect(array[0..4]).to eq([1, 2, 3, 4, 5])
        expect(array[0..5]).to eq([1, 2, 3, 4, 5, 1])
        expect(array[5..9]).to eq([1, 2, 3, 4, 5])
        expect(array[0..10]).to eq([1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1])
        expect(array[5..10]).to eq([1, 2, 3, 4, 5, 1])
      end
    end
  end

  describe '#method_missing' do
    it 'proxies all remaining method calls on the array object' do
      expect(array.rotate(2)).to eq([3, 4, 5, 1, 2])
    end
  end
end
