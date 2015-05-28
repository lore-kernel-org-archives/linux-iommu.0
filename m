From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 13/22] iommu: Introduce iommu_request_dm_for_dev()
Date: Thu, 28 May 2015 18:41:36 +0200
Message-ID: <1432831305-11126-14-git-send-email-joro@8bytes.org>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432831305-11126-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This function can be called by an IOMMU driver to request
that a device's default domain is direct mapped.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  6 ++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 224c6dd..cf6ea95 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1538,3 +1538,55 @@ void iommu_put_dm_regions(struct device *dev, struct list_head *list)
 	if (ops && ops->put_dm_regions)
 		ops->put_dm_regions(dev, list);
 }
+
+/* Request that a device is direct mapped by the IOMMU */
+int iommu_request_dm_for_dev(struct device *dev)
+{
+	struct iommu_domain *dm_domain;
+	struct iommu_group *group;
+	int ret;
+
+	/* Device must already be in a group before calling this function */
+	group = iommu_group_get_for_dev(dev);
+	if (!group)
+		return -EINVAL;
+
+	mutex_lock(&group->mutex);
+
+	/* Check if the default domain is already direct mapped */
+	ret = 0;
+	if (group->default_domain &&
+	    group->default_domain->type == IOMMU_DOMAIN_IDENTITY)
+		goto out;
+
+	/* Don't change mappings of existing devices */
+	ret = -EBUSY;
+	if (iommu_group_device_count(group) != 1)
+		goto out;
+
+	/* Allocate a direct mapped domain */
+	ret = -ENOMEM;
+	dm_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_IDENTITY);
+	if (!dm_domain)
+		goto out;
+
+	/* Attach the device to the domain */
+	ret = __iommu_attach_group(dm_domain, group);
+	if (ret) {
+		iommu_domain_free(dm_domain);
+		goto out;
+	}
+
+	/* Make the direct mapped domain the default for this group */
+	iommu_domain_free(group->default_domain);
+	group->default_domain = dm_domain;
+
+	pr_info("Using direct mapping for device %s\n", dev_name(dev));
+
+	ret = 0;
+out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b944b2b..dc767f7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -225,6 +225,7 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 
 extern void iommu_get_dm_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_dm_regions(struct device *dev, struct list_head *list);
+extern int iommu_request_dm_for_dev(struct device *dev);
 
 extern int iommu_attach_group(struct iommu_domain *domain,
 			      struct iommu_group *group);
@@ -411,6 +412,11 @@ static inline void iommu_put_dm_regions(struct device *dev,
 {
 }
 
+static inline int iommu_request_dm_for_dev(struct device *dev)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_attach_group(struct iommu_domain *domain,
 				     struct iommu_group *group)
 {
-- 
1.9.1
