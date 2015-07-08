#!/usr/bin/env python2

import argparse
import os

def _parse_args():
    parser = argparse.ArgumentParser(description='Convert binary to VHDL.')
    parser.add_argument('input', metavar='input.bin', type=str, help='binary input file')
    parser.add_argument('output', metavar='output.vhd', type=str, help='VHDL output file')

    return parser.parse_args()

args = _parse_args()

words = []

with open(args.input, "rb") as f:
    word = bytes(f.read(2))
    while word != "":
        words.append(word)
        word = f.read(2)

name = os.path.splitext(os.path.basename(args.output))[0]

with open(args.output, "w") as f:
    f.write("""library IEEE;
use IEEE.std_logic_1164.all;

entity %s is
  port (
    ce_n     : in  std_logic;
    oe_n     : in  std_logic;
    addr     : in  std_logic_vector(12 downto 0);
    data_out : out std_logic_vector(15 downto 0)
  );
end %s;

architecture rtl of %s is

begin

  process (ce_n, oe_n, addr)
  begin
    if ce_n = '0' and oe_n = '0' then
      case addr is
""" % (name, name, name))

    for i, word in enumerate(words):
        if word == '\0\0':
            continue
        word_hex = word.encode('hex')
        f.write("""        when "{0:013b}"   =>
          data_out <= X"{1}";
""".format(i * 2, word_hex))

    f.write("""        when others  =>
          data_out <= X"0000";
      end case;
    else
        data_out <= (others => 'Z');
    end if;
  end process;

end rtl;
""")
