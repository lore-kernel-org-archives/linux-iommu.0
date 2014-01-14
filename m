From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/5] enhance DMA CMA on x86
Date: Tue, 14 Jan 2014 23:13:45 +0900
Message-ID: <1389708830-5841-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch set enhances the DMA Contiguous Memory Allocator on x86.

Currently the DMA CMA is only supported with pci-nommu dma_map_ops
and furthermore it can't be enabled on x86_64.  But I would like to
allocate big contiguous memory with dma_alloc_coherent() and tell it
to the device that requires it, regardless of which dma mapping
implementation is actually used in the system.

So this makes it work with swiotlb and intel-iommu dma_map_ops, too.
And this also extends "cma=" kernel parameter to specify placement
constraint by the physical address range of memory allocations.  For
example, CMA allocates memory below 4GB by "cma=64M@0-4G", it is
required for the devices only supporting 32-bit addressing on 64-bit
systems without iommu.

* Changes from v1
- fix dma_alloc_coherent() with __GFP_ZERO
- add placement specifier for "cma=" kernel parameter

Akinobu Mita (5):
  x86: make dma_alloc_coherent() return zeroed memory if CMA is enabled
  x86: enable DMA CMA with swiotlb
  intel-iommu: integrate DMA CMA
  memblock: introduce memblock_alloc_range()
  cma: add placement specifier for "cma=" kernel parameter

 Documentation/kernel-parameters.txt |  7 +++++--
 arch/x86/Kconfig                    |  2 +-
 arch/x86/include/asm/swiotlb.h      |  7 +++++++
 arch/x86/kernel/amd_gart_64.c       |  2 +-
 arch/x86/kernel/pci-dma.c           |  3 +--
 arch/x86/kernel/pci-swiotlb.c       |  9 +++++---
 arch/x86/pci/sta2x11-fixup.c        |  6 ++----
 drivers/base/dma-contiguous.c       | 42 ++++++++++++++++++++++++++++---------
 drivers/iommu/intel-iommu.c         | 32 +++++++++++++++++++++-------
 include/linux/dma-contiguous.h      |  9 +++++---
 include/linux/memblock.h            |  2 ++
 include/linux/swiotlb.h             |  2 ++
 lib/swiotlb.c                       |  2 +-
 mm/memblock.c                       | 27 +++++++++++++++++-------
 14 files changed, 110 insertions(+), 42 deletions(-)

Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
-- 
1.8.3.2
