Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05A34CD4
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 17:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18C6C433EF;
	Tue, 16 May 2023 17:19:46 +0000 (UTC)
Date: Tue, 16 May 2023 18:19:43 +0100
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
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Petr Tesarik <petrtesarik@huaweicloud.com>
Subject: Re: [PATCH v3 00/13] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Message-ID: <ZGO7L9EyDEXU6zWf@arm.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <ZBNiN9CR2F/fvUTh@google.com>
 <ZEARbKMfMS8KdkhJ@arm.com>
 <ZGKDWMqTt/f05AmG@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKDWMqTt/f05AmG@google.com>

On Mon, May 15, 2023 at 12:09:12PM -0700, Isaac Manjarres wrote:
> On Wed, Apr 19, 2023 at 05:06:04PM +0100, Catalin Marinas wrote:
> > I rebased it locally but the last stumbling block is sorting out the
> > iommu bouncing. I was hoping Robin Murphy can lend a hand but he's been
> > busy with other bits. I'll repost the series at 6.4-rc1.
> Hey Catalin, just following up on this. I think it might be worthwhile
> to split this series into two series:
> 
> Series 1: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN,
> and use the cacheline size to determine the minimum kmalloc
> alignment.
> 
> Series 2: Lower the minimum kmalloc alignment to 8 bytes by adding
> support for using SWIOTLB to bounce unaligned kmalloc buffers for DMA
> transactions.
> 
> Dividing the patches as such has the advantage of lowering the minimum
> kmalloc alignment to 64 bytes on many ARM64 systems while the work for
> lowering the minimum alignment to 8 bytes proceeds. This provides a
> noticeable decrease in the slab memory footprint (e.g. I observed a 15
> MB decrease in slab usage on a device I was using).

I attempted "series 1" some time ago and the discussion led to the
combined approach (i.e. don't bother with limiting kmalloc minimum
alignment to cache_line_size() but instead bounce those small buffers).
In my series, I still have this fallback in case there's no swiotlb
buffer.

I'll post a new series this week (including DMA bouncing) but I'll try
to move the bouncing towards the end of the series in case there are
more discussions around this, at least the first part could be picked
up.

-- 
Catalin
