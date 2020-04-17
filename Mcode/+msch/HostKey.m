classdef HostKey < handle
  
  properties (SetAccess = private, Hidden = true)
    j
  end
  properties (Dependent)
    host
    key
    fingerprint
    comment
    marker
    type
  end
  
  methods
    
    function this = HostKey(jHostKey)
      if nargin == 0
        return
      end
      msch.internal.mustBeA(jHostKey, 'com.jcraft.jsch.HostKey');
      this.j = jHostKey;
    end
    
    function out = get.host(this)
      out = string(this.j.getHost);
    end
    
    function out = get.key(this)
      out = string(this.j.getKey);
    end
    
    function out = get.fingerprint(this)
      out = '<UNIMPLEMENTED>';
    end
    
    function out = get.comment(this)
      out = string(this.j.getComment);
    end
    
    function out = get.marker(this)
      out = string(this.j.getMarker);
    end
    
    function out = get.type(this)
      out = string(this.j.getType);
    end
    
  end
  
end