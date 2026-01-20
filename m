Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B7222A4D6
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915241; cv=none; b=a3QfaKnM6t+NgqOtPaOs7t0X5RFN/m1vwnpotrP5MtSi1oDfLY6hQTSMDAWcU/FdZaCQEJmpGdvaVCgPypyNTWVqHpUD1hO5g4Bz5IAX4oCWWyGzSMYtCA+Otn6oz0J+oPcIclGLASI/RqJhLXOikZaEUmq+9V18QpA/c9uPBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915241; c=relaxed/simple;
	bh=io7TyySofGrbBKbhW9vbVGuE4sHNOiWV8eSK5OVNZEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgpxoTzx6qgZVUsBeOPXqaJUGUC2DweZRlDRTp5G695lar0RwZFoX9iQ8lBn8u8MtWe9ScwHrFxnuoofLzhfxBF8SQEUrRR1MfeQnM98R8vI+y8+86JWVK3yuVMMQB4STs394M2tX0uzqIZFloM9xwZhE3yhASpZXkOv9eW8qeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 247A21476;
	Tue, 20 Jan 2026 05:20:31 -0800 (PST)
Received: from [10.57.49.114] (unknown [10.57.49.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 718CD3F740;
	Tue, 20 Jan 2026 05:20:36 -0800 (PST)
Message-ID: <028734f6-2a72-4509-81e0-7e69bda20253@arm.com>
Date: Tue, 20 Jan 2026 13:20:34 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYXJtNjQ6IHN3aW90bGI6IERvbuKAmXQgc2hyaW5r?=
 =?UTF-8?Q?_default_buffer_when_bounce_is_forced?=
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, suzuki.poulose@arm.com,
 steven.price@arm.com
References: <20260120070102.182977-1-aneesh.kumar@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260120070102.182977-1-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-20 7:01 am, Aneesh Kumar K.V (Arm) wrote:
> arm64 reduces the default swiotlb size (for unaligned kmalloc()
> bouncing) when it detects that no swiotlb bouncing is needed.
> 
> If swiotlb bouncing is explicitly forced via the command line
> (swiotlb=force), this heuristic must not apply. Add a swiotlb helper to
> query the forced-bounce state and use it to skip the resize when
> bouncing is forced.

This doesn't appear to be an arm64-specific concern though... Since 
swiotlb_adjust_size() already prevents resizing if the user requests a 
specific size on the command line, it seems logical enough to also not 
reduce the size (but I guess still allow it to be enlarged) there if 
force is requested.

(Although realistically, anyone requesting force is quite likely to want 
to request a larger default size anyway...)

Thanks,
Robin.

> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   arch/arm64/mm/init.c    | 3 ++-
>   include/linux/swiotlb.h | 7 +++++++
>   kernel/dma/swiotlb.c    | 5 +++++
>   3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 524d34a0e921..7046241b47b8 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -345,7 +345,8 @@ void __init arch_mm_preinit(void)
>   		flags |= SWIOTLB_FORCE;
>   	}
>   
> -	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb) {
> +	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
> +	    !(swiotlb || force_swiotlb_bounce())) {
>   		/*
>   		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
>   		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..513a93dcbdbc 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -185,6 +185,7 @@ bool is_swiotlb_active(struct device *dev);
>   void __init swiotlb_adjust_size(unsigned long size);
>   phys_addr_t default_swiotlb_base(void);
>   phys_addr_t default_swiotlb_limit(void);
> +bool force_swiotlb_bounce(void);
>   #else
>   static inline void swiotlb_init(bool addressing_limited, unsigned int flags)
>   {
> @@ -234,6 +235,12 @@ static inline phys_addr_t default_swiotlb_limit(void)
>   {
>   	return 0;
>   }
> +
> +static inline bool force_swiotlb_bounce(void)
> +{
> +	return false;
> +}
> +
>   #endif /* CONFIG_SWIOTLB */
>   
>   phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 0d37da3d95b6..85e31f228cc9 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1646,6 +1646,11 @@ phys_addr_t default_swiotlb_base(void)
>   	return io_tlb_default_mem.defpool.start;
>   }
>   
> +bool force_swiotlb_bounce(void)
> +{
> +	return swiotlb_force_bounce;
> +}
> +
>   /**
>    * default_swiotlb_limit() - get the address limit of the default SWIOTLB
>    *

