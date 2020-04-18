classdef DumbUserInfo < handle
  
  properties (SetAccess = private, Hidden)
    j net.janke.msch.DumbUserInfo = net.janke.msch.DumbUserInfo
  end
  properties (Dependent)
    password
    passphrase
  end
    
  methods
    
    function this = DumbUserInfo(password, passphrase)
      if nargin >= 1
        this.j.setPassword(password);
      end
      if nargin >= 2
        this.j.setPassphrase(passphrase);
      end
    end
    
    function disp(this)
      if isscalar(this)
        if isempty(this.password)
          passwordDisp = '<missing>';
        else
          passwordDisp = '*****';
        end
        if isempty(this.passphrase)
          passphraseDisp = '<missing>';
        else
          passphraseDisp = '*****';
        end
        fprintf('%s: password=%s, passphrase=%s', class(this), ...
          passwordDisp, passphraseDisp);
      elseif isempty(this)
        fprintf('%s empty %s', size2str(size(this)), class(this));
      else
        fprintf('%s %s', size2str(size(this)), class(this));
      end
    end
    
    function out = get.passphrase(this)
      out = string(this.j.getPassphrase);
    end
    
    function set.passphrase(this, val)
      this.j.setPassphrase(val);
    end
    
    function out = get.password(this)
      out = string(this.j.getPassword);
    end
    
    function set.password(this, val)
      this.j.setPassword(val);
    end
    
  end
  
end