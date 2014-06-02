function [ ] = exportCoefs(filename, taps, q_frac)
%exportCoefs Export filter taps to C header
%   exportCoefs(filename, taps) - Export 'taps' to file whose name is given
%   by the argument 'filename'
%
%   exportCoefs(filename, taps, q_frac) - Quantize the taps passed in 
%   argument 'taps' to the format Qx, where x is the argument 'q_frac'. The
%   output will have 16 bits, 1 for sign, 'q_frac' for the fractional part
%   and the remaining for the integer part. After this, the taps are 
%   exported to a file named by the argument 'filename'.

% Check if a quantization is desired
if(nargin > 2 && nargin == 3)
    % Quantizer:
    q = quantizer([16 q_frac], 'RoundMode', 'round');

    % Quantize FIR taps:
    taps_quantized = quantize(q, taps);

    multiplier = 2^q_frac - 1;

    % Redefine taps
    taps = cast(taps_quantized * multiplier, 'Int16');
end

fd = fopen(filename, 'w');

fprintf(fd, 'Int16 coefs[%s]={ \n \t', num2str(length(taps)));

for i=1:length(taps)
  if ((mod(i-1, 6) == 0) && ((i-1) > 0))  
    fprintf( fd, '\n\t');
  end
  fprintf( fd, '%s,\t', num2str(taps(i)) );

end

fprintf(fd, '\n};');

fclose(fd);


end

