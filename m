From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: DMA mappings and crossing boundaries
Date: Fri, 20 Jul 2018 13:12:56 +1000
Message-ID: <97be22364c8b90ca6caba7e2596d6cf90f28136f.camel@kernel.crashing.org>
References: <2d752386b82481bc53080fcee1a3dcd474dbeef2.camel@au1.ibm.com>
	<82688fc5-c294-1db3-9a05-fecf9b9b5e17@arm.com>
	<5f31e833851f5b9a58ca4ed9b5f0a1958cca0efd.camel@au1.ibm.com>
	<2786eaad-f359-c88c-a42c-ff1b93e78c21@arm.com>
	<dad4fa57254e30d99c930e2788eef7f1ce18c17b.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <dad4fa57254e30d99c930e2788eef7f1ce18c17b.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Russell Currey <ruscur-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2018-07-11 at 14:51 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2018-07-04 at 13:57 +0100, Robin Murphy wrote:
> > 
> > > Could it ? I wouldn't think dma_map_page is allows to cross page
> > > boundaries ... what about single() ? The main worry is people using
> > > these things on kmalloc'ed memory
> > 
> > Oh, absolutely - the underlying operation is just "prepare for DMA 
> > to/from this physically-contiguous region"; the only real difference 
> > between map_page and map_single is for the sake of the usual "might be 
> > highmem" vs. "definitely lowmem" dichotomy. Nobody's policing any limits 
> > on the size and offset parameters (in fact, if anyone asks I would say 
> > the outcome of the big "offset > PAGE_SIZE" debate for dma_map_sg a few 
> > months back is valid for dma_map_page too, however silly it may seem).
> 
> I think this is a very bad idea though. We should thrive to avoid
> coalescing before the iommu layer and we should avoid creating sglists
> that cross natural alignment boundaries.

Ping ? Jens, Christoph ?

I really really don't like how sg_alloc_table_from_pages() coalesces
the sglist before it gets mapped. This will potentially create huge
constraints and fragmentation in the IOMMU allocator by passing large
chunks to it.

> I had a look at sg_alloc_table_from_pages() and it basically freaks me
> out.
> 
> Back in the old days, we used to have the block layer aggressively
> coalesce requests iirc, but that was changed to let the iommu layer do
> it.
> 
> If you pass to dma_map_sg() something already heavily coalesced, such
> as what sg_alloc_table_from_pages() can do since it seems to have
> absolutely no limits there, you will create a significant fragmentation
> problem in the iommu allocator.
> 
> Instead, we should probably avoid such coalescing at that level and
> instead let the iommu opportunistically coalesce at the point of
> mapping which it does just fine.
> 
> We've been racking our brains here and we can't find a way to implement
> something we want that is both very performance efficient (no global
> locks etc...) and works with boundary crossing mappings.
> 
> We could always fallback to classic small page mappings but that is
> quite suboptimal.
> 
> I also notice that sg_alloc_table_from_pages() doesn't try to prevent
> crossing the 4G boundary. I remember pretty clearly that it was
> explicitely forbidden to create such a crossing.
> 
> > Of course, given that the allocators tend to give out size/order-aligned 
> > chunks, I think you'd have to be pretty tricksy to get two allocations 
> > to line up either side of a large power-of-two boundary *and* go out of 
> > your way to then make a single request spanning both, but it's certainly 
> > not illegal. Realistically, the kind of "scrape together a large buffer 
> > from smaller pieces" code which is liable to hit a boundary-crossing 
> > case by sheer chance is almost certainly going to be taking the 
> > sg_alloc_table_from_pages() + dma_map_sg() route for convenience, rather 
> > than implementing its own merging and piecemeal mapping.
> 
> Yes and I  think what sg_alloc_table_from_pages() does is quite wrong.
> 
> > > > Conceptually it looks pretty easy to extend the allocation constraints
> > > > to cope with that - even the pathological worst case would have an
> > > > absolute upper bound of 3 IOMMU entries for any one physical region -
> > > > but if in practice it's a case of mapping arbitrary CPU pages to 32-bit
> > > > DMA addresses having only 4 1GB slots to play with, I can't really see a
> > > > way to make that practical :(
> > > 
> > > No we are talking about 40-ish-bits of address space, so there's a bit
> > > of leeway. Of course no scheme will work if the user app tries to map
> > > more than the GPU can possibly access.
> > > 
> > > But with newer AMD adding a few more bits and nVidia being at 47-bits,
> > > I think we have some margin, it's just that they can't reach our
> > > discontiguous memory with a normal 'bypass' mapping and I'd rather not
> > > teach Linux about every single way our HW can scatter memory accross
> > > nodes, so an "on demand" mechanism is by far the most flexible way to
> > > deal with all configurations.
> > > 
> > > > Maybe the best compromise would be some sort of hybrid scheme which
> > > > makes sure that one of the IOMMU entries always covers the SWIOTLB
> > > > buffer, and invokes software bouncing for the awkward cases.
> > > 
> > > Hrm... not too sure about that. I'm happy to limit that scheme to well
> > > known GPU vendor/device IDs, and SW bouncing is pointless in these
> > > cases. It would be nice if we could have some kind of guarantee that a
> > > single mapping or sglist entry never crossed a specific boundary
> > > though... We more/less have that for 4G already (well, we are supposed
> > > to at least). Who are the main potential problematic subsystems here ?
> > > I'm thinking network skb allocation pools ... and page cache if it
> > > tries to coalesce entries before issuing the map request, does it ?
> > 
> > I don't know of anything definite off-hand, but my hunch is to be most 
> > wary of anything wanting to do zero-copy access to large buffers in 
> > userspace pages. In particular, sg_alloc_table_from_pages() lacks any 
> > kind of boundary enforcement (and most all users don't even use the 
> > segment-length-limiting variant either), so I'd say any caller of that 
> > currently has a very small, but nonzero, probability of spoiling your day.
> 
> And I'm starting to think we should just fix them.
> 
> Cheers,
> Ben.
> 
> > Robin.
> > 
