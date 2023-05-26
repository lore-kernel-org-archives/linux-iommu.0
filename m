Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B328C3E
	for <iommu@lists.linux.dev>; Fri, 26 May 2023 19:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB83C433EF;
	Fri, 26 May 2023 19:22:16 +0000 (UTC)
Date: Fri, 26 May 2023 20:22:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 13/15] iommu/dma: Force bouncing if the size is not
 cacheline-aligned
Message-ID: <ZHEG5ghHMXcv1/WL@arm.com>
References: <20230524171904.3967031-1-catalin.marinas@arm.com>
 <20230524171904.3967031-14-catalin.marinas@arm.com>
 <ZHDgDrQL+WPDsxxh@xhacker>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHDgDrQL+WPDsxxh@xhacker>

On Sat, May 27, 2023 at 12:36:30AM +0800, Jisheng Zhang wrote:
> On Wed, May 24, 2023 at 06:19:02PM +0100, Catalin Marinas wrote:
> > diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> > index 87aaf8b5cdb4..330a157c5501 100644
> > --- a/include/linux/scatterlist.h
> > +++ b/include/linux/scatterlist.h
> > @@ -248,6 +248,29 @@ static inline void sg_unmark_end(struct scatterlist *sg)
> >  	sg->page_link &= ~SG_END;
> >  }
> >  
> > +#define SG_DMA_BUS_ADDRESS	(1 << 0)
> > +#define SG_DMA_USE_SWIOTLB	(1 << 1)
> > +
> > +#ifdef CONFIG_SWIOTLB
> 
> s/CONFIG_SWIOTLB/CONFIG_NEED_SG_DMA_FLAGS ?
> Otherwise, there's compiler error if SWIOTLB=y but IOMMU=n

Yes, I pushed a fixup to the kmalloc-minalign branch.

> > +static inline bool sg_is_dma_use_swiotlb(struct scatterlist *sg)
> > +{
> > +	return sg->dma_flags & SG_DMA_USE_SWIOTLB;
> > +}
> > +
> > +static inline void sg_dma_mark_use_swiotlb(struct scatterlist *sg)
> > +{
> > +	sg->dma_flags |= SG_DMA_USE_SWIOTLB;
> > +}
> > +#else
> > +static inline bool sg_is_dma_use_swiotlb(struct scatterlist *sg)
> > +{
> > +	return false;
> > +}
> > +static inline void sg_dma_mark_use_swiotlb(struct scatterlist *sg)
> > +{
> > +}
> > +#endif

And I wonder whether we should keep these accessors in the scatterlist.h
file. They are only used by the dma-iommu.c code.

-- 
Catalin
