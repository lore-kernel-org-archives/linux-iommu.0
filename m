Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7E225B2F4
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174175; cv=none; b=Mq0EkIIoENdR0La5UkyKGk10JZjZ+QPGfzudDbVb9fdnOfl+zZKlLMef9rsJZpVTBrm6McRuK3hl+RELJnRvhc4YuzaRA3q+d97SGYGI8JUGz+wN+b2SPpuXxm/U4BRGbbpYfHHThVYOeB1AfjWrXjsFZSSSV8pOPru68NHa0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174175; c=relaxed/simple;
	bh=5Nz2rGPPwqkzFPSGO42JyaFE6VLUOKskrtT8Y5jqURc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIrAKxgPlFQpbxxpdOMM30j01jtXfBdKLXLw+mEaTdkNEDwHRZrWTUtdtZ4FO6YNZtimk3jX/AkdPtj+4/SRQECrJYtIVQHmSX9Y6XB5wZMmk/db1vVtBkItki72lvD5OR4m+whHidYSZoaNMFYhgpSatQN3g/Gr/Q+P0ojfrc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TtaF+XMa; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TtaF+XMa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776174167; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=U2weyCWeUiC1DQdpANta8XyK+H83ByiNSTyDznEA5f4=;
	b=TtaF+XMa+yE6XL0MXlHdWP1Q1ns1kKIXjhwbQ4FKse5+yWq44MHd1aqIjlgm6SxiTcJumdueZDuvGlTgd4izrfck529teV54OH7NQY4FNYI+VuuIUHT/aYpWvvrO2VA+kC+oS3KT33KAJId255WKeqVKgzRRbp73v2cdKBHAp3s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X11gcsy_1776174166;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X11gcsy_1776174166 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Apr 2026 21:42:47 +0800
Date: Tue, 14 Apr 2026 21:42:46 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dma-contiguous: try local node first for
 dma_alloc_contiguous()
Message-ID: <ad5EVrgODYccho0Y@U-2FWC9VHC-2323.local>
References: <20260414090310.92055-1-feng.tang@linux.alibaba.com>
 <dbe5ceb4-cf2a-4742-a706-dac64611998c@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbe5ceb4-cf2a-4742-a706-dac64611998c@arm.com>

Hi Robin,

On Tue, Apr 14, 2026 at 01:32:11PM +0100, Robin Murphy wrote:
> On 14/04/2026 10:03 am, Feng Tang wrote:
> > There was a bug report on a multi-numa-nodes ARM server that when
> > IOMMU is disabled, the dma_alloc_coherent() function always returns
> > memory from node 0 even for devices attaching to other nodes, while
> > they can get local dma memory when IOMMU is on with the same API.
> > 
> > The reason is, when IOMMU is disabled, the dma_alloc_coherent() will
> > go the direct way and call dma_alloc_contiguous(). The system doesn't
> > have any explicit cma setting (like per-numa cma), and only has a
> > default 64MB cma reserved area (on node 0), where kernel will try
> > first to allocate memory from.
> > 
> > Make the dma allocation more locality friendly by trying first the
> > numa aware allocation alloc_pages_node() before falling back to the
> > reserved cma area.
> > 
> > One more thought is to check the node of the reserved cma area and
> > only call alloc_pages_nodes() when it isn't the same node that the
> > device attaches to.

Thanks for the prompt review!

> Frankly, no. We literally have a feature specifically created for this
> use-case already - if you care about NUMA locality of DMA allocations then
> enable DMA_NUMA_CMA. Or if you don't need CMA at all, then disabling CMA
> would be even better for the overall performance of your system.

That makes sense. I also recommended using the per-numa cma to the reporter.

One thing is this numa unfriendly behavior happens silently, and I haven't
noticed it for long time till I got the bug report, as the normal
distribution enable CONFIG_CMA which provides the 64M cma area on node
0 (mostly) by default. I'm afraid many normal users are experiencing the
same thing without doing any extra explicit cma setting.

Thanks,
Feng

> Thanks,
> Robin.
> 
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> >   kernel/dma/contiguous.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index c56004d314dc..0180f40f094e 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -371,8 +371,9 @@ static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
> >    */
> >   struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> >   {
> > -#ifdef CONFIG_DMA_NUMA_CMA
> > +#ifdef CONFIG_NUMA
> >   	int nid = dev_to_node(dev);
> > +	struct page *page;
> >   #endif
> >   	/* CMA can be used only in the context which permits sleeping */
> > @@ -386,7 +387,6 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> >   #ifdef CONFIG_DMA_NUMA_CMA
> >   	if (nid != NUMA_NO_NODE && !(gfp & (GFP_DMA | GFP_DMA32))) {
> >   		struct cma *cma = dma_contiguous_pernuma_area[nid];
> > -		struct page *page;
> >   		if (cma) {
> >   			page = cma_alloc_aligned(cma, size, gfp);
> > @@ -402,6 +402,14 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> >   		}
> >   	}
> >   #endif
> > +
> > +#ifdef CONFIG_NUMA
> > +	/* Try first to allocate memory on the same node as the device */
> > +	page = alloc_pages_node(nid, gfp, get_order(size));
> > +	if (page)
> > +		return page;
> > +#endif
> > +
> >   	if (!dma_contiguous_default_area)
> >   		return NULL;
