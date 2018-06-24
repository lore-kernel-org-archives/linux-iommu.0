From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: DMA mappings and crossing boundaries
Date: Sun, 24 Jun 2018 17:32:50 +1000
Message-ID: <2d752386b82481bc53080fcee1a3dcd474dbeef2.camel@au1.ibm.com>
Reply-To: benh@au1.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell Currey <ruscur@au1.ibm.com>, Jens Axboe <jens.axboe@oracle.com>
List-Id: iommu@lists.linux-foundation.org

Hi Folks !

So due work around issues with devices having to strict limitations in
DMA address bits (GPUs ugh....) on POWER, we've been playing with a
mechanism that does dynamic mapping in the IOMMU but using a very large
IOMMU page size (256M on POWER8 and 1G on POWER9) for performances.

Now, with such page size, we can't just pop out new entries for every
DMA map, we need to try to re-use entries for mappings in the same
"area". 

We've prototypes something using refcounts on the entires. It does
imply some locking which is potentially problematic, and we'll be
looking at options there long run, but it works... so far.

My worry is that it will fail if we ever get a mapping request (or
coherent allocation request) that spawns one of those giant pages
boundaries. At least our current implementation.

AFAIK, dma_alloc_coherent() is defined (Documentation/DMA-API-
HOWTO.txt) as always allocating to the next power-of-2 order, so we
should never have the problem unless we allocate a single chunk larger
than the IOMMU page size.

For dma_map_sg() however, if a request that has a single "entry"
spawning such a boundary, we need to ensure that the result mapping is
2 contiguous "large" iommu pages as well.

However, that doesn't fit well with us re-using existing mappings since
they may already exist and either not be contiguous, or partially exist
with no free hole around them.

Now, we *could* possibly construe a way to solve this by detecting this
case and just allocating another "pair" (or set if we cross even more
pages) of IOMMU pages elsewhere, thus partially breaking our re-use
scheme.

But while doable, this introduce some serious complexity in the
implementation, which I would very much like to avoid.

So I was wondering if you guys thought that was ever likely to happen ?
Do you see reasonable cases where dma_map_sg() would be called with a
list in which a single entry crosses a 256M or 1G boundary ?

Cheers,
Ben.
