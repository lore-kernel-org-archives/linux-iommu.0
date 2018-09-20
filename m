From: Christoph Hellwig <hch@lst.de>
Subject: dma mask related fixups (including full bus_dma_mask support)
Date: Thu, 20 Sep 2018 20:52:42 +0200
Message-ID: <20180920185247.20037-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

the dma_get_required_mask dma API implementation has always been a little
odd, in that we by default don't wire it up struct dma_map_ops, but
instead hard code a default implementation.  powerpc and ia64 override
this default and either call a method or otherwise duplicate the default.

This series always enabled the method and just falls back to the previous
default implementation when it is not available, as well as fixing up
a few bits in the default implementations.  This already allows removing
the ia64 override of the implementation, and will also allow to remove
the powerpc one together with a few additional cleanups in the powerpc
code, but those will be sent separately with other powerpc DMA API
patches.  Last but not least the method will allow us to return a more
sensible value for typical iommu dma_ops eventually, but that is left
to another series as well.

Additionally the dma-direct code has been a bit sloppy in when it was
using phys_to_dma in a few places, so this gets fixed up as well as
actually respecting the bus_dma_mask everywhere instead of just
rejecting dma mask that don't fit into it.

Alltogether this should be all core dma-direct changes required to
move powerpc over to the generic code.
