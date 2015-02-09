From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] CHROMIUM: iommu: rockchip: Make sure that page table state is
	coherent
Date: Mon,  9 Feb 2015 20:19:21 +0900
Message-ID: <1423480761-33453-1-git-send-email-tfiga@chromium.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Even though the code uses the dt_lock spin lock to serialize mapping
operation from different threads, it does not protect from IOMMU
accesses that might be already taking place and thus altering state
of the IOTLB. This means that current mapping code which first zaps
the page table and only then updates it with new mapping which is
prone to mentioned race.

In addition, current code assumes that mappings are always > 4 MiB
(which translates to 1024 PTEs) and so they would always occupy
entire page tables. This is not true for mappings created by V4L2
Videobuf2 DMA contig allocator.

This patch changes the mapping code to always zap the page table
after it is updated, which avoids the aforementioned race and also
zap the last page of the mapping to make sure that stale data is
not cached from an already existing mapping.

Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 6a8b1ec..b06fe76 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -544,6 +544,15 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 }
 
+static void rk_iommu_zap_iova_first_last(struct rk_iommu_domain *rk_domain,
+					 dma_addr_t iova, size_t size)
+{
+	rk_iommu_zap_iova(rk_domain, iova, SPAGE_SIZE);
+	if (size > SPAGE_SIZE)
+		rk_iommu_zap_iova(rk_domain, iova + size - SPAGE_SIZE,
+					SPAGE_SIZE);
+}
+
 static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 				  dma_addr_t iova)
 {
@@ -568,12 +577,6 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	rk_table_flush(page_table, NUM_PT_ENTRIES);
 	rk_table_flush(dte_addr, 1);
 
-	/*
-	 * Zap the first iova of newly allocated page table so iommu evicts
-	 * old cached value of new dte from the iotlb.
-	 */
-	rk_iommu_zap_iova(rk_domain, iova, SPAGE_SIZE);
-
 done:
 	pt_phys = rk_dte_pt_address(dte);
 	return (u32 *)phys_to_virt(pt_phys);
@@ -623,6 +626,14 @@ static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_addr,
 
 	rk_table_flush(pte_addr, pte_count);
 
+	/*
+	 * Zap the first and last iova to evict from iotlb any previously
+	 * mapped cachelines holding stale values for its dte and pte.
+	 * We only zap the first and last iova, since only they could have
+	 * dte or pte shared with an existing mapping.
+	 */
+	rk_iommu_zap_iova_first_last(rk_domain, iova, size);
+
 	return 0;
 unwind:
 	/* Unmap the range of iovas that we just mapped */
-- 
2.2.0.rc0.207.ga3a616c
