From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH v2 04/15] drivers: acpi: iort: add support for IOMMU
	registration
Date: Tue,  7 Jun 2016 14:30:59 +0100
Message-ID: <1465306270-27076-5-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
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
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The ACPI IORT table provide entries for IOMMU (aka SMMU in ARM world)
components that allow creating the kernel data structures required to
probe and initialize the IOMMU devices.

This patch provides support in the IORT kernel code to register IOMMU
components and their respective IOMMU operations, along with a hook
(ie iommu_xlate()) that is used to translate devices ids to ids usable
by the SMMU driver to set-up IOMMU group/domain configuration.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
---
 drivers/acpi/iort.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iort.h |  5 ++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 226eb6d..7cc9880 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -19,10 +19,13 @@
 #define pr_fmt(fmt)	"ACPI: IORT: " fmt
 
 #include <linux/export.h>
+#include <linux/iommu.h>
 #include <linux/iort.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
 
 struct iort_its_msi_chip {
 	struct list_head	list;
@@ -30,6 +33,75 @@ struct iort_its_msi_chip {
 	u32			translation_id;
 };
 
+struct iort_ops_node {
+	struct list_head list;
+	struct acpi_iort_node *node;
+	const struct iommu_ops *ops;
+	int (*iommu_xlate)(struct device *dev, u32 streamid,
+			   struct acpi_iort_node *node);
+};
+static LIST_HEAD(iort_iommu_ops);
+static DEFINE_SPINLOCK(iort_ops_lock);
+
+/**
+ * iort_smmu_set_ops - Create iort_ops_node and use it to register
+ *		       iommu data in the iort_iommu_ops list.
+ *
+ * @node: IORT table node associated with the IOMMU
+ * @ops: IOMMU operations associated with the IORT node
+ * @iommu_xlate: iommu translate function to be used to carry out stream id
+ *		 translation
+ *
+ * Returns: 0 on success
+ *          -ENOMEM on failure
+ */
+int iort_smmu_set_ops(struct acpi_iort_node *node,
+		       const struct iommu_ops *ops,
+		       int (*iommu_xlate)(struct device *dev, u32 streamid,
+					  struct acpi_iort_node *node))
+{
+	struct iort_ops_node *iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
+
+	if (WARN_ON(!iommu))
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&iommu->list);
+	iommu->node = node;
+	iommu->ops = ops;
+	iommu->iommu_xlate = iommu_xlate;
+
+	spin_lock(&iort_ops_lock);
+	list_add_tail(&iommu->list, &iort_iommu_ops);
+	spin_unlock(&iort_ops_lock);
+
+	return 0;
+}
+
+/**
+ * iort_smmu_get_ops_node - Retrieve iort_ops_node associated with an
+ *			    IORT node.
+ *
+ * @node: IORT table node to be looked-up
+ *
+ * Returns: iort_ops_node pointer on success
+ *          NULL on failure
+*/
+const struct iort_ops_node *iort_smmu_get_ops_node(struct acpi_iort_node *node)
+{
+	struct iort_ops_node *curr, *iommu_node = NULL;
+
+	spin_lock(&iort_ops_lock);
+	list_for_each_entry(curr, &iort_iommu_ops, list) {
+		if (curr->node == node) {
+			iommu_node = curr;
+			break;
+		}
+	}
+	spin_unlock(&iort_ops_lock);
+
+	return iommu_node;
+}
+
 typedef acpi_status (*iort_find_node_callback)
 	(struct acpi_iort_node *node, void *context);
 
diff --git a/include/linux/iort.h b/include/linux/iort.h
index 6f2fec3..5053cc3 100644
--- a/include/linux/iort.h
+++ b/include/linux/iort.h
@@ -35,5 +35,10 @@ static inline u32 iort_pci_get_msi_rid(struct pci_dev *pdev, u32 req_id)
 static inline struct irq_domain *
 iort_pci_get_domain(struct pci_dev *pdev, u32 req_id) { return NULL; }
 #endif
+int iort_smmu_set_ops(struct acpi_iort_node *node,
+		      const struct iommu_ops *ops,
+		      int (*iommu_xlate)(struct device *dev,
+					 u32 streamid,
+					 struct acpi_iort_node *node));
 
 #endif /* __IORT_H__ */
-- 
2.6.4
