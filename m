From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: DMA mappings and crossing boundaries
Date: Mon, 2 Jul 2018 14:06:02 +0100
Message-ID: <82688fc5-c294-1db3-9a05-fecf9b9b5e17@arm.com>
References: <2d752386b82481bc53080fcee1a3dcd474dbeef2.camel@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2d752386b82481bc53080fcee1a3dcd474dbeef2.camel-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: benh-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Russell Currey <ruscur-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Ben,

On 24/06/18 08:32, Benjamin Herrenschmidt wrote:
> Hi Folks !
> 
> So due work around issues with devices having to strict limitations in
> DMA address bits (GPUs ugh....) on POWER, we've been playing with a
> mechanism that does dynamic mapping in the IOMMU but using a very large
> IOMMU page size (256M on POWER8 and 1G on POWER9) for performances.
> 
> Now, with such page size, we can't just pop out new entries for every
> DMA map, we need to try to re-use entries for mappings in the same
> "area".
> 
> We've prototypes something using refcounts on the entires. It does
> imply some locking which is potentially problematic, and we'll be
> looking at options there long run, but it works... so far.
> 
> My worry is that it will fail if we ever get a mapping request (or
> coherent allocation request) that spawns one of those giant pages
> boundaries. At least our current implementation.
> 
> AFAIK, dma_alloc_coherent() is defined (Documentation/DMA-API-
> HOWTO.txt) as always allocating to the next power-of-2 order, so we
> should never have the problem unless we allocate a single chunk larger
> than the IOMMU page size.

(and even then it's not *that* much of a problem, since it comes down to 
just finding n > 1 consecutive unused IOMMU entries for exclusive use by 
that new chunk)

> For dma_map_sg() however, if a request that has a single "entry"
> spawning such a boundary, we need to ensure that the result mapping is
> 2 contiguous "large" iommu pages as well.
> 
> However, that doesn't fit well with us re-using existing mappings since
> they may already exist and either not be contiguous, or partially exist
> with no free hole around them.
> 
> Now, we *could* possibly construe a way to solve this by detecting this
> case and just allocating another "pair" (or set if we cross even more
> pages) of IOMMU pages elsewhere, thus partially breaking our re-use
> scheme.
> 
> But while doable, this introduce some serious complexity in the
> implementation, which I would very much like to avoid.
> 
> So I was wondering if you guys thought that was ever likely to happen ?
> Do you see reasonable cases where dma_map_sg() would be called with a
> list in which a single entry crosses a 256M or 1G boundary ?

For streaming mappings of buffers cobbled together out of any old CPU 
pages (e.g. user memory), you may well happen to get two 
physically-adjacent pages falling either side of an IOMMU boundary, 
which comprise all or part of a single request - note that whilst it's 
probably less likely than the scatterlist case, this could technically 
happen for dma_map_{page, single}() calls too.

Conceptually it looks pretty easy to extend the allocation constraints 
to cope with that - even the pathological worst case would have an 
absolute upper bound of 3 IOMMU entries for any one physical region - 
but if in practice it's a case of mapping arbitrary CPU pages to 32-bit 
DMA addresses having only 4 1GB slots to play with, I can't really see a 
way to make that practical :(

Maybe the best compromise would be some sort of hybrid scheme which 
makes sure that one of the IOMMU entries always covers the SWIOTLB 
buffer, and invokes software bouncing for the awkward cases.

Robin.
