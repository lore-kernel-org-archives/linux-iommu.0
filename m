From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: DMA mappings and crossing boundaries
Date: Mon, 02 Jul 2018 23:37:36 +1000
Message-ID: <5f31e833851f5b9a58ca4ed9b5f0a1958cca0efd.camel@au1.ibm.com>
References: <2d752386b82481bc53080fcee1a3dcd474dbeef2.camel@au1.ibm.com>
         <82688fc5-c294-1db3-9a05-fecf9b9b5e17@arm.com>
Reply-To: benh@au1.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <82688fc5-c294-1db3-9a05-fecf9b9b5e17@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: Russell Currey <ruscur@au1.ibm.com>, iommu@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2018-07-02 at 14:06 +0100, Robin Murphy wrote:

 .../...

Thanks Robin, I was starting to depair anybody would reply ;-)

> > AFAIK, dma_alloc_coherent() is defined (Documentation/DMA-API-
> > HOWTO.txt) as always allocating to the next power-of-2 order, so we
> > should never have the problem unless we allocate a single chunk larger
> > than the IOMMU page size.
> 
> (and even then it's not *that* much of a problem, since it comes down to 
> just finding n > 1 consecutive unused IOMMU entries for exclusive use by 
> that new chunk)

Yes, this case is not my biggest worry.

> > For dma_map_sg() however, if a request that has a single "entry"
> > spawning such a boundary, we need to ensure that the result mapping is
> > 2 contiguous "large" iommu pages as well.
> > 
> > However, that doesn't fit well with us re-using existing mappings since
> > they may already exist and either not be contiguous, or partially exist
> > with no free hole around them.
> > 
> > Now, we *could* possibly construe a way to solve this by detecting this
> > case and just allocating another "pair" (or set if we cross even more
> > pages) of IOMMU pages elsewhere, thus partially breaking our re-use
> > scheme.
> > 
> > But while doable, this introduce some serious complexity in the
> > implementation, which I would very much like to avoid.
> > 
> > So I was wondering if you guys thought that was ever likely to happen ?
> > Do you see reasonable cases where dma_map_sg() would be called with a
> > list in which a single entry crosses a 256M or 1G boundary ?
> 
> For streaming mappings of buffers cobbled together out of any old CPU 
> pages (e.g. user memory), you may well happen to get two 
> physically-adjacent pages falling either side of an IOMMU boundary, 
> which comprise all or part of a single request - note that whilst it's 
> probably less likely than the scatterlist case, this could technically 
> happen for dma_map_{page, single}() calls too.

Could it ? I wouldn't think dma_map_page is allows to cross page
boundaries ... what about single() ? The main worry is people using
these things on kmalloc'ed memory

> Conceptually it looks pretty easy to extend the allocation constraints 
> to cope with that - even the pathological worst case would have an 
> absolute upper bound of 3 IOMMU entries for any one physical region - 
> but if in practice it's a case of mapping arbitrary CPU pages to 32-bit 
> DMA addresses having only 4 1GB slots to play with, I can't really see a 
> way to make that practical :(

No we are talking about 40-ish-bits of address space, so there's a bit
of leeway. Of course no scheme will work if the user app tries to map
more than the GPU can possibly access.

But with newer AMD adding a few more bits and nVidia being at 47-bits,
I think we have some margin, it's just that they can't reach our
discontiguous memory with a normal 'bypass' mapping and I'd rather not
teach Linux about every single way our HW can scatter memory accross
nodes, so an "on demand" mechanism is by far the most flexible way to
deal with all configurations.

> Maybe the best compromise would be some sort of hybrid scheme which 
> makes sure that one of the IOMMU entries always covers the SWIOTLB 
> buffer, and invokes software bouncing for the awkward cases.

Hrm... not too sure about that. I'm happy to limit that scheme to well
known GPU vendor/device IDs, and SW bouncing is pointless in these
cases. It would be nice if we could have some kind of guarantee that a
single mapping or sglist entry never crossed a specific boundary
though... We more/less have that for 4G already (well, we are supposed
to at least). Who are the main potential problematic subsystems here ?
I'm thinking network skb allocation pools ... and page cache if it
tries to coalesce entries before issuing the map request, does it ?

Ben.

> Robin.
