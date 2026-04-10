Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD8A3C3C07
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775828409; cv=pass; b=FQTEdcpHiAAFRnnTyf0hqG+AcavLcyeIg543CTipGMKuKy2a8fJua95r/wthjnahNfNG8WlDH1ZgZUVHeR83H9JuTNU1JBEzcsM8xqjRsrLY4ksB1xhYMftT0qlD51299qTX9OvBW/ZLN7/aHO1F7zdDrPJGKNjc1UNH7HQj+co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775828409; c=relaxed/simple;
	bh=LSR04DrYd2CNPoGkLuzcgQfT1tMVn5ZfdEM6iihG19s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIMaxW8jLtbWR3hVjZbpmw3t3q6EFnzQIl75U4063oGC2Npyu5WWRqgkCa323/nH46BXYPOEvL+bXgpl860GxmzFEUxSxrV9wR6/kKcLzKIUmmblcnlWo2uMVSk/+loI0hm0EnG/jOb1IJ7VEb2FYBAjUwropQOqmGGR+aqNEzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fuaeIarT; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fuaeIarT"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1279eced0b9so3035201c88.0
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 06:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775828407; cv=none;
        d=google.com; s=arc-20240605;
        b=BBjhb9ok17QGtSAjkDbAL6LiEEWNwTQ/hOERv2EbZDPjaOqXoj6poOcwRlIhpCHs8g
         mz68LhhE9Ge6t4/wBd43ngLbycHe39xJKMq/ltOYFrH/yCru61ysxkbhFTckR4KaxaOR
         EDeA+hWMUEBLFT5x+8QrLwBRohc/TWQUGceUdQ/JwxLTijEJoZNj8PrdiqjxT0wVUg1F
         I65RgArNfQbJblBgheOLR4F/kzEN2D7Ip09KhObzm33E3sArHpfb4N6DCby9qa2QWbe9
         QL8uAdIyQvqL0NF8ivj8LHSom3+Yd+TBJXqAgMw57sPa83juY91uELXBbW5MrlknzyVV
         HvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        fh=hbu+IzY8zYJBMuF40DPclv1R/UCr8I/yYSTcVdxIe9A=;
        b=cvJNg11APCmEod0+qDbL+7eqB3wsbU7I4Wha8B0S3lAi7YfU7GVilwVqW2myQ2zHfq
         vlLZs377ON9ueTIN5YlUVad2IYGcFVZWtPgx+FhxaUBQtf2PI6xgpea9cDT0MCgYGLfI
         UoM+DF7BDhJeL73dV+qbivmTccCAp9axI0+0TR0vUUb/eNS3OiX8DPy7lFt3mWbqoS4v
         sE2p6WLOKW0OF5z8hWNwVLJ3qeEfz1ggRUD5aizIj9UxcxZzDYldmef319IasvH8LXEr
         RFHcVbkdvRHdR9Rfe3iZXH24xNSYqhTKDqx9cDzLFjG/bzhGeBarOX+hfGlNg99mLvVO
         kSwg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775828407; x=1776433207; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        b=fuaeIarTsZCwHmCcmuY0NJa/YuLcYjNDNifE7In/lr9S82c/vxjQJZrOlx9ZWyeyVE
         j5xgudHRAqt+EdD+pkzVCbinDYZWJAr+pPW4Syunfu7j/rQWYWpWByRKMcZH/Q04/yD5
         XZq5U4GRVMu+n1EYPRiwgZbThlw06bhGEEv8CH0vAFp999KwU2IaFEZB+3v6WkTOT5dQ
         D0qzJBgAE5RcoFODzBI2xwq/9E7K071F7/Bd4NSerQq5roLE5b6U7isiEl//UDlRKbmA
         Ju7l8808kv1OZZCLHcTiYMvmRSaHQkFKufQ+P14FCcCa/dueNV+jzQxpdHZSkA42wtD7
         9iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775828407; x=1776433207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCXB7w7ko4o+lkpt1Tfr/OwLPxl1m2l/vGRhYm7vF9w=;
        b=hv/U7J+vg11fr9lveULyWWk/V03EjXSPKXeTnKhb5hykr8/n+dmYwVKC2xkgYQ6GTR
         i1F7fuqWefvdI2awqcjZ88UP1ub4mzzr+6jLwR7+BxOkXVbD/pnZPXcPPe6zPEJwXoBk
         I7+R8Usrx1aqqVtOOs3/7Pvu3W2i8OFsF6Hhx8Dt+C15IPDruxy3vM7rQ69thVnZ3Ikx
         k+zMoUxQ+a1kHRXGyeVRoOX2IJitRmyYYMrbmdY5i0OG+Mfws/mkWVaegfFY1elvBK5Z
         7enggR0cYG74Vu5IoC8dRzQtwkMcUzMeOHRyo1Pu99m/Q/90iJU9Z3mKuszha62+x7wq
         OzLg==
