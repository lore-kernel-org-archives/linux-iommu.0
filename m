From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] kernel/dma/direct: take DMA offset into account in
	dma_direct_supported
Date: Wed, 29 Aug 2018 18:59:56 +0200
Message-ID: <20180829165956.GA6787@lst.de>
References: <20180824065324.654-1-hch@lst.de> <20180824065324.654-2-hch@lst.de>
	<0e95df80-38f7-7970-ef74-419567f13fdc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0e95df80-38f7-7970-ef74-419567f13fdc-5wv7dgnIgG8@public.gmane.org>
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
Cc: thomas.lendacky-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 24, 2018 at 12:11:23PM +0100, Robin Murphy wrote:
> On 24/08/18 07:53, Christoph Hellwig wrote:
>> When a device has a DMA offset the dma capable result will change due
>> to the difference between the physical and DMA address.  Take that into
>> account.
>
> The "phys_to_dma(..., DMA_BIT_MASK(...))" idiom always looks like a glaring 
> error at first glance, but this whole function is fairly unintuitive 
> anyway, and ultimately I think the change does work out to be correct.
>
> It might be nicer if we could reference max_zone_pfns[] for a bit more 
> clarity, but I guess that's not arch-independent.

Not just arch specific, but also local variables.  There is
arch_zone_lowest_possible_pfn in page_alloc.c, but that gets discarded
after init.  That being said this is the right direction and I'll
look into it for 4.20 or later.
