classdef HostConfig < handle
  
  properties (SetAccess = private, Hidden = true)
    j
  end
  properties (Dependent)
    hostname
    port
    user
  end
  
  methods
    
    function this = HostConfig(jHostConfig)
      if nargin == 0
        return
      end
      mustBeA(jHostConfig, 'com.jcraft.jsch.ConfigRepository.Config');
      this.j = jHostConfig;
    end
    
    function out = get.hostname(this)
      out = string(this.j.getHostname);
    end
    
    function out = get.port(this)
      out = this.j.getPort;
    end
    
    function out = get.user(this)
      out = string(this.j.getUser);
    end
    
    function out = getValue(this, key)
      out = string(this.j.getValue(key));
    end
    
    function out = getValues(this, key)
      out = string(this.j.getValues(key));
    end
    
  end
  
end