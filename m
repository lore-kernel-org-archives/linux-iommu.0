Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386306FDE
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 15:08:47 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b04706c974so42461815ad.2
        for <iommu@lists.linux.dev>; Mon, 05 Jun 2023 08:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685977727; x=1688569727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aiwp/bDLmwSr5erFDhpBQgGpKXSsi00J2xGn70rauW0=;
        b=M1WoLpg7MJCk6fgCPpgHfKlm45+oT+PrUm91WdApLmxFVe/IbFDfBcKft5ulTrPBo+
         CX3oGUn8iytQB84Qz4w438XT8vaovLFHAlFp84bmjFv8zgL36xLLCzKayVkRoijM+NiE
         zd6X1dA70O80dm1PqAi60OL3qs4xpzO6I+btaot61pWyxP+h4s5TI1yxXzqJeIQELhP6
         BjY9GyagNRrRTlLnaoRD9G0Cx249flJYfmiDLE+YgK+hEhRd38KEtLLYLTlN9T66MUqn
         UDbZDOI/u0UhmKbjfNhCYw4ZlBBqWHev1Ke86eyJ0IWqLR1YMnt8jCTT3i4b5+iOgpzX
         rnWg==
X-Gm-Message-State: AC+VfDw6VumrRzq1JOwocOYWFJ1hBRayVW1eyJNG7r5TfYKfwsITRdef
	IMNfAGFDYkxyZmFPOTunn3B9BzGp7rTCtw==
X-Google-Smtp-Source: ACHHUZ7hwAHonQV5Z9ZT+g6bgoeMw+HYuB4slf+NFYlPU4iGQw1FdMxBJJBsd2+G3NdeEMdRpaQ7qQ==
X-Received: by 2002:a17:902:d4c2:b0:1ae:35ba:8c8f with SMTP id o2-20020a170902d4c200b001ae35ba8c8fmr10640420plg.13.1685977727151;
        Mon, 05 Jun 2023 08:08:47 -0700 (PDT)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c24c00b001aafdf8063dsm6703828plg.157.2023.06.05.08.08.46
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 08:08:46 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-65299178ac5so4367633b3a.1
        for <iommu@lists.linux.dev>; Mon, 05 Jun 2023 08:08:46 -0700 (PDT)
X-Received: by 2002:a05:6870:3e4:b0:19e:86e4:55b0 with SMTP id
 h36-20020a05687003e400b0019e86e455b0mr54853oaf.1.1685977705560; Mon, 05 Jun
 2023 08:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1685692810.git.geert+renesas@glider.be>
In-Reply-To: <cover.1685692810.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Jun 2023 17:08:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXrgyWT=RtS6cuUP6sT-Ta9Oa4cU2kHP10ah-U50DOSsg@mail.gmail.com>
Message-ID: <CAMuHMdXrgyWT=RtS6cuUP6sT-Ta9Oa4cU2kHP10ah-U50DOSsg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] iopoll: Busy loop and timeout improvements + conversions
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Tomasz Figa <tomasz.figa@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Dejin Zheng <zhengdejin5@gmail.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Tero Kristo <tero.kristo@linux.intel.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-pm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 2, 2023 at 10:51=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> When implementing a polling loop, a common review comment is to use one
> of the read*_poll_timeout*() helpers.  Unfortunately this is not always
> possible, or might introduce subtle bugs.  This patch series aims to
> improve these helpers, so they can gain wider use.
>
>   1. The first patch improves busy-looping behavior of both the atomic
>      and non-atomic read*_poll_timeout*() helpers.
>      The issue addressed by this patch was discussed before[1-2], but I
>      am not aware of any patches moving forward.
>
>   2. The second patch fixes timeout handling of the atomic variants.
>      Some of the issues addressed by this patch were mitigated in
>      various places[3-5], and some of these findings may be of interest
>      to the authors of [6-8].
>
> The first two patches were sent before, and already received some acks
> and reviews.  I plan to queue these in an immutable and tagged branch
> after the weekend, for consumption by myself, and by other interested
> parties.

FTR...
The following changes since commit ac9a78681b921877518763ba0e89202254349d1b=
:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
tags/iopoll-busy-loop-timeout-tag

for you to fetch changes up to 7349a69cf3125e92d48e442d9f400ba446fa314f:

  iopoll: Do not use timekeeping in read_poll_timeout_atomic()
(2023-06-05 15:35:27 +0200)

----------------------------------------------------------------
iopoll: Busy loop and timeout improvements

----------------------------------------------------------------
Geert Uytterhoeven (2):
      iopoll: Call cpu_relax() in busy loops
      iopoll: Do not use timekeeping in read_poll_timeout_atomic()

 include/linux/iopoll.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

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
