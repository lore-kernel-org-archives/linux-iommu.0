Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281D1FA0
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 11:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDE2C433C1;
	Tue, 15 Nov 2022 11:48:45 +0000 (UTC)
Date: Tue, 15 Nov 2022 11:48:41 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/13] iommu/dma: Force bouncing of the size is not
 cacheline-aligned
Message-ID: <Y3N8mbLTYPKNnjvV@arm.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-4-catalin.marinas@arm.com>
 <Y3LOCg9FEuFxny0B@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3LOCg9FEuFxny0B@google.com>

On Mon, Nov 14, 2022 at 03:23:54PM -0800, Isaac Manjarres wrote:
> On Sun, Nov 06, 2022 at 10:01:33PM +0000, Catalin Marinas wrote:
> > @@ -1202,7 +1203,10 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >  			goto out;
> >  	}
> >  
> > -	if (dev_use_swiotlb(dev))
> > +	if (dma_sg_kmalloc_needs_bounce(dev, sg, nents, dir))
> > +		sg_dma_mark_bounced(sg);
> > +
> > +	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sg))
> >  		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
> 
> Shouldn't you add a similar check in the iommu_dma_unmap_sg() path to
> free any SWIOTLB memory that may have been allocated to bounce a scatter gather
> list?

Good point, not sure how I missed this. The sync'ing works fine as
iommu_dma_sync_sg_for_cpu() has the check but the swiotlb buffer won't
be freed.

Thanks.

-- 
Catalin
