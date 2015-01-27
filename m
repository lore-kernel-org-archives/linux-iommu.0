From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/5] iommu: Allocate a default domain for iommu groups
Date: Tue, 27 Jan 2015 01:08:56 +0100
Message-ID: <1422317339-22620-3-git-send-email-joro@8bytes.org>
References: <1422317339-22620-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422317339-22620-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The default domain will be used (if supported by the iommu
driver) when the devices in the iommu group are not attached
to any other domain.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 34636eb..8f33ddd3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -76,6 +76,9 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
 #define to_iommu_group(_kobj)		\
 	container_of(_kobj, struct iommu_group, kobj)
 
+static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
+						 enum iommu_domain_type type);
+
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
@@ -362,6 +365,17 @@ rename:
 
 	kobject_get(group->devices_kobj);
 
+	/*
+	 * Try to allocate a default domain for the group, if this
+	 * hasn't happened yet. This is not the best place to do that,
+	 * it should happen in iommu_group_alloc(). But we have no
+	 * iommu_ops there yet, so the allocation has to happen here for
+	 * now.
+	 */
+	if (group->default_domain == NULL)
+		group->default_domain = __iommu_domain_alloc(dev->bus,
+							     IOMMU_DOMAIN_DMA);
+
 	dev->iommu_group = group;
 
 	mutex_lock(&group->mutex);
@@ -899,22 +913,28 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
-struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
+static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
+						 enum iommu_domain_type type)
 {
 	struct iommu_domain *domain;
 
 	if (bus == NULL || bus->iommu_ops == NULL)
 		return NULL;
 
-	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
+	domain = bus->iommu_ops->domain_alloc(type);
 	if (!domain)
 		return NULL;
 
 	domain->ops  = bus->iommu_ops;
-	domain->type = IOMMU_DOMAIN_UNMANAGED;
+	domain->type = type;
 
 	return domain;
 }
+
+struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
+{
+	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
+}
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 void iommu_domain_free(struct iommu_domain *domain)
-- 
1.9.1
