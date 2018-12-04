From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry
 pool
Date: Tue, 4 Dec 2018 15:29:38 +0100
Message-ID: <20181204142938.GC2767@lst.de>
References: <cover.1543856576.git.robin.murphy@arm.com> <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

> +	for (retry_count = 0; ; retry_count++) {
> +		spin_lock_irqsave(&free_entries_lock, flags);
> +
> +		if (num_free_entries > 0)
> +			break;
>  
>  		spin_unlock_irqrestore(&free_entries_lock, flags);

Taking a spinlock just to read a single integer value doesn't really
help anything.

> +
> +		if (retry_count < DMA_DEBUG_DYNAMIC_RETRIES &&
> +		    !prealloc_memory(DMA_DEBUG_DYNAMIC_ENTRIES))

Don't we need GFP_ATOMIC here?  Also why do we need the retries?
