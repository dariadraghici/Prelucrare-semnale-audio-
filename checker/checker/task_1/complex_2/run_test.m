function run_test()
    "task-1";
    tol = 1e-2;

    fout = fopen("out", "w");

    load("../../input/task_1/in_complex_2.mat");
    load("../../input/task_1/ref_complex_2.mat");

    sig3 = stereo_to_mono(sig3);
    sig3_rev = apply_reverb(sig3, impulse_response);

    _sig3_rev_high = high_pass(sig3_rev, fs3, high_pass_cutoff);
    save "output.mat" _sig3_rev_high;

    dsig = abs(_sig3_rev_high - sig3_rev_high);

    is_sig_good = mean(dsig) < tol;

    fprintf(fout, "%d", is_sig_good);

    fclose(fout);
end
