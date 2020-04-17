function mustBeScalarNumeric(x)
%MUSTBESCALARNUMERIC Validate that value is a scalar logical
%
% mustBeScalarNumeric(x)
%
% Errors if x is not a scalar numeric value.

% TODO: This calling form results in bad error messages. Fix. And add label
% support.

msch.internal.mustBeA(x, 'numeric');
msch.internal.mustBeScalar(x);

