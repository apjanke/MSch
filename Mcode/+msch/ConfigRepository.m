classdef ConfigRepository < handle
  
  properties (SetAccess = private, Hidden = true)
    j
  end
  properties (Dependent)
  end
  
  methods (Static)
    
    function out = getDefaultConfig()
      out = msch.ConfigRepository(com.jcraft.jsch.ConfigRepository.defaultConfig);
    end
    
    function out = getNullConfig()
      out = msch.ConfigRepository(com.jcraft.jsch.ConfigRepository.nullConfig);
    end
    
  end
    
  methods
    
    function this = ConfigRepository(jConfigRepository)
      if nargin == 0
        return
      end
      mustBeA(jConfigRepository, 'com.jcraft.jsch.ConfigRepository');
      this.j = jConfigRepository;
    end
    
    function out = getConfig(this, host)
      out = msch.HostConfig(this.j.getConfig(host));
    end
    
  end
  
end