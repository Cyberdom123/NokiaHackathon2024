package tasks_parameters;
// TASK 1
    parameter TASK_1_DATA_WIDTH_IN              = 8;   
    parameter TASK_1_DATA_WIDTH_OUT             = 8;   
    parameter TASK_1_NUM_WORDS_IN               = 1000;
    parameter TASK_1_NUM_WORDS_OUT              = 1000;
    parameter TASK_1_N_IN                       = 1;
    parameter TASK_1_N_OUT                      = 1;
    parameter TASK_1_TV_IN_BYTES                = TASK_1_NUM_WORDS_IN * TASK_1_DATA_WIDTH_IN /8;
    parameter TASK_1_TV_IN_NUM_TRANSACTIONS     = TASK_1_NUM_WORDS_IN * TASK_1_DATA_WIDTH_IN /32;
    parameter TASK_1_TV_OUT_NUM_TRANSACTIONS    = TASK_1_NUM_WORDS_OUT* TASK_1_DATA_WIDTH_OUT/32;
// TASK 2
    parameter TASK_2_DATA_WIDTH_IN              = 8;
    parameter TASK_2_DATA_WIDTH_OUT             = 16;
    parameter TASK_2_NUM_WORDS_IN               = 256;
    parameter TASK_2_NUM_WORDS_OUT              = 256;
    parameter TASK_2_N_IN                       = 1;
    parameter TASK_2_N_OUT                      = 1;
    parameter TASK_2_TV_IN_BYTES                = TASK_2_NUM_WORDS_IN * TASK_2_DATA_WIDTH_IN /8;
    parameter TASK_2_TV_IN_NUM_TRANSACTIONS     = TASK_2_NUM_WORDS_IN * TASK_2_DATA_WIDTH_IN /32;
    parameter TASK_2_TV_OUT_NUM_TRANSACTIONS    = TASK_2_NUM_WORDS_OUT* TASK_2_DATA_WIDTH_OUT/32;
// TASK 3
    parameter TASK_3_DATA_WIDTH_IN              = 32;
    parameter TASK_3_DATA_WIDTH_OUT             = 32;
    parameter TASK_3_NUM_WORDS_IN               = 128;
    parameter TASK_3_NUM_WORDS_OUT              = 128;
    parameter TASK_3_N_IN                       = 1;
    parameter TASK_3_N_OUT                      = 1;
    parameter TASK_3_TV_IN_BYTES                = TASK_3_NUM_WORDS_IN * TASK_3_DATA_WIDTH_IN /8;
    parameter TASK_3_TV_IN_NUM_TRANSACTIONS     = TASK_3_NUM_WORDS_IN * TASK_3_DATA_WIDTH_IN /32;
    parameter TASK_3_TV_OUT_NUM_TRANSACTIONS    = TASK_3_NUM_WORDS_OUT* TASK_3_DATA_WIDTH_OUT/32;
// TASK 4
    parameter TASK_4_DATA_WIDTH_IN              = 16;
    parameter TASK_4_DATA_WIDTH_OUT             = 16;
    parameter TASK_4_NUM_WORDS_IN               = 734;
    parameter TASK_4_NUM_WORDS_OUT              = 512;
    parameter TASK_4_N_IN                       = 1;
    parameter TASK_4_N_OUT                      = 1;
    parameter TASK_4_TV_IN_BYTES                = TASK_4_NUM_WORDS_IN * TASK_4_DATA_WIDTH_IN /8;
    parameter TASK_4_TV_IN_NUM_TRANSACTIONS     = TASK_4_NUM_WORDS_IN * TASK_4_DATA_WIDTH_IN /32;
    parameter TASK_4_TV_OUT_NUM_TRANSACTIONS    = TASK_4_NUM_WORDS_OUT* TASK_4_DATA_WIDTH_OUT/32;
