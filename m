From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 3/7] iommu/of: Check ATS capability in root complex nodes
Date: Wed, 24 May 2017 19:01:39 +0100
Message-ID: <20170524180143.19855-4-jean-philippe.brucker@arm.com>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, okaya@codeaurora.org, sunil.kovvuri@gmail.com, thunder.leizhen@huawei.com, tn@semihalf.com
List-Id: iommu@lists.linux-foundation.org

The PCI root complex node in DT has a property indicating whether it
supports ATS. Store this bit in the IOMMU fwspec when initializing a
device, so it can be accessed later by an IOMMU driver.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/of_iommu.c | 8 ++++++++
 include/linux/iommu.h    | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 9f44ee8ea1bc..3d8168e80634 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -147,6 +147,11 @@ static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
 	return iommu_spec->np == pdev->bus->dev.of_node;
 }
 
+static bool of_pci_rc_supports_ats(struct device_node *rc_node)
+{
+	return of_property_read_bool(rc_node, "ats-supported");
+}
+
 static const struct iommu_ops
 *of_pci_iommu_init(struct pci_dev *pdev, struct device_node *bridge_np)
 {
@@ -175,6 +180,9 @@ static const struct iommu_ops
 
 	ops = of_iommu_xlate(&pdev->dev, &iommu_spec);
 
+	if (!IS_ERR_OR_NULL(ops) && of_pci_rc_supports_ats(bridge_np))
+		pdev->dev.iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_SUPPORTS_ATS;
+
 	of_node_put(iommu_spec.np);
 	return ops;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2cb54adc4a33..206821b9044c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -360,6 +360,7 @@ extern struct iommu_group *generic_device_group(struct device *dev);
  * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @iommu_priv: IOMMU driver private data for this device
+ * @flags: miscellaneous properties for this device
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -367,10 +368,13 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	void			*iommu_priv;
+	u32			flags;
 	unsigned int		num_ids;
 	u32			ids[1];
 };
 
+#define IOMMU_FWSPEC_PCI_RC_SUPPORTS_ATS		(1 << 0)
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
-- 
2.12.1

