Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106823DB961
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517604; cv=none; b=sXLHLSuv1ScoojKxbH1Vvebdc5vP3BCIw2Bws8gmi/U2g3PktZm73N5mM2OB04dxLqvPWvnwiww8Ly1CCQ304lg12YdOIteqkXFf7ptLWTjpKOzn6tI+Ghk+/lxXJM3u2ubhWTZ1zJb2q27JDgslgyCiFURlkH6AdDEjy+92xTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517604; c=relaxed/simple;
	bh=3wXcpfM+S5tmyfpHkwf6cFdOFFat2m79jZMaL5c6R8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogV8613mAQBaucnTjqkhj1vENVNKELgK74pNwr/mY+cFmixMXuEVDfXt5O74PjUCofYeHSHgXQuLefJyBkl7qo2aW4x3JPXmXQ5p82xGiTO8VvUudTVTaMzOELMf6Di7vU+zPFadFCmd2ALRumYmARj8vO1sFU5WfeuwHaTuzNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgrnFDll; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgrnFDll"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4619990ca5fso469824f8f.1
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781517601; x=1782122401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/40NyX5fmI7vs0/LA5CZV+IOaV0U2Xfp7EO4Khsh9Vc=;
        b=FgrnFDll3s019/Mh2IzTYW29GX9rnHX91V9IJlG+eMejNDEByuk84rQbFrCqs9N4RZ
         0HGHoT6bEV1ipkSq/0e4pf/pIWYBRSZ9j2m1+tjXoSd4Qaq+HWkyd/zvRHJ7xKfrwngx
         hvkUsZ4jW2pB+qfHlNTxVUqOE14B0PRWmR9U3F4gzIhoxk7jpGHFIJwllQ8XFDPasXvf
         t14YUeVqcev9OoMUuU9krjxCBZdtOm2yGRIJlC0ea7j1p8TdKZ4NR5pcoXC4Un5OCRtl
         +JArt9iwd1AuyEEjkF1bWvtzD5cA4QNh2+26Bh/B6vIczLn92hRtrHbEEx+Bb6wb7er7
         AvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781517601; x=1782122401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/40NyX5fmI7vs0/LA5CZV+IOaV0U2Xfp7EO4Khsh9Vc=;
        b=ERLpbZmkCi+7uwFm6kB6g5sRDKTsQ2p0PNlmuEuv/5C6SpL+StfcdfZtl9QtvqU1Er
         fovX9UVqtL9Pn0+aolViO5TB9iihJZgTuI1ls+DR/27YIxxf/9DmXUeD/AntrGsS4jkf
         zAZkfXwh78FaCdpfov86TlYYNBgsZU0847TOkPEssPTB1cn7IetaGzI8Lr/fKatkZH7e
         Dn4VWec+Jg9sxi+F5rCtJiul76XMIa4tWZN9vFNWEusEDdTSLNhHaLG6MoAu8aOu2FPb
         sYnhPBIlUWZ1DhQ9KFZk3AZ0GxBp0lV1qOPssAMV1inuZWhD4Sw9UguWjBK34l8lWYyO
         XeaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NzC/h6W8FVIpzm3GKHJkZiRR2y0iSG9oeoKOAx+UZqVBIV/QzVDVEURkiHrWtJ3weBidqdw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3dHDHBuwy7y/j40trYMEPEZhVWc82l8+7A63Svs+FjEhy+D+d
	4IGAC3XF+umeEeUGd0/i4dmLcsNjp/5O8inZPOu4+B5A4n6DXL4z4Wc4
