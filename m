From: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH v9 09/13] xpfo: add primitives for mapping underlying
	memory
Date: Wed,  3 Apr 2019 11:34:10 -0600
Message-ID: <9f7930eca60750aaf5381efbbcb45f6da192874f.1554248002.git.khalid.aziz@oracle.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1554248001.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <cover.1554248001.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
References: <cover.1554248001.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: juergh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tycho-E0fblnxP3wo@public.gmane.org, jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org, ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, liran.alon-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, aneesh.kumar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org, rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, anthony.yznaga-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org, npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joao.m.martins-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, brgl-ARrdPY/1zhM@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, chris.hyser-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Khalid Aziz <khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org>, aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, steve.capper-5wv7dgnIgG8@public.gmane.org, james.morse-5wv7dgnIgG8@public.gmane.org, iamjoo
List-Id: iommu@lists.linux-foundation.org

From: Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>

In some cases (on arm64 DMA and data cache flushes) we may have unmapped
the underlying pages needed for something via XPFO. Here are some
primitives useful for ensuring the underlying memory is mapped/unmapped in
the face of xpfo.

Signed-off-by: Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>
Signed-off-by: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Khalid Aziz <khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org>
---
 include/linux/xpfo.h | 21 +++++++++++++++++++++
 mm/xpfo.c            | 30 ++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
index 5d8d06e4b796..2318c7eb5fb7 100644
--- a/include/linux/xpfo.h
+++ b/include/linux/xpfo.h
@@ -91,6 +91,15 @@ void xpfo_free_pages(struct page *page, int order);
 
 phys_addr_t user_virt_to_phys(unsigned long addr);
 
+#define XPFO_NUM_PAGES(addr, size) \
+	(PFN_UP((unsigned long) (addr) + (size)) - \
+		PFN_DOWN((unsigned long) (addr)))
+
+void xpfo_temp_map(const void *addr, size_t size, void **mapping,
+		   size_t mapping_len);
+void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
+		     size_t mapping_len);
+
 #else /* !CONFIG_XPFO */
 
 static inline void xpfo_init_single_page(struct page *page) { }
@@ -106,6 +115,18 @@ static inline void xpfo_flush_kernel_tlb(struct page *page, int order) { }
 
 static inline phys_addr_t user_virt_to_phys(unsigned long addr) { return 0; }
 
+#define XPFO_NUM_PAGES(addr, size) 0
+
+static inline void xpfo_temp_map(const void *addr, size_t size, void **mapping,
+				 size_t mapping_len)
+{
+}
+
+static inline void xpfo_temp_unmap(const void *addr, size_t size,
+				   void **mapping, size_t mapping_len)
+{
+}
+
 #endif /* CONFIG_XPFO */
 
 #if (!defined(CONFIG_HIGHMEM)) && (!defined(ARCH_HAS_KMAP))
diff --git a/mm/xpfo.c b/mm/xpfo.c
index b74fee0479e7..974f1b70ccd9 100644
--- a/mm/xpfo.c
+++ b/mm/xpfo.c
@@ -14,6 +14,7 @@
  * the Free Software Foundation.
  */
 
+#include <linux/highmem.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/xpfo.h>
@@ -104,3 +105,32 @@ void xpfo_free_pages(struct page *page, int order)
 		}
 	}
 }
+
+void xpfo_temp_map(const void *addr, size_t size, void **mapping,
+		   size_t mapping_len)
+{
+	struct page *page = virt_to_page(addr);
+	int i, num_pages = mapping_len / sizeof(mapping[0]);
+
+	memset(mapping, 0, mapping_len);
+
+	for (i = 0; i < num_pages; i++) {
+		if (page_to_virt(page + i) >= addr + size)
+			break;
+
+		if (PageXpfoUnmapped(page + i))
+			mapping[i] = kmap_atomic(page + i);
+	}
+}
+EXPORT_SYMBOL(xpfo_temp_map);
+
+void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
+		     size_t mapping_len)
+{
+	int i, num_pages = mapping_len / sizeof(mapping[0]);
+
+	for (i = 0; i < num_pages; i++)
+		if (mapping[i])
+			kunmap_atomic(mapping[i]);
+}
+EXPORT_SYMBOL(xpfo_temp_unmap);
-- 
2.17.1
