classdef HostKeyStatus
  % HostKeyStatus the status of a host key in a HostKeyRepository
  
  enumeration
    CHANGED(com.jcraft.jsch.HostKeyRepository.CHANGED)
    NOT_INCLUDED(com.jcraft.jsch.HostKeyRepository.NOT_INCLUDED)
    OK(com.jcraft.jsch.HostKeyRepository.OK)
  end
  
  properties
    code (1,1) double = 0
  end
  
  methods (Static)
    
    function out = ofJavaCode(code)
      switch code
        case com.jcraft.jsch.HostKeyRepository.CHANGED
          out = msch.HostKeyStatus.CHANGED;
        case com.jcraft.jsch.HostKeyRepository.NOT_INCLUDED
          out = msch.HostKeyStatus.NOT_INCLUDED;
        case com.jcraft.jsch.HostKeyRepository.OK
          out = msch.HostKeyStatus.OK;
        otherwise
          error('Invalid Java code for HostKeyStatus: %d', code);
      end
    end
    
  end
  
  methods
    
    function this = HostKeyStatus(code)
      if nargin == 0
        return
      end
      this.code = code;
    end
    
  end
  
end