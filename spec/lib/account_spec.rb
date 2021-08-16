# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/account'

RSpec.describe Account do
  context 'constants' do
    it 'CATEGORIES: is a hash with categories' do
      categories = {
        habitation: 1,
        supermarket: 2,
        transportation: 3,
        credit_card: 4,
        pet: 5,
        health: 6,
        investments: 7,
        'phone and internet': 8,
        recreation: 9,
        eletronics: 10,
        personal: 11,
        gas: 12,
        delivery: 13
      }

      expect(described_class::CATEGORIES.is_a?(Hash)).to eq true
      expect(described_class::CATEGORIES).to eq categories
    end
  end

  context 'categories table' do
    it 'has a categories table' do
      table = <<-MESSAGE
      +---------------------------+
      |        Categories         |
      +--------+------------------+
      |Category|Code              |
      +--------+------------------+
      |1       |habitation        |
      |2       |supermarket       |
      |3       |transportation    |
      |4       |credit_card       |
      |5       |pet               |
      |6       |health            |
      |7       |investments       |
      |8       |phone and internet|
      |9       |recreation        |
      |10      |eletronics        |
      |11      |personal          |
      |12      |gas               |
      |13      |delivery          |
      +--------+------------------+
      MESSAGE
      account = Account.new
      expect(account.categories_table).to eq(puts table)
    end
  end
end
