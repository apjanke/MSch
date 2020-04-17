classdef HostKeyRepository < handle
  
  properties (SetAccess = private, Hidden)
    j
  end
  
  methods
    
    function this = HostKeyRepository(jHostKeyRepository)
      if nargin == 0
        return
      end
      msch.internal.mustBeA(jHostKeyRepository, 'com.jcraft.jsch.HostKeyRepository');
      this.j = jHostKeyRepository;
    end
    
    function addHostKey(this, hostKey, userInfo)
      msch.internal.mustBeA(hostKey, 'msch.HostKey');
      msch.internal.mustBeA(userInfo, 'msch.UserInfo');
      this.j.add(hostKey.j, userInfo.j);
    end
    
    function out = check(this, host, key)
      code = this.j.check(host, key);
      out = msch.HostKeyStatus.ofJavaCode(code);
    end
    
    function out = getHostKeys(this, host, type)
      if nargin == 1
        jHostKeys = this.j.getHostKey;
      else
        jHostKeys = this.j.getHostKey(host, type);
      end
      n = numel(jHostKeys);
      out = repmat(msch.HostKey, [1 n]);
      for i = 1:n
        out(i) = msch.HostKey(jHostKeys(i-1));
      end
    end
    
    function out = getRepositoryId(this)
      out = string(this.j.getKnownHostsRepositoryID);
    end
    
    function remove(this, host, type, key)
      if nargin < 4
        this.j.remove(host, type);
      else
        this.j.remove(host, type, key);
      end
    end
    
  end
  
end