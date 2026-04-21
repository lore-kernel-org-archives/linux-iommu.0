Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FA03BE632
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770577; cv=none; b=RBXW6mXvMEr8ciI/+s18P72mesCrmvJcPcUOUoNchMFqpbncluUlaFQ1+kkfyIbLa+2Dd3hb3hqP3YI2Q7zQcUkR6r8mt5n79Gc8jLninRVqV9t5gJT0HCtgndu2x+3LRnFoBxBsS94dfURnPVgm3/A8KR9VvX6/4xUBjTfB/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770577; c=relaxed/simple;
	bh=7J5sLUyTcEtZ5b/o54KJz2TjlXrWGH0W+oigsdVGJYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUgGYf8bFOxHA9Eb/ampr15QFqEmWhSb8pURCrmCmkH/AU7I2IByR3Of9HvBTB+/3/VMFcBHphsCvfk8HUtt4l1xzFT7eGwZiohA4OqmRcrJdLZaJhc9gj0fYyUrUddDSFYyYb3/8w8e4+hVpIZsXjWP67QLsJU4vt5xc4wWzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt5tYEHs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt5tYEHs"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f943870baso1460247b3a.1
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 04:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776770574; x=1777375374; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbepvZoiaQHnY8ojgGndHUN0tqRJnJo2KRx8HLgDgUI=;
        b=Qt5tYEHsZVMsVADO5g2oK6XlFXsGr3FzRRPhYPG4oIGd443zerq+6ihtJV+Ke67qd5
         K7q9KpnwT2VI61yZ85yHOQHu9wHdNv5orMPh7nZW4WiRveCSqkVe3jabuksJPJE39j2L
         JTQPHw8uTCL30IrpWghB6+nJ5nwUuKLUXDK4NrooFT+rENWXZKMIxsmg+yNkC4TXEVJJ
         1hws5n0Vgjv/Go1vlznQwHoEy73Lqelz4gH8RYDIAYGTOJ8WJ5yB/KLd2psWU/iIWNOv
         4rz/TEn4hJ9YmBNzxgYhDC/1Rr6heZWkyZ9/d41PasihBhzClTeGDdU8Ma2c4OPMoi2D
         /YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770574; x=1777375374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbepvZoiaQHnY8ojgGndHUN0tqRJnJo2KRx8HLgDgUI=;
        b=K0ArphnbrnZcTTx6LIaip1NaKMLBzP11ZF0vvyP5y+hD8VRSHOu5J8SFukB141bx7V
         DR1Xqe4bTL02hA/jtDoaVIRSPyvHam0kHJtfrprUPvUz7eJ+nW40rrr1TM2+c53hLlkW
         DX75icayNAoKcKpaU56CW2FEMxb27OpODDTS3yj32SrfkTqHKqZ6Y7qTBbDpu4NF8x0h
         vzuUEcDWNAMdYicNHflJrehMKLfJ9O4LqjGCSz3uxIQJf5CK29EUzZftenfYHeLFd7Nq
         fk8uQ2UpdOwu9hVLEYwwNvIiOluAcULo7uvwSzSPiQLkRC/50W+YIN98TkFvaNgw2pW9
         y4fQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9p1563sBIWZlUxNYIIy3fZh7C+DDs5sr9iVrmJssiSDkF9iam0mlyIzf2rNsgWx3a6w608Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtMjd8GWbglOljoNvKSrtzHzpJLiqeElDD/7mvMhLk7PimdAdI
	KI8VMGO6e8zzbB4x2zXRx07t2Y9ugj+8mhLBssZAuZ0JVj+3rrY+d4HM
X-Gm-Gg: AeBDieuZY14Bj//KMw6sNGWxRlqcF/K2hToJhDqF+gaUpK63F3tOQSKJHCN3q+EjwkI
	o363xEmdTZBPooDCenioyhrAx+1Wsnc+1i2KXAOLB4Ju75ilWFFTYIq7BwCLOlX1giniaUCJivg
	WlhADAvCY/bnlLvom3QF1sLujk3SiJZuEJyK3sEp4dhXN+8K0OGkR8M1yQwhraKNchcgyVplt6P
	4/WtQh2uOf1k6sNXh3T/hYtfmLMi40IbY9+8TEDUxDJRbONDW1XbiiKTmsHQKHQqE0YFDJlvCtG
	032ANvHiBzPZBJDjckmBi2CZte+zyQRdFDopyrlPN4e4feptEOZaGEgdXrAKx5ZOMIzuNbsUTtO
	hF6IotTK9zPG1WYDsPaJQ4L1MJsAvTS6OTi65dat2YQ8htH1LodjMdl7OKZZz0Sh7ll4nCjzJsk
	3DqVhs1y3EAVBDhSDVT1mrOmdgjGNg6mrAFBQ3c2GwvNgg9lwYBAnG9IJDZRl/LWha3/JZN52Jr
	KwUow==
X-Received: by 2002:a05:6a00:6988:b0:82f:aae5:c7a9 with SMTP id d2e1a72fcca58-82faae5d438mr7228492b3a.27.1776770573719;
        Tue, 21 Apr 2026 04:22:53 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981a0asm14155014b3a.3.2026.04.21.04.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:22:53 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:52:37 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, 
	x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, 
	Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>, 
	Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 33/38] powerpc: Select ARCH_HAS_RANDOM_ENTROPY
Message-ID: <aedc9UddBSYXzrAj@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.789114053@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410120319.789114053@kernel.org>

On Fri, Apr 10, 2026 at 02:21:09PM +0200, Thomas Gleixner wrote:
> The only remaining usage of get_cycles() is to provide random_get_entropy().
> 
> Switch powerpc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
> 
> Remove asm/timex.h as it has no functionality anymore.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/Kconfig              |    1 +
>  arch/powerpc/include/asm/random.h |   13 +++++++++++++
>  arch/powerpc/include/asm/timex.h  |   21 ---------------------
>  3 files changed, 14 insertions(+), 21 deletions(-)
> 
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -150,6 +150,7 @@ config PPC
>  	select ARCH_HAS_PREEMPT_LAZY
>  	select ARCH_HAS_PTDUMP
>  	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_RANDOM_ENTROPY
>  	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
>  	select ARCH_HAS_SET_MEMORY
>  	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S || PPC_8xx) && !HIBERNATION
> --- /dev/null
> +++ b/arch/powerpc/include/asm/random.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_RANDOM_H
> +#define _ASM_POWERPC_RANDOM_H
> +
> +#include <asm/cputable.h>
> +#include <asm/vdso/timebase.h>
> +
> +static inline unsigned long random_get_entropy(void)
> +{
> +	return mftb();
> +}
> +
> +#endif	/* _ASM_POWERPC_RANDOM_H */
> --- a/arch/powerpc/include/asm/timex.h
> +++ b/arch/powerpc/include/asm/timex.h
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_POWERPC_TIMEX_H
> -#define _ASM_POWERPC_TIMEX_H
> -
> -#ifdef __KERNEL__
> -
> -/*
> - * PowerPC architecture timex specifications
> - */
> -
> -#include <asm/cputable.h>
> -#include <asm/vdso/timebase.h>
> -
> -ostatic inline cycles_t get_cycles(void)
> -{
R> -	return mftb();
> -}
> -#define get_cycles get_cycles
> -
> -#endif	/* __KERNEL__ */
> -#endif	/* _ASM_POWERPC_TIMEX_H */
> 
Build tested for this series with allmodconfig and allyesconfig on ppc64le
machine for ppc64le.
tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git getcycles-v1

Boot tested for this series on powernv9 qemu, powernv10 qemu and pSeries
power11 hardware.

Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

