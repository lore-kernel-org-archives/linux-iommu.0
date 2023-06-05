Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D8C6FC3
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 13:15:49 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-3f7fd59bb13so46182481cf.3
        for <iommu@lists.linux.dev>; Mon, 05 Jun 2023 06:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685970948; x=1688562948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evDCePhMrS7Ny+TFmHSDloaESI5T/zQOM1dd67+oY2c=;
        b=lHMW/rnD/10qmoZQ+oXRIZ5SGM4TiXgSK1ohI2hJH3j161a36+bL5CCJXwd/ULKx9x
         erdxqGetGrwYGP6ZY7FwwayvNa5kzBwfTbKoMNxk6cLAqG7/Y1vumacFLbazFIHQlAZ7
         /nTwJc1sKM9cd8sUJmCT1qDV1H2fjPAUT7wYt021zRzij5U8Q2YTVUkI2NOhxN7xQd6v
         MCExzy5svvTAfCHPG0/RWwUq6w7bJIQlA5/rq5rKLe03gt/d1B5epn6z61irz0wZhkPj
         s8fAaxmaCzIIweJNHOnERImHr/59l7pLYSCnhwmm0lC/uKmHdcMQUplA4RdUXkIXB0St
         aQzw==
X-Gm-Message-State: AC+VfDyT2Plh2IZWM0K23yAq2CdkZHYC0X03AWlTIiSGzUozLZl5OOhY
	Gg9zPQ/589z13xyFMUgsejUXj/zY5xnxRQ==
X-Google-Smtp-Source: ACHHUZ5VmpdEWP1Jt9omv58JUZmsvl0pxPGD4mAFpA9TpV0MSPUQx3UvvmBfnUlR64pnJAs+0f5fEg==
X-Received: by 2002:a05:622a:44c:b0:3f6:c5c5:a6e0 with SMTP id o12-20020a05622a044c00b003f6c5c5a6e0mr6973942qtx.53.1685970948068;
        Mon, 05 Jun 2023 06:15:48 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id d7-20020a05622a15c700b003f018e18c35sm1447581qty.27.2023.06.05.06.15.47
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 06:15:47 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-75da00a1eddso140371185a.3
        for <iommu@lists.linux.dev>; Mon, 05 Jun 2023 06:15:47 -0700 (PDT)
X-Received: by 2002:a25:76cf:0:b0:ba9:89d4:b2f5 with SMTP id
 r198-20020a2576cf000000b00ba989d4b2f5mr14228253ybc.53.1685970927309; Mon, 05
 Jun 2023 06:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1685692810.git.geert+renesas@glider.be> <ae4bf03ab8fd5a557c683086958d6764babc0723.1685692810.git.geert+renesas@glider.be>
In-Reply-To: <ae4bf03ab8fd5a557c683086958d6764babc0723.1685692810.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Jun 2023 15:15:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9n3ypBG1HffvHxYke5Ym068ZK1s2QryE-rbVgFS9dzw@mail.gmail.com>
Message-ID: <CAMuHMdV9n3ypBG1HffvHxYke5Ym068ZK1s2QryE-rbVgFS9dzw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] soc: renesas: rmobile-sysc: Convert to readl_poll_timeout_atomic()
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
> Use readl_poll_timeout_atomic() instead of open-coding the same
> operation.
>
>   1. rmobile_pd_power_down(): as typically less than 20 retries are
>      needed, PSTR_RETRIES (100) =C2=B5s is a suitable timeout value.
>
>   2. __rmobile_pd_power_up(): the old method of first polling some
>      cycles with a 1 =C2=B5s delay, followed by more polling cycles witho=
ut
>      any delay didn't make much sense, as the latter was insignificant
>      compared to the former.  Furthermore, typically no retries are
>      needed.  Hence just retain the polling with delay.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> diff --git a/drivers/soc/renesas/rmobile-sysc.c b/drivers/soc/renesas/rmo=
bile-sysc.c
> index 728ebac98e14a5cc..5d621c35fba1116a 100644

> @@ -74,25 +71,17 @@ static int rmobile_pd_power_down(struct generic_pm_do=
main *genpd)
>
>  static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd)
>  {
> -       unsigned int mask =3D BIT(rmobile_pd->bit_shift);
> -       unsigned int retry_count;
> -       int ret =3D 0;
> +       unsigned int val, mask =3D BIT(rmobile_pd->bit_shift);
> +       int ret;

Oops, "ret" should still be initialized to zero.

>
>         if (readl(rmobile_pd->base + PSTR) & mask)
>                 return ret;
>
>         writel(mask, rmobile_pd->base + SWUCR);
>
> -       for (retry_count =3D 2 * PSTR_RETRIES; retry_count; retry_count--=
) {
> -               if (!(readl(rmobile_pd->base + SWUCR) & mask))
> -                       break;
> -               if (retry_count > PSTR_RETRIES)
> -                       udelay(PSTR_DELAY_US);
> -               else
> -                       cpu_relax();
> -       }
> -       if (!retry_count)
> -               ret =3D -EIO;
> +       ret =3D readl_poll_timeout_atomic(rmobile_pd->base + SWUCR, val,
> +                                       (val & mask), PSTR_DELAY_US,
> +                                       PSTR_RETRIES * PSTR_DELAY_US);
>
>         pr_debug("%s: Power on, 0x%08x -> PSTR =3D 0x%08x\n",
>                  rmobile_pd->genpd.name, mask,

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
