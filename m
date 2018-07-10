From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] dma-mapping: Clean up dma_get_required_mask()
	hooks
Date: Tue, 10 Jul 2018 17:08:24 +0200
Message-ID: <20180710150824.GA12274@lst.de>
References: <55ac9550c311f056dcfeed9b2c8265375f17b155.1530726467.git.robin.murphy@arm.com>
	<08256121f325ceed7f6b88c1a5d3cf949698787d.1530726467.git.robin.murphy@arm.com>
	<20180710113908.GB32688@lst.de>
	<3b8a23b6-6015-3e8e-07f0-b75920a1e264@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3b8a23b6-6015-3e8e-07f0-b75920a1e264-5wv7dgnIgG8@public.gmane.org>
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
Cc: linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 10, 2018 at 01:29:20PM +0100, Robin Murphy wrote:
>> What I've done is to:
>>
>>   1) provide the get_required_mask unconditionally in struct dma_map_ops
>>   2) default to what is the current dma_get_required_mask implementation
>>      if nothing else is specified.
>
> Yeah, there's already 17 pointers in dma_map_ops of which about half are 
> optional, so these awkward #ifdefs to save one more probably aren't worth 
> the inconsistency they bring. It feels like this guy mostly goes 
> hand-in-hand with dma_supported, so ack to giving it the same look and 
> feel.

This whole area needs a major refactoring - we currentl have three
different APIs to deal with addressability: dma_get_required_mask,
dma_capable/dma_set_mask and dma_capable from dma-direct.h, and there
is plenty of unexplainable mismatches between them.

Sorting this out has been on my TODO list, but I think it can only
effectively be done once the direct mapping implementations are
reasonably consolidated.

>> What I still had on my todo list but not done yet:
>>
>>   3) go through all instances and check if the current default
>>      makes sense, at it based on direct addressability.  For most
>>      iommu instances it seems like we should just return a 64-bit mask.
>
> That's reasonable, although in many cases we should know the effective 
> IOMMU input address size which would be even neater.

Sure.  Maybe I just need to steps 1 and 2 and let maintainers fill
in.

>>   4) figure out how to take the dma offsets into account for it
>
> AFAICS it might boil down to simply:
>
> 	mask = roundup_pow_of_two(phys_to_dma(dev, PFN_PHYS(max_pfn))) - 1;

That looks way to sensible.  Which reminds me that I need to research
the history behind the low_totalram/high_totalram magic in
dma_get_required_mask.
