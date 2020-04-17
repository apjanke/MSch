classdef IdentityRepositoryStatus
  
  enumeration
    NOTRUNNING(com.jcraft.jsch.IdentityRepository.NOTRUNNING)
    RUNNING(com.jcraft.jsch.IdentityRepository.RUNNING)
    UNAVAILABLE(com.jcraft.jsch.IdentityRepository.UNAVAILABLE)
  end
  
  properties
    code (1,1) double
  end
  
  methods (Static)
    
    function out = ofJavaCode(code)
      switch code
        case com.jcraft.jsch.IdentityRepository.NOTRUNNING
          out = msch.IdentityRepositoryStatus.NOTRUNNING;
        case com.jcraft.jsch.IdentityRepository.RUNNING
          out = msch.IdentityRepositoryStatus.RUNNING;
        case com.jcraft.jsch.IdentityRepository.UNAVAILABLE
          out = msch.IdentityRepositoryStatus.UNAVAILABLE;
        otherwise
          error('Invalid Java code for HostKeyStatus: %d', code);
      end
    end
    
  end
  
  methods
    
    function this = IdentityRepositoryStatus(code)
      this.code = code;
    end
    
  end
  
end
      