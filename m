From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 4/8] dma-debug: Dynamically expand the
 dma_debug_entry pool
Date: Thu, 6 Dec 2018 15:24:23 +0100
Message-ID: <20181206142423.GB24642@lst.de>
References: <cover.1544037783.git.robin.murphy@arm.com> <8ba34734842beb3ef72260c4ab822dba7c588e4c.1544037783.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8ba34734842beb3ef72260c4ab822dba7c588e4c.1544037783.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, cai@gmx.us, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

> @@ -47,6 +47,8 @@
>  #ifndef PREALLOC_DMA_DEBUG_ENTRIES
>  #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>  #endif

FYI, I think we should drop the potential arch hook with the ifndef
here once we support the dynamic adjustment.

> +		if (dma_debug_create_entries(DMA_DEBUG_DYNAMIC_ENTRIES, GFP_ATOMIC)) {

Overly long line.
