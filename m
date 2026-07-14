Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CAC448CE0
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032082; cv=none; b=e+P0OU8uBJKxP77F66c8A6FY5OTutPQ/SwTqYbdwne6WJd48JTQGL+AxLuCDbPAbzLegYoL/fWTS7gmAtVJVFqxNJMAf31BZcEtfSsBW25FpDrF9CrKfTXKNoRJ2lugVQeu6jVKocveqTU7YLAoeh8F3D4jWG8BrslO3hTWBK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032082; c=relaxed/simple;
	bh=zzEYaVVhSuGCuAAvI0y0XEVUpmDQVjrHVxuT2tgpuUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IImG+bS9r3qpNThH17GCcrtqmlC/x7bEEj+DBPmOColWsk3uqbVuVCUARaaYE3xMrcKubGgno9jGKXL+uZnVxp1xU6DFITmQ2IYVqJeqknExctW2ffhuyh9gRADzA6Dn6E6oNNrtLQhQ/KlUeYs3cViC3NOC2EIIxYH0AuJ8Q2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DsN8zTDv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DsN8zTDv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23AE11476;
	Tue, 14 Jul 2026 05:27:53 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 224FE3F7B4;
	Tue, 14 Jul 2026 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784032077; bh=zzEYaVVhSuGCuAAvI0y0XEVUpmDQVjrHVxuT2tgpuUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DsN8zTDveK+mVBpv6T2NXbyfwS9iLZFlYhMP6iJHbw5XNQF6IRrdDhP2N2W2jVV0T
	 oyemgLXS4Eeupb/X2xIpG0ZH/ptgErYr6CN/H5wqksizy12oqfoMVHzDWP3N6RiPwI
	 WV1hcCRMd24mHGvGYJELvV4RKgwKnzUuWWMh9e+g=
Message-ID: <3591a185-d0b5-4cb0-a0d5-ae9608a4e244@arm.com>
Date: Tue, 14 Jul 2026 13:27:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/riscv: Use 32-bit MMIO accesses for 64-bit
 registers
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
 Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Guo Ren <guoren@kernel.org>, David Laight <david.laight.linux@gmail.com>,
 Vivian Wang <wangruikang@iscas.ac.cn>, Zong Li <zong.li@sifive.com>,
 cuiyunhui@bytedance.com, yuanzhu@bytedance.com, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/07/2026 1:29 pm, Zhanpeng Zhang wrote:
> The RISC-V IOMMU specification [1] permits 64-bit registers to be accessed
> using two 32-bit transactions, high half first, and leaves the single-copy
> atomicity of 8-byte IOMMU register accesses unspecified.
> 
> Use the generic hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() helpers
> for ordinary 64-bit IOMMU registers. For DDTP, poll BUSY in the low half,
> then read the high half and compose the register value from the polled low
> half. HPM counter reads require a rollover-aware sequence and remain
> outside these accessors.
> 
> This follows the 32-bit access direction proposed by Guo Ren [2] and uses
> the generic non-atomic MMIO helpers suggested by David Laight.
> 
> [1] https://docs.riscv.org/reference/iommu/
> [2] https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org
> 
> Suggested-by: Guo Ren <guoren@kernel.org>
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
> Changes in v3:
> - Use the DDTP access sequence from [1]: retain the low half returned by
>    BUSY polling, read only the high half, and compose the DDTP value from
>    those two 32-bit reads.
> 
> Changes in v2:
> - Rework the patch based on Guo Ren's earlier proposal [1].
> - Drop the build-time option and use 32-bit accesses unconditionally.
> - Drop the global lock and use the generic high-low MMIO helpers, as
>    suggested by David Laight.
> - Poll DDTP.BUSY through its low half.
> 
> Link to v1: [2]
> Specification discussion: [3]
> 
> [1]: https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org
> [2]: https://lore.kernel.org/r/20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com
> [3]: https://github.com/riscv-non-isa/riscv-iommu/issues/765
> 
>   drivers/iommu/riscv/iommu.c | 9 ++++++---
>   drivers/iommu/riscv/iommu.h | 9 +++------
>   2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index cec3ddd7ab1..d647b71ebec 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -670,9 +670,12 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu)
>   
>   #define riscv_iommu_read_ddtp(iommu) ({ \
>   	u64 ddtp; \
> -	riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
> -				  !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
> +	u32 ddtp_lo, ddtp_hi; \
> +	riscv_iommu_readl_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp_lo, \
> +				  !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY), 10, \
>   				  RISCV_IOMMU_DDTP_TIMEOUT); \
> +	ddtp_hi = riscv_iommu_readl((iommu), RISCV_IOMMU_REG_DDTP + 4); \

