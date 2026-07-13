Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E73438F629
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928021; cv=none; b=RxLqNySIOZcT1ewZ7FIhl7eq+VgRJ0MHES4Hve/5koG2OaH/VW24JQVk0L+a2Gi0pWpsl68nL8NvIYHkqOo+b4QgpdF/Rk21OkqD6LHG/3QHgWlZncSOg/6wIE2S9JFv/29+w4yzwbPD/tHtkqxn+fV4meVz3o9dNvUv6LQH3VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928021; c=relaxed/simple;
	bh=AZ5aJfgOtxw4eilRp1nS3ASn4R/LbBfvz4779V+hybk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=OMnmi5sFIyOXCpHNys3zEOti79E1bjeBwiqyLozg22Im3EkQMMgmNG+/GNRK/Jz7W20CXSS0XPNzvvPx3S8UfuaxvIJcBBtUSRP5sXXUzjwZVOMUTJnarfP0FS+NfVhseK2MDHn03UaYh1lp4MLbm3UMsdeGsEpB/nRZf9x/JU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lat4hWOf; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lat4hWOf"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260713073337euoutp02aed487ec982c2c447e7d1519bbd8fb7d~ByRSietIj2405624056euoutp028
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 07:33:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260713073337euoutp02aed487ec982c2c447e7d1519bbd8fb7d~ByRSietIj2405624056euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783928017;
	bh=9HDaA2CfDIM51R+Z67L4xmhMFjudrQ+MESP5rXa50To=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=lat4hWOfTFAQuMtDfrLm4rdwTSwl+4AAuoqOih6i599nkRpP8RN4a1k6tczl2FpVk
	 2dF8AGKpYFqs0/sYPcGrI/5yECiHv1VOW8UmOjlxVGzvmTU0tO/TkW0SQdqNs+CUFK
	 rXdwo2gyi19WBdRYhkKVvYHfm5qdSOM2IUBeexFM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260713073337eucas1p295261ebda3ecaa8e43e43e4fcd17b528~ByRSXegge2789127891eucas1p2o;
	Mon, 13 Jul 2026 07:33:37 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260713073337eusmtip179ec1f5a5d23976f748a28f91d8a7117~ByRR23XBB2210522105eusmtip1T;
	Mon, 13 Jul 2026 07:33:37 +0000 (GMT)
Message-ID: <8c254797-a349-47a0-be4a-86a8ad09cf56@samsung.com>
Date: Mon, 13 Jul 2026 09:33:36 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] iommu/dma: simplify dma_iova_destroy() and drop the
 free_iova helper
To: Honglei Huang <honghuan@amd.com>, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, leonro@nvidia.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Ray.Huang@amd.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260703033729.455358-1-honghuan@amd.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260713073337eucas1p295261ebda3ecaa8e43e43e4fcd17b528
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260703033750eucas1p21cd9472b9cd02f6611e8eeacf6e1610c
X-EPHeader: CA
X-CMS-RootMailID: 20260703033750eucas1p21cd9472b9cd02f6611e8eeacf6e1610c
References: <CGME20260703033750eucas1p21cd9472b9cd02f6611e8eeacf6e1610c@eucas1p2.samsung.com>
	<20260703033729.455358-1-honghuan@amd.com>

On 03.07.2026 05:37, Honglei Huang wrote:
> dma_iova_destroy() frees the IOVA space through __iommu_dma_iova_unlink()
> using a "free_iova" boolean, which duplicates the IOVA free logic in
> dma_iova_free(). And it frees using the unmapped @mapped_len, which for a
> partially linked reservation is smaller than the reserved size. This
> results in a benign waste as pointed out by Robin, not a leak. So this is
> a cleanup, not a fix.
>
> Drop the duplicated free path. Fold __iommu_dma_iova_unlink into
> dma_iova_unlink and remove the free_iova parameter so it only unmaps.
> dma_iova_destroy then unlinks the mapped range if mapped_len is set and
> unconditionally calls dma_iova_free, which frees the whole reservation
> via dma_iova_size. The freed size now always matches the reserved size,
> and destroy reads as unlink then free.
>
> Note that dma_iova_destroy() no longer routes the free through the flush
> queue; teardown now unmaps synchronously and frees directly, matching
> dma_iova_free().
>
> No functional change intended for callers.
>
> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>


