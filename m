From: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Subject: [PATCH 21/26] iommu/fsl: Fix checkpatch type LONG_LINE
Date: Wed, 28 Jan 2015 08:34:53 -0600
Message-ID: <1422455698-3074-22-git-send-email-Emilian.Medve@Freescale.com>
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

Only pr_*() here

WARNING:LONG_LINE: line over 80 characters
+		pr_debug("window size too small or not a power of two %pa\n", &win_size);

WARNING:LONG_LINE: line over 80 characters
+				pr_debug("missing cache-stash-id at %s\n", node->full_name);

ARNING:LONG_LINE: line over 80 characters
+				pr_debug("missing cache-stash-id at %s\n", node->full_name);

WARNING:LONG_LINE: line over 80 characters
+					pr_emerg("PAACE[%u]=%08x\n", j, in_be32(paace + j));

WARNING:LONG_LINE: line over 80 characters
+				pr_emerg("Disabling liodn %x\n", avs1 >> PAMU_AVS1_LIODN_SHIFT);

WARNING:LONG_LINE: line over 80 characters
+			pr_debug("Subwindow reconfiguration failed for liodn %d\n", liodn);

WARNING:LONG_LINE: line over 80 characters
+			pr_debug("Window reconfiguration failed for liodn %d\n", liodn);

WARNING:LONG_LINE: line over 80 characters
+		pr_debug("Windows not configured, stash destination update failed for liodn %d\n", liodn);

WARNING:LONG_LINE: line over 80 characters
+			pr_debug("Failed to update SPAACE %d field for liodn %d\n ", i, liodn);

WARNING:LONG_LINE: line over 80 characters
+		pr_debug("PAACE configuration failed for liodn %d, win_cnt =%d\n", liodn, win_cnt);

WARNING:LONG_LINE: line over 80 characters
+				pr_debug("SPAACE configuration failed for liodn %d\n", liodn);

Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c        | 15 ++++++++++-----
 drivers/iommu/fsl_pamu_domain.c | 18 ++++++++++++------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index ba5d1e0..3f83259 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -338,7 +338,8 @@ int pamu_config_ppaace(int liodn, phys_addr_t win_addr, phys_addr_t win_size,
 	unsigned long fspi;
 
 	if ((win_size & (win_size - 1)) || win_size < PAMU_PAGE_SIZE) {
-		pr_debug("window size too small or not a power of two %pa\n", &win_size);
+		pr_debug("window size too small or not a power of two %pa\n",
+			 &win_size);
 		return -EINVAL;
 	}
 
@@ -530,7 +531,8 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
 		if (node) {
 			prop = of_get_property(node, "cache-stash-id", 0);
 			if (!prop) {
-				pr_debug("missing cache-stash-id at %s\n", node->full_name);
+				pr_debug("missing cache-stash-id at %s\n",
+					 node->full_name);
 				of_node_put(node);
 				return ~(u32)0;
 			}
@@ -556,7 +558,8 @@ found_cpu_node:
 		if (stash_dest_hint == cache_level) {
 			prop = of_get_property(node, "cache-stash-id", 0);
 			if (!prop) {
-				pr_debug("missing cache-stash-id at %s\n", node->full_name);
+				pr_debug("missing cache-stash-id at %s\n",
+					 node->full_name);
 				of_node_put(node);
 				return ~(u32)0;
 			}
@@ -793,7 +796,8 @@ irqreturn_t pamu_av_isr(int irq, void *arg)
 
 				/* Only the first four words are relevant */
 				for (j = 0; j < 4; j++)
-					pr_emerg("PAACE[%u]=%08x\n", j, in_be32(paace + j));
+					pr_emerg("PAACE[%u]=%08x\n",
+						 j, in_be32(paace + j));
 			}
 
 			/* clear access violation condition */
@@ -813,7 +817,8 @@ irqreturn_t pamu_av_isr(int irq, void *arg)
 				/* Disable the LIODN */
 				ret = pamu_disable_liodn(avs1 >> PAMU_AVS1_LIODN_SHIFT);
 				BUG_ON(ret);
-				pr_emerg("Disabling liodn %x\n", avs1 >> PAMU_AVS1_LIODN_SHIFT);
+				pr_emerg("Disabling liodn %x\n",
+					 avs1 >> PAMU_AVS1_LIODN_SHIFT);
 			}
 			out_be32((p + PAMU_PICS), pics);
 		}
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index ae21305..38c26be 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -167,7 +167,8 @@ static int update_liodn(int liodn, struct fsl_dma_domain *dma_domain, u32 wnd_nr
 					 (wnd_nr > 0) ? 1 : 0,
 					 wnd->prot);
 		if (ret)
-			pr_debug("Subwindow reconfiguration failed for liodn %d\n", liodn);
+			pr_debug("Subwindow reconfiguration failed for liodn %d\n",
+				 liodn);
 	} else {
 		phys_addr_t wnd_addr;
 
@@ -180,7 +181,8 @@ static int update_liodn(int liodn, struct fsl_dma_domain *dma_domain, u32 wnd_nr
 					 dma_domain->snoop_id, dma_domain->stash_id,
 					 0, wnd->prot);
 		if (ret)
-			pr_debug("Window reconfiguration failed for liodn %d\n", liodn);
+			pr_debug("Window reconfiguration failed for liodn %d\n",
+				 liodn);
 	}
 
 	spin_unlock_irqrestore(&iommu_lock, flags);
@@ -196,7 +198,8 @@ static int update_liodn_stash(int liodn, struct fsl_dma_domain *dma_domain,
 
 	spin_lock_irqsave(&iommu_lock, flags);
 	if (!dma_domain->win_arr) {
-		pr_debug("Windows not configured, stash destination update failed for liodn %d\n", liodn);
+		pr_debug("Windows not configured, stash destination update failed for liodn %d\n",
+			 liodn);
 		spin_unlock_irqrestore(&iommu_lock, flags);
 		return -EINVAL;
 	}
@@ -204,7 +207,8 @@ static int update_liodn_stash(int liodn, struct fsl_dma_domain *dma_domain,
 	for (i = 0; i < dma_domain->win_cnt; i++) {
 		ret = pamu_update_paace_stash(liodn, i, val);
 		if (ret) {
-			pr_debug("Failed to update SPAACE %d field for liodn %d\n ", i, liodn);
+			pr_debug("Failed to update SPAACE %d field for liodn %d\n ",
+				 i, liodn);
 			spin_unlock_irqrestore(&iommu_lock, flags);
 			return ret;
 		}
@@ -245,7 +249,8 @@ static int pamu_set_liodn(int liodn, struct device *dev,
 					 dma_domain->stash_id, win_cnt, 0);
 	spin_unlock_irqrestore(&iommu_lock, flags);
 	if (ret) {
-		pr_debug("PAACE configuration failed for liodn %d, win_cnt =%d\n", liodn, win_cnt);
+		pr_debug("PAACE configuration failed for liodn %d, win_cnt =%d\n",
+			 liodn, win_cnt);
 		return ret;
 	}
 
@@ -262,7 +267,8 @@ static int pamu_set_liodn(int liodn, struct device *dev,
 							 0, 0);
 			spin_unlock_irqrestore(&iommu_lock, flags);
 			if (ret) {
-				pr_debug("SPAACE configuration failed for liodn %d\n", liodn);
+				pr_debug("SPAACE configuration failed for liodn %d\n",
+					 liodn);
 				return ret;
 			}
 		}
-- 
2.2.2
