From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Subject: [PATCH v2 1/2] acpica: iort: Update SMMUv3 header for proximity domain mapping
Date: Tue,  6 Jun 2017 16:17:44 +0530
Message-ID: <1496746065-11082-2-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1496746065-11082-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1496746065-11082-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Will.Deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com, lv.zheng@intel.com, joro@8bytes.org, rjw@rjwysocki.net, lenb@kernel.org, jnair@caviumnetworks.com, gpkulkarni@gmail.com
List-Id: iommu@lists.linux-foundation.org

ARM IORT specification (rev. C) has added two new fields to define
proximity domain for the SMMUv3 node in the IORT table.

Proximity Domain Valid:
	Set to 1 if the value provided in the Proximity Domain field is
	valid. Set to 0 otherwise.

Proximity domain:
	If the Proximity Domain Valid flag is set to 1, this entry
	provides the proximity domain to which this SMMU
	instance belongs.

Update header file to reflect this.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 include/acpi/actbl2.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 4b306a6..c16ced8 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -805,6 +805,9 @@ struct acpi_iort_smmu_v3 {
 	u32 pri_gsiv;
 	u32 gerr_gsiv;
 	u32 sync_gsiv;
+	u8 pxm;
+	u8 reserved1;
+	u16 reserved2;
 };
 
 /* Values for Model field above */
@@ -817,6 +820,7 @@ struct acpi_iort_smmu_v3 {
 
 #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
 #define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (1<<1)
+#define ACPI_IORT_SMMU_V3_PXM_VALID         (1<<3)
 
 /*******************************************************************************
  *
-- 
1.8.1.4

