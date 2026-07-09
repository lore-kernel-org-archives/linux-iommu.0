Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7AA41A76A
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597702; cv=none; b=mAeEQMB3Obqdef8Z1ep7VXOqU9TAuPkUHm+ni0XM93UIR7WlW70JTHr+WJ/7ERogAEieqTTfJ4u/VegH4vOV4gcENhx6ghVGJLZ5euFNEHqAG5ZJQitkv2gpe0c5aomcXgLGYLnhkT4cU+KSMfuRYQbjG+ayQEQkWxkQB79O37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597702; c=relaxed/simple;
	bh=b6Cc4UcywU20YwkD+cdB4MosSaGEN9+qS/zz4wONwV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=MDlS6lGv6MuuaMpfx4ZjJdti8wSM7x93tWBLnXYX8o72Se0EgRzUHokQVQ2ecV3mxxm5tBQIrawOuDX9LjE6Nv9RJIzHmrTSCjO3xzCU6Lr9ER6kKp0Ra1zKvwVDSpBP+j4lGo0+wbDpKNsZjfmaA+rENS4k4fwzAi78G6XznoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dmyp4Var; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dmyp4Var"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260709114817euoutp0146429dd8ec8c86cf55ab9330b37c4afa~AnKfeEHUY0179801798euoutp01G
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 11:48:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260709114817euoutp0146429dd8ec8c86cf55ab9330b37c4afa~AnKfeEHUY0179801798euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783597697;
	bh=mbdm+gUkaYDjaWGKLha+HVrbYf+sfFzbfVrVqxEhhvQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dmyp4Var6RjkkB1vajADW+b854j66E4a8tOhbdAZBc+KrQ3T4ExgndaJ0ru91bFtT
	 4aL0TDpMA9o+owJxLFhQYpDaChGMM6tI/YudIMETgaGbaq9fQRz+OvPjywucg/6gyP
	 5VSgJg+HKMF4+vsL6EffRkXM0S6JTsUkMvX8OOK4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260709114816eucas1p110f68ffa791aae37e094a48f7c81a84c~AnKfIORfW0198001980eucas1p1j;
	Thu,  9 Jul 2026 11:48:16 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260709114815eusmtip26476bf679b9f8b6a9369ca12f533d2b8~AnKd7jPDA0429604296eusmtip2W;
	Thu,  9 Jul 2026 11:48:15 +0000 (GMT)
Message-ID: <b3caef50-db1a-4102-9be8-745c68d53074@samsung.com>
Date: Thu, 9 Jul 2026 13:48:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [RFC PATCH] x86/pci-dma: add "any" keyword to swiotlb= kernel
 parameter
To: Aakarsh Jain <aakarsh.jain@oss.qualcomm.com>, robin.murphy@arm.com
Cc: corbet@lwn.net, skhan@linuxfoundation.org, akpm@linux-foundation.org,
	bp@alien8.de, rdunlap@infradead.org, peterz@infradead.org,
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com, elver@google.com,
	enelsonmoore@gmail.com, kuba@kernel.org, lirongqing@baidu.com,
	ebiggers@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	aneesh.kumar@kernel.org, alexey.kardashevskiy@amd.com,
	thomas.lendacky@amd.com, jeff.hugo@oss.qualcomm.com,
	thanson@qti.qualcomm.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260708114244.246176-1-aakarsh.jain@oss.qualcomm.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260709114816eucas1p110f68ffa791aae37e094a48f7c81a84c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260708114338eucas1p2bbdea8406913619fdc046b6e8f66d5ca
X-EPHeader: CA
X-CMS-RootMailID: 20260708114338eucas1p2bbdea8406913619fdc046b6e8f66d5ca
References: <CGME20260708114338eucas1p2bbdea8406913619fdc046b6e8f66d5ca@eucas1p2.samsung.com>
	<20260708114244.246176-1-aakarsh.jain@oss.qualcomm.com>

On 08.07.2026 13:42, Aakarsh Jain wrote:
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
>
>   Without "any": pool at 0x35a9c000 (~900MB, below 4GB boundary)
>   With    "any": pool at 0x1df9c00000 (~120GB, anywhere in RAM)
>   [Tested on AMD SEV-SNP guest, swiotlb=4194304]


Do we really need a new option for that? Doesn't this simply mean that
x86_swiotlb_flags should be always set to "any" for CoCo guests?


> Add "any" as a new keyword to the swiotlb= kernel parameter. This is an
> explicit, opt-in mechanism that sets SWIOTLB_ANY for the default pool at
> boot time, without touching any arch-specific code.
>
> Devices with 32-bit DMA masks are not affected, they still use the normal
> low-memory bounce buffer path. The "any" option is only meaningful for
> workloads where all active DMA devices have 64-bit masks.
>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@oss.qualcomm.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 ++++-
>  kernel/dma/swiotlb.c                            | 5 +++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..8a1fccbd9b25 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7477,7 +7477,7 @@ Kernel parameters
>  			Execution Facility on pSeries.
>  
>  	swiotlb=	[ARM,PPC,MIPS,X86,S390,EARLY]
> -			Format: { <int> [,<int>] | force | noforce }
> +			Format: { <int> [,<int>] | force | noforce | any}
>  			<int> -- Number of I/O TLB slabs
>  			<int> -- Second integer after comma. Number of swiotlb
>  				 areas with their own lock. Will be rounded up
> @@ -7485,6 +7485,9 @@ Kernel parameters
>  			force -- force using of bounce buffers even if they
>  			         wouldn't be automatically used by the kernel
>  			noforce -- Never use bounce buffers (for debugging)
> +			any --  Allow the swiotlb pool to be placed anywhere in
> +				system RAM, lifting the default low-memory (4GB)
> +				restriction.
>  
>  	switches=	[HW,M68k,EARLY]
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1abd3e6146f4..34773ae7c770 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -80,6 +80,7 @@ struct io_tlb_slot {
>  
>  static bool swiotlb_force_bounce;
>  static bool swiotlb_force_disable;
> +static unsigned int swiotlb_param_flags __initdata;
>  
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  
> @@ -198,6 +199,8 @@ setup_io_tlb_npages(char *str)
>  		swiotlb_force_bounce = true;
>  	else if (!strcmp(str, "noforce"))
>  		swiotlb_force_disable = true;
> +	else if (!strcmp(str, "any"))
> +		swiotlb_param_flags |= SWIOTLB_ANY;
>  
>  	return 0;
>  }
> @@ -445,6 +448,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  
>  	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
>  
> +	flags |= swiotlb_param_flags;
> +
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  	if (!remap)
>  		io_tlb_default_mem.can_grow = true;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

