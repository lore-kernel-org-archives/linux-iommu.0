Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAE23BF
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905157; cv=none; b=O42+EqC0ocP7b8odlgjVUwFg8bmj1MgEENCcV1Jn3Qf6lyTOGzGrms+nc0GurtfotXOSYrwoaiBrOkQu+4gUsP9Fljhbtj0PqT5ilc4VPuy3tm+P6fTcf3vPwgAWNyl/GEQ4cxoEYe6MpN590ZYij7e6H1xrtmLHaY1WqtZh+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905157; c=relaxed/simple;
	bh=RBDBVusewDGRLSs5t/KGYCnpMkkB9AXqptRnmV4l8Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiEQD5pXZZrq2CbdZXHSM/7SV3zeO266IdPXdohBt0Qqq9arjBh9xqj0vBBWMI1cjab+OIdiFE6WXNzOIU3S2sZbUfEmjKounsy/pfPYb+UQIEK/T+nXNzut46zO+MX9eldd/Fd4Trcp5NvYeR1u7wZFQm2DZOx3y8Mjou/xo7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9ECFB68AA6; Thu, 29 Aug 2024 06:19:12 +0200 (CEST)
Date: Thu, 29 Aug 2024 06:19:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dma: Trace API
Message-ID: <20240829041912.GB4408@lst.de>
References: <20240826203240.2234615-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826203240.2234615-1-sean.anderson@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

I'd change the subject to

dma-mapping: add tracing for dma-mapping API calls

On Mon, Aug 26, 2024 at 04:32:40PM -0400, Sean Anderson wrote:
> When debugging drivers, it can often be useful to trace when memory gets
> (un)mapped for DMA (and can be accessed by the device). Add some
> tracepoints for this purpose.
> 
> We use unsigned long long instead of phys_addr_t and dma_addr_t (and
> similarly %llx instead of %pa) because libtraceevent can't handle
> typedefs.

and a __u64 would seem like the better type here.

otherwise this looks fine to me.  I can do the tweaks as I'll apply
the patch if needed.

