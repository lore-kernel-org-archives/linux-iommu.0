From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 08/11] drivers: acpi: iort: enhance mapping API
Date: Thu, 14 Apr 2016 18:25:40 +0100
Message-ID: <1460654743-7896-9-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1460654743-7896-1-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
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

The current IORT API works only for mappings that have the GIC ITS
as a sink node and does not allow mapping components other than
PCI root complexes.

This patch enhances the IORT API to allow any mapping permitted by
the IORT specifications, inclusive of IORT translations for named
components.

Based on prior work by Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
---
 drivers/acpi/iort.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/iort.c b/drivers/acpi/iort.c
index 080888a..2b5ce65 100644
--- a/drivers/acpi/iort.c
+++ b/drivers/acpi/iort.c
@@ -182,15 +182,61 @@ iort_scan_node(enum acpi_iort_node_type type,
 	return NULL;
 }
 
+static struct acpi_iort_node *
+iort_find_parent_node(struct acpi_iort_node *node, u8 type)
+{
+	struct acpi_iort_id_mapping *id;
+
+	if (!node || !node->mapping_offset || !node->mapping_count)
+		return NULL;
+
+	id = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
+			  node->mapping_offset);
+
+	if (!id->output_reference) {
+		pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
+		       node, node->type);
+		return NULL;
+	}
+
+	node = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+			    id->output_reference);
+
+	return node->type == type ? node : NULL;
+}
+
 static acpi_status
 iort_find_dev_callback(struct acpi_iort_node *node, void *context)
 {
-	struct acpi_iort_root_complex *pci_rc;
 	struct device *dev = context;
-	struct pci_bus *bus;
 
 	switch (node->type) {
-	case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
+	case ACPI_IORT_NODE_NAMED_COMPONENT: {
+		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+		struct acpi_iort_named_component *ncomp;
+		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
+
+		if (!adev)
+			break;
+
+		ncomp = (struct acpi_iort_named_component *)node->node_data;
+
+		if (ACPI_FAILURE(acpi_get_name(adev->handle,
+					       ACPI_FULL_PATHNAME, &buffer))) {
+			pr_warn("Can't get device full path name\n");
+			break;
+		}
+
+		if (!strcmp(ncomp->device_name, (char *)buffer.pointer))
+			return AE_OK;
+
+		break;
+	}
+
+	case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
+		struct acpi_iort_root_complex *pci_rc;
+		struct pci_bus *bus;
+
 		bus = to_pci_bus(dev);
 		pci_rc = (struct acpi_iort_root_complex *)node->node_data;
 
@@ -204,20 +250,21 @@ iort_find_dev_callback(struct acpi_iort_node *node, void *context)
 
 		break;
 	}
+	}
 
 	return AE_NOT_FOUND;
 }
 
 static struct acpi_iort_node *
 iort_dev_map_rid(struct acpi_iort_node *node, u32 rid_in,
-			    u32 *rid_out)
+			    u32 *rid_out, u8 type)
 {
 
 	if (!node)
 		goto out;
 
 	/* Go upstream */
-	while (node->type != ACPI_IORT_NODE_ITS_GROUP) {
+	while (node->type != type) {
 		struct acpi_iort_id_mapping *id;
 		int i, found = 0;
 
@@ -283,7 +330,7 @@ iort_its_find_node_and_map_rid(struct pci_dev *pdev, u32 req_id, u32 *dev_id)
 		return NULL;
 	}
 
-	return iort_dev_map_rid(node, req_id, dev_id);
+	return iort_dev_map_rid(node, req_id, dev_id, ACPI_IORT_NODE_ITS_GROUP);
 }
 
 /**
-- 
2.6.4
