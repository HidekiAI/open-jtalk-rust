# open-jtalk-rust

W.I.P. - Please do not even bother with this until this until I've got something...

## Motivations

For desktop assistance, I often try to locate screen reader (TTS) for Japanese for Debian (my current
choice of GUI) with suggestion to "write your own if you need it", so I'm finally considering it...

## Recipe Ingrediants

* Open JTalk - [sourceforge](http://open-jtalk.sourceforge.net/) ([open-jtalk](https://sourceforge.net/projects/open-jtalk/) - last updated 2018-12-25; [GitHub](http://github.com): unknown, cannot locate users s_sako, tokuda, or uratec)
* [MeCab](https://github.com/taku910/mecab) ([Japanese](https://taku910.github.io/mecab/))
* Voice -
* Parser, interpreters and dict - [osdn naist jdic](http://naist-jdic.osdn.jp/) (UTF8 version)
* Misc
  * [julius](https://github.com/julius-speech)

Please refer to LICENSE section (though the github/VCS links should have its own accomocating licenses)

## General Idea

Since Open JTalk does not have lib, we're just going to call the exec-app via system call;
But this can cause pathing issue that are not too easy at times.  Some system just drops the
app (in this case, open_jtalk) while some will install to app bin dir (i.e. Debian has apt
package).  Pathing for output also can be an issue, so we'll opt always to generate towards
/tmp which Windows does create user-based temp (%TEMP%).

I am quite fond of Mei's voice (easier on the ears) so that voice will be default, ar at least
will provide the htsvoice file in repos (of course, with accomodating README file that came
with that data).

As a library, will (for now) take all the parameters as a passing parameters and deal with all
these per-platform problems externally (let the external calling thing deal with their platform
specific pathings, etc).

TODO: Decide whether to follow suit on the API design by [node-openjtalk](https://github.com/TanUkkii007/node-openjtalk)

```bash
  usage:
       open_jtalk [ options ] [ infile ]
  options:                                                                   [  def][ min-- max]
    -x  dir        : dictionary directory                                    [  N/A]
    -m  htsvoice   : HTS voice files                                         [  N/A]
    -ow s          : filename of output wav audio (generated speech)         [  N/A]
    -ot s          : filename of output trace information                    [  N/A]
    -s  i          : sampling frequency                                      [ auto][   1--    ]
    -p  i          : frame period (point)                                    [ auto][   1--    ]
    -a  f          : all-pass constant                                       [ auto][ 0.0-- 1.0]
    -b  f          : postfiltering coefficient                               [  0.0][ 0.0-- 1.0]
    -r  f          : speech speed rate                                       [  1.0][ 0.0--    ]
    -fm f          : additional half-tone                                    [  0.0][    --    ]
    -u  f          : voiced/unvoiced threshold                               [  0.5][ 0.0-- 1.0]
    -jm f          : weight of GV for spectrum                               [  1.0][ 0.0--    ]
    -jf f          : weight of GV for log F0                                 [  1.0][ 0.0--    ]
    -g  f          : volume (dB)                                             [  0.0][    --    ]
    -z  i          : audio buffer size (if i==0, turn off)                   [    0][   0--    ]
  infile:
    text file                                                                [stdin]
```

## LICENSE

* OpenJTalk and hts_engine API, and is shiped with HTS Voice "NIT ATR503 M001" and "Mei".
* Both OpenJTalk and hts_engine API are issued under the Modified BSD license.
* HTS Voice "NIT ATR503 M001" and "Mei" are both issued under the Creative Commons Attribution 3.0 license.
