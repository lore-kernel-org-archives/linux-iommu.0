Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B4313E10
	for <iommu@lists.linux.dev>; Sun, 12 Apr 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775984199; cv=none; b=PaoucwdMya3/vsf5lG6jajgv5XlP7cuR54//GtJn3rrCXLe4wDgzCrN5RO7qq9GJKWLEneSth3uRn4RBON3wylQNaPPPIpQbGICM8Ms/2vNSSSUWxqWtTgaDvTkoaBYo35W6pYNWu+7VvX0LjITDGmXHsCNanAyxXHfggoFl4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775984199; c=relaxed/simple;
	bh=XZtsBYJ+xUzK/w66hhh7L4ep5/Nv3d9zyXSTiNiHtzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBob1VLEdl1atvMzGDs0etxC244oFJtMYX1AdWgnFihD+AU7zegupmZAjnW6yk8Pa0oXr+P+fvoPGSzBxbhbyptXAd3G69clAMaue5FC9LCNVY9Hh9qoIEcAOZoNYKmifZkdt++NpAeeKNnTcQmQ5owvfkSjLT7qbYWa0X7k/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmMcTnV1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmMcTnV1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-482f454be5bso36434225e9.0
        for <iommu@lists.linux.dev>; Sun, 12 Apr 2026 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775984196; x=1776588996; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbDgrbrkQIZIzHMqS4zyFwb8jbE/7QCDRz8zhtNheE4=;
        b=BmMcTnV1OowlZqbZ1jrfd98WJphSxWy5+lBeGqwecH8euKBjY4tFO0fQHQTkJRIZ7w
         pWnkNg9AnO/PL9hOQgGXOjyiiRrRYM2UIuQG8eSMEeVKlHlHuIMjyqA97ASczbe+hnKs
         FbqazQ1Q1ySH4XwT1wrqQaMu2BUSrc0RoN3VZ4QqSPuZnnBQnJ6R6UCvI/SpdZ6xm2aj
         BCO1iktwBXd1krkdeTlXoTdqvfQsdgof72VbJkP+bmp4bTPH/DmsfwPtEIENYaR7FQ4c
         nt+J9lzzOYKvA3eBoaa8sed5Ql4ueHYFP3QnePmfv9+xw6yrcDgaeFpiVSKT8CAGDynV
         G1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775984196; x=1776588996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbDgrbrkQIZIzHMqS4zyFwb8jbE/7QCDRz8zhtNheE4=;
        b=UAGLTyMrBlkuAiTCOvLAbFJQRYbeqnDZJ0tuPktl3Saljoah5X9bskONYbvM0tK13Y
         qwpek+z22ibJxyWJ7yqeZE7tAh7NvkCOIAliSoc9RB5O8yeDHhj8z+PzCM/eLfm/seMD
         X1CxQTSpXujLDYPEMUtCDfF1861ot8UbhYQXZvRmnNLDe0b1pQlHxODqf0Y01IikdTm+
         bjORzPfPVuzZJr0R8F9LTo30lIDBx+IRQwLdTp1mdN0jJ7D9fwsAu7xVaFMVLIyrAJiQ
         siLX6AYKzukZgvFesH9h39WYk90u561vBtGH951pddt754uONh46P8g5dB9fwtKqbLJB
         WnCg==
X-Forwarded-Encrypted: i=1; AJvYcCV8jh5nxx0L6OUtXl2qSLyfs3swBY8Q5Vlt9nPgaz0+Jg62PL6ScDMfQuMD5LcqeuNM20CZJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdAPEAKaXnpz/qPg3uWqBCx4NHCTZbuycLyM384eFgXOziJYe0
	jHzF/JPc/1Gao0nmM8VM8s7bQH5lPRp4YDlJ2qjl84pS2ZgJfQY7l9fw
