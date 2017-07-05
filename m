From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [RFC PATCH 2/5] base: dma-mapping: Provide a function to look up
	remapped pages
Date: Wed,  5 Jul 2017 16:12:12 +0900
Message-ID: <20170705071215.17603-3-tfiga@chromium.org>
References: <20170705071215.17603-1-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170705071215.17603-1-tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

DMA API implementations, which use the dma_common_*() helpers, typically
use them in pair with other helpers, such as iommu_dma_*(). For example,
a typical .free() callback needs to retrieve the pages remapped earlier
by dma_common_remap() and call iommu_dma_unmap() on them. Currently it
is done by calling find_vm_area() manually, however it relies on
implementation details of dma_common_remap() and is also difficult to
expose to loadable modules, due to find_vm_area() being quite a low
level function without its symbol exported.

Improve this by providing a function to look-up the pages previously
remapped. It hides implementation details, can do more sanity checks
than find_vm_area() and can be exported for use in loadable modules.

Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/base/dma-mapping.c  | 15 +++++++++++++++
 include/linux/dma-mapping.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 1fda8df3d849..9add50dd7a08 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -335,6 +335,21 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
 	vunmap(cpu_addr);
 }
 EXPORT_SYMBOL(dma_common_free_remap);
+
+struct page **dma_common_get_mapped_pages(void *cpu_addr,
+					  unsigned long vm_flags)
+{
+	struct vm_struct *area = find_vm_area(cpu_addr);
+
+	if (!area || (area->flags & vm_flags) != vm_flags) {
+		WARN(1, "trying to get pages for invalid coherent area: %p\n",
+		     cpu_addr);
+		return NULL;
+	}
+
+	return area->pages;
+}
+EXPORT_SYMBOL(dma_common_get_mapped_pages);
 #endif
 
 /*
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 843ab866e0f4..bd20435dac16 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -422,6 +422,8 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 			unsigned long vm_flags, pgprot_t prot,
 			const void *caller);
 void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags);
+struct page **dma_common_get_mapped_pages(void *cpu_addr,
+					  unsigned long vm_flags);
 
 /**
  * dma_mmap_attrs - map a coherent DMA allocation into user space
-- 
2.13.2.725.g09c95d1e9-goog
