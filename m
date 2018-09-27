From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
Date: Thu, 27 Sep 2018 11:45:15 +1000
Message-ID: <1811156d5a1df1166c7ab7522525619b951f047d.camel@kernel.crashing.org>
References: <20180920185247.20037-1-hch@lst.de>
	<20180920185247.20037-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180920185247.20037-4-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2018-09-20 at 20:52 +0200, Christoph Hellwig wrote:
> +static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
> +               u64 *phys_mask)
> +{
> +       if (force_dma_unencrypted())
> +               *phys_mask = __dma_to_phys(dev, dma_mask);
> +       else
> +               *phys_mask = dma_to_phys(dev, dma_mask);
> +
> +       /* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> +       if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> +               return GFP_DMA;
> +       if (*phys_mask <= DMA_BIT_MASK(32))
> +               return GFP_DMA32;
> +       return 0;
> +}

I'm not sure this is entirely right.

Let's say the mask is 30 bits. You will return GFP_DMA32, which will
fail if you allocate something above 1G (which is legit for
ZONE_DMA32).

I think the logic should be:

	if (mask < ZONE_DMA)
		fail;
	else if (mask < ZONE_DMA32)
		use ZONE_DMA or fail if doesn't exist
	else if (mask < top_of_ram)
		use ZONE_DMA32 or fail if doesn't exist
	else
		use ZONE_NORMAL

Additionally, we want to fold-in the top-of-ram test such that we don't
fail the second case if the mask is 31-bits (smaller than ZONE_DMA32)
but top of ram is also small enough.

So the top of ram test should take precendence.

Cheers,
Ben.
