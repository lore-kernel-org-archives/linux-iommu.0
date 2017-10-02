From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: road blocks for using dma-iommu on more than arm64
Date: Mon, 2 Oct 2017 18:48:20 +0100
Message-ID: <8027096b-08f8-ca31-3b23-6cf41178b75a@arm.com>
References: <20171001090245.GA22124@infradead.org>
	<7fcdaa8c-a12c-3264-0173-5c1be6f11ff7@arm.com>
	<20171002145025.GA28291@infradead.org>
	<7037c9c3-002b-2228-6988-aa659667056e@arm.com>
	<20171002163153.GA17254@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171002163153.GA17254-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 02/10/17 17:31, Christoph Hellwig wrote:
> On Mon, Oct 02, 2017 at 03:56:14PM +0100, Robin Murphy wrote:
>> IIRC, dmabounce has to stay because it handles non-contiguous DMA masks,
>> thanks to a StrongARM hardware erratum where the DMA controller could
>> only access every other megabyte of memory (or something like that).
> 
> Isn't that exactly the problem that xen-swiotlb solves?

As far as I can see, not quite - swiotlb-xen appears to handle buffers
which span non-contiguous host pages, but still assumes that DMA masks
are of the full DMA_BIT_MASK() form such that checks like "addr <= mask"
work. I suppose we *could* try just making the SWIOTLB users themselves
robust against incomplete masks (e.g. [2]) if they need to be, but I'm
not sure whether that would actually work in practice.

FWIW, I could have sworn I had an old mail from Russell about this but
that seems to have vanished - after a bit more digging it's actually
about avoiding a particular address line on the SA-1111 as documented in
[1], and set up in sa1111_configure_smc() (arch/arm/common/sa1111.c).

Robin.


[1] https://wwwcip.informatik.uni-erlangen.de/~simigern/jornada-7xx/docs/sa1111-errata.pdf

[2]
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 0df756b24863..8db96d714517 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -66,10 +66,13 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
+	dma_addr_t mask;
+
 	if (!dev->dma_mask)
 		return false;
 
-	return addr + size - 1 <= *dev->dma_mask;
+	mask = *dev->dma_mask;
+	return !(addr + size - 1 & ~mask) && (size - 1 <= mask ^ (mask + 1));
 }
 
 static inline void dma_mark_clean(void *addr, size_t size)
