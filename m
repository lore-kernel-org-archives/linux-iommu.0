Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E954219E8
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600118; cv=none; b=ph/boHDF5atfOoAHywhnnBkPz4iqL4wBotwDOvVUdlrpOxsD31bzDaIQluwe9ZRLxbGktDtIE2OFDYs8QotNuQfJSo58KMEyu/Pv5ifmtvh1qczrmWl8o1mWsCahcMN0UYtfgYCR7mlpryJxmj8nZAsI5FLo7GnncbtZfSM07EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600118; c=relaxed/simple;
	bh=NnmsjNhmzW8bThr0JWOuKyFi1grEkGRM8hcunCmz8cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvQvtflOmjTFh3xAzlIphtQW432AKhqd4syi5cDPphpzRypCuMHmNJVqbYLFtyZU9/avyPmxRXbB5HAuPl+7ykVSamEie0S6tpIvWb2TjtXjDdPT+fIWHXLfXaW2HcgvLelqo3/yZYJNyVzauwO0y4V9gVzHWaVb644B5XOl4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SueM+Xfo; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SueM+Xfo"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0E751684;
	Thu,  9 Jul 2026 05:28:31 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EAD23F66F;
	Thu,  9 Jul 2026 05:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783600116; bh=NnmsjNhmzW8bThr0JWOuKyFi1grEkGRM8hcunCmz8cg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SueM+Xfo0cdmmUSQ+xzz4/+MZ+JENGI5JGQsNpGkY99Cas7h0ao728fHm6tkvi4Jx
	 ZQQNmwdFGSY93bqNWhdRCH27jM9l24R3zdCD4kBXo8bRnFGm900NPXAkFCHBHt1wkE
	 Lq7MD5nIVl3YvO4kuIcgfyyXhpogpdRqJtmhLja8=
Message-ID: <7c21e121-9bce-469e-a983-adbdf3781842@arm.com>
Date: Thu, 9 Jul 2026 13:28:30 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] x86/pci-dma: add "any" keyword to swiotlb= kernel
 parameter
To: Aakarsh Jain <aakarsh.jain@oss.qualcomm.com>, m.szyprowski@samsung.com
Cc: corbet@lwn.net, skhan@linuxfoundation.org, akpm@linux-foundation.org,
 bp@alien8.de, rdunlap@infradead.org, peterz@infradead.org,
 feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com, elver@google.com,
 enelsonmoore@gmail.com, kuba@kernel.org, lirongqing@baidu.com,
 ebiggers@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 aneesh.kumar@kernel.org, alexey.kardashevskiy@amd.com,
 thomas.lendacky@amd.com, jeff.hugo@oss.qualcomm.com, thanson@qti.qualcomm.com
