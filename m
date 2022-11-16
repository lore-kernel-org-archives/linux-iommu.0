Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A847F
	for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 06:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1TLoj1jBh9mfMsybawiDvBcJ2RcbjxqyJGEX5P65aOg=; b=bU6HegogN9wH+X9y5iGWJdisoO
	k2Ymc/RhPss5DD1PUdAnIYOcGXq08cIdUXnSu7fknT3bN7sh8c3wALssuMTPRne3/L+ZS61ufQZXN
	9Pjuddt0jI5AnGbXPA5PnshgQxRaKH5b7pjnonneOw7g2lmW+ntc/7cpF944/iC6X9uPizKqiwGdK
	yGrPUs2DpOLpw/ssxLxrGHXcx4XRjB+G1SWH2nTjcb7aJl22kQaq1RTHL3H7Tjp2lZ/2/9XEwd+ud
	RJdtZE/gFeJt3xGddeKtNAsknRtiHqN+h32kyqNkDqp1o8h6rtdYkCvgae4U/ArvtBIqJ/eLjJGI0
	8fpeP64A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovCIM-000NU5-7X; Wed, 16 Nov 2022 06:53:14 +0000
Date: Tue, 15 Nov 2022 22:53:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>, iommu@lists.linux.dev
Subject: Re: [PATCH v2 -next] iommu/dma: avoid expensive indirect calls for
 sync operations
Message-ID: <Y3SI2vMf58/WZDwS@infradead.org>
References: <20221115182841.2640176-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115182841.2640176-1-edumazet@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

As Robing pointed out this really is mostly a dma-mapping layer
patch and the subject should reflect that.

> +		if (!IS_ENABLED(CONFIG_DMA_API_DEBUG) && dev_is_dma_coherent(dev))
> +			dev->skip_dma_sync = true;

I don't think CONFIG_DMA_API_DEBUG should come into play here.  It
is independent from the low-level sync calls.  That'll need a bit
of restructuring later on to only skil the sync calls and not the
debug_dma_* calls, but I think that is worth it to keep the concept
clean.
In fact that might lead to just checking the skip_dma_sync flag in
a wrapper in dma-mapping.h, avoiding the function call entirely
for the fast path, at the downside of increasing code size by
adding an extra branch in the callers, but I think that is ok.

I think we should also apply the skip_dma_sync to dma-direct while
we're it.  While dma-direct already avoids the indirect calls we can
shave off a few more cycles with this infrastructure, so why skip that?

> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -647,6 +647,7 @@ struct device {
>      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>  	bool			dma_coherent:1;
>  #endif
> +	bool			skip_dma_sync:1;

This also needs a blurb in the kerneldoc comment describing struct
device.  Please make it very clear in the comment that the flag is
only for internal use in the DMA mapping subsystem and not for use
by drives.

> +static inline bool dev_skip_dma_sync(struct device *dev)
> +{
> +	return dev->skip_dma_sync;
> +}

I'd drop this wrapper and just check the flag directly.

> +	if (unlikely(dev->skip_dma_sync))
> +		dev->skip_dma_sync = false;

Please add a comment here.


Btw, one thing I had in my mind for a while is to do direct calls to
dma-iommu from the core mapping code just like we for dma-direct.
Would that be useful for your networking loads, or are the actual
mapping calls rare enough to not matter?
