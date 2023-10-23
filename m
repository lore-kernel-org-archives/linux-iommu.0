Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C824A5236
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC75468AA6; Mon, 23 Oct 2023 08:08:45 +0200 (CEST)
Date: Mon, 23 Oct 2023 08:08:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jia He <justin.he@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v3 2/2] dma-mapping: fix dma_addressing_limited() if
 dma_range_map can't cover all system RAM
Message-ID: <20231023060845.GA11907@lst.de>
References: <20231016125254.1875-1-justin.he@arm.com> <20231016125254.1875-3-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016125254.1875-3-justin.he@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> + */
> +static int check_ram_in_range_map(unsigned long start_pfn,
> +				  unsigned long nr_pages, void *data)
> +{
> +	unsigned long end_pfn = start_pfn + nr_pages;
> +	struct device *dev = (struct device *)data;

No need for the cast here.

> +	struct bus_dma_region *bdr = NULL;
> +	const struct bus_dma_region *m;
> +
> +	while (start_pfn < end_pfn) {
> +		for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
> +			unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
> +
> +			if (start_pfn >= cpu_start_pfn
> +			    && start_pfn - cpu_start_pfn < PFN_DOWN(m->size)) {

Linux coding style keeps the && on the previous line.

> +				bdr = (struct bus_dma_region *)m;

If you also declared bdr as const this should be able to do away with
the cast.

>  bool dma_addressing_limited(struct device *dev)
>  {
> -	return min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
> -			    dma_get_required_mask(dev);
> +	if (min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
> +			 dma_get_required_mask(dev))
> +		return true;
> +
> +	return !all_ram_in_dma_range_map(dev);

So, all the dma range map thing is really a dma-direct concept.  So I
think here in dma_addressing_limited we should just do a:

	if (likely(!ops))
		return !dma_direct_all_ram_mapped(dev));
	return false

with dma_direct_all_ram_mapped move to dma-direct.c.

