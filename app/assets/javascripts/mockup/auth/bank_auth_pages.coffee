@AuthBankSignInPage = React.createClass
  render: ->
    <div className='auth-bank-sign-in-page'>
      <div className='ui container'>
        <div className='ui grid'>
          <div className='row'>
            <div className='six wide column' />
            <div className='eight wide column product-logo'>
              <div className='logo-img' />
            </div>
          </div>

          <div className='six wide column'>
            <div className='customer-logo' />
          </div>
          <div className='eight wide column'>
            <div className='ui segment'>
              <div className='head'>
                <i className='icon sign in' />
                <span className='sign-in link'>用户登录</span>
              </div>
              <SignInForm submit_url={'/mockup/auth/do_sign_in'} jump={'/mockup/bank_home'} />
            </div>
          </div>
        </div>
      </div>
    </div>