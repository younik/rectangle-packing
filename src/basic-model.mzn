include "globals.mzn";

int: w;
int: n;
array[1..n, 1..2] of int: sizes; 

%decreasing area order
array[int] of int: order = arg_sort([-sizes[i, 1]*sizes[i, 2] | i in 1..n]); 
array[1..n] of int: widths = [sizes[i, 1] | i in order]; 
array[1..n] of int: heights = [sizes[i, 2] | i in order]; 

int: min_h = max(heights ++ [ceil(sum([heights[i]*widths[i] | i in 1..n])/w)]);
array[int] of int: new_row_idx = [1] ++ [i | i in 2..n  where 
                     floor((sum([widths[j] | j in 1..i])-1)/w) > floor((sum([widths[j] | j in 1..i-1])-1)/w)] ++ [n];
int: max_h = sum([max([heights[j] | j in new_row_idx[i-1]..new_row_idx[i]]) | i in 2..length(new_row_idx)]);
var min_h..max_h: h;

array [1..n] of var 0..w-1: x;
array [1..n] of var 0..max_h: y;

constraint diffn(x, y, widths, heights);

constraint forall(i in 1..n)(
  x[i] + widths[i] <= w /\ y[i] + heights[i] <= h
);

%implied constraint as suggested in point 2
constraint cumulative(x, widths, heights, h);
constraint cumulative(y, heights, widths, w);

%symmetry breaking
constraint x[1] + ceil(widths[1]/2) <= ceil(w/2);
constraint y[1] + ceil(heights[1]/2) <= h+1 div 2;

%symmetry breaking 2
constraint forall(i in 1..n-1, j in 2..n where i<j)(
  (widths[i]==widths[j] /\ heights[i]==heights[j]) -> lex_less([x[i], y[i]], [x[j], y[j]])
);

solve :: seq_search([
          int_search(y, smallest, indomain_min) :: int_search(x, first_fail, indomain_min),
          int_search([h], input_order, indomain_min),
])
maximize -h;


output ["w = \(w)\n", 
        "h = \(h)\n",
        "n = \(n)\n", 
        "xs = \(x)\n", 
        "ys = \(y)\n",
        "widths = \(widths)\n",
        "heights = \(heights)\n", 
        ];
