From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/2] iommu: Tidy up window attributes
Date: Wed, 19 Sep 2018 11:12:57 +0100
Message-ID: <96e8371cc3143a58c7a142d9ff1134ba7331dd0a.1537351779.git.robin.murphy@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The external interface to get/set window attributes is already
abstracted behind iommu_domain_{get,set}_attr(), so there's no real
reason for the internal interface to be different. Since we only have
one window-based driver anyway, clean up the core code by just moving
the DOMAIN_ATTR_WINDOWS handling directly into the PAMU driver.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Just a cleanup opportunity I spotted whilst poking around in the area.

 drivers/iommu/fsl_pamu_domain.c | 20 ++++++++++++++++++++
 drivers/iommu/iommu.c           | 20 --------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index f089136e9c3f..f83965ee3095 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -818,6 +818,7 @@ static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr_type, void *data)
 {
 	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
+	u32 *count;
 	int ret = 0;
 
 	switch (attr_type) {
@@ -829,6 +830,15 @@ static int fsl_pamu_set_domain_attr(struct iommu_domain *domain,
 		break;
 	case DOMAIN_ATTR_FSL_PAMU_ENABLE:
 		ret = configure_domain_dma_state(dma_domain, *(int *)data);
+		break;
+	case DOMAIN_ATTR_WINDOWS:
+		count = data;
+
+		if (domain->ops->domain_set_windows != NULL)
+			ret = domain->ops->domain_set_windows(domain, *count);
+		else
+			ret = -ENODEV;
+
 		break;
 	default:
 		pr_debug("Unsupported attribute type\n");
@@ -843,6 +853,7 @@ static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr_type, void *data)
 {
 	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
+	u32 *count;
 	int ret = 0;
 
 	switch (attr_type) {
@@ -855,6 +866,15 @@ static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
 		break;
 	case DOMAIN_ATTR_FSL_PAMUV1:
 		*(int *)data = DOMAIN_ATTR_FSL_PAMUV1;
+		break;
+	case DOMAIN_ATTR_WINDOWS:
+		count = data;
+
+		if (domain->ops->domain_get_windows != NULL)
+			*count = domain->ops->domain_get_windows(domain);
+		else
+			ret = -ENODEV;
+
 		break;
 	default:
 		pr_debug("Unsupported attribute type\n");
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c15c5980299..2faec6aa73c4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1796,7 +1796,6 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 	struct iommu_domain_geometry *geometry;
 	bool *paging;
 	int ret = 0;
-	u32 *count;
 
 	switch (attr) {
 	case DOMAIN_ATTR_GEOMETRY:
@@ -1807,15 +1806,6 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 	case DOMAIN_ATTR_PAGING:
 		paging  = data;
 		*paging = (domain->pgsize_bitmap != 0UL);
-		break;
-	case DOMAIN_ATTR_WINDOWS:
-		count = data;
-
-		if (domain->ops->domain_get_windows != NULL)
-			*count = domain->ops->domain_get_windows(domain);
-		else
-			ret = -ENODEV;
-
 		break;
 	default:
 		if (!domain->ops->domain_get_attr)
@@ -1832,18 +1822,8 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
 			  enum iommu_attr attr, void *data)
 {
 	int ret = 0;
-	u32 *count;
 
 	switch (attr) {
-	case DOMAIN_ATTR_WINDOWS:
-		count = data;
-
-		if (domain->ops->domain_set_windows != NULL)
-			ret = domain->ops->domain_set_windows(domain, *count);
-		else
-			ret = -ENODEV;
-
-		break;
 	default:
 		if (domain->ops->domain_set_attr == NULL)
 			return -EINVAL;
-- 
2.19.0.dirty
