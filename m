From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 V3 08/20] iommu/vt-d, trivial: clean up unused code
Date: Mon,  6 Jan 2014 14:18:15 +0800
Message-ID: <1388989107-4795-9-git-send-email-jiang.liu@linux.intel.com>
References: <1388989107-4795-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1388989107-4795-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Remove dead code from VT-d related files.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c        |    2 --
 drivers/iommu/intel-iommu.c |   25 -------------------------
 2 files changed, 27 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 5e7ba3b..f5f7b7d 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1113,8 +1113,6 @@ static const char *irq_remap_fault_reasons[] =
 	"Blocked an interrupt request due to source-id verification failure",
 };
 
-#define MAX_FAULT_REASON_IDX 	(ARRAY_SIZE(fault_reason_strings) - 1)
-
 const char *dmar_get_fault_reason(u8 fault_reason, int *fault_type)
 {
 	if (fault_reason >= 0x20 && (fault_reason - 0x20 <
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3a0cf5d..751db33 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -289,26 +289,6 @@ static inline void dma_clear_pte(struct dma_pte *pte)
 	pte->val = 0;
 }
 
-static inline void dma_set_pte_readable(struct dma_pte *pte)
-{
-	pte->val |= DMA_PTE_READ;
-}
-
-static inline void dma_set_pte_writable(struct dma_pte *pte)
-{
-	pte->val |= DMA_PTE_WRITE;
-}
-
-static inline void dma_set_pte_snp(struct dma_pte *pte)
-{
-	pte->val |= DMA_PTE_SNP;
-}
-
-static inline void dma_set_pte_prot(struct dma_pte *pte, unsigned long prot)
-{
-	pte->val = (pte->val & ~3) | (prot & 3);
-}
-
 static inline u64 dma_pte_addr(struct dma_pte *pte)
 {
 #ifdef CONFIG_64BIT
@@ -319,11 +299,6 @@ static inline u64 dma_pte_addr(struct dma_pte *pte)
 #endif
 }
 
-static inline void dma_set_pte_pfn(struct dma_pte *pte, unsigned long pfn)
-{
-	pte->val |= (uint64_t)pfn << VTD_PAGE_SHIFT;
-}
-
 static inline bool dma_pte_present(struct dma_pte *pte)
 {
 	return (pte->val & 3) != 0;
-- 
1.7.10.4
