Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7666158209
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432055; cv=none; b=HMXJruGT3VKXifSwSWP1gzMHPW5HNr3euDbaQvaQyTkqV2AZ2S7GHwZ0xhezw5Dk3l4b+BU32osmJtDWJJr7zVus6j9NrNkQxd2Z8FjqmC1JIK11g+yXKUhyEWbZAByvcsTRuN3XtkSxwev1S9kVsSkxQEDgShcBdPGJO8QtYEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432055; c=relaxed/simple;
	bh=wv3BWdUjEsHxFz36HH4yDDYcOKARUT+h/vA74KGBDCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZlj6BGTBpbr/i6Cg3JivF6ONOf5OeVOciSfyg+UM1gu5vYUvHxymC0xxtMBuUL1hU1V0CBbSmAJiPy05TZYc1mPFGQHNUTKBSELGhdZm13P7Gtu0RRjA0y72/otoTLedbQcXXtSLckslxJHP1ft4ve6LqeCrKUuwXH7jHJV69Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6164d7a02d2so6418607b3.3
        for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 02:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713432052; x=1714036852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=med4sx583FmrjJ8xsZWP62GvasCPoxmlq0Xh1ieUCdI=;
        b=V30WaakO0IQWFjtpdZBId/juYOcj1c11j26tyWVt9XsME9zXLaXVRwZiTfRQ3Emzc0
         gMUXKpd/LqxQuKDYrEmePaNyNUmJf5WlR6hlyJV0qg/eAzXkdd9w8XezMI+LVyMLLmf2
         b6wurKRQ3d7vhEU0vfKHb26TDeMXbsQH2NuO1ZlAA1YUOcMqbnXNZ31L+g3jOCWY9vIF
         YhJoHEwk9r+/aOY+9WZztCJ6YdqAMMuCvxoWAXgMXNbrwVA9DKXaFTdR8NkCorIv6kR9
         PUypmaqSFBLKeVUImEejWhtl6szkZGGVJ3/ZZOThcTikH5UIlV7dThbkO4OOtBwbeTVM
         +OAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBze3seIIukS/HrB/IV2sVuvYBV1RT295gRmPWvo8gIhovf9jJD356dtE3q/w/BM9HTIvfgIQY3fXjFrOCGVVnkTcMWjo=
X-Gm-Message-State: AOJu0YyA34odtsI5QIjVtvYA40iDjGYv95sxdxjW/ywIiHj3eLLoIvZC
	94tU4Pj4kiFZYbFybgfQgmp7S+pNVCtfCgBqO2Ukdq83XH3vvPy1MpBoNdy6YDc=
X-Google-Smtp-Source: AGHT+IFcc6v80Z4qDQz8pDt1oNI9sDYE/m+eTJc/Gf5IPqOzMzDWUWyVdc/t7RkmDnnSYbWFzvdH0w==
X-Received: by 2002:a05:690c:6303:b0:615:4330:e859 with SMTP id ho3-20020a05690c630300b006154330e859mr2369079ywb.17.1713432052308;
        Thu, 18 Apr 2024 02:20:52 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id w188-20020a0dd4c5000000b0060a0f62c589sm254058ywd.137.2024.04.18.02.20.33
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 02:20:34 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6164d7a02d2so6415547b3.3
        for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 02:20:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX51yHKPdEeuDu3ldZurQY7aQeD9875+wRET/x3BOLlsEcKZGLPgmw+hwXK8nVRbYqBTQSPMELUGoMmXnZ8hCCOmhbLAnU=
X-Received: by 2002:a05:690c:84:b0:61a:d00a:5aed with SMTP id
 be4-20020a05690c008400b0061ad00a5aedmr1891798ywb.12.1713432032825; Thu, 18
 Apr 2024 02:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <3d2a2f4e553489392d871108797c3be08f88300b.1685692810.git.geert+renesas@glider.be>
 <20240326013119.10591-1-zong.li@sifive.com>
