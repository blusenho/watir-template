describe 'My Feature' do

  before(:all) do
    @test_page = TestPage.new(@browser)
  end

  it 'should be able to test things' do
    expect(@test_page.test_object.present?).to be_falsey
  end

end
