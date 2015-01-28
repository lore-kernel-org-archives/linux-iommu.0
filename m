From: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Subject: [PATCH 05/26] iommu/fsl: Fix checkpatch type LINE_SPACING
Date: Wed, 28 Jan 2015 08:34:37 -0600
Message-ID: <1422455698-3074-6-git-send-email-Emilian.Medve@Freescale.com>
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

CHECK:LINE_SPACING: Please don't use multiple blank lines
+
+

CHECK:LINE_SPACING: Please don't use multiple blank lines
+
+

CHECK:LINE_SPACING: Please don't use multiple blank lines
+
+

CHECK:LINE_SPACING: Please don't use multiple blank lines
+
+

WARNING:LINE_SPACING: Missing a blank line after declarations
+                       u32 win_cnt = dma_domain->win_cnt > 1 ?  dma_domain->win_cnt : 0;
+                       ret = pamu_set_liodn(liodn[i], dev, dma_domain,

CHECK:LINE_SPACING: Please don't use multiple blank lines
+
+

CHECK:LINE_SPACING: Please don't use multiple blank lines
+
+

Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c        | 4 ----
 drivers/iommu/fsl_pamu_domain.c | 3 +--
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index d3a9fff..df6007c 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -56,7 +56,6 @@ static const struct of_device_id guts_device_ids[] __initconst = {
 	{}
 };
 
-
 /*
  * Table for matching compatible strings, for device tree
  * L3 cache controller node.
@@ -317,7 +316,6 @@ int pamu_disable_spaace(int liodn, u32 subwin)
 	return 0;
 }
 
-
 /**
  * pamu_config_paace() - Sets up PPAACE entry for specified liodn
  *
@@ -433,7 +431,6 @@ int pamu_config_spaace(int liodn, u32 subwin_cnt, u32 subwin,
 {
 	struct paace *paace;
 
-
 	/* setup sub-windows */
 	if (!subwin_cnt) {
 		pr_debug("Invalid subwindow count\n");
@@ -824,7 +821,6 @@ irqreturn_t pamu_av_isr(int irq, void *arg)
 		}
 	}
 
-
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 7ea93ae..dc38db5 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -633,6 +633,7 @@ static int handle_attach_device(struct fsl_dma_domain *dma_domain,
 		 */
 		if (dma_domain->win_arr) {
 			u32 win_cnt = dma_domain->win_cnt > 1 ? dma_domain->win_cnt : 0;
+
 			ret = pamu_set_liodn(liodn[i], dev, dma_domain,
 					      &domain->geometry,
 					      win_cnt);
@@ -822,7 +823,6 @@ static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
 	struct fsl_dma_domain *dma_domain = domain->priv;
 	int ret = 0;
 
-
 	switch (attr_type) {
 	case DOMAIN_ATTR_GEOMETRY:
 		ret = configure_domain_geometry(domain, data);
@@ -848,7 +848,6 @@ static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
 	struct fsl_dma_domain *dma_domain = domain->priv;
 	int ret = 0;
 
-
 	switch (attr_type) {
 	case DOMAIN_ATTR_FSL_PAMU_STASH:
 		memcpy((struct pamu_stash_attribute *) data, &dma_domain->dma_stash,
-- 
2.2.2
