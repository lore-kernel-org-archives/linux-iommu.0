Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9040F14F9FA;
	Fri, 31 May 2024 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144633; cv=none; b=MPJIM+ox5samKLKUJiE8tpYqbZLwh4/Oc/f4utFGDJmbKfCs71G6z2s3cfHE/3W9IRyU3PEepV89HMUh4/jqHgUpMdoJdkE8zkbOW9oOfqWCwAf7OIRx8fgeYDqVE6ay1Upq6h7m039/y2b1UA/MIyO5Hx0IXEGb34kp2PM3BxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144633; c=relaxed/simple;
	bh=krRVD3UkRnE4YDx4vNs3xr7/v74++jw0AqyhDKkqFB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyU6TlzCcu/TVGwETXjswPwCb6KAcrMKUe+VW+Zf96rXbzgyqdygFSv2emYyyJPYUjB3yaPnfhbHo2skQBM2i+fNTgOZ+DlUOJAHyqYnRX8rSUKWjSeIMhpNzy+9rOer+3jxy5rUac4Lmxju3feZ8xfL+vSqyU6ylvNaP2SWbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9D6F113E;
	Fri, 31 May 2024 01:37:34 -0700 (PDT)
Received: from [10.57.67.251] (unknown [10.57.67.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 481AB3F792;
	Fri, 31 May 2024 01:37:08 -0700 (PDT)
Message-ID: <ecdc4d9f-a7b4-45e1-a870-e97cf4922539@arm.com>
Date: Fri, 31 May 2024 09:37:02 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] iommu: sun50i: allocate page tables from below 4 GiB
To: Andre Przywara <andre.przywara@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin
 <ryan@testtoast.com>, iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240530233800.27705-1-andre.przywara@arm.com>
 <20240530233800.27705-3-andre.przywara@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240530233800.27705-3-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-31 12:37 am, Andre Przywara wrote:
> The Allwinner IOMMU is a strict 32-bit device, with the page table root
> pointer as well as both level's page tables and also the target addresses
> all required to be below 4GB.
> The Allwinner H6 SoC only supports 32-bit worth of physical addresses
> anyway, so this isn't a problem so far, but the H616 and later SoCs extend
> the PA space beyond 32 bit to accommodate more DRAM.
> To make sure we stay within the 32-bit PA range required by the IOMMU,
> force the memory for the page tables to come from below 4GB. by using
> allocations with the DMA32 flag.

Uh-oh... what about the output addresses in sun50i_mk_pte()? Limiting 
its own accesses is OK, but if the IOMMU isn't capable of *mapping* any 
valid PA for its clients, we can't easily support that.

Thanks,
Robin.

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   drivers/iommu/sun50i-iommu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index dd3f07384624c..c3244db5ac02f 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -682,7 +682,8 @@ sun50i_iommu_domain_alloc_paging(struct device *dev)
>   	if (!sun50i_domain)
>   		return NULL;
>   
> -	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL, get_order(DT_SIZE));
> +	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL | GFP_DMA32,
> +					      get_order(DT_SIZE));
>   	if (!sun50i_domain->dt)
>   		goto err_free_domain;
>   
> @@ -997,7 +998,7 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
>   
>   	iommu->pt_pool = kmem_cache_create(dev_name(&pdev->dev),
>   					   PT_SIZE, PT_SIZE,
> -					   SLAB_HWCACHE_ALIGN,
> +					   SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA32,
>   					   NULL);
>   	if (!iommu->pt_pool)
>   		return -ENOMEM;
