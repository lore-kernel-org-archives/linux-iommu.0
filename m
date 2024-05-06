Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576A15575A
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011376; cv=none; b=qIuQsbaExZDD4jg2loATTZGwT+9U0+L7mNZov9CZzgvO7JNB4LYs6L57+JrdHcTud2D6/MWsmHvFHGKEvmZM+lhP3Z78xfQ5ObJDJ6QSLMhJSfv9S/MCUli5/+Tw/RV9aoK3O89Dqpt0rPx2+fENOvUkF2RDQS3wghjZu0PPnW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011376; c=relaxed/simple;
	bh=v5x3U+x8DQXfwQO2ShgOACnPVHyFVvdqv8MMZOJHQJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dip/U44Gr00Xt8kH+ZwopoaXdr6XDTxpis6f3ZcovK5OXyAlwdk6e5mcpYoTdT3w+wroM+5PjsFTrHtI+0V8YT3hYwChVo2UFQAcrWy7MibT9xFDj71lxa0CVC/L+tAVnVgfH0acRibvRVUh/wnkDSamq4+R0R7me68GX/n0EEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B4053227A87; Mon,  6 May 2024 18:02:44 +0200 (CEST)
Date: Mon, 6 May 2024 18:02:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, isaacmanjarres@google.com,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
Message-ID: <20240506160244.GA16248@lst.de>
References: <20240503183713.1557480-1-tjmercier@google.com> <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 06, 2024 at 09:00:59AM -0700, T.J. Mercier wrote:
> Oh, that's disappointing. I'm looking for a way to quickly check if
> any addresses point at a SWIOTLB buffer without doing a potentially
> expensive call to iommu_iova_to_phys. Since it's meant to be dma-iommu
> only I guess I could use sg_dma_is_swiotlb if iommu_get_domain_for_dev
> returns a domain, and is_swiotlb_buffer otherwise for dma-direct, but
> it'd be nice to have just one way to check which it looked like the
> SG_DMA_SWIOTLB flag could be used for.

This sounds like you're trying to do that from a consumer of the
DMA API, which is simply wrong.  What is the actual problem you are
trying to solve?