// TASK 5
    parameter TASK_5_DATA_WIDTH_IN              = 32;
    parameter TASK_5_DATA_WIDTH_OUT             = 32;
    parameter TASK_5_NUM_WORDS_IN               = 128;
    parameter TASK_5_NUM_WORDS_OUT              = 128;
    parameter TASK_5_N_IN                       = 1;
    parameter TASK_5_N_OUT                      = 1;
    parameter TASK_5_TV_IN_BYTES                = TASK_5_NUM_WORDS_IN * TASK_5_DATA_WIDTH_IN /8;
    parameter TASK_5_TV_IN_NUM_TRANSACTIONS     = TASK_5_NUM_WORDS_IN * TASK_5_DATA_WIDTH_IN /32;
    parameter TASK_5_TV_OUT_NUM_TRANSACTIONS    = TASK_5_NUM_WORDS_OUT* TASK_5_DATA_WIDTH_OUT/32;
// TASK 6
    parameter TASK_6_DATA_WIDTH_IN              = 8;
    parameter TASK_6_DATA_WIDTH_OUT             = 8;
    parameter TASK_6_NUM_WORDS_IN               = 1400;
    parameter TASK_6_NUM_WORDS_OUT              = 5;
    parameter TASK_6_N_IN                       = 1;
    parameter TASK_6_N_OUT                      = 1;
    parameter TASK_6_TV_IN_BYTES                = TASK_6_NUM_WORDS_IN * TASK_6_DATA_WIDTH_IN /8;
    parameter TASK_6_TV_IN_NUM_TRANSACTIONS     = TASK_6_NUM_WORDS_IN * TASK_6_DATA_WIDTH_IN /32;
    parameter TASK_6_TV_OUT_NUM_TRANSACTIONS    = 5;
// TASK 7
    parameter TASK_7_DATA_WIDTH_IN              = 16;
    parameter TASK_7_DATA_WIDTH_OUT             = 8;
    parameter TASK_7_NUM_WORDS_IN               = 512;
    parameter TASK_7_NUM_WORDS_OUT              = 8;
    parameter TASK_7_N_IN                       = 1;
    parameter TASK_7_N_OUT                      = 1;
    parameter TASK_7_TV_IN_BYTES                = TASK_7_NUM_WORDS_IN * TASK_7_DATA_WIDTH_IN /8;
    parameter TASK_7_TV_IN_NUM_TRANSACTIONS     = TASK_7_NUM_WORDS_IN * TASK_7_DATA_WIDTH_IN /32;
    parameter TASK_7_TV_OUT_NUM_TRANSACTIONS    = 1;
// TASK 8
    parameter TASK_8_DATA_WIDTH_IN              = 8;
    parameter TASK_8_DATA_WIDTH_OUT             = 8;
    parameter TASK_8_NUM_WORDS_IN               = 8;
    parameter TASK_8_NUM_WORDS_OUT              = 16;
    parameter TASK_8_N_IN                       = 1;
    parameter TASK_8_N_OUT                      = 1;
    parameter TASK_8_TV_IN_BYTES                = TASK_8_NUM_WORDS_IN * TASK_8_DATA_WIDTH_IN /8;
    parameter TASK_8_TV_IN_NUM_TRANSACTIONS     = TASK_8_NUM_WORDS_IN * TASK_8_DATA_WIDTH_IN /32;
    parameter TASK_8_TV_OUT_NUM_TRANSACTIONS    = 2;
// TASK 9
    parameter TASK_9_DATA_WIDTH_IN              = 8;
    parameter TASK_9_DATA_WIDTH_OUT             = 8;
    parameter TASK_9_NUM_WORDS_IN               = 8;
    parameter TASK_9_NUM_WORDS_OUT              = 8;
    parameter TASK_9_N_IN                       = 1;
    parameter TASK_9_N_OUT                      = 1;
    parameter TASK_9_TV_IN_BYTES                = TASK_9_NUM_WORDS_IN * TASK_9_DATA_WIDTH_IN /8;
    parameter TASK_9_TV_IN_NUM_TRANSACTIONS     = TASK_9_NUM_WORDS_IN * TASK_9_DATA_WIDTH_IN /32;
    parameter TASK_9_TV_OUT_NUM_TRANSACTIONS    = TASK_9_NUM_WORDS_OUT* TASK_9_DATA_WIDTH_OUT/32;
