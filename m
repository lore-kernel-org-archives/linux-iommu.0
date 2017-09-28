From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] iommu/iova: Try harder to allocate from rcache
 magazine
Date: Thu, 28 Sep 2017 15:41:16 +0200
Message-ID: <20170928134115.GS8398@8bytes.org>
References: <cover.1505827369.git.robin.murphy@arm.com>
 <8127fabc219811d8169189e9d7177d42bc74bcbf.1505827369.git.robin.murphy@arm.com>
 <8e319924684be401103a5831acee6895d7c5b6d6.1506594488.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8e319924684be401103a5831acee6895d7c5b6d6.1506594488.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 28, 2017 at 11:31:23AM +0100, Robin Murphy wrote:
> When devices with different DMA masks are using the same domain, or for
> PCI devices where we usually try a speculative 32-bit allocation first,
> there is a fair possibility that the top PFN of the rcache stack at any
> given time may be unsuitable for the lower limit, prompting a fallback
> to allocating anew from the rbtree. Consequently, we may end up
> artifically increasing pressure on the 32-bit IOVA space as unused IOVAs
> accumulate lower down in the rcache stacks, while callers with 32-bit
> masks also impose unnecessary rbtree overhead.
> 
> In such cases, let's try a bit harder to satisfy the allocation locally
> first - scanning the whole stack should still be relatively inexpensive.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: There's no need for a 'proper' stack rotation
> 
>  drivers/iommu/iova.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Thanks, applied the series.
