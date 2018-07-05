From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Date: Thu, 5 Jul 2018 21:36:13 +0200
Message-ID: <20180705193613.GA28905@lst.de>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, JuergenUrban-Mmb7MZpHnFY@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> -	BUG_ON(!ops);
> -	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> -
>  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>  		return cpu_addr;
>  
> +	BUG_ON(!ops);
> +	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);

I think doing dma on a device without ops is completely broken no matter
what you think of it, so I very much disagree with that part of the change.

Also while I don't think not having a dma mask is a good idea even for
a driver purely using dma coherent pools.  If the pools really are on
the device itself I can see why it might not matter, but for the case
commonly used on some ARM SOCs where we just reserve memory for certain
devices from a system pool it very much does matter.

There really is no good excuse to not set a coherent mask in the drivers.