References: <20260708114244.246176-1-aakarsh.jain@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260708114244.246176-1-aakarsh.jain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/2026 12:42 pm, Aakarsh Jain wrote:
> CoCo guests (AMD SEV-SNP, Intel TDX) require large swiotlb pools for
> streaming DMA workloads such as high-speed NIC and AI accelerator
> inference. The existing swiotlb pool allocator restricts placement to
> low memory (below 4GB by default), capping usable pool size at ~1GB even
> when a larger pool is requested via swiotlb=<nslabs>.
> 
> The SWIOTLB_ANY flag already exists to lift this restriction, and
> swiotlb_init_remap() already handles it correctly via the flags
> parameter (see CONFIG_SWIOTLB_DYNAMIC path: io_tlb_default_mem.phys_limit
> is set to virt_to_phys(high_memory-1) when SWIOTLB_ANY is set).
> 
> However, there is no way to set SWIOTLB_ANY from the command line. The
> only existing mechanism was via arch-specific code (e.g. powerpc SVM sets
> SWIOTLB_ANY in pci_iommu_init). x86 CoCo guests have no such path.
> 
> After Aneesh  series ("dma-mapping: Track shared DMA state through
> direct, pool and swiotlb paths", https://patchwork.kernel.org/project/linux-arm-kernel/cover/20260701054926.825925-1-aneesh.kumar@kernel.org/)
> removes SWIOTLB_FORCE, x86 pci_swiotlb_detect() leaves x86_swiotlb_flags = 0 for
> CoCo guests. The pool falls back to low memory and caps at ~1GB:

This is entirely irrelevant; SWIOTLB_FORCE has no impact on allocation 
behaviour anyway. x86 wasn't passing SWIOTLB_ANY before and it still 
isn't, although there doesn't seem to be any particular reason why the 
well-reviewed patch for that hasn't been picked up:

https://lore.kernel.org/lkml/20260625012616.2992535-1-jun.miao@intel.com/

>    Without "any": pool at 0x35a9c000 (~900MB, below 4GB boundary)
>    With    "any": pool at 0x1df9c00000 (~120GB, anywhere in RAM)
>    [Tested on AMD SEV-SNP guest, swiotlb=4194304]
> 
> Add "any" as a new keyword to the swiotlb= kernel parameter. This is an
> explicit, opt-in mechanism that sets SWIOTLB_ANY for the default pool at
> boot time, without touching any arch-specific code.
> 
> Devices with 32-bit DMA masks are not affected, they still use the normal
> low-memory bounce buffer path. The "any" option is only meaningful for
> workloads where all active DMA devices have 64-bit masks.

That doesn't make any sense - if a user passes this option then any 
devices with DMA addressing limitations definitely *are* going to be 
affected, and quite likely broken altogether. If anything, the 
documentation should be even more explicit that this should only be used 
if you do know for sure that no devices have DMA addressing limitations.

As a general SWIOTLB-behaviour-debugging option for orthogonality with 
force/noforce I'm not opposed to the idea, but it is definitely not 
something that real CoCo use-cases should rely on - if the general 
consensus if that CoCo environments want a different setup by default 
then the arch/CoCo code should be taking care of that.

Thanks,
Robin.

> Signed-off-by: Aakarsh Jain <aakarsh.jain@oss.qualcomm.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 5 ++++-
>   kernel/dma/swiotlb.c                            | 5 +++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..8a1fccbd9b25 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7477,7 +7477,7 @@ Kernel parameters
>   			Execution Facility on pSeries.
>   
>   	swiotlb=	[ARM,PPC,MIPS,X86,S390,EARLY]
> -			Format: { <int> [,<int>] | force | noforce }
> +			Format: { <int> [,<int>] | force | noforce | any}
>   			<int> -- Number of I/O TLB slabs
>   			<int> -- Second integer after comma. Number of swiotlb
>   				 areas with their own lock. Will be rounded up
> @@ -7485,6 +7485,9 @@ Kernel parameters
>   			force -- force using of bounce buffers even if they
>   			         wouldn't be automatically used by the kernel
>   			noforce -- Never use bounce buffers (for debugging)
> +			any --  Allow the swiotlb pool to be placed anywhere in
> +				system RAM, lifting the default low-memory (4GB)
> +				restriction.
>   
>   	switches=	[HW,M68k,EARLY]
>   
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1abd3e6146f4..34773ae7c770 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -80,6 +80,7 @@ struct io_tlb_slot {
>   
>   static bool swiotlb_force_bounce;
>   static bool swiotlb_force_disable;
> +static unsigned int swiotlb_param_flags __initdata;
>   
>   #ifdef CONFIG_SWIOTLB_DYNAMIC
>   
> @@ -198,6 +199,8 @@ setup_io_tlb_npages(char *str)
>   		swiotlb_force_bounce = true;
>   	else if (!strcmp(str, "noforce"))
>   		swiotlb_force_disable = true;
> +	else if (!strcmp(str, "any"))
> +		swiotlb_param_flags |= SWIOTLB_ANY;
>   
>   	return 0;
>   }
> @@ -445,6 +448,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>   
>   	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
>   
> +	flags |= swiotlb_param_flags;
> +
>   #ifdef CONFIG_SWIOTLB_DYNAMIC
>   	if (!remap)
>   		io_tlb_default_mem.can_grow = true;

