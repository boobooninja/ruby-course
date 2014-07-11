require 'spec_helper'

describe DoubleDog::SignIn do
  describe 'validation' do
    before(:each) do
      @use_case = DoubleDog::SignIn.new
      @args     = {username: 'valid_username', password: 'valid_password'}
      @user     = DoubleDog.db.create_user(@args)
    end

    let(:result) { @use_case.run(@args) }

    it "requires a non-nil username" do
      @args = {username: nil}

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:nil_username)
    end

    it "requires a non-blank username" do
      @args = {username: ''}

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:blank_username)
    end

    it "it requires a non-nil password" do
      @args = {username: 'username', password: nil}

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:nil_password)
    end

    it "it requires a non-blank password" do
      @args = {username: 'username', password: ''}

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:blank_password)
    end

    it "requires the username to exist" do
      @args = {username: 'invalid', password: 'password'}

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:no_such_user)
    end

    it "requires a valid password and username combination" do
      @args = {username: @user.username, password: 'invalid'}

      expect(result[:success?]).to eq(false)
      expect(result[:error]).to eq(:invalid_password)
    end

    it "creates a sessions for the user" do
      @args = {username: @user.username, password: 'valid_password'}

      expect(result[:success?]).to eq(true)
      expect(result[:session_id]).to_not be_nil
    end

    it "retrieves a user from the created session" do
      @args = {username: @user.username, password: 'valid_password'}

      expect(result[:success?]).to eq(true)

      user = result[:user]
      expect(user.username).to eq(@user.username)
    end

  end
end
