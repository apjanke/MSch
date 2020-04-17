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
    
  end
  
end