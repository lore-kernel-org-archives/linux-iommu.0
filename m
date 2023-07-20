Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CDF3D99
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 06:25:29 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 11F7567373; Thu, 20 Jul 2023 08:25:26 +0200 (CEST)
Date: Thu, 20 Jul 2023 08:25:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] dma: DMA_ATTR_SKIP_CPU_SYNC documentation tweaks
Message-ID: <20230720062525.GA3723@lst.de>
References: <98ef4f76d7a5f90b0878e649a70b101402b8889d.1689761699.git.mst@redhat.com> <20230720060742.GA2987@lst.de> <20230720021914-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720021914-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 20, 2023 at 02:21:05AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 20, 2023 at 08:07:42AM +0200, Christoph Hellwig wrote:
> > On Wed, Jul 19, 2023 at 06:15:59AM -0400, Michael S. Tsirkin wrote:
> > > A recent patchset highlighted to me that DMA_ATTR_SKIP_CPU_SYNC
> > > might be easily misunderstood.
> > 
> > .. just curious: what patchset is that?  DMA_ATTR_SKIP_CPU_SYNC is
> > often a bad idea and all users probably could use a really good
> > audit..
> 
> Message-Id: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>

Do you have an actual link?

> 
> 
> Looks like there's really little else can be done: there's a
> shared page we allow DMA into, so we sync periodically.
> Then when we unmap we really do not need that data
> synced again.
> 
> What exactly is wrong with this?

A "shared" page without ownership can't work with the streaming
DMA API (dma_map_*) at all.  You need to use dma_alloc_coherent
so that it is mapped uncached.
