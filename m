Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5896023CB
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 05:42:44 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8176D68AA6; Wed, 17 Aug 2022 07:36:28 +0200 (CEST)
Date: Wed, 17 Aug 2022 07:36:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Liu Song <liusong@linux.alibaba.com>, akpm@linux-foundation.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2] mm/dmapool.c: avoid duplicate memset within
 dma_pool_alloc
Message-ID: <20220817053628.GA28747@lst.de>
References: <1658125690-76930-1-git-send-email-liusong@linux.alibaba.com> <CGME20220816123958eucas1p1b03a5efa1f5804245a5c1a9b27529015@eucas1p1.samsung.com> <1dbe63ff-5575-745b-653a-a992ae53e1aa@samsung.com> <413d8666-7a82-efd7-6716-13658016ca10@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413d8666-7a82-efd7-6716-13658016ca10@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>>> A helper function "use_dev_coherent_memory" is introduced here to
>>> determine whether the memory is allocated by "dma_alloc_from_dev_coherent".
>>>
>>> And use "get_dma_ops" to determine whether the memory is allocated by
>>> "dma_direct_alloc".

WTF?  get_dma_ops is privat to the DMA API layer, and dmapool has no
business even using that.  Even independent of this particular case,
consumers of an API never have any business looking at the implementation
of the API, that is the whole point of the abstraction.

> It's not even that, the change here is just obviously broken, since it ends 
> up entirely ignoring want_init_on_alloc() for devices using dma-direct. 
> Sure, the memory backing a dma_page is zeroed *once* by its initial 
> dma-coherent allocation, but who says we're not not reallocating pool 
> entries from an existing dma_page?

And yes, in addition to that it also is completely broken.
