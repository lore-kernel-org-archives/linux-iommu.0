From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
Date: Tue, 5 Mar 2019 09:16:44 +0100
Message-ID: <CAK8P3a2KQKTDQCQcFR7ZTFJ+_XhfKpy9W27r+YV=iD6hLVu2xg@mail.gmail.com>
References: <20190304195951.1118807-1-arnd@arndb.de> <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Stefano Stabellini <sstabellini@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, xen-devel <xen-devel@lists.xenproject.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 5, 2019 at 12:56 AM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2019-03-04 7:59 pm, Arnd Bergmann wrote:
> > This reverts commit b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR"), which
> > introduced an overflow warning in configurations that have a larger
> > dma_addr_t than phys_addr_t:
> >
> > In file included from include/linux/dma-direct.h:5,
> >                   from kernel/dma/swiotlb.c:23:
> > kernel/dma/swiotlb.c: In function 'swiotlb_tbl_map_single':
> > include/linux/dma-mapping.h:136:28: error: conversion from 'long long unsigned int' to 'phys_addr_t' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Werror=overflow]
> >   #define DMA_MAPPING_ERROR  (~(dma_addr_t)0)
> >                              ^
> > kernel/dma/swiotlb.c:544:9: note: in expansion of macro 'DMA_MAPPING_ERROR'
> >    return DMA_MAPPING_ERROR;
> >
> > The configuration that caused this is on 32-bit ARM, where the DMA address
> > space depends on the enabled hardware platforms, while the physical
> > address space depends on the type of MMU chosen (classic vs LPAE).
>
> Are these real platforms, or random configs? Realistically I don't see a
> great deal of need to support DMA_ADDR_T_64BIT for non-LPAE.
> Particularly in this case since AFAIK the only selector of SWIOTLB on
> Arm is Xen, and that by definition is never going to be useful on
> non-LPAE hardware.
...
On Mon, Mar 4, 2019 at 11:00 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
> What about making the phys_addr_t and dma_addr_t have the same
> width with some magic #ifdef hackery?

As far as I can tell, only randconfig builds see this problem, in
real systems phys_addr_t is normally the same as dma_addr_t,
and you could reasonably have a machine with a larger phys_addr_t
than dma_addr_t but wouldn't need to bother.

The reason I'd like to keep them independent on ARM is that
the difference does occasionally find real driver bugs where some
drivers happily mix phys_addr_t and dma_addr_t in ways that
are broken even when they are the same size.

On Tue, Mar 5, 2019 at 12:56 AM Robin Murphy <robin.murphy@arm.com> wrote:
> Fair enough that we don't still don't want even randconfigs generating
> warnings, though. As long as this change doesn't let SWIOTLB_MAP_ERROR
> leak out to logic expecting DMA_MAP_ERROR - which does appear to be the
> case - and is also still OK for the opposite weirdness of
> PHYS_ADDR_T_64BIT && !DMA_ADDR_T_64BIT, then I think it's reasonable.

Another option would be to change the return type of swiotlb_tbl_map_single()
to 'u64', which would always be large enough to contain both a phys_addr_t
and DMA_MAP_ERROR. I first tried changing the return type to dma_addr_t,
which solves the build issue, but I couldn't convince myself that this is
correct in all cases, or that this is a sensible type to use here.

       Arnd
