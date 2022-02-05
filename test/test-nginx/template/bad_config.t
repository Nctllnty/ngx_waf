use Test::Nginx::Socket 'no_plan';

run_tests();


__DATA__

=== TEST: Bad directive waf

--- main_config
${main_config}

--- config
waf bad;

--- must_die


=== TEST: Bad directive waf_rule_path

--- main_config
${main_config}

--- config
waf_rule_path ${base_dir}/waf/rules;

--- must_die


=== TEST: Bad directive waf_mode

--- main_config
${main_config}

--- config
waf_mode BAD;

--- must_die


=== TEST: Bad directive waf_cc_deny (1)

--- main_config
${main_config}

--- config
waf_cc_deny on rate=100/m;

--- must_die


=== TEST: Bad directive waf_cc_deny (2)

--- main_config
${main_config}

--- config
waf_cc_deny on rate=r/m;

--- must_die

=== TEST: Bad directive waf_cc_deny (3)

--- main_config
${main_config}

--- config
waf_cc_deny on rate=-1r/m;

--- must_die


=== TEST: Bad directive waf_cc_deny (4)

--- main_config
${main_config}

--- config
waf_cc_deny on rate=100r;

--- must_die


=== TEST: Bad directive waf_cc_deny (5)

--- main_config
${main_config}

--- config
waf_cc_deny on rate=100r/b;

--- must_die


=== TEST: Bad directive waf_cc_deny (6)

--- main_config
${main_config}

--- config
waf_cc_deny on;

--- must_die


=== TEST: Bad directive waf_cc_deny (7)

--- main_config
${main_config}

--- config
waf_cc_deny on rate=100r/m duration=1;

--- must_die


=== TEST: Bad directive waf_cc_deny (8)

--- main_config
${main_config}

--- config
waf_cc_deny on rate=100r/m duration=1b;

--- must_die


=== TEST: Bad directive waf_cc_deny (9)

--- main_config
${main_config}

--- config
waf_cc_deny on rate=100r/m duration=1h size=10z;

--- must_die


=== TEST: Bad directive waf_cc_deny (10)

--- main_config
${main_config}

--- config
waf_cc_deny on rate=100r/m duration=1h bad=bad;

--- must_die


=== TEST: Bad directive waf_cc_deny (11)

--- main_config
${main_config}

--- config
waf_cc_deny rate=100r/m;

--- must_die


=== TEST: Bad directive waf_cache (1)

--- main_config
${main_config}

--- config
waf_cache capacity=50m;

--- must_die


=== TEST: Bad directive waf_cache (2)

--- main_config
${main_config}

--- config
waf_cache on capacity=-1m;

--- must_die


=== TEST: Bad directive waf_cache (3)

--- main_config
${main_config}

--- config
waf_cache on bad=bad;

--- must_die


=== TEST: Bad directive waf_modsecurity (1)

--- main_config
${main_config}

--- config
waf_modsecurity bad file=${base_dir}/waf/modsec/modsecurity.conf;

--- must_die


=== TEST: Bad directive waf_modsecurity (2)

--- main_config
${main_config}

--- config
waf_modsecurity on file=${base_dir}/waf/modsec/bad.conf;

--- must_die


=== TEST: Bad directive waf_modsecurity (3)

--- main_config
${main_config}

--- config
waf_modsecurity on bad=bad;

--- must_die


=== TEST: Bad directive waf_verify_bot (1)

--- main_config
${main_config}

--- config
waf_verify_bot bad;

--- must_die


=== TEST: Bad directive waf_verify_bot (2)

--- main_config
${main_config}

--- config
waf_verify_bot on bad;

--- must_die


=== TEST: Bad directive waf_under_attack (1)

--- main_config
${main_config}

--- config
waf_under_attack bad;

--- must_die


=== TEST: Bad directive waf_under_attack (2)

--- main_config
${main_config}

--- config
waf_under_attack on bad;

--- must_die


=== TEST: Bad directive waf_under_attack (3)

--- main_config
${main_config}

--- config
waf_under_attack on bad;

--- must_die


=== TEST: Bad directive waf_under_attack (4)

--- main_config
${main_config}

--- config
waf_under_attack on file=bad;

--- must_die


=== TEST: Bad directive waf_http_status

--- main_config
${main_config}

--- config
waf_http_status bad;

--- must_die


=== TEST: Bad directive waf_priority

--- main_config
${main_config}

--- config
waf_priority W-IP IP VERIFY-BOT CC CAPTCHA UNDER-ATTACK W-URL URL ARGS UA W-REFERER REFERER COOKIE POST;

--- must_die

=== TEST: Non-existent zone

--- main_config
${main_config}

--- http_config

--- config
waf_cc_deny on rate=100r/m zone=test:cc;

--- must_die


=== TEST: Duplicate tag

--- main_config
${main_config}

--- http_config
waf_zone name=test size=10m;

--- config
waf_cc_deny on rate=100r/m zone=test:cc;

location /t {
    waf_cc_deny on rate=100r/m zone=test:cc;
}

--- must_die


=== TEST: waf_captcha without sitekey

--- main_config
${main_config}

--- config
waf_captcha on prov=reCAPTCHAv3 secret=xxx;

--- must_die


=== TEST: waf_captcha without secret

--- main_config
${main_config}

--- config
waf_captcha on prov=reCAPTCHAv3 sitekey=xxx;

--- must_die


=== TEST: waf_captcha without zone

--- main_config
${main_config}

--- config
waf_captcha on prov=reCAPTCHAv3 sitekey=xxx secret=xxx max_fails=100:60m;

--- must_die


=== TEST: Bad directive waf_sysguard (1)

--- main_config
${main_config}

--- config
waf_syaguard offf;

--- must_die


=== TEST: Bad directive waf_sysguard (2)

--- main_config
${main_config}

--- config
waf_syaguard on loaddd=0.1;

--- must_die


=== TEST: Bad directive waf_sysguard (3)

--- main_config
${main_config}

--- config
waf_syaguard on load=0;

--- must_die


=== TEST: Bad directive waf_sysguard (4)

--- main_config
${main_config}

--- config
waf_syaguard on load=-0.5;

--- must_die
