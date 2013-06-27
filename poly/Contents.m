%% MATLAB
% THis is just a decscription

% Files
%   EM                 - [An, Cn, Qn, Rn, LL, rhon] = EM( data, fixed_j, max_iterations )
%   Learn              - Run Expectation Maximization Algorithm
%   Pr                 - Pr(r1,j1,r2,j2) == p(r(t),j(t),r(t-1),j(t-1))
%   arrow_pot          - arrow_pot( source, dest )
%   down_sample        - (wav,D) Downsample the array by factor D
%   draw_SS            - Init Viterbi Visualization
%   em_gui             - M-file for em_gui.fig
%   filter_chord       - [ out ] = filter_chord( notes, y, T, note_mode)
%   gen_chord_samples  - [y yj] = gen_chord_samples( r, T)
%   gen_chord_section  - [y sv]=gen_chord_section(j, T )
%   givens             - (angular_velocity) 
%   init_note_table    - init midi notes
%   init_parameters    - Initialize Generative Model Parameters
%   init_prior_table   - (p_same,p_change)
%   init_trans_mat     - (damping_coef,angular_velocity,H)
%   load_training_data - 
%   midi_to_roll       - [r j] = midi_to_roll( nt, max_notes, Fs )
%   mog2str            - UNTITLED1 Summary of this function goes here
%   note2str           - [out] = note2str( midi_nums )
%   piano_roll_to_midi - [nt] = piano_roll_to_midi(r, j, T, filename,tempo)
%   plot_gaussian      - plot_gaussian( mu, P, min, max, step )
%   plots              - 
%   prune              - (a,threshold) return member of a.Posterior>threshold
%   sample_chord_gui   - _GUI M-file for sample_chord_gui_gui.fig
%   sample_melody      - sample_melody(r,j,T)
%   sample_mono_gui    - _GUI M-file for sample_mono_gui_gui.fig
%   update_params_EM   - 
%   viterbi_chord      - [best_config, history] = viterbi_chord(y,T, draw, max_it)
%   viterbi_chord_gui  - M-file for viterbi_chord_gui.fig
%   viterbi_chord_init - (y,T) - local max likelihood chord configuration r(1:M)
%   viterbi_chord_itr  - (y,T) - local max likelihood chord configuration r(1:M)
%   viterbi_mono       - [delta map] = viterbi_mono(y,T)
%   viterbi_mono_gui   - M-file for viterbi_mono_gui.fig
%   viterbi_mono_init  - [MAP] = viterbi_mono_init(y, T)
%   viterbi_mono_step  - [ delta MAP ] = viterbi_mono_step(delta_prev,y,t,T)