Applied to dma-mapping-for-next. Thanks!


> ---
> Changes since v1:
>  - Reframed from an IOVA-leak fix into a cleanup; dropped Fixes:/Cc: stable.
>  - Fold the free_iova helper into dma_iova_unlink() according to Leon's
>    diff, so destroy is unlink + dma_iova_free(). Added Suggested-by: Leon.
>
>  drivers/iommu/dma-iommu.c | 57 +++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703e..5598ed4bff7 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -2068,10 +2068,20 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
>  		arch_sync_dma_flush();
>  }
>  
> -static void __iommu_dma_iova_unlink(struct device *dev,
> -		struct dma_iova_state *state, size_t offset, size_t size,
> -		enum dma_data_direction dir, unsigned long attrs,
> -		bool free_iova)
> +/**
> + * dma_iova_unlink - Unlink a range of IOVA space
> + * @dev: DMA device
> + * @state: IOVA state
> + * @offset: offset into the IOVA state to unlink
> + * @size: size of the buffer
> + * @dir: DMA direction
> + * @attrs: attributes of mapping properties
> + *
> + * Unlink a range of IOVA space for the given IOVA state.
> + */
> +void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
> +		size_t offset, size_t size, enum dma_data_direction dir,
> +		unsigned long attrs)
>  {
>  	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> @@ -2087,35 +2097,13 @@ static void __iommu_dma_iova_unlink(struct device *dev,
>  		iommu_dma_iova_unlink_range_slow(dev, addr, size, dir, attrs);
>  
>  	iommu_iotlb_gather_init(&iotlb_gather);
> -	iotlb_gather.queued = free_iova && READ_ONCE(cookie->fq_domain);
>  
>  	size = iova_align(iovad, size + iova_start_pad);
>  	addr -= iova_start_pad;
>  	unmapped = iommu_unmap_fast(domain, addr, size, &iotlb_gather);
>  	WARN_ON(unmapped != size);
>  
> -	if (!iotlb_gather.queued)
> -		iommu_iotlb_sync(domain, &iotlb_gather);
> -	if (free_iova)
> -		iommu_dma_free_iova(domain, addr, size, &iotlb_gather);
> -}
> -
> -/**
> - * dma_iova_unlink - Unlink a range of IOVA space
> - * @dev: DMA device
> - * @state: IOVA state
> - * @offset: offset into the IOVA state to unlink
> - * @size: size of the buffer
> - * @dir: DMA direction
> - * @attrs: attributes of mapping properties
> - *
> - * Unlink a range of IOVA space for the given IOVA state.
> - */
> -void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
> -		size_t offset, size_t size, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -	 __iommu_dma_iova_unlink(dev, state, offset, size, dir, attrs, false);
> +	iommu_iotlb_sync(domain, &iotlb_gather);
>  }
>  EXPORT_SYMBOL_GPL(dma_iova_unlink);
>  
> @@ -2136,14 +2124,13 @@ void dma_iova_destroy(struct device *dev, struct dma_iova_state *state,
>  		unsigned long attrs)
>  {
>  	if (mapped_len)
> -		__iommu_dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs,
> -				true);
> -	else
> -		/*
> -		 * We can be here if first call to dma_iova_link() failed and
> -		 * there is nothing to unlink, so let's be more clear.
> -		 */
> -		dma_iova_free(dev, state);
> +		dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs);
> +
> +	/*
> +	 * We can be here if the first call to dma_iova_link() failed and
> +	 * there is nothing to unlink, so let's be more clear.
> +	 */
> +	dma_iova_free(dev, state);
>  }
>  EXPORT_SYMBOL_GPL(dma_iova_destroy);
>  
>
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

