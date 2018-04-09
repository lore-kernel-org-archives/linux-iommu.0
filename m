From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH] base: dma-mapping: Postpone cpu addr translation on mmap()
Date: Mon,  9 Apr 2018 18:59:08 +0200
Message-ID: <1523293148-18726-1-git-send-email-jacopo+renesas@jmondi.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: laurent.pinchart@ideasonboard.com, robin.murphy@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp, dalias@libc.org, iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Postpone calling virt_to_page() translation on memory locations not
guaranteed to be backed by a struct page.

This patch fixes a specific issue of SH architecture configured with
SPARSEMEM memory model, when mapping buffers allocated with the memblock
APIs at system initialization time, and thus not backed by the page
infrastructure.

It does apply to the general case though, as an early translation is anyhow
incorrect and shall be postponed after trying to map memory from the device
coherent memory pool first.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

---
Compared to the RFC version I have tried to generalize the commit message,
please suggest any improvement to that.

I'm still a bit puzzled on what happens if dma_mmap_from_dev_coherent() fails.
Does a dma_mmap_from_dev_coherent() failure guarantee anyhow that the
successive virt_to_page() isn't problematic as it is today?
Or is it the
 	if (off < count && user_count <= (count - off))
check that makes the translation safe?

Thanks
   j

---
 drivers/base/dma-mapping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 3b11835..8b4ec34 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -226,8 +226,8 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
 	unsigned long off = vma->vm_pgoff;
+	unsigned long pfn;

 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

@@ -235,6 +235,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		return ret;

 	if (off < count && user_count <= (count - off)) {
+		pfn = page_to_pfn(virt_to_page(cpu_addr));
 		ret = remap_pfn_range(vma, vma->vm_start,
 				      pfn + off,
 				      user_count << PAGE_SHIFT,
--
2.7.4
