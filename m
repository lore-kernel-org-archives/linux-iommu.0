From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 01/12] iommu: Introduce iommu_capable API function
Date: Fri,  5 Sep 2014 12:52:53 +0200
Message-ID: <1409914384-21191-2-git-send-email-joro@8bytes.org>
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

This function will replace the current iommu_domain_has_cap
function and clean up the interface while at it.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 18 +++++++++++++++---
 include/linux/iommu.h |  7 +++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ac4adb3..1bc882e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -815,6 +815,15 @@ bool iommu_present(struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(iommu_present);
 
+bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
+{
+	if (!bus->iommu_ops || !bus->iommu_ops->capable)
+		return false;
+
+	return bus->iommu_ops->capable(cap);
+}
+EXPORT_SYMBOL_GPL(iommu_capable);
+
 /**
  * iommu_set_fault_handler() - set a fault handler for an iommu domain
  * @domain: iommu domain
@@ -948,10 +957,13 @@ EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 int iommu_domain_has_cap(struct iommu_domain *domain,
 			 unsigned long cap)
 {
-	if (unlikely(domain->ops->domain_has_cap == NULL))
-		return 0;
+	if (domain->ops->domain_has_cap != NULL)
+		return domain->ops->domain_has_cap(domain, cap);
+
+	if (domain->ops->capable != NULL)
+		return domain->ops->capable(cap);
 
-	return domain->ops->domain_has_cap(domain, cap);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_domain_has_cap);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20f9a52..d43146a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -102,6 +102,7 @@ enum iommu_attr {
  * @pgsize_bitmap: bitmap of supported page sizes
  */
 struct iommu_ops {
+	bool (*capable)(enum iommu_cap);
 	int (*domain_init)(struct iommu_domain *domain);
 	void (*domain_destroy)(struct iommu_domain *domain);
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
@@ -142,6 +143,7 @@ struct iommu_ops {
 
 extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern bool iommu_present(struct bus_type *bus);
+extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
 extern struct iommu_group *iommu_group_get_by_id(int id);
 extern void iommu_domain_free(struct iommu_domain *domain);
@@ -250,6 +252,11 @@ static inline bool iommu_present(struct bus_type *bus)
 	return false;
 }
 
+static inline bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
+{
+	return false;
+}
+
 static inline struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 {
 	return NULL;
-- 
1.9.1
