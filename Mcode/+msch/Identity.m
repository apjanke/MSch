classdef Identity < handle
  
  properties (SetAccess = private, Hidden = true)
    j
  end
  properties (Dependent)
    name
    algorithmName
    isEncrypted
  end
  
  methods
    
    function this = Identity(jIdentityRepository)
      if nargin == 0
        return
      end
      mustBeA(jIdentityRepository, 'com.jcraft.jsch.IdentityRepository');
      this.j = jIdentityRepository;
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
      out = uint8(this.j.getSignature(data);
    end
    
    function out = setPassphrase(this, passphrase)
      out = this.j.setPassphrase(passphrase);
    end
    
    function clear(this)
      this.j.clear;
    end
    
  end
  
end