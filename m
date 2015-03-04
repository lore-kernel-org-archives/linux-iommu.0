From: Baptiste Reynal <b.reynal@virtualopensystems.com>
Subject: [PATCH v5 3/4] vfio: type1: replace vfio_domains_have_iommu_cache
 with generic function
Date: Wed,  4 Mar 2015 17:07:53 +0100
Message-ID: <1425485274-5709-4-git-send-email-b.reynal@virtualopensystems.com>
References: <1425485274-5709-1-git-send-email-b.reynal@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <1425485274-5709-1-git-send-email-b.reynal@virtualopensystems.com>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: iommu@lists.linux-foundation.org, kvmarm@lists.cs.columbia.edu
Cc: "open list:VFIO DRIVER" <kvm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, alex.williamson@redhat.com, tech@virtualopensystems.com
List-Id: iommu@lists.linux-foundation.org

From: Antonios Motakis <a.motakis@virtualopensystems.com>

Replace the function vfio_domains_have_iommu_cache() with a more generic
function vfio_domains_have_iommu_cap() which allows to check all domains
of an vfio_iommu structure for a given cached capability.

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
Signed-off-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
---
 drivers/vfio/vfio_iommu_type1.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 57d8c37..a5847e8 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -82,6 +82,23 @@ struct vfio_group {
 	struct list_head	next;
 };
 
+static int vfio_domains_have_iommu_cap(struct vfio_iommu *iommu, int cap)
+{
+	struct vfio_domain *domain;
+	int ret = 1;
+
+	mutex_lock(&iommu->lock);
+	list_for_each_entry(domain, &iommu->domain_list, next) {
+		if (!(domain->domain->ops->capable(cap))) {
+			ret = 0;
+			break;
+		}
+	}
+	mutex_unlock(&iommu->lock);
+
+	return ret;
+}
+
 /*
  * This code handles mapping and unmapping of user data buffers
  * into DMA'ble space using the IOMMU
@@ -935,23 +952,6 @@ static void vfio_iommu_type1_release(void *iommu_data)
 	kfree(iommu);
 }
 
-static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
-{
-	struct vfio_domain *domain;
-	int ret = 1;
-
-	mutex_lock(&iommu->lock);
-	list_for_each_entry(domain, &iommu->domain_list, next) {
-		if (!(domain->prot & IOMMU_CACHE)) {
-			ret = 0;
-			break;
-		}
-	}
-	mutex_unlock(&iommu->lock);
-
-	return ret;
-}
-
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -967,7 +967,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		case VFIO_DMA_CC_IOMMU:
 			if (!iommu)
 				return 0;
-			return vfio_domains_have_iommu_cache(iommu);
+			return vfio_domains_have_iommu_cap(iommu,
+						  IOMMU_CAP_CACHE_COHERENCY);
 		default:
 			return 0;
 		}
-- 
2.3.1
