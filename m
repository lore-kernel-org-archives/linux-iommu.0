From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH v3 01/13] drivers: iommu: add FWNODE_IOMMU fwnode type
Date: Wed, 20 Jul 2016 12:23:23 +0100
Message-ID: <1469013815-24380-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1469013815-24380-1-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On systems booting with a device tree, every struct device is
associated with a struct device_node, that represents its DT
representation. The device node can be used in generic kernel
contexts (eg IRQ translation, IOMMU streamid mapping), to
retrieve the properties associated with the device and carry
out kernel operation accordingly. Owing to the 1:1 relationship
between the device and its device_node, the device_node can also
be used as a look-up token for the device (eg looking up a device
through its device_node), to retrieve the device in kernel paths
where the device_node is available.

On systems booting with ACPI, the same abstraction provided by
the device_node is required to provide look-up functionality.

Therefore, mirroring the approach implemented in the IRQ domain
kernel layer, this patch adds an additional fwnode type FWNODE_IOMMU.

This patch also implements a glue kernel layer that allows to
allocate/free FWNODE_IOMMU fwnode_handle structures and associate
them with IOMMU devices.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
---
 include/linux/fwnode.h |  1 +
 include/linux/iommu.h  | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 8516717..6e10050 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -19,6 +19,7 @@ enum fwnode_type {
 	FWNODE_ACPI_DATA,
 	FWNODE_PDATA,
 	FWNODE_IRQCHIP,
+	FWNODE_IOMMU,
 };
 
 struct fwnode_handle {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 664683a..298328a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -38,6 +38,7 @@ struct bus_type;
 struct device;
 struct iommu_domain;
 struct notifier_block;
+struct fwnode_handle;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -540,4 +541,28 @@ static inline void iommu_device_unlink(struct device *dev, struct device *link)
 
 #endif /* CONFIG_IOMMU_API */
 
+/* IOMMU fwnode handling */
+static inline bool is_fwnode_iommu(struct fwnode_handle *fwnode)
+{
+	return fwnode && fwnode->type == FWNODE_IOMMU;
+}
+
+static inline struct fwnode_handle *iommu_alloc_fwnode(void)
+{
+	struct fwnode_handle *fwnode;
+
+	fwnode = kzalloc(sizeof(struct fwnode_handle), GFP_KERNEL);
+	fwnode->type = FWNODE_IOMMU;
+
+	return fwnode;
+}
+
+static inline void iommu_free_fwnode(struct fwnode_handle *fwnode)
+{
+	if (WARN_ON(!is_fwnode_iommu(fwnode)))
+		return;
+
+	kfree(fwnode);
+}
+
 #endif /* __LINUX_IOMMU_H */
-- 
2.6.4
