From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [RFC PATCH 3/6] ACPI: IORT: Add stall and pasid properties to iommu_fwspec
Date: Thu, 31 Aug 2017 16:20:39 +0800
Message-ID: <1504167642-14922-4-git-send-email-xieyisheng1@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jean-philippe.brucker@arm.com
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, robin.murphy@arm.com, robert.moore@intel.com, lv.zheng@intel.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org, liubo95@huawei.com, chenjiankang1@huawei.com, xieyisheng@huawei.com
List-Id: iommu@lists.linux-foundation.org

According to ACPI IORT spec, named component specific data has a node
flags field whoes bit0 is for Stall support. However, it do not have any
field for pasid bit.

As PCIe SMMU support 20 pasid bits, this patch suggest to use 5 bits[5:1]
in node flags field for pasid bits which means we can have 32 pasid bits.
And this should be enough for platform device. Anyway, this is just a RFC.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/acpi/arm64/iort.c | 20 ++++++++++++++++++++
 include/acpi/actbl2.h     |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 4d9ccdd0..514caca3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -710,6 +710,22 @@ static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
 	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
 }
 
+static bool iort_platform_support_stall(struct acpi_iort_node *node)
+{
+	struct acpi_iort_named_component *ncomp;
+
+	ncomp = (struct acpi_iort_named_component *)node->node_data;
+	return ncomp->node_flags & ACPI_IORT_STALL_SUPPORTED;
+}
+
+static unsigned long iort_platform_get_pasid_bits(struct acpi_iort_node *node)
+{
+	struct acpi_iort_named_component *ncomp;
+
+	ncomp = (struct acpi_iort_named_component *)node->node_data;
+	return (ncomp->node_flags & ACPI_IORT_PASID_BITS_MASK) >> ACPI_IORT_PASID_BITS_SHIFT;
+}
+
 /**
  * iort_iommu_configure - Set-up IOMMU configuration for a device.
  *
@@ -772,6 +788,10 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 							   IORT_IOMMU_TYPE,
 							   i++);
 		}
+		if (!IS_ERR_OR_NULL(ops)) {
+			dev->iommu_fwspec->can_stall = iort_platform_support_stall(node);
+			dev->iommu_fwspec->num_pasid_bits = iort_platform_get_pasid_bits(node);
+		}
 	}
 
 	/*
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 707dda74..125b150 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -749,6 +749,11 @@ struct acpi_iort_named_component {
 	char device_name[1];	/* Path of namespace object */
 };
 
+#define ACPI_IORT_STALL_SUPPORTED	0x00000001	/* The platform device supports stall */
+#define ACPI_IORT_STALL_UNSUPPORTED	0x00000000	/* The platform device doesn't support stall */
+#define ACPI_IORT_PASID_BITS_MASK	0x0000003e	/* 5 bits for PASID BITS */
+#define ACPI_IORT_PASID_BITS_SHIFT	1		/* PASID BITS numbers shift */
+
 struct acpi_iort_root_complex {
 	u64 memory_properties;	/* Memory access properties */
 	u32 ats_attribute;
-- 
1.7.12.4
