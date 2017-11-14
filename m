From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [RFC v2 2/2] base: dma-mapping: Postpone page_to_pfn() on mmap()
Date: Tue, 14 Nov 2017 18:08:06 +0100
Message-ID: <1510679286-6988-3-git-send-email-jacopo+renesas@jmondi.org>
References: <1510679286-6988-1-git-send-email-jacopo+renesas@jmondi.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510679286-6988-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ysato@users.sourceforge.jp, dalias@libc.org, laurent.pinchart@ideasonboard.com, geert@linux-m68k.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On SH4 architecture, with SPARSEMEM memory model, translating page to
pfn hangs the CPU. Post-pone translation to pfn after
dma_mmap_from_dev_coherent() function call as it succeeds and make page
translation not necessary.

This patch was suggested by Laurent Pinchart and he's working to submit
a proper fix mainline. Not sending for inclusion at the moment.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/base/dma-mapping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index e584edd..73d64d3 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -227,8 +227,8 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
 	unsigned long off = vma->vm_pgoff;
+	unsigned long pfn;

 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

@@ -236,6 +236,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		return ret;

 	if (off < count && user_count <= (count - off)) {
+		pfn = page_to_pfn(virt_to_page(cpu_addr));
 		ret = remap_pfn_range(vma, vma->vm_start,
 				      pfn + off,
 				      user_count << PAGE_SHIFT,
--
2.7.4
