From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v7 01/16] drivers: acpi: add FWNODE_ACPI_STATIC fwnode type
Date: Wed,  9 Nov 2016 14:19:33 +0000
Message-ID: <20161109141948.19244-2-lorenzo.pieralisi@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161109141948.19244-1-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On systems booting with a device tree, every struct device is associated
with a struct device_node, that provides its DT firmware representation.
The device node can be used in generic kernel contexts (eg IRQ
translation, IOMMU streamid mapping), to retrieve the properties
associated with the device and carry out kernel operations accordingly.
Owing to the 1:1 relationship between the device and its device_node,
the device_node can also be used as a look-up token for the device (eg
looking up a device through its device_node), to retrieve the device in
kernel paths where the device_node is available.

On systems booting with ACPI, the same abstraction provided by
the device_node is required to provide look-up functionality.

The struct acpi_device, that represents firmware objects in the
ACPI namespace already includes a struct fwnode_handle of
type FWNODE_ACPI as their member; the same abstraction is missing
though for devices that are instantiated out of static ACPI tables
entries (eg ARM SMMU devices).

Add a new fwnode_handle type to associate devices created out
of static ACPI table entries to the respective firmware components
and create a simple ACPI core layer interface to dynamically allocate
and free the corresponding firmware nodes so that kernel subsystems
can use it to instantiate the nodes and associate them with the
respective devices.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Reviewed-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Tested-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Tested-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
---
 include/linux/acpi.h   | 21 +++++++++++++++++++++
 include/linux/fwnode.h |  3 ++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 689a8b9..6efb13c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -56,6 +56,27 @@ static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 	acpi_fwnode_handle(adev) : NULL)
 #define ACPI_HANDLE(dev)		acpi_device_handle(ACPI_COMPANION(dev))
 
+static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
+{
+	struct fwnode_handle *fwnode;
+
+	fwnode = kzalloc(sizeof(struct fwnode_handle), GFP_KERNEL);
+	if (!fwnode)
+		return NULL;
+
+	fwnode->type = FWNODE_ACPI_STATIC;
+
+	return fwnode;
+}
+
+static inline void acpi_free_fwnode_static(struct fwnode_handle *fwnode)
+{
+	if (WARN_ON(!fwnode || fwnode->type != FWNODE_ACPI_STATIC))
+		return;
+
+	kfree(fwnode);
+}
+
 /**
  * ACPI_DEVICE_CLASS - macro used to describe an ACPI device with
  * the PCI-defined class-code information
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 8516717..8bd28ce 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -17,8 +17,9 @@ enum fwnode_type {
 	FWNODE_OF,
 	FWNODE_ACPI,
 	FWNODE_ACPI_DATA,
+	FWNODE_ACPI_STATIC,
 	FWNODE_PDATA,
-	FWNODE_IRQCHIP,
+	FWNODE_IRQCHIP
 };
 
 struct fwnode_handle {
-- 
2.10.0
