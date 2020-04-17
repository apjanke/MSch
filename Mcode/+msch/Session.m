classdef Session < handle
  
  properties (SetAccess = private, Hidden = true)
    j
    context
  end
  properties (Dependent = true)
    clientVersion
    host
    port
    serverAliveCountMax
    serverAliveInterval
    serverVersion
    timeout
    username
    isConnected
    hostKeyAlias
    hostKeyRepository
  end
  
  methods
    
    function this = Session(jSession, context)
      if nargin == 0
        return
      end
      msch.internal.mustBeA(jSession, 'com.jcraft.jsch.Session');
      msch.internal.mustBeA(context, 'msch.MSch');
      this.j = jSession;
      this.context = context;
    end
    
    function disp(this)
      if isempty(this.j)
        fprintf('msch.Session (null)');
      else
        fprintf('msch.Session: %s@%s (connected=%d)', ...
          this.username, this.host, this.isConnected);
      end
    end
    
    function disconnect(this)
      this.j.disconnect;
    end
    
    function delete(this)
      if ~isempty(this.j)
        if this.isConnected
          this.disconnect;
        end
      end
    end
    
    function out = get.clientVersion(this)
      out = string(this.j.getClientVersion);
    end
    
    function set.clientVersion(this, val)
      msch.internal.mustBeScalarString(val);
      this.j.setClientVersion(val);
    end
    
    function out = get.host(this)
      out = string(this.j.getHost);
    end
    
    function set.host(this, val)
      msch.internal.mustBeScalarString(val);
      this.j.setHost(val);
    end
    
    function out = get.port(this)
      out = this.j.getPort;
    end
    
    function set.port(this, val)
      msch.internal.mustBeScalarNumeric(val);
      this.j.setPort(val);
    end
    
    function out = get.serverAliveCountMax(this)
      out = this.j.getServerAliveCountMax;
    end
    
    function set.serverAliveCountMax(this, val)
      msch.internal.mustBeScalarNumeric(val);
      this.j.setServerAliveCountMax(val);
    end
    
    function out = get.serverAliveInterval(this)
      out = this.j.getServerAliveInterval;
    end
    
    function set.serverAliveInterval(this, val)
      msch.internal.mustBeScalarNumeric(val);
      this.j.setServerAliveInterval(val);
    end
    
    function out = get.serverVersion(this)
      out = string(this.j.getServerVersion);
    end
    
    function out = get.timeout(this)
      out = this.j.getTimeout;
    end
    
    function set.timeout(this, val)
      msch.internal.mustBeScalarNumeric(val);
      this.j.setTimeout(val);
    end
    
    function out = get.username(this)
      out = string(this.j.getUserName);
    end
    
    function out = get.isConnected(this)
      out = this.j.isConnected;
    end
    
    function out = get.hostKeyAlias(this)
      out = string(this.j.getHostKeyAlias);
    end
    
    function set.hostKeyAlias(this, val)
      this.j.setHostKeyAlias(val);
    end
    
    function out = get.hostKeyRepository(this)
      out = msch.HostKeyRepository(this.j.getHostKeyRepository);
    end
    
    function set.hostKeyRepository(this, repository)
      msch.internal.mustBeA(repository, 'msch.HostKeyRepository');
      this.j.setHostKeyRepository(repository.j);
    end
    
    function out = getConfigOption(this, key)
      out = string(this.j.getConfig(key));
    end
    
    function setConfigOption(this, key, value)
      this.j.setConfig(key, value);
    end
    
    function connect(this, connectTimeout)
      if nargin < 2 || isempty(connectTimeout)
        connectTimeout = this.timeout;
      end
      this.j.connect(connectTimeout);
    end
    
    function out = getHostKey(this)
      out = msch.HostKey(this.j.getHostKey);
    end
    
  end
  
end