Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92C2125B2
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707804688; cv=none; b=SvP5hF7gkLYsMX1KmTp4Z/gt0ntFisqCUFPS7lPICiToPqKlVcasvvDVsshcs8hMmLoB2B1SggGPjwPeKdakTnIj921fNlLYczJ0IX3s7iZsyUEb8GtcG8Ag9ugq/0CVemztZs97CWKtS+rGca2WVn7xag5xflOv+jt2/iJOGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707804688; c=relaxed/simple;
	bh=PFyLboEBhpUyz1orqNgFN5pE677Wm/BvvN1lOPAD3WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuuftRRUxLWmT+POWbt3n25nL2lyTfJwLi3Rj9cfHyEORXK3pbZIBTwdjY8V1WWVTFib6g6cnbMkIE5TgvuIfPSJjw0H0gs1IESJIRaUPySfWqJcYOWkRjrkJaWM88gepLjYb1YWa1iHGMfY6rnCiPWQFS1dz+8N3eeJik5uwBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 14FE2227A87; Tue, 13 Feb 2024 07:11:21 +0100 (CET)
Date: Tue, 13 Feb 2024 07:11:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/7] dma: avoid redundant calls for sync
 operations
Message-ID: <20240213061120.GC22451@lst.de>
References: <20240205110426.764393-1-aleksander.lobakin@intel.com> <20240205110426.764393-3-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205110426.764393-3-aleksander.lobakin@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 05, 2024 at 12:04:21PM +0100, Alexander Lobakin wrote:
> Quite often, NIC devices do not need dma_sync operations on x86_64
> at least.

This is a fundamental property of the platform being DMA coherent,
and devices / platforms not having addressing limitations or other
need for bounce buffering (like all those whacky trusted platform
schemes).  Nothing NIC-specific here.

> In case some device doesn't work with the shortcut:
> * include <linux/dma-map-ops.h> to the driver source;
> * call dma_set_skip_sync(dev, false) at the beginning of the probe
>   callback. This will disable the shortcut and force DMA syncs.

No, drivers should never include dma-map-ops.h.  If we have a legit
reason for drivers to ever call it it would have to move to
dma-mapping.h.  But I see now reason why there would be such a need.
For now I'd suggest simply dropping this paragraph from the commit
message.

>  	if (dma_map_direct(dev, ops))
> +		/*
> +		 * dma_skip_sync could've been set to false on first SWIOTLB
> +		 * buffer mapping, but @dma_addr is not necessary an SWIOTLB
> +		 * buffer. In this case, fall back to more granular check.
> +		 */
>  		return dma_direct_need_sync(dev, dma_addr);
> +

Nit: with such a long block comment adding curly braces would make the
code a bit more readable.

> +#ifdef CONFIG_DMA_NEED_SYNC
> +void dma_setup_skip_sync(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +	bool skip;
> +
> +	if (dma_map_direct(dev, ops))
> +		/*
> +		 * dma_skip_sync will be set to false on first SWIOTLB buffer
> +		 * mapping, if any. During the device initialization, it's
> +		 * enough to check only for DMA coherence.
> +		 */
> +		skip = dev_is_dma_coherent(dev);
> +	else if (!ops->sync_single_for_device && !ops->sync_single_for_cpu)
> +		/*
> +		 * Synchronization is not possible when none of DMA sync ops
> +		 * is set. This check precedes the below one as it disables
> +		 * the synchronization unconditionally.
> +		 */
> +		skip = true;
> +	else if (ops->flags & DMA_F_CAN_SKIP_SYNC)
> +		/*
> +		 * Assume that when ``DMA_F_CAN_SKIP_SYNC`` is advertised,
> +		 * the conditions for synchronizing are the same as with
> +		 * the direct DMA.
> +		 */
> +		skip = dev_is_dma_coherent(dev);
> +	else
> +		skip = false;
> +
> +	dma_set_skip_sync(dev, skip);

I'd just assign directly to dev->dma_skip_sync instead of using a
local variable and the dma_set_skip_sync call - we are under
ifdef CONFIG_DMA_NEED_SYNC here and thus know is is available.

> +static inline void swiotlb_disable_dma_skip_sync(struct device *dev)
> +{
> +	/*
> +	 * If dma_skip_sync was set, reset it to false on first SWIOTLB buffer
> +	 * mapping/allocation to always sync SWIOTLB buffers.
> +	 */
> +	if (unlikely(dma_skip_sync(dev)))
> +		dma_set_skip_sync(dev, false);
> +}

Nothing really swiotlb-specific here.  Also the naming is a bit odd.
Maybe have a dma_set_skip_sync helper without the bool to enable
skipping, and a dma_clear_skip_sync that clear the flag.  The optimization
to first check the flag here could just move into that latter
helper.
