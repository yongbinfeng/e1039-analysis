# A Package to Generate and Analyze Hit-Embedded MC Events

The hit embedding is a procedure for embedding a set of hits into a simulated physics event (like J/psi).
It is to mimic a real event, which contains not only a physics process but also background hits.
It can be used in studying the effects of background hits, such fake track and efficiency loss.

## Terminology

For events, data or files:

| Term | Meaning |
| ---- | ------- |
| "Signal" events    | (Simulated) physics events                    |
| "Embedding" events | Events which (or whose hits) will be embedded |
| "Embedded" events  | Physics events where hits have been embedded  |

## Prerequisite

This program depends on the E1039 resource+share+core packages.
You are recommended to use "spinquestgpvm01.fnal.gov".
You are expected to be familiar with the procedure for generating and analyzing a set of simulated events, using `SimChainDev` and `AnaSimDst` in `e1039-analysis` for example.

You can check out the repository as usual;
```
cd /path/to/your_working_directory
git clone git@github.com:E1039-Collaboration/e1039-analysis.git
cd e1039-analysis/HitEmbedding
```

## Software structure

### Source codes

All source codes specific to this packages are stored in `src/`.
You have to compile them at least once by the following commands;
```
source setup.sh
cmake-this
make-this
```

`cmake-this` and `make-this` can be executed at any directory, since they don't depend on the current directory.
They have to be executed again after you modify the codes.

### Fun4All macros

Multiple Fun4All macros are available in this packages in order to carry out the hit embedding step-by-step.
Details of each macro are explained in `README.md` of each directory.

1. [`macro_gen_signal/`](macro_gen_signal/):  Macro to generate signal events.
1. [`macro_gen_emb/`](macro_gen_emb/):  Macro to generate embedding events.
1. [`macro_embed/`](macro_embed/):  Macro to do the hit embedding.
1. [`macro_ana/`](macro_ana/):  Macro to analysis the hit-embedded events.

```
  [ Generate signal events ]                        ... `macro_gen_signal`
    |             |
    V             |
  [ Reconstruct ] |                                 ... `macro_gen_signal`
    |             |
    |             |  [ Generate embedding events ]  ... `macro_gen_emb`
    |             |    |
    |             V    V
    |           [ Embed hits ]                      ... `macro_emb`
    |             |
    |             V
    |           [ Reconstruct ]                     ... `macro_emb`
    |             |
    V             V
  [ Analyze ]   [ Analyze ]                         ... `macro_ana`
          |       |
          V       V
         [ Compare ]                                ... `macro_ana`
```

## To-do list

* Find a way to auto-balance N of signal events and N of embedding events per file.
* Check how compact the TTree object (`embedding_data.root`) is.
    If it is not much different from DST, DST can be used as is,
    although it is not sure how efficiently we can read DST when 
    trying to shuffle the event order.

## Contact

Feel free to send any questions/suggestions to Kenichi Nakano.

