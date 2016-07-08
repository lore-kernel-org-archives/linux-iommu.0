From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 05/20] iommu/amd: Implement apply_dm_region call-back
Date: Fri,  8 Jul 2016 13:44:56 +0200
Message-ID: <1467978311-28322-6-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

It is used to reserve the dm-regions in the iova-tree.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 4b8b9ee..5ea5679 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3379,6 +3379,20 @@ static void amd_iommu_put_dm_regions(struct device *dev,
 		kfree(entry);
 }
 
+static void amd_iommu_apply_dm_region(struct device *dev,
+				      struct iommu_domain *domain,
+				      struct iommu_dm_region *region)
+{
+	struct protection_domain *pdomain = to_pdomain(domain);
+	struct dma_ops_domain *dma_dom = pdomain->priv;
+	unsigned long start, end;
+
+	start = IOVA_PFN(region->start);
+	end   = IOVA_PFN(region->start + region->length);
+
+	WARN_ON_ONCE(reserve_iova(&dma_dom->iovad, start, end) == NULL);
+}
+
 static const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -3394,6 +3408,7 @@ static const struct iommu_ops amd_iommu_ops = {
 	.device_group = amd_iommu_device_group,
 	.get_dm_regions = amd_iommu_get_dm_regions,
 	.put_dm_regions = amd_iommu_put_dm_regions,
+	.apply_dm_region = amd_iommu_apply_dm_region,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 };
 
-- 
1.9.1