X-Gm-Gg: Acq92OGQ1UnKVY+Hpgs5VICxomoTHq7Qs9xT0VQbuJWR3gbyIuODgbQrAZ2P2g47hfu
	izEHbJqDvzaZgBdLuOSH2URMhKA8uQxyp4LsgD8WfDcpw5I3RBI4PuHfmI0AO01kFXSoq7BXDmI
	AW13eHgKHA5QkyrFvLY5T3R29QbxTVaWgQRV+NTZf/5dDFhqijb4beiuPvEQrvUZum/A+IexThm
	plswl/JQvkPDFkptZxLZ6xmlv0mDqPCHZXTzTRsHB3rCocS5ZtXskJWYEj1MMaoFQPQ9uJFrzzx
	O6cIjRt0f8GdwsZTMzfohKC2SmCFckjdBT6dqotm13ikxG0HlJ37PulAVDEapceUOmxaqiMll04
	wV916RSQB/hlxgImC9GLnEQh7Eu8+y0elON7YOsLyzrVFncP38YuegMro5A9dwb0aruxk9zQh3C
	lJKxaxNagMsb7ewyKaCBQZLDRFOT7wIlEzdWIwgW/eR/uRtkYsWojDeFrbZ9nWeUJWWq8ft9I=
X-Received: by 2002:a05:600c:6d8b:b0:492:1e36:bb03 with SMTP id 5b1f17b1804b1-4922011dfd7mr98130405e9.36.1781517600965;
        Mon, 15 Jun 2026 03:00:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619b9b7750sm5526943f8f.6.2026.06.15.03.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 03:00:00 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:59:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Xu Lu <luxu.kernel@bytedance.com>,
 cuiyunhui@bytedance.com, yuanzhu@bytedance.com
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
Message-ID: <20260615105959.136698e8@pumpkin>
In-Reply-To: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 14:48:55 +0800
Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com> wrote:

> Some RISC-V IOMMU implementations cannot perform 64-bit MMIO accesses
> to the IOMMU register file. The RISC-V IOMMU architecture allows 64-bit
> registers to be accessed using 32-bit accesses, provided the accesses are
> properly aligned and do not span multiple registers.
> 
> Add a config option for such implementations and access 64-bit IOMMU
> registers as paired 32-bit MMIO operations when it is enabled. Serialize
> the paired accesses so the high and low halves cannot interleave with
> another CPU. Full 64-bit register programming writes the high half before
> the low half.
> 
> This option describes the register access width. It is not an RV32 kernel
> mode and does not describe a 32-bit IOMMU architecture.
> 
> Co-developed-by: Xu Lu <luxu.kernel@bytedance.com>
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
> This is needed for platforms whose RISC-V IOMMU register window does not
> support naturally aligned 64-bit MMIO accesses.
> 
>  drivers/iommu/riscv/Kconfig | 11 ++++++++
>  drivers/iommu/riscv/iommu.c |  4 +++
>  drivers/iommu/riscv/iommu.h | 55 +++++++++++++++++++++++++++++++++----
>  3 files changed, 64 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> index b86e5ab94183..54d624b9b2ef 100644
> --- a/drivers/iommu/riscv/Kconfig
> +++ b/drivers/iommu/riscv/Kconfig
> @@ -22,3 +22,14 @@ config RISCV_IOMMU_PCI
>  	def_bool y if RISCV_IOMMU && PCI_MSI
>  	help
>  	  Support for the PCIe implementation of RISC-V IOMMU architecture.
> +
> +config RISCV_IOMMU_32BIT_ACCESS
> +	bool "Use 32-bit accesses for RISC-V IOMMU registers"
> +	depends on RISCV_IOMMU
> +	help
> +	  Say Y when the RISC-V IOMMU MMIO window cannot be accessed
> +	  using naturally aligned 64-bit loads and stores.
> +
> +	  When enabled, 64-bit IOMMU registers are accessed as paired
> +	  32-bit MMIO operations. This option does not describe an RV32
> +	  kernel or a 32-bit IOMMU architecture.
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index a31f50bbad35..7fa1721b5728 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -53,6 +53,10 @@ struct riscv_iommu_devres {
>  	void *addr;
>  };
>  
> +#ifdef CONFIG_RISCV_IOMMU_32BIT_ACCESS
> +DEFINE_RAW_SPINLOCK(riscv_iommu_32bit_access_lock);
> +#endif
> +
>  static void riscv_iommu_devres_pages_release(struct device *dev, void *res)
>  {
>  	struct riscv_iommu_devres *devres = res;
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 46df79dd5495..ba78ef1858c5 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -14,6 +14,9 @@
>  #include <linux/iommu.h>
>  #include <linux/types.h>
>  #include <linux/iopoll.h>
> +#ifdef CONFIG_RISCV_IOMMU_32BIT_ACCESS
> +#include <linux/spinlock.h>
> +#endif
>  
>  #include "iommu-bits.h"
>  
> @@ -69,21 +72,61 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
>  #define riscv_iommu_readl(iommu, addr) \
>  	readl_relaxed((iommu)->reg + (addr))
>  
> -#define riscv_iommu_readq(iommu, addr) \
> -	readq_relaxed((iommu)->reg + (addr))
> -
>  #define riscv_iommu_writel(iommu, addr, val) \
>  	writel_relaxed((val), (iommu)->reg + (addr))
>  
> +#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
> +	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
> +			   delay_us, timeout_us)
> +
> +#ifndef CONFIG_RISCV_IOMMU_32BIT_ACCESS
> +#define riscv_iommu_readq(iommu, addr) \
> +	readq_relaxed((iommu)->reg + (addr))
> +
>  #define riscv_iommu_writeq(iommu, addr, val) \
>  	writeq_relaxed((val), (iommu)->reg + (addr))
>  
>  #define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
>  	readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
>  			   delay_us, timeout_us)
> +#else /* CONFIG_RISCV_IOMMU_32BIT_ACCESS */
>  
> -#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
> -	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
> -			   delay_us, timeout_us)
> +extern raw_spinlock_t riscv_iommu_32bit_access_lock;
> +
> +static inline u64 __riscv_iommu_readq_relaxed(void __iomem *addr)
> +{
> +	u32 lo, hi;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&riscv_iommu_32bit_access_lock, flags);
> +	do {
> +		hi = readl_relaxed(addr + sizeof(u32));
> +		lo = readl_relaxed(addr);
> +	} while (hi != readl_relaxed(addr + sizeof(u32)));
> +	raw_spin_unlock_irqrestore(&riscv_iommu_32bit_access_lock, flags);

