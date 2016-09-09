From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 04/14] drivers: acpi: iort: add support for IOMMU fwnode
	registration
Date: Fri,  9 Sep 2016 15:23:33 +0100
Message-ID: <20160909142343.13314-5-lorenzo.pieralisi@arm.com>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160909142343.13314-1-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The ACPI IORT table provide entries for IOMMU (aka SMMU in ARM world)
components that allow creating the kernel data structures required to
probe and initialize the IOMMU devices.

This patch provides support in the IORT kernel code to register IOMMU
components and their respective fwnode.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Reviewed-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
---
 drivers/acpi/arm64/iort.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi_iort.h |  9 +++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 4cbeb707..b89b3d3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -20,7 +20,9 @@
 
 #include <linux/acpi_iort.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
 
 struct iort_its_msi_chip {
 	struct list_head	list;
@@ -28,6 +30,69 @@ struct iort_its_msi_chip {
 	u32			translation_id;
 };
 
+struct iort_fwnode {
+	struct list_head list;
+	struct acpi_iort_node *iort_node;
+	struct fwnode_handle *fwnode;
+};
+static LIST_HEAD(iort_fwnode_list);
+static DEFINE_SPINLOCK(iort_fwnode_lock);
+
+/**
+ * iort_set_fwnode() - Create iort_fwnode and use it to register
+ *		       iommu data in the iort_fwnode_list
+ *
+ * @node: IORT table node associated with the IOMMU
+ * @fwnode: fwnode associated with the IORT node
+ *
+ * Returns: 0 on success
+ *          <0 on failure
+ */
+int iort_set_fwnode(struct acpi_iort_node *iort_node,
+		    struct fwnode_handle *fwnode)
+{
+	struct iort_fwnode *np;
+
+	np = kzalloc(sizeof(struct iort_fwnode), GFP_ATOMIC);
+
+	if (WARN_ON(!np))
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&np->list);
+	np->iort_node = iort_node;
+	np->fwnode = fwnode;
+
+	spin_lock(&iort_fwnode_lock);
+	list_add_tail(&np->list, &iort_fwnode_list);
+	spin_unlock(&iort_fwnode_lock);
+
+	return 0;
+}
+
+/**
+ * iort_get_fwnode() - Retrieve fwnode associated with an IORT node
+ *
+ * @node: IORT table node to be looked-up
+ *
+ * Returns: fwnode_handle pointer on success, NULL on failure
+*/
+struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node)
+{
+	struct iort_fwnode *curr;
+	struct fwnode_handle *fwnode = NULL;
+
+	spin_lock(&iort_fwnode_lock);
+	list_for_each_entry(curr, &iort_fwnode_list, list) {
+		if (curr->iort_node == node) {
+			fwnode = curr->fwnode;
+			break;
+		}
+	}
+	spin_unlock(&iort_fwnode_lock);
+
+	return fwnode;
+}
+
 typedef acpi_status (*iort_find_node_callback)
 	(struct acpi_iort_node *node, void *context);
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index d16fdda..c851646 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -30,6 +30,9 @@ struct fwnode_handle *iort_find_domain_token(int trans_id);
 void acpi_iort_init(void);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
+int iort_set_fwnode(struct acpi_iort_node *iort_node,
+		    struct fwnode_handle *fwnode);
+struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node);
 #else
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
@@ -37,6 +40,12 @@ static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 static inline struct irq_domain *iort_get_device_domain(struct device *dev,
 							u32 req_id)
 { return NULL; }
+static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
+				  struct fwnode_handle *fwnode)
+{ return -ENODEV; }
+static inline
+struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node)
+{ return NULL; }
 #endif
 
 #define IORT_ACPI_DECLARE(name, table_id, fn)		\
-- 
2.10.0
