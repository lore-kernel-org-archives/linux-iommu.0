Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F425387
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 11:54:35 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 39C3F67373; Wed, 30 Aug 2023 13:54:31 +0200 (CEST)
Date: Wed, 30 Aug 2023 13:54:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
	yajun.deng@linux.dev, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-contiguous: fix the Kconfig entry for
 CONFIG_DMA_NUMA_CMA
Message-ID: <20230830115431.GA23190@lst.de>
References: <20230830092731.148759-1-hch@lst.de> <a33702d2-6024-0129-588d-ce1a879f825c@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a33702d2-6024-0129-588d-ce1a879f825c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 30, 2023 at 11:11:29AM +0100, Robin Murphy wrote:
> I think the "good reason" is that folks who do have NUMA systems are likely 
> to be more interested in getting more consistent DMA performance than 
> losing a bit more non-movable memory capacity, and the runtime impact on 
> non-NUMA systems should be negligible, so I would definitely be inclined to 
> make it "default y". But it's not critically important.

Well, Linus hates these default y, and usually for a good reason.
If it's that useful/importanst for numa systems we should just drop
the option and make the code conditional on CONFIG_NUMA only.
