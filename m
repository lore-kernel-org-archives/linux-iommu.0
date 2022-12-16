Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A02634
	for <iommu@lists.linux.dev>; Fri, 16 Dec 2022 06:54:12 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id A8D8E68AA6; Fri, 16 Dec 2022 07:46:45 +0100 (CET)
Date: Fri, 16 Dec 2022 07:46:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, hch@lst.de,
	m.szyprowski@samsung.com,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [6.2][regression] after commit
 ffcb754584603adf7039d7972564fbf6febdc542 all sound devices
 disappeared (due BUG at mm/page_alloc.c:3592!)
Message-ID: <20221216064645.GA24446@lst.de>
References: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=AMvf7ZahcYvpRQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Ok, it seems like the sound noncontig alloc code that I already
commented on as potentially bogus GFP_GOMP mapping trips this.  I think
for now the right thing would be to revert the hunk in dma-iommu.c
(see patch below).  The other thing to try would be to remove both
uses GFP_COMP in sound/core/memalloc.c, which should have the same
effect.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9297b741f5e80e..f798c44e090337 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -744,9 +744,6 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 	/* IOMMU can map any pages, so himem can also be used here */
 	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
 
-	/* It makes no sense to muck about with huge pages */
-	gfp &= ~__GFP_COMP;
-
 	while (count) {
 		struct page *page = NULL;
 		unsigned int order_size;