// TASK 10
    parameter TASK_10_DATA_WIDTH_IN             = 16;
    parameter TASK_10_DATA_WIDTH_OUT            = 64;
    parameter TASK_10_NUM_WORDS_IN              = 256;
    parameter TASK_10_NUM_WORDS_OUT             = 32;
    parameter TASK_10_N_IN                      = 8;
    parameter TASK_10_N_OUT                     = 1;
    parameter TASK_10_TV_IN_BYTES               = TASK_10_NUM_WORDS_IN * TASK_10_DATA_WIDTH_IN /8;
    parameter TASK_10_TV_IN_NUM_TRANSACTIONS    = TASK_10_NUM_WORDS_IN * TASK_10_DATA_WIDTH_IN /32;
    parameter TASK_10_TV_OUT_NUM_TRANSACTIONS   = TASK_10_NUM_WORDS_OUT* TASK_10_DATA_WIDTH_OUT/32;
// TASK 11
    parameter TASK_11_DATA_WIDTH_IN             = 8;
    parameter TASK_11_DATA_WIDTH_OUT            = 16;
    parameter TASK_11_NUM_WORDS_IN              = 64;
    parameter TASK_11_NUM_WORDS_OUT             = 1;
    parameter TASK_11_N_IN                      = 1;
    parameter TASK_11_N_OUT                     = 1;
    parameter TASK_11_TV_IN_BYTES               = TASK_11_NUM_WORDS_IN * TASK_11_DATA_WIDTH_IN /8;
    parameter TASK_11_TV_IN_NUM_TRANSACTIONS    = 16;
    parameter TASK_11_TV_OUT_NUM_TRANSACTIONS   = 2;
// TASK 12
    parameter TASK_12_DATA_WIDTH_IN             = 16;
    parameter TASK_12_DATA_WIDTH_OUT            = 32;
    parameter TASK_12_NUM_WORDS_IN              = 3;
    parameter TASK_12_NUM_WORDS_OUT             = 3;
    parameter TASK_12_N_IN                      = 3;
    parameter TASK_12_N_OUT                     = 3;
    parameter TASK_12_TV_IN_BYTES               = TASK_12_NUM_WORDS_IN * TASK_12_DATA_WIDTH_IN /8;
    parameter TASK_12_TV_IN_NUM_TRANSACTIONS    = 2;
    parameter TASK_12_TV_OUT_NUM_TRANSACTIONS   = 3;
// TASK 13
    parameter TASK_13_DATA_WIDTH_IN             = 8;
    parameter TASK_13_DATA_WIDTH_OUT            = 16;
    parameter TASK_13_NUM_WORDS_IN              = 4;
    parameter TASK_13_NUM_WORDS_OUT             = 4;
    parameter TASK_13_N_IN                      = 1;
    parameter TASK_13_N_OUT                     = 1;
    parameter TASK_13_TV_IN_BYTES               = TASK_13_NUM_WORDS_IN * TASK_13_DATA_WIDTH_IN /8;
    parameter TASK_13_TV_IN_NUM_TRANSACTIONS    = 1;
    parameter TASK_13_TV_OUT_NUM_TRANSACTIONS   = 2;
// TASK 14
    parameter TASK_14_DATA_WIDTH_IN             = 8;
    parameter TASK_14_DATA_WIDTH_OUT            = 16;
    parameter TASK_14_NUM_WORDS_IN              = 16;
    parameter TASK_14_NUM_WORDS_OUT             = 16;
    parameter TASK_14_N_IN                      = 1;
    parameter TASK_14_N_OUT                     = 1;
    parameter TASK_14_TV_IN_BYTES               = TASK_14_NUM_WORDS_IN * TASK_14_DATA_WIDTH_IN /8;
    parameter TASK_14_TV_IN_NUM_TRANSACTIONS    = 4;
    parameter TASK_14_TV_OUT_NUM_TRANSACTIONS   = 8;
