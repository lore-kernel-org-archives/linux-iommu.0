Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4F632BF52;
	Mon, 15 Jun 2026 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527113; cv=none; b=M0EdoHLOevteRXwxBBoZLpGaEI5KvotR9cYLx+A4OKQz+rSMB679UgGAxoL6/E//BiaD4BxRixjyTro/GPosNxs4NFekzzhlDJEDsofA/la8u2C0ohzcuNqtqb2/evZ9pY/MzmxrD23mIKO1L2KH+KAeMO9qM5e3+ifmqpojpXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527113; c=relaxed/simple;
	bh=tzz0JSf1ZF0tUw8LwKVRiKptKJkeiPYuIws2VpU0R1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O58x3ndiqzWDXRylBP4VTb2W7rvTieyG1xLBiFMRma4+MMigKwNRxvLWZQqdL4bRyYu0IYMpjMuZcUZuWhS7R38+PfXpfvy62d41GE0VjVCkqQASpuS0VmuVmguQg/PwHODpyFxYmb0MNbb0D9hbrhf+slNtaFmHJ9iDdbLBnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3BmglUb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3BmglUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BF01F000E9;
	Mon, 15 Jun 2026 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781527112;
	bh=INa7GhoaDabxSDGA5GIOXW3gtQQqTT3ikXo5/4MfYq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j3BmglUb18g/fkPeaFFodkzF5td/9xsvfn5SdWuF2utMETdx4GtCDlw+Uj5WhCrox
	 plZjRQ+Slao5FoB3Gao+aJHnBI+50NfZe3q3ySWtOeqGpDnlR5+W6lMHHooQg8b3zm
	 MC/t03gDaS4dHjO66Mb+SW2EjVtiNHW/LUVXsAqf5jg6S1WVnzTXZK500XeUuc9X/N
	 XcvirrIjkEt29Ps/iql/ezNnrz4h9udC7rUqsmNVfYkn4VkGqbS4pmSNzyP5wzGcC6
	 X1r09qvFdtZwZig1+l1xUa4QhijVRdD7dqLmXgWaUm/M01jGfwCbjLCW41EaHuMI9y
	 dKwBCX7CaIlcQ==
From: Guo Ren <guoren@kernel.org>
To: zhangzhanpeng.jasper@bytedance.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	cuiyunhui@bytedance.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	luxu.kernel@bytedance.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	will@kernel.org,
	yuanzhu@bytedance.com
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
Date: Mon, 15 Jun 2026 12:38:17 +0000
Message-ID: <20260615123821.373248-1-guoren@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Zhanpeng Zhang,

I noticed you posted a similar fix recently. However, I had already
submitted a similar solution back in September 2025 [1]. It would be
great if you could review it. A few concerns with the current patch:

1. Using spin_lock_irqsave in such a small semantic structure is
unnecessary. IRQ protection should be provided by the higher-level
IOMMU driver interfaces. Many existing call sites already handle IRQ
disabling, so adding it here feels redundant and adds avoidable
overhead.

2. More critically, the RISCV_IOMMU_32BIT_ACCESS Kconfig option is
problematic. According to the RISC-V IOMMU specification (Software
Guidelines, “Reading and writing IOMMU registers”):

> Registers that are 64-bit wide may be accessed using either a 32-bit
> or a 64-bit access.

This clearly requires that any hardware supporting 64-bit MMIO access
must also support 32-bit MMIO access. Therefore, the IOMMU driver should
be built on a 32-bit access base for maximum hardware compatibility.

3. Only performance-monitoring counters require 64-bit IO access or the
high-low-high do-while retry strategy. For ordinary status and control
MMIO registers, a single read is sufficient.

4. Introducing a compile-time Kconfig that forces 32-bit splitting (or
64-bit access) across the entire driver is unnecessary for the vast
majority of registers and would prevent a single kernel Image (or .ko)
from working across all compliant platforms.

I believe the correct approach is to keep the driver on a 32-bit access
foundation (as required by the spec) and apply special 64-bit or
high-low-high handling only to performance-monitoring counters when
justified by data. This preserves broad hardware support without
unnecessary complexity.

What do you think? I’m happy to discuss or collaborate on a cleaner
solution based on the earlier patch [1].

[1]: https://lore.kernel.org/linux-riscv/20250903144217.837448-1-guoren@kernel.org/

Best Regards
  GUO Ren

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
> -- 
> 2.50.1 (Apple Git-155)
