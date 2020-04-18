classdef SftpFileAttrs < handle
  
  properties (SetAccess = private, Hidden = true)
    % The underlying com.jcraft.jsch.SftpATTRS Java object
    j
  end
  properties (Dependent)
    flags
    size
    type
    uid
    gid
    permissions
    atime
    mtime
    extendedCount
    extendedData
  end
  
  methods
    
    function this = SftpFileAttrs(jSftpFileAttrs)
      if nargin == 0
        return
      end
      msch.internal.mustBeA(jSftpFileAttrs, 'com.jcraft.jsch.SftpATTRS');
      this.j = jSftpFileAttrs;
    end
    
    function out = get.atime(this)
      out = posixtime2datetime(this.j.getATime);
    end
    
    function set.atime(this, atime)
      newPosixTime = settimearg2posixtime(atime);
      this.j.setACMODTIME(newPosixTime, this.j.getMTime);
    end
    
    function out = get.mtime(this)
      out = posixtime2datetime(this.j.getMTime);
    end
    
    function set.mtime(this, mtime)
      newPosixTime = settimearg2posixtime(mtime);
      this.j.setACMODTIME(this.j.getATime, newPosixTime);
    end
    
    function out = get.extendedData(this)
      out = string(this.j.getExtended);
    end
    
    function out = get.flags(this)
      out = this.j.getFlags;
    end
    
    function out = get.gid(this)
      out = this.j.getGId;
    end
    
    function set.gid(this, gid)
      this.j.setUIDGID(this.uid, gid);
    end
    
    function out = get.permissions(this)
      out = this.j.getPermissions;
    end
    
    function set.permissions(this, permissions)
      this.j.setPERMISSIONS(permissions);
    end
    
    function out = get.size(this)
      % TODO: Should we convert this to double? How about UID and GUID?
      out = this.j.getSize;
    end
    
    function set.size(this, size)
      % TODO: Warn about possible loss of precision when caller passes in a
      % large value as double?
      this.j.setSIZE(size);
    end
    
    function out = get.uid(this)
      out = this.j.getUId;
    end
    
    function set.uid(this, uid)
      this.j.setUIDGID(uid, this.gid);
    end
    
    function out = get.type(this)
      if this.j.isBlk
        out = msch.SftpFileType.Block;
      elseif this.j.isChr
        out = msch.SftpFileType.Character;
      elseif this.j.isDir
        out = msch.SftpFileType.Directory;
      elseif this.j.isFifo
        out = msch.SftpFileType.Fifo;
      elseif this.j.isLink
        out = msch.SftpFileType.Link;
      elseif this.j.isReg
        out = msch.SftpFileType.Regular;
      elseif this.j.isSoc
        out = msch.SftpFileType.Socket;
      else
        out = msch.SftpFileType.Unknown;
      end
    end
    
  end
  
end

function out = settimearg2posixtime(time)
if ischar(time) || isstring(time)
  time = datetime(time);
end
if isa(time, 'datetime')
  out = round(posixtime(time));
else
  out = atime;
end
end

function out = posixtime2datetime(posixTime)
if isempty(posixTime)
  out = datetime(missing);
else
  out = datetime(posixTime, 'ConvertFrom','posixtime');
end
end