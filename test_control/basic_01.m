function the = basic_01(a,b,d) %a*sin(the) + b*cos(the) = d;
    alp = atan2(b,a)  ; %sin(alp) = b/sqrt(a*a + b*b); cos(alp) = a/sqrt(a*a + b*b)
    the1 = atan2(d, sqrt(a*a + b*b - d*d)) - alp;
    the2 = atan2(d, -sqrt(a*a + b*b - d*d)) - alp;
    the = [the1; the2];