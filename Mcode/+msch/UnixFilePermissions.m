classdef UnixFilePermissions
  
  properties
    bits (1,1) uint16 = uint16(0)
  end
  properties (Dependent)
    setuid
    setgid
    sticky
    userRead
    userWrite
    userExecute
    groupRead
    groupWrite
    groupExecute
    otherRead
    otherWrite
    otherExecute
  end
  
  methods
    
    function this = UnixFilePermissions(arg)
      if nargin == 0
        return
      end
      if ischar(arg) || iscellstr(arg) %#ok<ISCLSTR>
        arg = string(arg);
      end
      msch.internal.mustBeScalar(arg);
      if isnumeric(arg)
        if ~isa(arg, 'uint16')
          error('msch:InvalidInput', 'Numeric arguments to UnixFilePermissions() must be uint16');
        end
        this.bits = arg;
      elseif isstring(arg)
        this.bits = parseStringPermissions(arg);
      else
        error('msch:InvalidInput', 'Arguments must be uint16 or string; got a %s', class(arg));
      end
    end
    
    function disp(this)
      if isscalar(this)
        disp(this.symbolicStr);
      elseif isempty(this)
        fprintf('%s empty %s', size2str(size(this)), class(this));
      else
        fprintf('%s %s', size2str(size(this)), class(this));
      end
    end
    
    function out = get.setuid(this)
      out = logical(bitand(this.bits, 0b0000010000000000));
    end
    
    function this = set.setuid(this, val)
      this.bits = bitset(this.bits, 12, val);
    end
    
    function out = get.setgid(this)
      out = logical(bitand(this.bits, 0b0000001000000000));
    end
    
    function this = set.setgid(this, val)
      this.bits = bitset(this.bits, 11, val);
    end
    
    function out = get.sticky(this)
      out = logical(bitand(this.bits, 0b0000000100000000));
    end
    
    function this = set.sticky(this, val)
      this.bits = bitset(this.bits, 10, val);
    end
    
    function out = get.userRead(this)
      out = logical(bitand(this.bits, 0b0000000100000000));
    end
    
    function this = set.userRead(this, val)
      this.bits = bitset(this.bits, 9, val);
    end
    
    function out = get.userWrite(this)
      out = logical(bitand(this.bits, 0b0000000010000000));
    end
    
    function this = set.userWrite(this, val)
      this.bits = bitset(this.bits, 8, val);
    end
    
    function out = get.userExecute(this)
      out = logical(bitand(this.bits, 0b0000000001000000));
    end
    
    function this = set.userExecute(this, val)
      this.bits = bitset(this.bits, 7, val);
    end
    
    function out = get.groupRead(this)
      out = logical(bitand(this.bits, 0b0000000000100000));
    end
    
    function this = set.groupRead(this, val)
      this.bits = bitset(this.bits, 6, val);
    end
    
    function out = get.groupWrite(this)
      out = logical(bitand(this.bits, 0b0000000000010000));
    end
    
    function this = set.groupWrite(this, val)
      this.bits = bitset(this.bits, 5, val);
    end
    
    function out = get.groupExecute(this)
      out = logical(bitand(this.bits, 0b0000000000001000));
    end
    
    function this = set.groupExecute(this, val)
      this.bits = bitset(this.bits, 4, val);
    end
    
    function out = get.otherRead(this)
      out = logical(bitand(this.bits, 0b0000000000000100));
    end
    
    function this = set.otherRead(this, val)
      this.bits = bitset(this.bits, 3, val);
    end
    
    function out = get.otherWrite(this)
      out = logical(bitand(this.bits, 0b0000000000000010));
    end
    
    function this = set.otherWrite(this, val)
      this.bits = bitset(this.bits, 2, val);
    end
    
    function out = get.otherExecute(this)
      out = logical(bitand(this.bits, 0b0000000000000001));
    end
    
    function this = set.otherExecute(this, val)
      this.bits = bitset(this.bits, 1, val);
    end
    
    function out = symbolicStr(this)
      s = repmat('-', [1 10]);
      if this.userRead; s(2) = 'r'; end
      if this.userWrite; s(3) = 'w'; end
      if this.userExecute
        if this.setuid; s(4) = 's'; else; s(4) = 'x'; end
      else
        if this.setuid; s(4) = 'S'; end
      end
      if this.groupRead; s(5) = 'r'; end
      if this.groupWrite; s(6) = 'w'; end
      if this.groupExecute
        if this.setgid; s(7) = 's'; else; s(7) = 'x'; end
      else
        if this.setgid; s(7) = 'S'; end
      end
      if this.otherRead; s(8) = 'r'; end
      if this.otherWrite; s(9) = 'w'; end
      if this.otherExecute
        if this.sticky; s(10) = 't'; else; s(10) = 'x'; end
      else
        if this.sticky; s(10) = 'T'; end
      end
      out = string(s);
    end
    
  end
  
end

function out = parseStringPermissions(str)
if regexp(str, '^x[01234567]?[01234567]{3}$')
  out = parseNumericNotation(str);
elseif regexp(str, '^[-dc]?([-r][-w][-xstST]){3}')
  out = parseSymbolicNotation(str);
else
  error('Invalid format for string file permissions: "%s"', str);
end
end

function out = parseNumericNotation(str)
s = char(str);
digits = uint16(cellfun(@str2double, num2cell(s)));
if numel(digits) == 4
  hiNibble = digits(1);
  digits = digits(2:end);
else
  hiNibble = 0;
end

out = (hiNibble * 2^9) + (digits(1) * 2^6) + (digits(2) * 2^3) + digits(1);
end

function out = parseSymbolicNotation(str)
s = char(str);
perms = msch.UnixFilePermissions;
% Ignore the first character; that's a file type indicator and
% not about permissions.
if s(2) == 'r';  perms.userRead = true;  end
if s(3) == 'w';  perms.userWrite = true;  end
if s(4) == 'x'
  perms.userExecute = true;
elseif s(4) == 's'
  perms.userExecute = true;
  perms.setuid = true;
elseif s(4) == 'S'
  perms.setuid = true;
end
if s(5) == 'r';  perms.userRead = true;  end
if s(6) == 'w';  perms.userWrite = true;  end
if s(7) == 'x'
  perms.userExecute = true;
elseif s(7) == 's'
  perms.userExecute = true;
  perms.setgid = true;
elseif s(7) == 'S'
  perms.setgid = true;
end
if s(8) == 'r';  perms.userRead = true;  end
if s(9) == 'w';  perms.userWrite = true;  end
if s(10) == 'x'
  perms.userExecute = true;
elseif s(10) == 't'
  perms.userExecute = true;
  perms.sticky = true;
elseif s(10) == 'T'
  perms.sticky = true;
end
out = perms.bits;
end
