From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 1/2] iommu/dma: Respect __GFP_DMA and __GFP_DMA32 in
 incoming GFP flags
Date: Wed, 26 Jul 2017 11:15:46 +0200
Message-ID: <20170726091545.GC15833@8bytes.org>
References: <20170704135556.21704-1-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170704135556.21704-1-tfiga@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 04, 2017 at 10:55:55PM +0900, Tomasz Figa wrote:
> Current implementation of __iommu_dma_alloc_pages() keeps adding
> __GFP_HIGHMEM to GFP flags regardless of whether other zone flags are
> already included in the incoming flags. If __GFP_DMA or __GFP_DMA32 is
> set at the same time as __GFP_HIGHMEM, the allocation fails due to
> invalid zone flag combination.
> 
> Fix this by checking for __GFP_DMA and __GFP_DMA32 in incoming GFP flags
> and adding __GFP_HIGHMEM only if they are not present.
> 
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>

Isn't it better to mask out __GFP_DMA and __GFP_DMA32 in the allocation
flags and only take them into account for iova allocation?

When the IOMMU re-maps the DMA to this memory it doesn't matter where it
is in system memory.



	Joerg
