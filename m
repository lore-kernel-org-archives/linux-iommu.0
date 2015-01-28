From: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Subject: [PATCH 15/26] iommu/fsl: Fix checkpatch type SPACING
Date: Wed, 28 Jan 2015 08:34:47 -0600
Message-ID: <1422455698-3074-16-git-send-email-Emilian.Medve@Freescale.com>
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

CHECK:SPACING: No space is necessary after a cast
+               pamu_reg_base = (unsigned long) pamu_regs + pamu_reg_off;

CHECK:SPACING: No space is necessary after a cast
+               memcpy((struct pamu_stash_attribute *) data, &dma_domain->dma_stash,

Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c        | 2 +-
 drivers/iommu/fsl_pamu_domain.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 6f9c976..18a604a 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -1151,7 +1151,7 @@ static int __init fsl_pamu_probe(struct platform_device *pdev)
 	for (pamu_reg_off = 0, pamu_counter = 0x80000000; pamu_reg_off < size;
 	     pamu_reg_off += PAMU_OFFSET, pamu_counter >>= 1) {
 
-		pamu_reg_base = (unsigned long) pamu_regs + pamu_reg_off;
+		pamu_reg_base = (unsigned long)pamu_regs + pamu_reg_off;
 		setup_one_pamu(pamu_reg_base, pamu_reg_off, ppaact_phys,
 				 spaact_phys, omt_phys);
 		/* Disable PAMU bypass for this PAMU */
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index c9886ff..c7af760 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -845,8 +845,8 @@ static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
 
 	switch (attr_type) {
 	case DOMAIN_ATTR_FSL_PAMU_STASH:
-		memcpy((struct pamu_stash_attribute *) data, &dma_domain->dma_stash,
-				 sizeof(struct pamu_stash_attribute));
+		memcpy(data, &dma_domain->dma_stash,
+		       sizeof(struct pamu_stash_attribute));
 		break;
 	case DOMAIN_ATTR_FSL_PAMU_ENABLE:
 		*(int *)data = dma_domain->enabled;
-- 
2.2.2
