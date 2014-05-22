From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/3] iommu/exynos: Fix checkpatch warning
Date: Thu, 22 May 2014 09:50:56 +0530
Message-ID: <1400732456-5716-3-git-send-email-sachin.kamat@linaro.org>
References: <1400732456-5716-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1400732456-5716-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
Cc: sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Silences the following type of warnings:
WARNING: Missing a blank line after declarations

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 09f69b1d80fc..99054d2c040d 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -268,6 +268,7 @@ static void __sysmmu_tlb_invalidate_entry(void __iomem *sfrbase,
 				sysmmu_iova_t iova, unsigned int num_inv)
 {
 	unsigned int i;
+
 	for (i = 0; i < num_inv; i++) {
 		__raw_writel((iova & SPAGE_MASK) | 1,
 				sfrbase + REG_MMU_FLUSH_ENTRY);
@@ -878,6 +879,7 @@ static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *priv,
 		 */
 		if (need_flush_flpd_cache) {
 			struct exynos_iommu_owner *owner;
+
 			spin_lock(&priv->lock);
 			list_for_each_entry(owner, &priv->clients, client)
 				sysmmu_tlb_invalidate_flpdcache(
@@ -941,6 +943,7 @@ static int lv2set_page(sysmmu_pte_t *pent, phys_addr_t paddr, size_t size,
 		*pgcnt -= 1;
 	} else { /* size == LPAGE_SIZE */
 		int i;
+
 		for (i = 0; i < SPAGES_PER_LPAGE; i++, pent++) {
 			if (WARN_ON(!lv2ent_fault(pent))) {
 				if (i > 0)
-- 
1.7.9.5
