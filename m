Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA41B425C;
	Wed, 27 Aug 2025 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279877; cv=none; b=rUTwi5fv3FhoaGe2Qjh0c94VhzI3yTyfnOIO//9BCRZf5BDFQR3G+y+cew+8cPWy4bjuLIeoaifer6yvCpiPm+mhWd6+FNrIyv7ACWRh7w1IzxgcAW9n9gvtxOKljwM9OQOIhGIrwdV91YT5Xy06F7Qe6wSP+wVGlnYNM6j4kSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279877; c=relaxed/simple;
	bh=2IT4LuiyZ46gsn8oCmiOCI4CDl0EjpYJPZYtx/911+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1tMCLZHL8uFiuE/ySQ0Lb158cmdTJQl6hGtdsy1SGSJLx0ladtHz+YPObCiCO91iCfsD2/lo5cA05gITZptD83oEapi8kdtW8ccWVwZ2M2X1Hg/WNnr2mJfdTqNX00WPUY72bGGz9V2qhOx2bPH4YJqlzpoAbhLQYXlklID734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FpxgAH8+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FpxgAH8+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pkdlRrvzbQZi7w/IQQdZiZJdzjHiN51gRoy88Tqftwk=; b=FpxgAH8+kW1MldQurPl8J6EJQ+
	ETrzej00HEVGF7wFk+ERXh9LA2/N55XziLx3Unxn1ysWMcIRwuxKYNirTQgo/jZBXVEH0lPHMjZvc
	5tuxcVxRa/iu3Q4uHTDL1VT9LFVkBLoWb8cJB6XboMAuXovNWBTaqOy/B39DUW93T2s+jeAbpi0CF
	fyMDv4En0kmzdq8qesSoFRorysPhjeXH7JZ8fhyoWf1qTQ6+9w26dUUeynI3fPsIsSagFLQwjCzfQ
	Tdvvu1MN8k9ZFMuxaR3gAwIbUMlwXPSzJLCIfj8NYk9QNQyA8k1twGj1XNFtWyRDYwiCycU9ZGsAm
	k3Z3O6LQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urAch-0000000EQbB-2OLB;
	Wed, 27 Aug 2025 07:31:11 +0000
Date: Wed, 27 Aug 2025 00:31:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jeff Johnson <jjohnson@kernel.org>, iommu@lists.linux.dev,
	"linux-kernel@vger.kernel.org >> linux-kernel" <linux-kernel@vger.kernel.org>,
	"ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: Re: is dma_mapping_error() check necessary for
 dma_alloc_noncoherent()?
Message-ID: <aK60Py3r25U43k1E@infradead.org>
References: <ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 26, 2025 at 05:44:42PM +0800, Baochen Qiang wrote:
> Checking code gives me the impression that I should do dma_mapping_error() check as well.
> And indeed with below diff the warning is gone:
> 
> +       dma_mapping_error(ab->dev, paddr);
> 
> However this does not make sense to me since IMO testing the CPU address is good enough, I
> can not imagine a valid case where DMA alloc/map fails while returning a valid CPU
> address, no?

Yes, this doesn't make sense.  dma_mapping_error exists to provide a
error handling path for dma_map_*, which return the dma address only.

For the dma_alloc_* interfaces that return a pointer and can signal
with a NULL return it should not be needed and dma-debug needs to
be fixed.

> If I was right, should we remove invocation to debug_dma_map_page() in dma_alloc_pages()?
> 

That allocation still needs to be tracked, so it can't just be removed
but needs to be changed to record the kind of allocation.
