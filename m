From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [15/15] dma-mapping: bypass indirect calls for dma-direct
Date: Sun, 16 Dec 2018 10:02:42 +0100
Message-ID: <20181216090242.GA30702@lst.de>
References: <20181207190720.18517-16-hch@lst.de>
	<20181215174654.GA25694@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181215174654.GA25694-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke-LJ9M9ZcSy1A@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Ilias Apalodimas <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jesper Dangaard Brouer <brouer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Jonathan Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tariq Toukan <tariqt-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Dec 15, 2018 at 09:46:54AM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Fri, Dec 07, 2018 at 11:07:20AM -0800, Christoph Hellwig wrote:
> > Avoid expensive indirect calls in the fast path DMA mapping
> > operations by directly calling the dma_direct_* ops if we are using
> > the directly mapped DMA operations.
> > 
> 
> This patch results in arm64 boot failures. Reverting the patch fixes
> the problem. Bisect results are attached. Per logs, the system fails
> to instantiate the root device. Examples from two logs:

This patch should fix it, it has already been sent out Friday and
I'm just waiting for an ACK from the arm64 maintainers before
applying it:

--
>From e6dc770875bc551ff77fe5673f5dd3c8ac242536 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Date: Fri, 14 Dec 2018 15:18:08 +0100
Subject: arm64: default to the direct mapping in get_arch_dma_ops

Otherwise the direct mapping won't work at all given that a NULL
dev->dma_ops causes a fallback.  Note that we already explicitly set
dev->dma_ops to dma_dummy_ops for dma-incapable devices, so this
fallback should not be needed anyway.

Fixes: 356da6d0cd ("dma-mapping: bypass indirect calls for dma-direct")
Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Reported-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Tested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm64/include/asm/dma-mapping.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 273e778f7de2..95dbf3ef735a 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -26,11 +26,7 @@
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	/*
-	 * We expect no ISA devices, and all other DMA masters are expected to
-	 * have someone call arch_setup_dma_ops at device creation time.
-	 */
-	return &dma_dummy_ops;
+	return NULL;
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-- 
2.19.2