X-Forwarded-Encrypted: i=1; AJvYcCXXfz3eQCiu6ytlkRTexdcZGhbJCW73uFURPYuUs22i0PXq7yVbRm7WRUgWSdUaQAu0aOHjLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPexLVHWlN4LoNsvjxxnZg4vOKnGpc1h7dJyPTyZad+KSMLDcH
	FdRvEDRIq+wNAz9L+9uNL6WMw6uRABcYAb8mb0HzoQAXzqZbCpKPs0MM2F6W3GSZ6J3LD7NdxLX
	Q/DZtAPcbDu9fo73hm12jVu2D10HBTYhkaluWqBqu
X-Gm-Gg: AeBDietjMC0o8/TigCg/WGWYqAoS7yskcLCVxd82XcTlmhAHwmEy+ilLLk4axxDgZM2
	e8IWtrui1pC1jshz0b5lOgVgWuwuNnOHgsCF287C8lR/ddw3vFSIY336NAAJIl3WgrLVsvuaASV
	AWM/To+3d7qoVDol7DaT1P0qqfTrxLqhHqLyQSEUm9OlA75ZkklwVpwaGcbEO51cdzwtMCcXjAS
	1oLiz34TxwsCnpH9V2DPhb84Sj3OdS+BG3mUBnTYioj9NysRluxn8dDffTv4HQT+gHZq8sQje99
	1l5cCOwQlL0b5+Y1ntcIW2nQkH8pdwqzn30CPJhvO83c8x7z
X-Received: by 2002:a05:7022:fa04:b0:12c:2ed4:62fa with SMTP id
 a92af1059eb24-12c34ef907emr1882312c88.32.1775828406651; Fri, 10 Apr 2026
 06:40:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260410120044.031381086@kernel.org> <20260410120318.862164111@kernel.org>
In-Reply-To: <20260410120318.862164111@kernel.org>
From: Marco Elver <elver@google.com>
Date: Fri, 10 Apr 2026 15:39:30 +0200
X-Gm-Features: AQROBzBE-9UxDQG5mMJLgipEeL_Y5pwE-Y_PUrJGxDBLilqBu51b8lLzxdip708
Message-ID: <CANpmjNO1vsO1LT6xijhz3nsjQa+_A=9omfgOSz=aGn293-LqTg@mail.gmail.com>
Subject: Re: [patch 19/38] kcsan: Replace get_cycles() usage
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, 
	David Woodhouse <dwmw2@infradead.org>, Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, 
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 14:20, Thomas Gleixner <tglx@kernel.org> wrote:
>
> KCSAN uses get_cycles() for two purposes:
>
>   1) Seeding the random state with get_cycles() is a historical leftover.
>
>   2) The microbenchmark uses get_cycles(), which provides an unit less
>      counter value and is not guaranteed to be functional on all
>      systems/platforms.
>
> Use random_get_entropy() for seeding the random state and ktime_get() which
> is universaly functional and provides at least a comprehensible unit.
>
> This is part of a larger effort to remove get_cycles() usage from
> non-architecture code.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  kernel/kcsan/core.c    |    2 +-
>  kernel/kcsan/debugfs.c |    8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -798,7 +798,7 @@ void __init kcsan_init(void)
>         BUG_ON(!in_task());
>
>         for_each_possible_cpu(cpu)
> -               per_cpu(kcsan_rand_state, cpu) = (u32)get_cycles();
> +               per_cpu(kcsan_rand_state, cpu) = (u32)random_get_entropy();
>
>         /*
>          * We are in the init task, and no other tasks should be running;
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -58,7 +58,7 @@ static noinline void microbenchmark(unsi
>  {
>         const struct kcsan_ctx ctx_save = current->kcsan_ctx;
>         const bool was_enabled = READ_ONCE(kcsan_enabled);
> -       u64 cycles;
> +       ktime_t nsecs;
>
>         /* We may have been called from an atomic region; reset context. */
>         memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
> @@ -70,16 +70,16 @@ static noinline void microbenchmark(unsi
>
>         pr_info("%s begin | iters: %lu\n", __func__, iters);
>
> -       cycles = get_cycles();
> +       nsecs = ktime_get();
>         while (iters--) {
>                 unsigned long addr = iters & ((PAGE_SIZE << 8) - 1);
>                 int type = !(iters & 0x7f) ? KCSAN_ACCESS_ATOMIC :
>                                 (!(iters & 0xf) ? KCSAN_ACCESS_WRITE : 0);
>                 __kcsan_check_access((void *)addr, sizeof(long), type);
>         }
> -       cycles = get_cycles() - cycles;
> +       nsecs = ktime_get() - nsecs;
>
> -       pr_info("%s end   | cycles: %llu\n", __func__, cycles);
> +       pr_info("%s end   | nsecs: %llu\n", __func__, nsecs);
>
>         WRITE_ONCE(kcsan_enabled, was_enabled);
>         /* restore context */
>
