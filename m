From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v8 09/13] iommu/amd: Use is_attach_deferred call-back
Date: Fri, 21 Jul 2017 16:59:07 +0800
Message-ID: <1500627551-12930-10-git-send-email-bhe@redhat.com>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1500627551-12930-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: jroedel-l3A5Bk7waGM@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Implement call-back is_attach_deferred and use it to defer the
domain attach from iommu driver init to device driver init when
iommu is pre-enabled in kdump kernel.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5508f57a3e4f..4ff413b34b51 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -121,6 +121,7 @@ struct iommu_dev_data {
 					     PPR completions */
 	u32 errata;			  /* Bitmap for errata to apply */
 	bool use_vapic;			  /* Enable device to use vapic mode */
+	bool defer_attach;
 
 	struct ratelimit_state rs;	  /* Ratelimit IOPF messages */
 };
@@ -371,12 +372,17 @@ static u16 get_alias(struct device *dev)
 static struct iommu_dev_data *find_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
 	dev_data = search_dev_data(devid);
 
-	if (dev_data == NULL)
+	if (dev_data == NULL) {
 		dev_data = alloc_dev_data(devid);
 
+		if (translation_pre_enabled(iommu))
+			dev_data->defer_attach = true;
+	}
+
 	return dev_data;
 }
 
@@ -2477,11 +2483,18 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
 static struct protection_domain *get_domain(struct device *dev)
 {
 	struct protection_domain *domain;
+	struct iommu_domain *io_domain;
 
 	if (!check_device(dev))
 		return ERR_PTR(-EINVAL);
 
 	domain = get_dev_data(dev)->domain;
+	if (domain == NULL && get_dev_data(dev)->defer_attach) {
+		get_dev_data(dev)->defer_attach = false;
+		io_domain = iommu_get_domain_for_dev(dev);
+		domain = to_pdomain(io_domain);
+		attach_device(dev, domain);
+	}
 	if (!dma_ops_domain(domain))
 		return ERR_PTR(-EBUSY);
 
@@ -3372,6 +3385,13 @@ static void amd_iommu_apply_resv_region(struct device *dev,
 	WARN_ON_ONCE(reserve_iova(&dma_dom->iovad, start, end) == NULL);
 }
 
+static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
+					 struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev->archdata.iommu;
+	return dev_data->defer_attach;
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
@@ -3388,6 +3408,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.get_resv_regions = amd_iommu_get_resv_regions,
 	.put_resv_regions = amd_iommu_put_resv_regions,
 	.apply_resv_region = amd_iommu_apply_resv_region,
+	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 };
 
-- 
2.5.5
