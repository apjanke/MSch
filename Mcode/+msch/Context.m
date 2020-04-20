classdef Context < handle
  %Context Central configuration point and factory for MSch stuff
  %
  % An Context object is the context from which all MSch sessions and stuff are
  % made. It contains configuration, identity/authentication info, host keys,
  % and so on. It will be the first object you create when working with the MSch
  % library.
  
  properties (SetAccess = private, Hidden = true)
    % The underlying com.jcraft.jsch.JSch Java object
    j
  end
  properties (Constant)
    validConfigOptions = [
      "kex"
      "server_host_key"
      "cipher.c2s"
      "cipher.s2c"
      "mac.c2s"
      "mac.s2c"
      "compression.c2s"
      "compression.s2c"
      "lang.c2s"
      "lang.s2c"
      "diffie-hellman-group-exchange-sha1"
      "diffie-hellman-group1-sha1"
      "ecdh-sha2-nistp"
      "3des-cbc"
      "3des-ctr"
      "blowfish-cbc"
      "aes256-cbc"
      "aes192-cbc"
      "aes128-cbc"
      "aes128-ctr"
      "aes192-ctr"
      "aes256-ctr"
      "arcfour"
      "arcfour128"
      "arcfour256"
      "none"
      "hmac-sha1"
      "hmac-sha1-96"
      "hmac-md5"
      "hmac-md5-96"
      "zlib"
      "zlib@openssh.com"
      "userauth.none"
      "userauth.password"
      "userauth.keyboard-interactive"
      "userauth.publickey"
      "userauth.gssapi-with-mic"
      "gssapi-with-mic.krb5"
      "dh"
      "random"
      "signature.des"
      "signature.rsa"
      "signature.ecdsa"
      "signature.dsa"
      "signature.rsa"
      "pbkdf"
      "sha-1"
      "md5"
      "compression_level"
      "PreferredAuthentications"
      "StrictHostKeyChecking"
      "HashKnownHosts"
      "CheckCiphers"
      ];
  end
  
  methods
    
    function this = Context()
      % Construct a new object
      this.j = com.jcraft.jsch.JSch;
    end
    
    function out = createSession(this, host, username, port)
      %createSession Create a new session to a remote host
      %
      % out = obj.createSession(host, username, port)
      %
      % Host (string) is the name or address of the remote host to
      % connect to.
      %
      % Username (string) is the username to connect as. The default behavior
      % when username is omitted has not been determined yet, so for now, it is
      % required.
      %
      % If port is omitted, port 22 is used.
      
      if nargin < 4 || isempty(port); port = 22; end
      mustBeNumeric(port);
      msch.internal.mustBeStringy(host);
      msch.internal.mustBeStringy(username);
      host = string(host);
      username = string(username);
      msch.internal.mustBeScalar(host);
      msch.internal.mustBeScalar(username);
      
      jSession = this.j.getSession(username, host, port);
      out = msch.Session(jSession, this);
    end
    
    function out = getConfigOption(this, key)
      %getConfigOption Get a default configuration option
      %
      % out = obj.getConfigOption(key)
      %
      % Gets the value for the named default configuration option.
      %
      % Key (string) is the key (name) of the option to get the value of.
      %
      % Returns a scalar string, or empty if key is not a valid option.
      out = string(this.j.getConfig(key));
    end
    
    function setConfigOption(this, key, value)
      %setConfigOption Set a default configuration option
      %
      % obj.setConfigOption(key, value)
      %
      % Key (string) is the key (name) of the option to set the value of.
      %
      % Value (scalar string) is the value to set for the option.
      this.j.setConfig(key, value);
    end
    
    function out = dumpConfigOptions(this)
      names = this.validConfigOptions;
      n = numel(names);
      out = repmat(string(missing), [n 2]);
      for i = 1:n
        out(i,1) = names(i);
        val = this.getConfigOption(names(i));
        if ~isempty(val)
          out(i,2) = val;
        end
      end
      if nargout == 0
        disp(out);
        clear out
      end
    end
    
    function loadHostKeysFromKnownHosts(this, file)
      %loadHostKeysFromKnownHosts Load host keys from a known_hosts file
      if nargin < 2 || isempty(file)
        file = fullfile(getenv('HOME'), '.ssh', 'known_hosts');
      end
      this.j.setKnownHosts(file);
    end
    
  end
  
end