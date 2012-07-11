From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/7] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Wed, 11 Jul 2012 12:49:18 +0200
Message-ID: <1342003763-8139-3-git-send-email-joerg.roedel@amd.com>
References: <1342003763-8139-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1342003763-8139-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Implement the attribute itself and add the code for the
AMD IOMMU driver.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |    4 ++++
 drivers/iommu/iommu.c     |   19 ++++++++++++++++---
 include/linux/iommu.h     |    8 ++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a2e418c..259a6be 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3069,6 +3069,10 @@ static int amd_iommu_domain_init(struct iommu_domain *dom)
 
 	dom->priv = domain;
 
+	dom->geometry.aperture_start = 0;
+	dom->geometry.aperture_end   = ~0ULL;
+	dom->geometry.force_aperture = true;
+
 	return 0;
 
 out_free:
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c39972d..ed5e0a5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -348,10 +348,23 @@ EXPORT_SYMBOL_GPL(iommu_device_group);
 int iommu_domain_get_attr(struct iommu_domain *domain,
 			  enum iommu_attr attr, void *data)
 {
-	if (!domain->ops->domain_get_attr)
-		return -EINVAL;
+	struct iommu_domain_geometry *geometry;
+	int ret = 0;
+
+	switch (attr) {
+	case DOMAIN_ATTR_GEOMETRY:
+		geometry  = data;
+		*geometry = domain->geometry;
+
+		break;
+	default:
+		if (!domain->ops->domain_get_attr)
+			return -EINVAL;
 
-	return domain->ops->domain_get_attr(domain, attr, data);
+		ret = domain->ops->domain_get_attr(domain, attr, data);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_domain_get_attr);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0eef096..f7df4aa 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -37,11 +37,18 @@ struct iommu_domain;
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 
+struct iommu_domain_geometry {
+	dma_addr_t aperture_start; /* First address that can be mapped    */
+	dma_addr_t aperture_end;   /* Last address that can be mapped     */
+	bool force_aperture;       /* DMA only allowed in mappable range? */
+};
+
 struct iommu_domain {
 	struct iommu_ops *ops;
 	void *priv;
 	iommu_fault_handler_t handler;
 	void *handler_token;
+	struct iommu_domain_geometry geometry;
 };
 
 #define IOMMU_CAP_CACHE_COHERENCY	0x1
@@ -49,6 +56,7 @@ struct iommu_domain {
 
 enum iommu_attr {
 	DOMAIN_ATTR_MAX,
+	DOMAIN_ATTR_GEOMETRY,
 };
 
 #ifdef CONFIG_IOMMU_API
-- 
1.7.9.5
