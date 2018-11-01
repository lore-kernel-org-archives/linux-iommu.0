From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] MIPS: Fix `dma_alloc_coherent' returning a non-coherent
 allocation
Date: Thu, 1 Nov 2018 07:54:24 +0000 (GMT)
Message-ID: <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de> <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org> <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org> <20181031203206.GA28337@lst.de>
 <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org> <20181101051359.GA4164@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181101051359.GA4164@lst.de>
Sender: stable-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Paul Burton <paul.burton@mips.com>
Cc: iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Fix a MIPS `dma_alloc_coherent' regression from commit bc3ec75de545 
("dma-mapping: merge direct and noncoherent ops") that causes a cached 
allocation to be returned on noncoherent cache systems.

This is due to an inverted check now used in the MIPS implementation of 
`arch_dma_alloc' on the result from `dma_direct_alloc_pages' before 
doing the cached-to-uncached mapping of the allocation address obtained.  
The mapping has to be done for a non-NULL rather than NULL result, 
because a NULL result means the allocation has failed.

Invert the check for correct operation then.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: bc3ec75de545 ("dma-mapping: merge direct and noncoherent ops")
Cc: stable@vger.kernel.org # 4.19+
---
On Thu, 1 Nov 2018, Christoph Hellwig wrote:

> Fails to compile for me with:
> 
> cc1: error: ‘-march=r3000’ requires ‘-mfp32’
> 
> using the x86_64 corss gcc 8 from Debian testing.

 Hmm, that seems related to the FPXX ABI, which the R3000 does not support 
and which they may have configured as the default for GCC (`-mfpxx').  
That's not relevant to the kernel, so we probably just ought to force 
`-mfp32' and `-mfp64' for 32-bit and 64-bit builds respectively these 
days.

> Either way the config looks like we have all the required bits for
> non-coherent dma support.  The only guess is that somehow
> dma_cache_wback_inv aren't hooked up to the right functions for some
> reason, but I can't really think off why.

 Well, `dma_cache_wback_inv' isn't actually called and with the 64-bit 
configuration I switched to the address returned is in the XKPHYS cached 
noncoherent space, as proved with a simple diagnostic patch applied to 
`dma_direct_alloc' showing the results of `dev_is_dma_coherent' and the 
actual allocation:

tc1: DEFTA at MMIO addr = 0x1e900000, IRQ = 20, Hardware addr = 08-00-2b-a3-a3-29
defxx tc1: dma_direct_alloc: coherent: 0
defxx tc1: dma_direct_alloc: returned: 9800000003db8000
tc1: registered as fddi0

(the value of 3 in bits 61:59 of the virtual address denotes the cached 
noncoherent attribute).

 The cause is commit bc3ec75de545 ("dma-mapping: merge direct and 
noncoherent ops") reversed the interpretation of the `dma_direct_alloc*' 
result in `arch_dma_alloc'.  I guess this change was unlucky not to have 
this part of the API actually verified at run-time by anyone anywhere.

 Fixed thus, with debug output now as expected:

defxx tc1: dma_direct_alloc: coherent: 0
defxx tc1: dma_direct_alloc: returned: 9000000003db8000

showing the address returned in the XKPHYS uncached space (the value of 2 
in bits 61:59 of the virtual address denotes the uncached attribute), and 
the network interface working properly.

 Please apply, and backport as required.

  Maciej
---
 arch/mips/mm/dma-noncoherent.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-mips-arch-dma-alloc-err.patch
Index: linux-20181028-4maxp64-defconfig/arch/mips/mm/dma-noncoherent.c
===================================================================
--- linux-20181028-4maxp64-defconfig.orig/arch/mips/mm/dma-noncoherent.c
+++ linux-20181028-4maxp64-defconfig/arch/mips/mm/dma-noncoherent.c
@@ -50,7 +50,7 @@ void *arch_dma_alloc(struct device *dev,
 	void *ret;
 
 	ret = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
-	if (!ret && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
+	if (ret && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
 		dma_cache_wback_inv((unsigned long) ret, size);
 		ret = (void *)UNCAC_ADDR(ret);
 	}
