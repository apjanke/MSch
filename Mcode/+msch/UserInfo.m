classdef UserInfo < handle
  
  properties (SetAccess = private, Hidden)
    j
  end
  
  methods
    
    function this = UserInfo(jUserInfo)
      if nargin == 0
        return
      end
      msch.internal.mustBeA(jUserInfo, 'com.jcraft.jsch.UserInfo');
      this.j = jUserInfo;
    end
    
    function out = promptPassphrase(message)
      out = this.j.promptPassphrase(message);
    end
    
    function out = promptPassword(message)
      out = this.j.promptPassword(message);
    end
    
    function out = promptYesNo(message)
      out = this.j.promptYesNo(message);
    end
    
    function showMessage(message)
      this.j.showMessage(message);
    end
    
    function out = getPassphrase(this)
      out = string(this.j.getPassphrase);
    end
    
    function out = getPassword(this)
      out = string(this.j.getPassword);
    end
    
  end
  
end