Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89964C61B
	for <iommu@lists.linux.dev>; Mon, 29 Jan 2024 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706508540; cv=none; b=ELtIYC28v7QSS9f+234tu/wXCO0yz6voWDCJsomm3vg6UfZo70gcM1v3JTTEUzLaTTx+8/Wpnm5HxZe0I8ZzQJBd20XhZKgLTBM8m8o2K9/1iPs/x+V9wqoXOu2P+L6aT2MtGcCBGuQI0mPvCrX2RrAhOCyb4H/T4D/BbFDJclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706508540; c=relaxed/simple;
	bh=jAALexVfdB8CH5+NUTWXDLvoHfK5Y5gEBA7XS2daLRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZeYVNyLzh+zc+wbndcRCh0FAP/N/sS5z90hcIuPEnocKpheW3ADsCZ9un+0Z/xFN3Zsf7IGV9qxK4tcTf07AgynV5GYgI2OEqFXbfgv9jfxZABiTQCx5m2zYl6L6BptjhFc//E9j+wNnjwUJllxkpSepKvC/TWEJNi5+CLg6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50B8C68B05; Mon, 29 Jan 2024 07:08:54 +0100 (CET)
Date: Mon, 29 Jan 2024 07:08:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 2/2] swiotlb: Enforce page alignment in swiotlb_alloc()
Message-ID: <20240129060853.GB19258@lst.de>
References: <20240126151956.10014-1-will@kernel.org> <20240126151956.10014-3-will@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126151956.10014-3-will@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 26, 2024 at 03:19:56PM +0000, Will Deacon wrote:
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 25febb9e670c..92433ea9f2d2 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1647,6 +1647,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
>  		return NULL;
>  
>  	tlb_addr = slot_addr(pool->start, index);
> +	if (!PAGE_ALIGNED(tlb_addr)) {
> +		dev_WARN_ONCE(dev, 1, "Cannot return 'struct page *' for non page-aligned swiotlb addr 0x%pa.\n",
> +			      &tlb_addr);
> +		swiotlb_release_slots(dev, tlb_addr);
> +		return NULL;
> +	}
>  
>  	return pfn_to_page(PFN_DOWN(tlb_addr));

So PFN_DOWN aligns the address and thus per se converting the unaligned
address isn't a problem.  That being said swiotlb obviously should never
allocate unaligned addresses, but the placement of this check feels
odd to me.  Also because it only catches swiotlb_alloc and not the
map side.

Maybe just throw a WARN_ON_ONCE into slot_addr() ?

>  }
> -- 
> 2.43.0.429.g432eaa2c6b-goog
---end quoted text---
