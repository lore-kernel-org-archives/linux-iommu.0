From: David Dillow via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH] iommu/vt-d: don't over-free page table directories
Date: Mon, 30 Jan 2017 19:11:11 -0800
Message-ID: <20170131031111.18464-1-dillow@google.com>
Reply-To: David Dillow <dillow-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Ben Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Dillow <dillow-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sridhar Raman <sridharr-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

dma_pte_free_level() recurses down the IOMMU page tables and frees
directory pages that are entirely contained in the given PFN range.
Unfortunately, it incorrectly calculates the starting address covered
by the PTE under consideration, which can lead to it clearing an entry
that is still in use.

This occurs if we have a scatterlist with an entry that has a length
greater than 1026 MB and is aligned to 2 MB for both the IOMMU and
physical addresses. For example, if __domain_mapping() is asked to map a
two-entry scatterlist with 2 MB and 1028 MB segments to PFN 0xffff80000,
it will ask if dma_pte_free_pagetable() is asked to PFNs from
0xffff80200 to 0xffffc05ff, it will also incorrectly clear the PFNs from
0xffff80000 to 0xffff801ff because of this issue. The current code will
set level_pfn to 0xffff80200, and 0xffff80200-0xffffc01ff fits inside
the range being cleared. Properly setting the level_pfn for the current
level under consideration catches that this PTE is outside of the range
being cleared.

This patch also changes the value passed into dma_pte_free_level() when
it recurses. This only affects the first PTE of the range being cleared,
and is handled by the existing code that ensures we start our cursor no
lower than start_pfn.

This was found when using dma_map_sg() to map large chunks of contiguous
memory, which immediatedly led to faults on the first access of the
erroneously-deleted mappings.

Fixes: 3269ee0bd668 ("intel-iommu: Fix leaks in pagetable freeing")
Reviewed-by: Benjamin Serebrin <serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: David Dillow <dillow-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8a185250ae5a..0aa0ca9a10e3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1144,7 +1144,7 @@ static void dma_pte_free_level(struct dmar_domain *domain, int level,
 		if (!dma_pte_present(pte) || dma_pte_superpage(pte))
 			goto next;
 
-		level_pfn = pfn & level_mask(level - 1);
+		level_pfn = pfn & level_mask(level);
 		level_pte = phys_to_virt(dma_pte_addr(pte));
 
 		if (level > 2)
-- 
2.11.0.483.g087da7b7c-goog
