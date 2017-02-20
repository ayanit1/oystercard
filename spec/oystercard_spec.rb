require 'oystercard'

describe OysterCard do
  subject(:oystercard) {OysterCard.new}

  context '#balance' do
    it 'balance of zero' do
      expect(subject.balance).to eq 0
    end
  end

  context '.top_up' do
    it 'respond to top up with 1 argument' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'top up oystercard with 10' do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by 10
    end

    it 'raises error if new balance is more than 90' do
      expect{ subject.top_up(91) }.to raise_error 'Cannot top up, reached maximum limit of 90'
    end
  end
end
