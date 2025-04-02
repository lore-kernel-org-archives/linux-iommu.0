Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DB0236A61
	for <iommu@lists.linux.dev>; Wed,  2 Apr 2025 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743593343; cv=none; b=kkS3aZIfKDwiFBOqEIcvgvKjh2bfVqhty47sITxD47GtLsZrxOrGV6A30EeMWcl64fJUkZrAEuppaC3YOnAXOTvJhn/74MAZOMph5H9bqWGL58Gfb1vaxrSNEDHGAckzEP7SHA99GPEZojQodRZakh55EIhsI24f3DkWOczp8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743593343; c=relaxed/simple;
	bh=BdaMmivvGxIoTi/+df3TeXjXtYwmJDg6l5TeR3nVX6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uys/mWE1gZQHPBBNYxH1YfLZijhNBmmuO2crlf0UNa+cu7fvKaffi/xvORPxPq+PZicsks1fXrTo7KAfhVnCad8t+9/QxIy4Tjecw69ex2VDGvrrf8Z4NsLPALBgFJWPaW0BnzVTo0+R/FAez9XZnrACL6WLxwenKqoCorhk1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83758106F;
	Wed,  2 Apr 2025 04:29:02 -0700 (PDT)
Received: from [10.57.67.12] (unknown [10.57.67.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 417F23F694;
	Wed,  2 Apr 2025 04:28:57 -0700 (PDT)
Message-ID: <8cfe938f-5eff-483e-95a1-c4029993e287@arm.com>
Date: Wed, 2 Apr 2025 12:28:54 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: riscv: Split 8-byte accesses on 32 bit I/O bus
 platform
To: Xu Lu <luxu.kernel@bytedance.com>, tjeznach@rivosinc.com,
 joro@8bytes.org, will@kernel.org, alex@ghiti.fr
Cc: lihangjing@bytedance.com, xieyongji@bytedance.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250325144252.27403-1-luxu.kernel@bytedance.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250325144252.27403-1-luxu.kernel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-25 2:42 pm, Xu Lu wrote:
> Introduce a new configuration CONFIG_RISCV_IOMMU_32BIT to enable
> splitting 8-byte access into 4-byte transactions for hardware platform
> whose I/O bus limits access to 4-byte transfers.
> 
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>   drivers/iommu/riscv/Kconfig |  9 +++++++++
>   drivers/iommu/riscv/iommu.h | 28 +++++++++++++++++++++++-----
>   2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> index c071816f59a6..b7c9ea22d969 100644
> --- a/drivers/iommu/riscv/Kconfig
> +++ b/drivers/iommu/riscv/Kconfig
> @@ -18,3 +18,12 @@ config RISCV_IOMMU_PCI
>   	def_bool y if RISCV_IOMMU && PCI_MSI
>   	help
>   	  Support for the PCIe implementation of RISC-V IOMMU architecture.
> +
> +config RISCV_IOMMU_32BIT
> +	bool "Support 4-Byte Accesses on RISC-V IOMMU Registers"
> +	depends on RISCV_IOMMU
> +	default n
> +	help
> +	  Support hardware platform whose I/O bus limits access to 4-byte
> +	  transfers. When enabled, all accesses to IOMMU registers will be
> +	  split into 4-byte accesses.
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 46df79dd5495..0e3552a8142d 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -14,6 +14,10 @@
>   #include <linux/iommu.h>
>   #include <linux/types.h>
>   #include <linux/iopoll.h>
> +#ifdef CONFIG_RISCV_IOMMU_32BIT
> +#include <linux/io-64-nonatomic-hi-lo.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#endif
>   
>   #include "iommu-bits.h"
>   
> @@ -69,21 +73,35 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
>   #define riscv_iommu_readl(iommu, addr) \
>   	readl_relaxed((iommu)->reg + (addr))
>   
> -#define riscv_iommu_readq(iommu, addr) \
> -	readq_relaxed((iommu)->reg + (addr))
> -
>   #define riscv_iommu_writel(iommu, addr, val) \
>   	writel_relaxed((val), (iommu)->reg + (addr))
>   
> +#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
> +	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
> +			   delay_us, timeout_us)
> +
> +#ifndef CONFIG_RISCV_IOMMU_32BIT
> +#define riscv_iommu_readq(iommu, addr) \
> +	readq_relaxed((iommu)->reg + (addr))
> +
>   #define riscv_iommu_writeq(iommu, addr, val) \
>   	writeq_relaxed((val), (iommu)->reg + (addr))
>   
>   #define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
>   	readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
>   			   delay_us, timeout_us)
> +#else /* CONFIG_RISCV_IOMMU_32BIT */
> +#define riscv_iommu_readq(iommu, addr) \
> +	hi_lo_readq_relaxed((iommu)->reg + (addr))
>   
> -#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
> -	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
> +#define riscv_iommu_writeq(iommu, addr, val) \
> +	((addr == RISCV_IOMMU_REG_IOHPMCYCLES) ? \
> +	 lo_hi_writeq_relaxed((val), (iommu)->reg + (addr)) : \
> +	 hi_lo_writeq_relaxed((val), (iommu)->reg + (addr)))

Echoing Jason's comment, what is this even trying to achieve? Nothing in 
the spec suggests that the cycle counter register is functionally 
different from the other PMU counter registers (other than its 
self-contained overflow bit).

It is not, in general, safe to do a split write to a running counter 
either way - low-high vs. high-low just moves the problem around, 
changing *which* combinations of values are problematic and capable of 
overflowing into each other between the writes. If the PMU driver can't 
write counters atomically, it will need to ensure that it only ever 
write them while stopped (at which point the order surely shouldn't 
matter). Conversely, though, reading from running counters is a bit more 
reasonable, but it needs more than just hi_lo_readq to guarantee it's 
not got a torn result.

Thanks,
Robin.

> +
> +#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
> +	readx_poll_timeout(hi_lo_readq_relaxed, (iommu)->reg + (addr), val, cond, \
>   			   delay_us, timeout_us)
> +#endif /* CONFIG_RISCV_IOMMU_32BIT */
>   
>   #endif

