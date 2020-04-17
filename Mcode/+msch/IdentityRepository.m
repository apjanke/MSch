classdef IdentityRepository < handle
  
  properties (SetAccess = private, Hidden = true)
    j
  end
  properties (Dependent)
    name
    status
  end
  
  methods
    
    function this = IdentityRepository(jIdentityRepository)
      if nargin == 0
        return
      end
      msch.internal.mustBeA(jIdentityRepository, 'com.jcraft.jsch.IdentityRepository');
      this.j = jIdentityRepository;
    end
    
    function out = get.name(this)
      out = string(this.j.getName);
    end
    
    function out = get.status(this)
      out = msch.IdentityRepositoryStatus.ofJavaCode(this.j.getStatus);
    end
    
    function addIdentity(this, identity)
      this.j.add(identity);
    end
    
    function out = getIdentities(this)
      jvec = this.j.getIdentities;
      n = jvec.size;
      out = repmat(msch.Identity, [1 n]);
      for i = 1:n
        jIdentity = jvec.get(i-1);
        out(i) = msch.Identity(jIdentity);
      end
    end
    
    function removeIdentity(this, identity)
      this.j.remove(identity);
    end
    
    function removeAllIdentities(this)
      this.j.removeAll;
    end
    
  end
  
end