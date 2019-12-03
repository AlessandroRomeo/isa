"""
Script that perform the Dadda algorithm and generate the relative implementation in VHDL
"""

import numpy as np
import os

n_bit = 32

def print_to_file(text):

  with open("Dadda_gen_out.txt", "a+") as file:
    file.write(text)
    file.write('\n\n')


def print_matrix(matrix):

  with open("Dadda_gen_out.txt", "a+") as file:
    for row in range(matrix.shape[0]):
      for col in range(matrix.shape[1]):
        file.write(str(matrix[row][col]) + ' ')
      file.write('\n\n')


# Adapt indexes for vhdl generation
def adapt_idexes(row, col):

  if row == 0:
    return (n_bit*2-col-1)
  else:
    return (n_bit*2-2*(row-1)-col-1)


def dadda_gen():

  if os.path.exists("Dadda_gen_out.txt"):
    os.remove("Dadda_gen_out.txt")

  n_rows = int(n_bit / 2) + 1
  n_cols = n_bit * 2
  matrix = np.full((n_rows, n_cols), '-', dtype=np.str)
  matrix_map = []  
  n_FA = 0
  n_HA = 0
  FAs_list = []
  HAs_list = []
  end = n_cols  

  # Initial Partial Products matrix
  for row in range(n_rows):
    if ((row == 0) or (row == n_rows-2)):
      start = end - n_bit - 4
    elif (row == n_rows - 1):
      start = end - n_bit - 3
    else:
      start = end - n_bit - 5
    for col in range(n_cols):
      if col >= start and col < end:
        matrix[row][col] = '•'
    if (row != 0):
      end -= 2
    for row in range(n_rows):
      if row != 0:
        matrix[row][2*n_bit-2*row] = '-'		

  print_to_file("Initial matrix of Partial Products")
  print_to_file("Number of rows in initial stage: {0}\n".format(n_rows))  
  print_matrix(matrix)	

  # Number of stages and number of rows required in every stage
  n_stages = 2
  rows_in_stage = [1, 2]
  while n_rows > (rows_in_stage[-1]*3/2):
    rows_in_stage.append(int(rows_in_stage[-1]*3/2))
    n_stages += 1
	
  print_to_file("Number of stages: {0} \n".format(n_stages))
  print_to_file("Number of rows for every stage: {0} \n\n".format(rows_in_stage))

  # Subproducts naming for the initial stage
  for col in range(n_cols):
    add_col = []
    for row in range(n_rows):
      if matrix[row][col] == '•':
        add_col.append("parprod({0})({1})".format(row, adapt_idexes(row, col)))
    matrix_map.append(add_col)

  # Dadda Tree 
  for stage in range(n_stages):
    print_to_file("#" * 150)
    print_to_file("Stage {0}".format(stage))
    max_rows = rows_in_stage[-(stage+1)]
    print_to_file("Number of rows in present stage: {0}\n".format(max_rows))
	
    dots_matrix = np.full_like(matrix, '-', dtype=np.str)

    for col in range(n_cols-1, -1, -1):

      if ((len(matrix_map[col])) > max_rows):
        diff = len(matrix_map[col]) - max_rows
        odd = diff % 2
 
        if odd:
          HAs_list.append(matrix_map[col][0:2])
          n_HA += 1
          del matrix_map[col][0:2]		  
          matrix_map[col].insert(0, "HA_out({0})".format(len(HAs_list)-1))
          if col != 0:
            matrix_map[col-1].insert(0, "HA_carry({0})".format(len(HAs_list)-1))
        
        for i in range(int(diff/2)):
          FAs_list.append(matrix_map[col][i+odd:(i+odd+3)])
          n_FA += 1
          del matrix_map[col][i+odd:(i+odd+3)]		  
          matrix_map[col].insert(0, "FA_out({0})".format(len(FAs_list)-1))
          if col != 0:
            matrix_map[col-1].insert(0, "FA_carry({0})".format(len(FAs_list)-1))
          
      dots_row = len(matrix_map[col])
	  
      for row in range(n_rows):
        if dots_row == 0:
          break
		  
        dots_matrix[row][col] = '•'
        dots_row -= 1


    print_matrix(dots_matrix)

  print_to_file("total number of FA= {0}, total number of HA= {1} \n".format(n_FA, n_HA))

  return([FAs_list, HAs_list])


# Create a new indented line
def new_line(indent, line):

  insert = " " * indent + line + '\n'
  return insert


# VHDL generation
def vhdl_gen(FA_list, HA_list):

  with open("vhdl_top.txt", "r") as file:
    top = file.read()
    top = top.replace("N_FA", str(len(FA_list)-1))
    top = top.replace("N_HA", str(len(HA_list)-1))
    top += "\n"
  with open("mbe_mul.vhd", "w") as file_w:
    file_w.write(top)
    
    for col in range(len(FA_list)):
      indent = 8
      file_w.write(new_line(indent, "FA_{0} : full_adder".format(col)))
      indent += 4
      file_w.write(new_line(indent, "PORT MAP("))
      indent += 4
      file_w.write(new_line(indent, "A     => {0},".format(FA_list[col][0])))
      file_w.write(new_line(indent, "B     => {0},".format(FA_list[col][1])))
      file_w.write(new_line(indent, "C_IN  => {0},".format(FA_list[col][2])))
      file_w.write(new_line(indent, "SUM   => FA_out({0}),".format(col)))
      file_w.write(new_line(indent, "C_OUT => FA_carry({0}));".format(col)))
      file_w.write('\n')

    for col in range(len(HA_list)):
      indent = 8
      file_w.write(new_line(indent, "HA_{0} : half_adder".format(col)))
      indent += 4
      file_w.write(new_line(indent, "PORT MAP("))
      indent += 4
      file_w.write(new_line(indent, "A     => {0},".format(HA_list[col][0])))
      file_w.write(new_line(indent, "B     => {0},".format(HA_list[col][1])))
      file_w.write(new_line(indent, "SUM   => HA_out({0}),".format(col)))
      file_w.write(new_line(indent, "C_OUT => HA_carry({0}));".format(col)))
      file_w.write('\n')

    indent = 8
    file_w.write(new_line(indent, "P(63 DOWNTO 2) <= UNSIGNED(FA_out({0} DOWNTO {1}));".format(len(FA_list) - 1, len(FA_list) - n_bit * 2 + 2)))
    file_w.write(new_line(indent, "P(1 DOWNTO 0) <= UNSIGNED(HA_out({0} DOWNTO {1}));".format(len(HA_list) - 1, len(HA_list) - 2)))
    file_w.write(new_line(0, "END ARCHITECTURE;"))
    file_w.write('\n')

def main():

  adders_list = dadda_gen()
  vhdl_gen(adders_list[0], adders_list[1])


main()