Why the lock and the loop?
If you need the loop (for places where the hardware might be changing
both words?) then there is no need to read 'hi' twice when you loop.

But does it make any sense to be reading the value either while the hardware
is updating it (does that happen?) or concurrently with a write.


> +
> +	return ((u64)hi << 32) | (u64)lo;
> +}
> +
> +static inline void __riscv_iommu_writeq_relaxed(u64 value, void __iomem *addr)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&riscv_iommu_32bit_access_lock, flags);
> +	writel_relaxed((u32)(value >> 32), addr + sizeof(u32));
> +	writel_relaxed((u32)value, addr);
> +	raw_spin_unlock_irqrestore(&riscv_iommu_32bit_access_lock, flags);

What are you actually locking against?
I'm pretty sure it doesn't make any sense for two cpu to be writing to the
same entry at the same time.

Can't the writel_relaxed() be re-ordered, so you aren't guaranteeing they'll
be done high-low.
Same with the reads.

	David

> +}
> +
> +#define riscv_iommu_readq(iommu, addr) \
> +	__riscv_iommu_readq_relaxed((iommu)->reg + (addr))
> +
> +#define riscv_iommu_writeq(iommu, addr, val) \
> +	__riscv_iommu_writeq_relaxed((val), (iommu)->reg + (addr))
> +
> +#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
> +	readx_poll_timeout(__riscv_iommu_readq_relaxed, (iommu)->reg + (addr), \
> +			   val, cond, delay_us, timeout_us)
> +#endif /* CONFIG_RISCV_IOMMU_32BIT_ACCESS */
>  
>  #endif