It looks like whenever you read DDTP you're only really looking at the 
BUSY/MODE fields anyway, so does this actually need to read the upper 
bits of PPN at all? (The spec says they don't even need to be written on 
RV32 either)

> +	ddtp = ((u64)ddtp_hi << 32) | ddtp_lo; \
>   	ddtp; })
>   
>   static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
> @@ -1501,7 +1504,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
>   	 * regular boot flow and disable translation when we boot into a kexec
>   	 * kernel and the previous kernel left them enabled.
>   	 */
> -	ddtp = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> +	ddtp = riscv_iommu_read_ddtp(iommu);
>   	if (ddtp & RISCV_IOMMU_DDTP_BUSY)
>   		return -EBUSY;
>   
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 46df79dd549..1b03790fbe1 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -11,6 +11,7 @@
>   #ifndef _RISCV_IOMMU_H_
>   #define _RISCV_IOMMU_H_
>   
> +#include <linux/io-64-nonatomic-hi-lo.h>
>   #include <linux/iommu.h>
>   #include <linux/types.h>
>   #include <linux/iopoll.h>
> @@ -70,17 +71,13 @@ void riscv_iommu_disable(struct riscv_iommu_device *iommu);
>   	readl_relaxed((iommu)->reg + (addr))
>   
>   #define riscv_iommu_readq(iommu, addr) \
> -	readq_relaxed((iommu)->reg + (addr))
> +	hi_lo_readq_relaxed((iommu)->reg + (addr))

This seems unnecessary (similarly for writeq() below) - once you've 
included the header, then it automatically provides readq{_relaxed}() 
for RV32 via the non-atomic implementation, and wherever atomicity 
doesn't matter, then as written there seems to be no reason for RV64 to 
stop using the regular arch readq().

Not that it makes any difference to me either way, but I don't see any 
real issue with the spec - if software *may* make a 64-bit access to any 
64-bit register unconditionally, then that can only imply that hardware 
*must* be able to accommodate RV64 software choosing to do so, and 
therefore must support *both* 32b and 64b accesses in general, except 
perhaps on RV32-only systems if software could never make 64b accesses 
in the first place. If 64b single-copy atomicity is not 
required/specified then it should be valid to achieve that by just 
sticking a downsizer in the upstream interconnect to split 64b accesses 
into 32bx2 incremental bursts.

If do actually you need this as an erratum workaround to support 
specific hardware which has misinterpreted the spec then I think you 
should be clear about that. Otherwise, adding speculative "workarounds" 
which (slightly) penalise hardware that got it right, while inviting 
future hardware to get it wrong, doesn't seem like the right way to go 
at all...

Thanks,
Robin.

>   
>   #define riscv_iommu_writel(iommu, addr, val) \
>   	writel_relaxed((val), (iommu)->reg + (addr))
>   
>   #define riscv_iommu_writeq(iommu, addr, val) \
> -	writeq_relaxed((val), (iommu)->reg + (addr))
> -
> -#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
> -	readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
> -			   delay_us, timeout_us)
> +	hi_lo_writeq_relaxed((val), (iommu)->reg + (addr))
>   
>   #define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, timeout_us) \
>   	readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \

