classdef Identity < handle
  
  properties (SetAccess = private, Hidden = true)
    % The underlying com.jcraft.jsch.Identity Java object
    j
  end
  properties (Dependent)
    name
    algorithmName
    isEncrypted
  end
  
  methods
    
    function this = Identity(jIdentity)
      if nargin == 0
        return
      end
      mustBeA(jIdentity, 'com.jcraft.jsch.Identity');
      this.j = jIdentity;
    end
    
    function out = get.name(this)
      out = string(this.j.getName);
    end
    
    function out = get.algorithmName(this)
      out = string(this.j.getAlgName);
    end
    
    function out = get.isEncrypted(this)
      out = this.j.isEncrypted;
    end
    
    function out = getPublicKeyBlob(this)
      out = uint8(this.j.getPublicKeyBlob);
    end
    
    function out = sign(this, data)
      out = uint8(this.j.getSignature(data));
    end
    
    function out = setPassphrase(this, passphrase)
      out = this.j.setPassphrase(passphrase);
    end
    
    function clear(this)
      this.j.clear;
    end
    
  end
  
end