X-Gm-Gg: AeBDiesKfSW/wTijE6cNhcXknam3yNJkZYnFj3xGU5L1Z6EG71W/3IHig20uVlkRPhy
	WhMHsWZGVfrL5NOC3yq9iIjVHjgjIjrwJsNQv18i4GU898xvD1Bnus/bWs1Us8co2ji5e/vJUlc
	aRjiHnMHht/emqIi/BLLOXxQWXV0ABUoMai9uRPQ+wnGiJ1mCzP3q8qHgE0+XHW/0xmzcTtlPCX
	KJapKvkUIxobL9wg4zYYTh/x8x07v/ADIFgepES9S6wnHuMuRqNnUxfpIxzXUWh8mSq6AN8y8WG
	yb7tndUV8pMs98qgnmF4/ayiu6SvfLGOSiBLBzSrwRrrEWKwXGzc+e0ZQ81bISE8gOQj1lCw78w
	soIG6yoXmHr982XiNXEh6kSyWk8t6TSlp5ZdMUSjsdZT4AF+aL4c5C8cRHAHI5+t1vwMigPCTHK
	if/l4VTt8tJqnvRrRVx6eFh5RGidMXMeqcVGrSZcKI2QTTkhM0ksQbSt0HsVOGpIwUpvZlLL3FT
	xdEzA==
X-Received: by 2002:a05:600c:698d:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-488d6ac9ce5mr126951995e9.14.1775984195334;
        Sun, 12 Apr 2026 01:56:35 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm197923925e9.4.2026.04.12.01.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 01:56:34 -0700 (PDT)
Date: Sun, 12 Apr 2026 09:56:33 +0100
From: Stafford Horne <shorne@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>,
	linux-openrisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>,
	Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	linux-alpha@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Subject: Re: [patch 30/38] openrisc: Select ARCH_HAS_RANDOM_ENTROPY
Message-ID: <adteQSw8c65MtX5l@antec>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.593798781@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410120319.593798781@kernel.org>

On Fri, Apr 10, 2026 at 02:20:55PM +0200, Thomas Gleixner wrote:
> The only remaining non-architecture usage of get_cycles() is to provide
> random_get_entropy().
> 
> Switch openrisc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
> 
> Add 'asm/timex.h' includes to the relevant files, so the global include can
> be removed once all architectures are converted over.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: linux-openrisc@vger.kernel.org

This looks good to me.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/Kconfig              |    1 +
>  arch/openrisc/include/asm/random.h |   12 ++++++++++++
>  arch/openrisc/include/asm/timex.h  |    5 -----
>  arch/openrisc/lib/delay.c          |    1 +
>  4 files changed, 14 insertions(+), 5 deletions(-)
> 
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -10,6 +10,7 @@ config OPENRISC
>  	select ARCH_HAS_DELAY_TIMER
>  	select ARCH_HAS_DMA_SET_UNCACHED
>  	select ARCH_HAS_DMA_CLEAR_UNCACHED
> +	select ARCH_HAS_RANDOM_ENTROPY
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select GENERIC_BUILTIN_DTB
>  	select COMMON_CLK
> --- /dev/null
> +++ b/arch/openrisc/include/asm/random.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __ASM_OPENRISC_RANDOM_H
> +#define __ASM_OPENRISC_RANDOM_H
> +
> +#include <asm/timex.h>
> +
> +static inline unsigned long random_get_entropy(void)
> +{
> +	return get_cycles();
> +}
> +
> +#endif
> --- a/arch/openrisc/include/asm/timex.h
> +++ b/arch/openrisc/include/asm/timex.h
> @@ -9,13 +9,9 @@
>   * OpenRISC implementation:
>   * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
>   */
> -
>  #ifndef __ASM_OPENRISC_TIMEX_H
>  #define __ASM_OPENRISC_TIMEX_H
>  
> -#define get_cycles get_cycles
> -
> -#include <asm-generic/timex.h>
>  #include <asm/spr.h>
>  #include <asm/spr_defs.h>
>  
> @@ -23,6 +19,5 @@ static inline cycles_t get_cycles(void)
>  {
>  	return mfspr(SPR_TTCR);
>  }
> -#define get_cycles get_cycles
>  
>  #endif
> --- a/arch/openrisc/lib/delay.c
> +++ b/arch/openrisc/lib/delay.c
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  
>  #include <asm/param.h>
> +#include <asm/timex.h>
>  #include <asm/processor.h>
>  
>  bool delay_read_timer(unsigned long *timer_value)
> 
> 
