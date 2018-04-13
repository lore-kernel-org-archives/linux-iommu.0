From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v2] base: dma-mapping: Postpone cpu addr translation on mmap()
Date: Fri, 13 Apr 2018 19:25:37 +0200
Message-ID: <1523640337-26064-1-git-send-email-jacopo+renesas@jmondi.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: laurent.pinchart@ideasonboard.com, robin.murphy@arm.com, hch@infradead.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp, dalias@libc.org, iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Postpone calling virt_to_page() translation on memory locations not
guaranteed to be backed by a struct page. Try first to map memory from
device's coherent memory pool, then perform translation if that fails.

On some architectures, specifically SH when configured with SPARSEMEM
memory model, assuming a struct page is always assigned to a memory
address lead to unexpected hangs during the virtual to page address
translation. This patch fixes that specific issue but applies in the
general case too.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

---

It has now been clarified this patch does not resolve the issue, but only
mitigate it on platforms where dma_mmap_from_dev_coherent() succeeds and
delay page_to_pfn() faulty conversion.

A suggested proper solution would be not relying on dma_common_mmap() but
require all platforms to implement an mmap methods known to work, as noted
by Christoph in v1 review.

v1 -> v2:
- Save the 'pfn' temp variable performing the page_to_pfn() conversion in the
  remap_pfn_range() function call as suggested by Christoph.

---
 drivers/base/dma-mapping.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 3b11835..d82566d 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -226,7 +226,6 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
 	unsigned long off = vma->vm_pgoff;

 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
@@ -234,12 +233,11 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;

-	if (off < count && user_count <= (count - off)) {
+	if (off < count && user_count <= (count - off))
 		ret = remap_pfn_range(vma, vma->vm_start,
-				      pfn + off,
+				      page_to_pfn(virt_to_page(cpu_addr)) + off,
 				      user_count << PAGE_SHIFT,
 				      vma->vm_page_prot);
-	}
 #endif	/* !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */

 	return ret;
--
2.7.4
