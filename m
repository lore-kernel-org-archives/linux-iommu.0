Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B8390988
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335497; cv=none; b=sMeB6/Cpvf5HXFMSONdnKwbWumwjGN8WtC/xYSByUPyAWTFBqr0WbbRGL3Nv7kSs7/3FKlBapIbnOhk1ey+CFleUUuYhMoYpH+l4+3cARsS1kKstNuBZzYw2SjRxvvXpxM6lxD/P/X6LYOqq4id8sHLfhTkIbgV6GliURWQrBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335497; c=relaxed/simple;
	bh=Il5EilNKbQmVM1qv4XgxLAe02Z9+zxydkwUqJc2BPRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4ggMN53tHxMpbNtIIIsOnxstDKc1AFkfdKiPX+4Gvx8ZALg81Ym4EaZpBohCUFl45fP8N69PiRgDDNHPgM0XtAYuej1/GmgoLC/hRqXxaJTOvhz6bTeQi31QMQkNwk+hXzDpu6FdJFzoE+MnJbxwWOa8ZZ8P+DNFJnOMbFBgAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d7ebe11bffso6493512a34.0
        for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 03:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335495; x=1776940295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9HEDsaws+1AaPEcUyrGjtCss1Kv3jZQFAB8Oib7mmY=;
        b=tZmYoNqd5GANfmaaH4eitHeRxdYyn+crQ5DgYohUYhRLIOgBQH6vWcNiKckdKgvSlu
         Z2CvBlBOLftsNRT456nbpgLm5rxTv2cxNpRD560tLOUD5dYWvBOTWwsc7gYxw6eRDQ7A
         MQEl/1udyHdY/F7OUmlN+YPGfxE9KB10YBmdVotB1FhMrHyt++om1bUhFnpNpFXHUSoB
         ht5hdAhPxWPXKV2Sx0T8a+2QS6e+cyRZC3Ky8fiE3qb+AJvcbLMMv1pxUJkiatktbiXH
         43rgw/Dmrv88rRmYfFcZEHkAHvzP0QArqS6v5/yfKOPs4ptA0QQrTpB0iVoWZ0Xevdjk
         yYfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HpW9yQ3EpV7IbM3BIsq/SDXTudTC6DZWJYC0PNfG1JTvugHwMbCheVWa82ldPh+FiADCOLw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzclww0SY5/oaXZOA8jQRhw2dehNCLDXalMeBztrN+zPGPUkXgC
	T20TbtY3mW/63+kb0JALpPXAktNt0wR9MHml8+hTsWjW2p+t7wQ/GcwCYILvTkRz
X-Gm-Gg: AeBDievN7DD7OFF7b/hhxTuhDWZglNfgJ4eDCFsU0PRebjvHhuNTVpKGE5qjzZZL7iQ
	niJvKE1KeqbWGDPcbzHszE2kVPe1/h/C9MLhxA01RTQhpTSalKoYIC1gt++EGqaSBllK6ArDM3q
	e3aWvnZFn4sQYQoaWQ/wwAVwuJahdijOpHa9qEH3+p4iW7YfXezM1BFXjnLU5FhpaRpSiDKd3H7
	bqTdJOyCQA1nnd5x0TTkw3biAdBJoJKns7jGp7JGxFrga+VdMQFp3wpzamP7f34CZgtHx7C3ruA
	4pa4dmowO26aAp0ZjZ9mcmGx5IEsXLrQZQideGRyr1bLUKcAXvU9UI/7hLQXdTrnjN/zBoBGvEv
	m1SNUP1926eu/x8HVZzSu7T+nfNmmPBrmRDRWBtusN6iKjSkRK9UDgmuOp0omRRJh2YgVW1WZ5z
	7rGl5IH6mTcZVilG/yRvTwPdRxdGj6tPIFudvpqeEl73LScYpNXnp6drDXMTNNFOH8XI/hPUTzy
	O0=
X-Received: by 2002:a05:6830:449f:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7dc27f116ffmr15517142a34.17.1776335494888;
        Thu, 16 Apr 2026 03:31:34 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc7746b5a8sm2896067a34.6.2026.04.16.03.31.34
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 03:31:34 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-47952229034so2844423b6e.3
        for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 03:31:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/OotV0TvFLeQ3n7u6eyDt4xEFurQk3ktbscUkt8fUxRoFpdxOw0+EaWxUhF9eHIKtbLpCorw==@lists.linux.dev
X-Received: by 2002:a05:6102:c48:b0:608:cd24:354c with SMTP id
 ada2fe7eead31-609fe9b0d22mr11966750137.3.1776335071251; Thu, 16 Apr 2026
 03:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.794680738@kernel.org>
In-Reply-To: <20260410120318.794680738@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Apr 2026 12:24:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
X-Gm-Features: AQROBzDRGGELVSySTko37h6zEj8YoV3p6pwZDCVQUlUW6sZbw_W5mbJzFIh35nQ
Message-ID: <CAMuHMdVerN6Pz07CQH+hcvT=-ZD-r9VNrSrGzTQZBEsuecK_ig@mail.gmail.com>
Subject: Re: [patch 18/38] lib/tests: Replace get_cycles() with ktime_get()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
> get_cycles() is the historical access to a fine grained time source, but it
> is a suboptimal choice for two reasons:
>
>    - get_cycles() is not guaranteed to be supported and functional on all
>      systems/platforms. If not supported or not functional it returns 0,
>      which makes benchmarking moot.
>
>    - get_cycles() returns the raw counter value of whatever the
>      architecture platform provides. The original x86 Time Stamp Counter
>      (TSC) was despite its name tied to the actual CPU core frequency.
>      That's not longer the case. So the counter value is only meaningful
>      when the CPU operates at the same frequency as the TSC or the value is
>      adjusted to the actual CPU frequency. Other architectures and
>      platforms provide similar disjunct counters via get_cycles(), so the
>      result is operations per BOGO-cycles, which is not really meaningful.
>
> Use ktime_get() instead which provides nanosecond timestamps with the
> granularity of the underlying hardware counter, which is not different to
> the variety of get_cycles() implementations.
>
> This provides at least understandable metrics, i.e. operations/nanoseconds,
> and is available on all platforms. As with get_cycles() the result might
> have to be put into relation with the CPU operating frequency, but that's
> not any different.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Thanks for your patch!

> --- a/lib/interval_tree_test.c
> +++ b/lib/interval_tree_test.c
> @@ -65,13 +65,13 @@ static void init(void)
>  static int basic_check(void)
>  {
>         int i, j;
> -       cycles_t time1, time2, time;
> +       ktime_t time1, time2, time;
>
>         printk(KERN_ALERT "interval tree insert/remove");
>
>         init();
>
> -       time1 = get_cycles();
> +       time1 = ktime_get();
>
>         for (i = 0; i < perf_loops; i++) {
>                 for (j = 0; j < nnodes; j++)
> @@ -80,11 +80,11 @@ static int basic_check(void)
>                         interval_tree_remove(nodes + j, &root);
>         }
>
> -       time2 = get_cycles();
> +       time2 = ktime_get();
>         time = time2 - time1;
>
>         time = div_u64(time, perf_loops);
> -       printk(" -> %llu cycles\n", (unsigned long long)time);
> +       printk(" -> %llu nsecs\n", (unsigned long long)time);

While cycles_t was unsigned long or long long, ktime_t is always s64,
so "%lld", and the cast can be dropped (everywhere).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
