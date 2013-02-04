From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/5] iommu: Add DOMAIN_ATTR_WINDOWS domain attribute
Date: Mon,  4 Feb 2013 14:18:43 +0100
Message-ID: <1359983924-28952-6-git-send-email-joro@8bytes.org>
References: <1359983924-28952-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1359983924-28952-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This attribute can be used to set and get the number of
subwindows on IOMMUs that are window-based.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/iommu.c |   33 ++++++++++++++++++++++++++++++---
 include/linux/iommu.h |    5 +++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0fdb7db..66402f7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -891,6 +891,7 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 	struct iommu_domain_geometry *geometry;
 	bool *paging;
 	int ret = 0;
+	u32 *count;
 
 	switch (attr) {
 	case DOMAIN_ATTR_GEOMETRY:
@@ -902,6 +903,15 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 		paging  = data;
 		*paging = (domain->ops->pgsize_bitmap != 0UL);
 		break;
+	case DOMAIN_ATTR_WINDOWS:
+		count = data;
+
+		if (domain->ops->domain_get_windows != NULL)
+			*count = domain->ops->domain_get_windows(domain);
+		else
+			ret = -ENODEV;
+
+		break;
 	default:
 		if (!domain->ops->domain_get_attr)
 			return -EINVAL;
@@ -916,9 +926,26 @@ EXPORT_SYMBOL_GPL(iommu_domain_get_attr);
 int iommu_domain_set_attr(struct iommu_domain *domain,
 			  enum iommu_attr attr, void *data)
 {
-	if (!domain->ops->domain_set_attr)
-		return -EINVAL;
+	int ret = 0;
+	u32 *count;
+
+	switch (attr) {
+	case DOMAIN_ATTR_WINDOWS:
+		count = data;
+
+		if (domain->ops->domain_set_windows != NULL)
+			ret = domain->ops->domain_set_windows(domain, *count);
+		else
+			ret = -ENODEV;
 
-	return domain->ops->domain_set_attr(domain, attr, data);
+		break;
+	default:
+		if (domain->ops->domain_set_attr == NULL)
+			return -EINVAL;
+
+		ret = domain->ops->domain_set_attr(domain, attr, data);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0cba2d8..8330df1 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -60,6 +60,7 @@ struct iommu_domain {
 enum iommu_attr {
 	DOMAIN_ATTR_GEOMETRY,
 	DOMAIN_ATTR_PAGING,
+	DOMAIN_ATTR_WINDOWS,
 	DOMAIN_ATTR_MAX,
 };
 
@@ -106,6 +107,10 @@ struct iommu_ops {
 	int (*domain_window_enable)(struct iommu_domain *domain, u32 wnd_nr,
 				    phys_addr_t paddr, size_t size);
 	void (*domain_window_disable)(struct iommu_domain *domain, u32 wnd_nr);
+	/* Set the numer of window per domain */
+	int (*domain_set_windows)(struct iommu_domain *domain, u32 w_count);
+	/* Get the numer of window per domain */
+	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
 	unsigned long pgsize_bitmap;
 };
-- 
1.7.9.5