In-Reply-To: <20240326013119.10591-1-zong.li@sifive.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 11:20:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxfXLmf0xAUKcVaF81fHbUs732J_zx7Xds0XuNUD5BVw@mail.gmail.com>
Message-ID: <CAMuHMdVxfXLmf0xAUKcVaF81fHbUs732J_zx7Xds0XuNUD5BVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] iopoll: Do not use timekeeping in read_poll_timeout_atomic()
To: Zong Li <zong.li@sifive.com>
Cc: arnd@arndb.de, hca@linux.ibm.com, iommu@lists.linux.dev, joro@8bytes.org, 
	jstultz@google.com, kai.heng.feng@canonical.com, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux@armlinux.org.uk, 
	magnus.damm@gmail.com, mturquette@baylibre.com, npiggin@gmail.com, 
	peterz@infradead.org, rafael.j.wysocki@intel.com, robin.murphy@arm.com, 
	s.nawrocki@samsung.com, sboyd@kernel.org, tero.kristo@linux.intel.com, 
	tglx@linutronix.de, tomasz.figa@gmail.com, tony@atomide.com, 
	ulf.hansson@linaro.org, vincent.guittot@linaro.org, will@kernel.org, 
	wsa+renesas@sang-engineering.com, yoshihiro.shimoda.uh@renesas.com, 
	zhengdejin5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zong,

On Tue, Mar 26, 2024 at 2:31=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote:
> On Fri, Jun 02, 2023 at 10:50:37AM +0200, Geert Uytterhoeven wrote:
> > read_poll_timeout_atomic() uses ktime_get() to implement the timeout
> > feature, just like its non-atomic counterpart.  However, there are
> > several issues with this, due to its use in atomic contexts:
> >
> >   1. When called in the s2ram path (as typically done by clock or PM
> >      domain drivers), timekeeping may be suspended, triggering the
> >      WARN_ON(timekeeping_suspended) in ktime_get():
> >
> >       WARNING: CPU: 0 PID: 654 at kernel/time/timekeeping.c:843 ktime_g=
et+0x28/0x78
> >
> >      Calling ktime_get_mono_fast_ns() instead of ktime_get() would get
> >      rid of that warning.  However, that would break timeout handling,
> >      as (at least on systems with an ARM architectured timer), the time
> >      returned by ktime_get_mono_fast_ns() does not advance while
> >      timekeeping is suspended.
> >      Interestingly, (on the same ARM systems) the time returned by
> >      ktime_get() does advance while timekeeping is suspended, despite
> >      the warning.
> >
> >   2. Depending on the actual clock source, and especially before a
> >      high-resolution clocksource (e.g. the ARM architectured timer)
> >      becomes available, time may not advance in atomic contexts, thus
> >      breaking timeout handling.
> >
> > Fix this by abandoning the idea that one can rely on timekeeping to
> > implement timeout handling in all atomic contexts, and switch from a
> > global time-based to a locally-estimated timeout handling.  In most
> > (all?) cases the timeout condition is exceptional and an error
> > condition, hence any additional delays due to underestimating wall cloc=
k
> > time are irrelevant.
> >
>
> Hi Geert,
> I tested this patch on the FPGA, and I noticed the timeout duration
> was much longer than expected. I tested it by removing the op operation
> and break condition for avoiding the influence of other factors.
> The code would look like as follows:
>
> for (;;) {
>         if (__timeout_us && __left_ns < 0)
>                 break;
>         if (__delay_us) {
>                 udelay(__delay_us);
>                 if (__timeout_us)
>                         __left_ns -=3D __delay_ns;;
>         cpu_relex();
>         if (__timeout_us)
>                 __left_ns--;
>         }
> }
>
> Despite setting the timeout to 1 second, it actually takes 25 seconds
> to reach the specified timeout value. I displayed the value of
> __left_ns when a timeout occurred. As follows: __delay_us is 1, when
> __left_ns counts down to -1, the system has run for 25 seconds.
>
> [   26.016213] __timeout_us: 1000000 __left_ns: -1
> [   50.818585] __timeout_us: 1000000  __left_ns: -1
> [   75.620467] __timeout_us: 1000000  __left_ns: -1
> [  100.422664] __timeout_us: 1000000  __left_ns: -1
> [  125.224775] __timeout_us: 1000000  __left_ns: -1
> ...
>
> I attempted to blend the two versions (e.g., ktime version and the
> current version) for discarding the value of __left_ns. The resulting
> output is as follows: __delay_us is 1, when it exceeds 1 second
> according to ktime, __left_ns only counts around 40 ms.
>
> [    6.734482] __timeout_us: 1000000  __left_ns: 961699000
> [    7.738485] __timeout_us: 1000000  __left_ns: 961228000
> [    8.812797] __timeout_us: 1000000  __left_ns: 961755000
> [    9.814021] __timeout_us: 1000000  __left_ns: 961542000
> [   10.815373] __timeout_us: 1000000 __left_ns: 962464000
> [   11.816184] __timeout_us: 1000000 __left_ns: 961536000
> [   12.817137] __timeout_us: 1000000 __left_ns: 961121000
> ...
>
> Per your suggestion, I attempted to increase delay_us to 10 us,
> it really helps to eliminate the underestimation. The actual
> timeout became 3 secs on the FPGA.
>
> I moved on my host x86 machine, the timeout has been reduced to
> 2 seconds even if the delay_us is 1. And the timeout can be
> precise 1 seconds when delay_us is 10. I'm not sure if the clock
> frequency or RTC frequency might also determine the underestimation
> of wall clock time? Is there a suggested value of delay_us for a
> driver that runs on various platforms?
> What is your perspective for those situation?

