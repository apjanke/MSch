function mustBeScalarLogical(x)
%MUSTBESCALARLOGICAL Validate that value is a scalar logical
%
% mustBeScalarLogical(x)
%
% Errors if x is not a scalar logical value.

msch.internal.mustBeA(x, 'logical');
msch.internal.mustBeScalar(x);

