Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424877;
	b=1W6/YshbPMVXZ1dHKKdUhRFtqUHzII/xSttlG9dhEbwXunXxWikEaTufEipq2tThvDaF
	 aWfHsh8SN0+SUZZ0tJ1WoOu1G+yWTAnqRF2shAiP72cn3qalt9hnnziEmQvEbiLNsoFmM
	 7CUPDc1hPlktO0V30jnYQXGR6LJ7KOnPw0qPrcSn5pg37jou3lzPe2Hsa1ebuf5kzGV2v
	 TCou3DE6TwjyKASxXZyutaylOwP5+4OHvR+R4mBdqo7qE3Wdypxmv4S4KJiGwtAmfdG6Q
	 +l0/L1xaE1ffo8/4hZ3R+RUiSEqY8J4IfisGJJfkaI1r6KjkN7ggUqsyJ05IIPKEvNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424877;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=K1JR23dis02yAIKnEumwFZRUJ8YPmutnD6YvRUw81Ak=;
	b=EHj2enfqmxeBO72pQqGPGYeGYnNhNiDRTY8OEd0O2zbCnLyHFDuJ+IRQzockD7Y/JhiS
	 SgTDfW7N40jXEYQfgNWFIdBxrJ5/tPG0OcvhpzgvH2IGqWYxaCVOocm3lQ1bEbEsygQWe
	 trxk0EIJPcfUtlcn35EQuUQJ4eolvwpzw4qvJid0B1KuM5DwRwUi/4QpctCRgxwFp3bLi
	 hz5jsxiLD6ZSMVZnV3rpGCEUJALi3la6wD+boChg1bj1Vwk9aRxjf4QNpj+i9HN7owhtl
	 7rHkJYtVlIWI0RMKGTcKOW9SChlrvgrsOs2IohgEOqrl6q3j7BhHsCu5Gq031var4Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=U1aJ343y;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF68760820C6
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 15:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF68760820C6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=U1aJ343y
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89F211682;
	Mon, 19 Oct 2026 08:47:52 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACE6B3F7D8;
	Mon, 19 Oct 2026 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792424875; bh=dCk6nUh5icp8CA5X/i9Oz2cAcRaobiJtEJkiiNaZ80o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U1aJ343yN6AE5BBuB/h4fJu7tR+XjNlcxCpFPJPbA+ZlRbBLokLCIdrzpaAAbFfNW
	 1QUDfx9d3Zj+6swZ1HOEFmRel/1rBd112uXKNG/aClm4WPvQ++9Yccfoy7xLQwwJ+X
	 NmUpMgAIJHf4xvQy+iy2BBefCyol3beT79SeYhUk=
Message-ID: <52c9bad4-39f4-46cf-87c2-9e57e8beeb5c@arm.com>
Date: Mon, 19 Oct 2026 16:47:39 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] ARM: dma-mapping: Handle foreign buffers in
 arm_iommu_get_sgtable
To: Mikko Perttunen <mperttunen@nvidia.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
References: <20261016-b4-arm32-iommu-dma-cookie-v2-0-b06842a01938@nvidia.com>
 <20261016-b4-arm32-iommu-dma-cookie-v2-6-b06842a01938@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261016-b4-arm32-iommu-dma-cookie-v2-6-b06842a01938@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/10/2026 7:46 am, Mikko Perttunen wrote:
> arm_iommu_get_sgtable can only describe buffers which came from
> arm_iommu_alloc_attrs, and returns -ENXIO for anything else. This is
> stricter than iommu_dma_get_sgtable(), which falls back to describing
> the buffer as a single chunk.
> 
> The difference shows up when a buffer is allocated for one device and
> mapped for another, as TegraDRM does. Buffers are allocated on the
> host1x logical device, which has no dma_configure and therefore uses
> direct DMA ops, and are then mapped for a display controller behind the
> SMMU.
> 
> Add the same fallback as iommu_dma_get_sgtable().

Hmm, that's not actually what it's for... :(

The "fallback" is only for the case when iommu_dma_alloc() has hit the 
dma_alloc_from_pool() path, see a98d9ae937d2 ("arm64/iommu: handle 
non-remapped addresses in ->mmap and ->get_sgtable"). It was never meant 
for dipping into *other* DMA ops because the caller has erroneously 
passed the wrong device. Just like dma_mmap_attrs() and 
dma_free_attrs(), dma_get_sgtable_attrs() must match the original 
dma_alloc_attrs() call - that's a bug in TegraDRM.

Thanks,
Robin.

> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   arch/arm/mm/dma-mapping.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index d6315baeddb9..c2ec4f107808 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1169,12 +1169,29 @@ static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
>   {
>   	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
> +	struct page *page;
> +	int ret;
>   
> -	if (!pages)
> -		return -ENXIO;
> +	if (pages)
> +		return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
> +						 GFP_KERNEL);
>   
> -	return sg_alloc_table_from_pages(sgt, pages, count, 0, size,
> -					 GFP_KERNEL);
> +	/*
> +	 * The buffer was not allocated through these DMA ops. It may belong to
> +	 * a device which is not behind an IOMMU at all, which can happen when a
> +	 * buffer is allocated on one device and mapped for another. Describe it
> +	 * as a single chunk, as iommu_dma_get_sgtable() does.
> +	 */
> +	if (is_vmalloc_addr(cpu_addr))
> +		page = vmalloc_to_page(cpu_addr);
> +	else
> +		page = virt_to_page(cpu_addr);
> +
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	if (!ret)
> +		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
> +
> +	return ret;
>   }
>   
>   /*
> 