// TASK 15
    parameter TASK_15_DATA_WIDTH_IN             = 16;
    parameter TASK_15_DATA_WIDTH_OUT            = 16;
    parameter TASK_15_NUM_WORDS_IN              = 50;
    parameter TASK_15_NUM_WORDS_OUT             = 50;
    parameter TASK_15_N_IN                      = 1;
    parameter TASK_15_N_OUT                     = 1;
    parameter TASK_15_TV_IN_BYTES               = TASK_15_NUM_WORDS_IN * TASK_15_DATA_WIDTH_IN /8;
    parameter TASK_15_TV_IN_NUM_TRANSACTIONS    = 25;
    parameter TASK_15_TV_OUT_NUM_TRANSACTIONS   = 25;

typedef struct packed {
    int DATA_WIDTH_IN;
    int DATA_WIDTH_OUT;
    int NUM_WORDS_IN;
    int NUM_WORDS_OUT;
    int INPUT_STREAMS;
    int OUTPUT_STREAMS;
    int TV_IN_BYTES;
    int TV_IN_NUM_TRANSACTIONS;
    int TV_OUT_NUM_TRANSACTIONS;
} tasks_params;

tasks_params [1:15] tasks_params_array = '{'{
    TASK_1_DATA_WIDTH_IN,
    TASK_1_DATA_WIDTH_OUT,
    TASK_1_NUM_WORDS_IN,
    TASK_1_NUM_WORDS_OUT,
    TASK_1_N_IN,
    TASK_1_N_OUT,
    TASK_1_TV_IN_BYTES,
    TASK_1_TV_IN_NUM_TRANSACTIONS,
    TASK_1_TV_OUT_NUM_TRANSACTIONS
   },'{
    TASK_2_DATA_WIDTH_IN,
    TASK_2_DATA_WIDTH_OUT,
    TASK_2_NUM_WORDS_IN,
    TASK_2_NUM_WORDS_OUT,
    TASK_2_N_IN,
    TASK_2_N_OUT,
    TASK_2_TV_IN_BYTES,
    TASK_2_TV_IN_NUM_TRANSACTIONS,
    TASK_2_TV_OUT_NUM_TRANSACTIONS
   },'{
    TASK_3_DATA_WIDTH_IN,
    TASK_3_DATA_WIDTH_OUT,
    TASK_3_NUM_WORDS_IN,
    TASK_3_NUM_WORDS_OUT,
    TASK_3_N_IN,
    TASK_3_N_OUT,
    TASK_3_TV_IN_BYTES,
    TASK_3_TV_IN_NUM_TRANSACTIONS,
    TASK_3_TV_OUT_NUM_TRANSACTIONS
   },'{
    TASK_4_DATA_WIDTH_IN,
    TASK_4_DATA_WIDTH_OUT,
    TASK_4_NUM_WORDS_IN,
    TASK_4_NUM_WORDS_OUT,
    TASK_4_N_IN,
    TASK_4_N_OUT,
    TASK_4_TV_IN_BYTES,
    TASK_4_TV_IN_NUM_TRANSACTIONS,
    TASK_4_TV_OUT_NUM_TRANSACTIONS
   },'{
    TASK_5_DATA_WIDTH_IN,
    TASK_5_DATA_WIDTH_OUT,
    TASK_5_NUM_WORDS_IN,
    TASK_5_NUM_WORDS_OUT,
    TASK_5_N_IN,
    TASK_5_N_OUT,
    TASK_5_TV_IN_BYTES,
    TASK_5_TV_IN_NUM_TRANSACTIONS,
    TASK_5_TV_OUT_NUM_TRANSACTIONS
   },'{
    TASK_6_DATA_WIDTH_IN,
    TASK_6_DATA_WIDTH_OUT,
    TASK_6_NUM_WORDS_IN,
    TASK_6_NUM_WORDS_OUT,
    TASK_6_N_IN,
    TASK_6_N_OUT,
    TASK_6_TV_IN_BYTES,
    TASK_6_TV_IN_NUM_TRANSACTIONS,
    TASK_6_TV_OUT_NUM_TRANSACTIONS
   },'{
    TASK_7_DATA_WIDTH_IN,
    TASK_7_DATA_WIDTH_OUT,
    TASK_7_NUM_WORDS_IN,
    TASK_7_NUM_WORDS_OUT,
    TASK_7_N_IN,
    TASK_7_N_OUT,
    TASK_7_TV_IN_BYTES,
    TASK_7_TV_IN_NUM_TRANSACTIONS,
    TASK_7_TV_OUT_NUM_TRANSACTIONS
   },'{
    TASK_8_DATA_WIDTH_IN,
    TASK_8_DATA_WIDTH_OUT,
    TASK_8_NUM_WORDS_IN,
    TASK_8_NUM_WORDS_OUT,
    TASK_8_N_IN,
    TASK_8_N_OUT,
    TASK_8_TV_IN_BYTES,
    TASK_8_TV_IN_NUM_TRANSACTIONS,
    TASK_8_TV_OUT_NUM_TRANSACTIONS
   },'{
    TASK_9_DATA_WIDTH_IN,
    TASK_9_DATA_WIDTH_OUT,
    TASK_9_NUM_WORDS_IN,
    TASK_9_NUM_WORDS_OUT,
    TASK_9_N_IN,
    TASK_9_N_OUT,
    TASK_9_TV_IN_BYTES,
    TASK_9_TV_IN_NUM_TRANSACTIONS,
    TASK_9_TV_OUT_NUM_TRANSACTIONS
   },'{
    TASK_10_DATA_WIDTH_IN,
    TASK_10_DATA_WIDTH_OUT,
    TASK_10_NUM_WORDS_IN,
    TASK_10_NUM_WORDS_OUT,
    TASK_10_N_IN,
    TASK_10_N_OUT,
    TASK_10_TV_IN_BYTES,
    TASK_10_TV_IN_NUM_TRANSACTIONS,
    TASK_10_TV_OUT_NUM_TRANSACTIONS
   },'{
    TASK_11_DATA_WIDTH_IN,
    TASK_11_DATA_WIDTH_OUT,
    TASK_11_NUM_WORDS_IN,
    TASK_11_NUM_WORDS_OUT,
    TASK_11_N_IN,
    TASK_11_N_OUT,
    TASK_11_TV_IN_BYTES,
    TASK_11_TV_IN_NUM_TRANSACTIONS,
    TASK_11_TV_OUT_NUM_TRANSACTIONS
   },'{
    TASK_12_DATA_WIDTH_IN,
    TASK_12_DATA_WIDTH_OUT,
    TASK_12_NUM_WORDS_IN,
    TASK_12_NUM_WORDS_OUT,
    TASK_12_N_IN,
    TASK_12_N_OUT,
    TASK_12_TV_IN_BYTES,
    TASK_12_TV_IN_NUM_TRANSACTIONS,
    TASK_12_TV_OUT_NUM_TRANSACTIONS
   },'{
    TASK_13_DATA_WIDTH_IN,
    TASK_13_DATA_WIDTH_OUT,
    TASK_13_NUM_WORDS_IN,
    TASK_13_NUM_WORDS_OUT,
    TASK_13_N_IN,
    TASK_13_N_OUT,
    TASK_13_TV_IN_BYTES,
    TASK_13_TV_IN_NUM_TRANSACTIONS,
    TASK_13_TV_OUT_NUM_TRANSACTIONS 
    },'{
    TASK_14_DATA_WIDTH_IN,
    TASK_14_DATA_WIDTH_OUT,
    TASK_14_NUM_WORDS_IN,
    TASK_14_NUM_WORDS_OUT,
    TASK_14_N_IN,
    TASK_14_N_OUT,
    TASK_14_TV_IN_BYTES,
    TASK_14_TV_IN_NUM_TRANSACTIONS,
    TASK_14_TV_OUT_NUM_TRANSACTIONS
    },'{
    TASK_15_DATA_WIDTH_IN,
    TASK_15_DATA_WIDTH_OUT,
    TASK_15_NUM_WORDS_IN,
    TASK_15_NUM_WORDS_OUT,
    TASK_15_N_IN,
    TASK_15_N_OUT,
    TASK_15_TV_IN_BYTES,
    TASK_15_TV_IN_NUM_TRANSACTIONS,
    TASK_15_TV_OUT_NUM_TRANSACTIONS
   }
};

endpackage