RTC frequency does not impact the timeout, as the macro no longer
relies on timekeeping.
CPU clock frequency does impact the timeout, especially when op()
executes lots of instructions.  The code assumes op() takes 1 ns,
which is a conservative value to prevent overestimation of wall clock
time.  This assumes that such an overestimation (i.e. timing out too
early) is much worse than an underestimation (i.e. timing out too late).
If op() takes much more time than 1 ns, or even more time than delay_us,
the effective timeout will be much larger than expected.

I can only suggest to use a reasonable value for delay_us, i.e. a value
that is (sufficiently) larger than the expected execution time of op().

I hope this helps.

> > --- a/include/linux/iopoll.h
> > +++ b/include/linux/iopoll.h
> > @@ -74,6 +74,10 @@
> >   * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
> >   * case, the last read value at @args is stored in @val.
> >   *
> > + * This macro does not rely on timekeeping.  Hence it is safe to call =
even when
> > + * timekeeping is suspended, at the expense of an underestimation of w=
all clock
> > + * time, which is rather minimal with a non-zero delay_us.
> > + *
> >   * When available, you'll probably want to use one of the specialized
> >   * macros defined below rather than this macro directly.
> >   */
> > @@ -81,22 +85,30 @@
> >                                       delay_before_read, args...) \
> >  ({ \
> >       u64 __timeout_us =3D (timeout_us); \
> > +     s64 __left_ns =3D __timeout_us * NSEC_PER_USEC; \
> >       unsigned long __delay_us =3D (delay_us); \
> > -     ktime_t __timeout =3D ktime_add_us(ktime_get(), __timeout_us); \
> > -     if (delay_before_read && __delay_us) \
> > +     u64 __delay_ns =3D __delay_us * NSEC_PER_USEC; \
> > +     if (delay_before_read && __delay_us) { \
> >               udelay(__delay_us); \
> > +             if (__timeout_us) \
> > +                     __left_ns -=3D __delay_ns; \
> > +     } \
> >       for (;;) { \
> >               (val) =3D op(args); \
> >               if (cond) \
> >                       break; \
> > -             if (__timeout_us && \
> > -                 ktime_compare(ktime_get(), __timeout) > 0) { \
> > +             if (__timeout_us && __left_ns < 0) { \
> >                       (val) =3D op(args); \
> >                       break; \
> >               } \
> > -             if (__delay_us) \
> > +             if (__delay_us) { \
> >                       udelay(__delay_us); \
> > +                     if (__timeout_us) \
> > +                             __left_ns -=3D __delay_ns; \
> > +             } \
> >               cpu_relax(); \
> > +             if (__timeout_us) \
> > +                     __left_ns--; \
> >       } \
> >       (cond) ? 0 : -ETIMEDOUT; \
> >  })

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
