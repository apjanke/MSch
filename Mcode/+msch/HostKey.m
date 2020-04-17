classdef HostKey < handle
  
  properties (SetAccess = private, Hidden = true)
    j
  end
  properties (Dependent)
    % The host or hosts this key is for. Always a single string, but may contain
    % a comma-separated list that represents multiple hosts.
    host
    key
    fingerprint
    comment
    marker
    type
  end
  
  methods (Static)
    
    function out = of(host, key, type, comment, marker)
      % Create a new HostKey object from data
      %
      % obj = msch.HostKey.of(host, key)
      % obj = msch.HostKey.of(host, key, type)
      % obj = msch.HostKey.of(host, key, type, comment)
      % obj = msch.HostKey.of(host, key, type, comment, marker)
      %
      % Host (string) is the host name.
      %
      % Key (int8 or uint8 vector) is the key data.
      %
      % Type (double) is the JSch constant for the type of key. If type is
      % omitted, the type is guessed based on the data in key. The type of this
      % parameter is going to change to something better than double soon.
      %
      % Comment (string) is an optional comment.
      %
      % Marker (string) is used internally by JSch; I don't know what it does.
      % Defaults to "".
      
      host = string(host);
      mustBeScalar(host);
      if nargin < 3 || isempty(type)
        % 0 is the undocumented JSch constant for GUESS, which is the default
        % behavior when type is not specified.
        type = 0;
      end
      if nargin < 4; comment = []; end
      if nargin < 5 || isempty(marker); marker = ""; end
      jHostKey = com.jcraft.jsch.HostKey(marker, host, type, key, comment);
      out = msch.HostKey(jHostKey);
    end
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
      % JSch's getFingerPrint takes a JSch, but that's only used for looking up
      % the md5 algorithm implementation, and since it's only being used for a
      % fingerprint here, we should be fine using the default. This lets us
      % avoid having to carry an MSch reference around in the HostKey object.
      out = string(this.j.getFingerPrint(com.jcraft.jsch.JSch));
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