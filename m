Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D203D4134
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901115; cv=none; b=swPH7s/pDY5dprqSDx8ZbClLI/hR57csjmrWSHiMb/5yBdxbfwDCiOg5Aw8h4tdbnUJJzsCp+P+/JLa9i61iw2KIEPQL9fjTZxrsYUqtSAh+M0k9EAwcgbMtjx1DDt9W0yHYi/mAYI+tVFXPQ/mzDIkt2XLjROKnO/mctvOelNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901115; c=relaxed/simple;
	bh=L8DVfXIsTbjMo1XJl7LNTxCV45FmE1EsQ5sGGfSVuhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9McyHHLZCA0Wqp6bndjJVUeChUxm31P2GqAiqh2X23Ce/bnq9bIlkv08DHZ4nbEYUnzvt3I21U5+Zju4bmDrAeD50AonSUrNt9vAUQbUwL1LauUmWxTi85K53achuQeumpYpTjO49wCNzFenGn10rhL57Nr/A/wmoGAtSrQ4rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67EF11476;
	Tue, 20 Jan 2026 01:25:04 -0800 (PST)
Received: from [10.163.163.250] (unknown [10.163.163.250])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 180A13F740;
	Tue, 20 Jan 2026 01:25:07 -0800 (PST)
Message-ID: <79a50bba-2805-4901-a258-817c584fff96@arm.com>
Date: Tue, 20 Jan 2026 14:55:05 +0530
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
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, suzuki.poulose@arm.com,
 steven.price@arm.com
References: <20260120070102.182977-1-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20260120070102.182977-1-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/01/26 12:31 PM, Aneesh Kumar K.V (Arm) wrote:
> arm64 reduces the default swiotlb size (for unaligned kmalloc()
> bouncing) when it detects that no swiotlb bouncing is needed.
> 
> If swiotlb bouncing is explicitly forced via the command line
> (swiotlb=force), this heuristic must not apply. Add a swiotlb helper to
> query the forced-bounce state and use it to skip the resize when
> bouncing is forced.

Makes sense not to reduce the SWIOTLB buffer size when being
forced by the administrator.

> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm64/mm/init.c    | 3 ++-
>  include/linux/swiotlb.h | 7 +++++++
>  kernel/dma/swiotlb.c    | 5 +++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 524d34a0e921..7046241b47b8 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -345,7 +345,8 @@ void __init arch_mm_preinit(void)
>  		flags |= SWIOTLB_FORCE;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb) {
> +	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
> +	    !(swiotlb || force_swiotlb_bounce())) {
>  		/*
>  		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
>  		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.

Should the comment here be updated as well ?

> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..513a93dcbdbc 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -185,6 +185,7 @@ bool is_swiotlb_active(struct device *dev);
>  void __init swiotlb_adjust_size(unsigned long size);
>  phys_addr_t default_swiotlb_base(void);
>  phys_addr_t default_swiotlb_limit(void);
> +bool force_swiotlb_bounce(void);
>  #else
>  static inline void swiotlb_init(bool addressing_limited, unsigned int flags)
>  {
> @@ -234,6 +235,12 @@ static inline phys_addr_t default_swiotlb_limit(void)
>  {
>  	return 0;
>  }
> +
> +static inline bool force_swiotlb_bounce(void)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_SWIOTLB */
>  
>  phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 0d37da3d95b6..85e31f228cc9 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1646,6 +1646,11 @@ phys_addr_t default_swiotlb_base(void)
>  	return io_tlb_default_mem.defpool.start;
>  }
>  
> +bool force_swiotlb_bounce(void)
> +{
> +	return swiotlb_force_bounce;
> +}
> +
>  /**
>   * default_swiotlb_limit() - get the address limit of the default SWIOTLB
>   *

