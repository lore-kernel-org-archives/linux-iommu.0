From: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Subject: [PATCH 20/26] iommu/fsl: Fix alignment of some stray lines
Date: Wed, 28 Jan 2015 08:34:52 -0600
Message-ID: <1422455698-3074-21-git-send-email-Emilian.Medve@Freescale.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422455698-3074-1-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, Varun.Sethi-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org
Cc: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu.h        |  2 +-
 drivers/iommu/fsl_pamu_domain.c | 15 ++++++---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.h b/drivers/iommu/fsl_pamu.h
index 04dcd25..342ac6d 100644
--- a/drivers/iommu/fsl_pamu.h
+++ b/drivers/iommu/fsl_pamu.h
@@ -67,7 +67,7 @@ struct pamu_mmap_regs {
 #define PAMU_AVS1_GCV   0x2000
 #define PAMU_AVS1_PDV   0x4000
 #define PAMU_AV_MASK    (PAMU_AVS1_AV | PAMU_AVS1_OTV | PAMU_AVS1_APV | PAMU_AVS1_WAV \
-			| PAMU_AVS1_LAV | PAMU_AVS1_GCV | PAMU_AVS1_PDV)
+			 | PAMU_AVS1_LAV | PAMU_AVS1_GCV | PAMU_AVS1_PDV)
 #define PAMU_AVS1_LIODN_SHIFT 16
 #define PAMU_LAV_LIODN_NOT_IN_PPAACT 0x400
 
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index eea2212..ae21305 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -62,8 +62,7 @@ static int __init iommu_init_mempool(void)
 static phys_addr_t get_phys_addr(struct fsl_dma_domain *dma_domain, dma_addr_t iova)
 {
 	u32 win_cnt = dma_domain->win_cnt;
-	struct dma_window *win_ptr =
-				&dma_domain->win_arr[0];
+	struct dma_window *win_ptr = &dma_domain->win_arr[0];
 	struct iommu_domain_geometry *geom;
 
 	geom = &dma_domain->iommu_domain->geometry;
@@ -92,15 +91,13 @@ static phys_addr_t get_phys_addr(struct fsl_dma_domain *dma_domain, dma_addr_t i
 
 static int map_subwins(int liodn, struct fsl_dma_domain *dma_domain)
 {
-	struct dma_window *sub_win_ptr =
-				&dma_domain->win_arr[0];
+	struct dma_window *sub_win_ptr = &dma_domain->win_arr[0];
 	int i, ret;
 	unsigned long rpn, flags;
 
 	for (i = 0; i < dma_domain->win_cnt; i++) {
 		if (sub_win_ptr[i].valid) {
-			rpn = sub_win_ptr[i].paddr >>
-				 PAMU_PAGE_SHIFT;
+			rpn = sub_win_ptr[i].paddr >> PAMU_PAGE_SHIFT;
 			spin_lock_irqsave(&iommu_lock, flags);
 			ret = pamu_config_spaace(liodn, dma_domain->win_cnt, i,
 						 sub_win_ptr[i].size,
@@ -180,8 +177,8 @@ static int update_liodn(int liodn, struct fsl_dma_domain *dma_domain, u32 wnd_nr
 					 wnd->size,
 					 ~(u32)0,
 					 wnd->paddr >> PAMU_PAGE_SHIFT,
-					dma_domain->snoop_id, dma_domain->stash_id,
-					0, wnd->prot);
+					 dma_domain->snoop_id, dma_domain->stash_id,
+					 0, wnd->prot);
 		if (ret)
 			pr_debug("Window reconfiguration failed for liodn %d\n", liodn);
 	}
@@ -679,7 +676,7 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 	} else {
 		pr_debug("missing fsl,liodn property at %s\n",
 			 dev->of_node->full_name);
-			ret = -EINVAL;
+		ret = -EINVAL;
 	}
 
 	return ret;
-- 
2.2.2
