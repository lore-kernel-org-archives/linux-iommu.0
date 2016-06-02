From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v3 45/45] dma-mapping: Document the DMA attributes right in
	declaration
Date: Thu, 02 Jun 2016 17:39:47 +0200
Message-ID: <1464881987-13203-46-git-send-email-k.kozlowski__4448.00989139384$1464882317$gmane$org@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Richard Henderson <rth-hL46jP5Bxq7R7s880joybQ@public.gmane.org>, Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>, Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Aurelien Jacquiot <a-jacquiot-l0cyMroinI0@public.gmane.org>, Mikael Starvik <starvik-VrBV9hrLPhE@public.gmane.org>, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Copy documentation abstract about each DMA attribute from
Documentation/DMA-attributes.txt to the place with declaration.

Suggested-by: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 include/linux/dma-mapping.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 6d013ba94213..f349df4cb009 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -14,14 +14,47 @@
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
  * of each attribute should be defined in Documentation/DMA-attributes.txt.
+ *
+ * DMA_ATTR_WRITE_BARRIER: DMA to a memory region with this attribute
+ * forces all pending DMA writes to complete.
  */
 #define DMA_ATTR_WRITE_BARRIER		(1UL << 1)
+/*
+ * DMA_ATTR_WEAK_ORDERING: Specifies that reads and writes to the mapping
+ * may be weakly ordered, that is that reads and writes may pass each other.
+ */
 #define DMA_ATTR_WEAK_ORDERING		(1UL << 2)
+/*
+ * DMA_ATTR_WRITE_COMBINE: Specifies that writes to the mapping may be
+ * buffered to improve performance.
+ */
 #define DMA_ATTR_WRITE_COMBINE		(1UL << 3)
+/*
+ * DMA_ATTR_NON_CONSISTENT: Lets the platform to choose to return either
+ * consistent or non-consistent memory as it sees fit.
+ */
 #define DMA_ATTR_NON_CONSISTENT		(1UL << 4)
+/*
+ * DMA_ATTR_NO_KERNEL_MAPPING: Lets the platform to avoid creating a kernel
+ * virtual mapping for the allocated buffer.
+ */
 #define DMA_ATTR_NO_KERNEL_MAPPING	(1UL << 5)
+/*
+ * DMA_ATTR_SKIP_CPU_SYNC: Allows platform code to skip synchronization of
+ * the CPU cache for the given buffer assuming that it has been already
+ * transferred to 'device' domain.
+ */
 #define DMA_ATTR_SKIP_CPU_SYNC		(1UL << 6)
+/*
+ * DMA_ATTR_FORCE_CONTIGUOUS: Forces contiguous allocation of the buffer
+ * in physical memory.
+ */
 #define DMA_ATTR_FORCE_CONTIGUOUS	(1UL << 7)
+/*
+ * DMA_ATTR_ALLOC_SINGLE_PAGES: This is a hint to the DMA-mapping subsystem
+ * that it's probably not worth the time to try to allocate memory to in a way
+ * that gives better TLB efficiency.
+ */
 #define DMA_ATTR_ALLOC_SINGLE_PAGES	(1UL << 8)
 
 /*
-- 
1.9.1
