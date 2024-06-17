verdiWindowResize -win $_vdCoverage_1 "233" "34" "900" "700"
gui_set_pref_value -category {coveragesetting} -key {geninfodumping} -value 1
gui_exclusion -set_force true
gui_assert_mode -mode flat
gui_class_mode -mode hier
gui_excl_mgr_flat_list -on  0
gui_covdetail_select -id  CovDetail.1   -name   Line
verdiWindowWorkMode -win $_vdCoverage_1 -coverageAnalysis
gui_open_cov  -hier merged_dir.vdb -testdir {} -test {merged_dir/merged_test} -merge MergedTest -db_max_tests 10 -fsm transition
gui_covtable_show -show  { Function Groups } -id  CoverageTable.1  -test  MergedTest
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /router_test_pkg::router_scoreboard::src_cg1   }
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::src_cg1
gui_list_expand -id CoverageTable.1   /router_test_pkg::router_scoreboard::src_cg1
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::src_cg1  -column {Group} 
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /router_test_pkg::router_scoreboard::src_cg1  /router_test_pkg::router_scoreboard::dst_cg   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /router_test_pkg::router_scoreboard::dst_cg  /router_test_pkg::router_scoreboard::dst_cg1   }
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /router_test_pkg::router_scoreboard::dst_cg1  /router_test_pkg::router_scoreboard::src_cg   }
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::src_cg
gui_list_expand -id CoverageTable.1   /router_test_pkg::router_scoreboard::src_cg
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::src_cg  -column {Group} 
gui_list_select -id CovDetail.1 -list covergroup { router_test_pkg::router_scoreboard::src_cg.addr  router_test_pkg::router_scoreboard::src_cg.err   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { router_test_pkg::router_scoreboard::src_cg.err  router_test_pkg::router_scoreboard::src_cg.addr   } -type { {Cover Group} {Cover Group}  }
gui_list_select -id CovDetail.1 -list covergroup { router_test_pkg::router_scoreboard::src_cg.addr  /router_test_pkg::router_scoreboard::src_cg   } -type { {Cover Group} {Cover Group}  }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::src_cg  -column {Group} 
gui_list_collapse -id  CoverageTable.1   -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::src_cg
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /router_test_pkg::router_scoreboard::src_cg  /router_test_pkg::router_scoreboard::src_cg1   }
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::src_cg1  -column {Group} 
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /router_test_pkg::router_scoreboard::src_cg1  /router_test_pkg::router_scoreboard::src_cg   }
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::src_cg
gui_list_expand -id CoverageTable.1   /router_test_pkg::router_scoreboard::src_cg
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::src_cg  -column {Group} 
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /router_test_pkg::router_scoreboard::src_cg  /router_test_pkg::router_scoreboard::dst_cg1   }
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::dst_cg1
gui_list_expand -id CoverageTable.1   /router_test_pkg::router_scoreboard::dst_cg1
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::dst_cg1  -column {Group} 
gui_list_select -id CoverageTable.1 -list covtblFGroupsList { /router_test_pkg::router_scoreboard::dst_cg1  /router_test_pkg::router_scoreboard::dst_cg   }
gui_list_expand -id  CoverageTable.1   -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::dst_cg
gui_list_expand -id CoverageTable.1   /router_test_pkg::router_scoreboard::dst_cg
gui_list_action -id  CoverageTable.1 -list {covtblFGroupsList} /router_test_pkg::router_scoreboard::dst_cg  -column {Group} 
gui_list_action -id  CovDetail.1 -list {covergroup} router_test_pkg::router_scoreboard::dst_cg.addr  -type {Cover Group}
vdCovExit -noprompt
