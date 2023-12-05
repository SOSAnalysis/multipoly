function c = kron(a,b)
% function B = kron(X,Y)
%
% DESCRIPTION
%   Kronecker tensor product
%
% INPUTS
%   X: rx-by-cx polynomial matrix
%   Y: ry-by-cy polynomial matrix
%
% OUTPUTS
%   B: rx*ry-by-cx*cy polynomial matrix
%
% SYNTAX
%   B=kron(X,Y)
%     B is the Kronecker product of X and Y.
%

% 9/9/2013: PJS  Initial Coding

% Check # of input arguments
if nargin~=2
    error('Syntax is B=kron(X,Y)');
    %narginchk(2,2);
end

a = polynomial(a);
b = polynomial(b);

% Get matrix dimensions
sza = size(a);
szb = size(b);

% Get polynomial info
acoef = a.coefficient;  bcoef = b.coefficient;
adeg  = a.degmat;       bdeg  = b.degmat;

% number of terms & elements
[ant,ane] = size(acoef);
[bnt,bne] = size(bcoef);

% variables of x and y
[Ia,Ib] = ndgrid(1:ant,1:bnt);
ja = reshape(kron(reshape(1:ane,sza),ones(szb)),[],1);
jb = reshape(kron(ones(sza),reshape(1:bne,szb)),[],1);

matdim = sza.*szb;
degmat = [adeg(Ia(:),:) bdeg(Ib(:),:)];
coefficient = acoef(Ia(:),ja(:)).*bcoef(Ib(:),jb(:));

[degmat,vars] = PVuniquevar(degmat,[a.varname b.varname]);
[coefficient,degmat] = PVuniqueterm(coefficient,degmat,matdim);

c = polynomial(coefficient,degmat,vars,matdim);

end