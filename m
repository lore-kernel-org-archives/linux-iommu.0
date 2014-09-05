From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 07/12] iommu/msm: Convert to iommu_capable() API function
Date: Fri,  5 Sep 2014 12:52:59 +0200
Message-ID: <1409914384-21191-8-git-send-email-joro@8bytes.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/msm_iommu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 49f41d6..6e3dcc28 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -603,10 +603,9 @@ fail:
 	return ret;
 }
 
-static int msm_iommu_domain_has_cap(struct iommu_domain *domain,
-				    unsigned long cap)
+static bool msm_iommu_capable(enum iommu_cap cap)
 {
-	return 0;
+	return false;
 }
 
 static void print_ctx_regs(void __iomem *base, int ctx)
@@ -675,6 +674,7 @@ fail:
 }
 
 static const struct iommu_ops msm_iommu_ops = {
+	.capable = msm_iommu_capable,
 	.domain_init = msm_iommu_domain_init,
 	.domain_destroy = msm_iommu_domain_destroy,
 	.attach_dev = msm_iommu_attach_dev,
@@ -682,7 +682,6 @@ static const struct iommu_ops msm_iommu_ops = {
 	.map = msm_iommu_map,
 	.unmap = msm_iommu_unmap,
 	.iova_to_phys = msm_iommu_iova_to_phys,
-	.domain_has_cap = msm_iommu_domain_has_cap,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
 };
 
-- 
1.9.1
