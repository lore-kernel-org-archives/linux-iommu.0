Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA1411182
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 15:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247B1C433D2;
	Fri, 19 May 2023 15:46:37 +0000 (UTC)
Date: Fri, 19 May 2023 16:46:35 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [PATCH v4 13/15] iommu/dma: Force bouncing if the size is not
 cacheline-aligned
Message-ID: <ZGeZ21UQAXvrMe/2@arm.com>
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
 <20230518173403.1150549-14-catalin.marinas@arm.com>
 <9dc3e036-75cd-debf-7093-177ef6c7a3ae@arm.com>
 <ZGeBcLVFKpLdTveZ@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGeBcLVFKpLdTveZ@arm.com>

On Fri, May 19, 2023 at 03:02:24PM +0100, Catalin Marinas wrote:
> On Fri, May 19, 2023 at 01:29:38PM +0100, Robin Murphy wrote:
> > On 2023-05-18 18:34, Catalin Marinas wrote:
> > > +				sg_dma_mark_bounced(sg);
> > 
> > I'd prefer to have iommu_dma_map_sg_swiotlb() mark the segments, since
> > that's in charge of the actual bouncing. Then we can fold the alignment
> > check into dev_use_swiotlb() (with the dev_is_untrusted() condition taking
> > priority), and sync/unmap can simply rely on sg_is_dma_bounced() alone.
> 
> With this patch we only set the SG_DMA_BOUNCED on the first element of
> the sglist. Do you want to set this flag only on individual elements
> being bounced? It makes some sense in principle but the
> iommu_dma_unmap_sg() path would need to scan the list again to decide
> whether to go the swiotlb path.
> 
> If we keep the SG_DMA_BOUNCED flag only on the first element, I can
> change it to your suggestion, assuming I understood it.

Can one call:

	iommu_dma_map_sg(sg, nents);
	...
	iommu_dma_unmap_sg(sg + n, nents - n);

(i.e. unmap it in multiple steps)

If yes, setting SG_DMA_BOUNCED on the first element only won't work. I
don't find this an unlikely scenario, so we maybe we do have to walk the
list again in unmap to search for the flag.

-- 
Catalin
