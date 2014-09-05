From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 05/12] iommu/fsl: Convert to iommu_capable() API function
Date: Fri,  5 Sep 2014 12:52:57 +0200
Message-ID: <1409914384-21191-6-git-send-email-joro@8bytes.org>
References: <1409914384-21191-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409914384-21191-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/fsl_pamu_domain.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 61d1daf..f43a80d 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -411,8 +411,7 @@ static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
 	return get_phys_addr(dma_domain, iova);
 }
 
-static int fsl_pamu_domain_has_cap(struct iommu_domain *domain,
-				      unsigned long cap)
+static bool fsl_pamu_capable(enum iommu_cap cap)
 {
 	return cap == IOMMU_CAP_CACHE_COHERENCY;
 }
@@ -1074,6 +1073,7 @@ static u32 fsl_pamu_get_windows(struct iommu_domain *domain)
 }
 
 static const struct iommu_ops fsl_pamu_ops = {
+	.capable	= fsl_pamu_capable,
 	.domain_init	= fsl_pamu_domain_init,
 	.domain_destroy = fsl_pamu_domain_destroy,
 	.attach_dev	= fsl_pamu_attach_device,
@@ -1083,7 +1083,6 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.domain_get_windows = fsl_pamu_get_windows,
 	.domain_set_windows = fsl_pamu_set_windows,
 	.iova_to_phys	= fsl_pamu_iova_to_phys,
-	.domain_has_cap = fsl_pamu_domain_has_cap,
 	.domain_set_attr = fsl_pamu_set_domain_attr,
 	.domain_get_attr = fsl_pamu_get_domain_attr,
 	.add_device	= fsl_pamu_add_device,
-- 
1.9.1
