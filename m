From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v8 1/5] Doc: iommu/arm-smmu-v3: Add workaround for HiSilicon erratum 161010801
Date: Wed, 27 Sep 2017 14:32:37 +0100
Message-ID: <20170927133241.21036-2-shameerali.kolothum.thodi@huawei.com>
References: <20170927133241.21036-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170927133241.21036-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, mark.rutland@arm.com, robh@kernel.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

From: John Garry <john.garry@huawei.com>

The HiSilicon erratum 161010801 describes the limitation of HiSilicon
platforms hip06/hip07 to support the SMMU mappings for MSI transactions.

On these platforms, GICv3 ITS translator is presented with the deviceID
by extending the MSI payload data to 64 bits to include the deviceID.
Hence, the PCIe controller on this platforms has to differentiate the MSI
payload against other DMA payload and has to modify the MSI payload.
This basically makes it difficult for this platforms to have a SMMU
translation for MSI.

This patch adds a compatible string to implement this errata for
HiSilicon Hi161x SMMUv3 model on hip06/hip07 platforms.

Also, the arm64 silicon errata is updated with this same erratum.

Signed-off-by: John Garry <john.garry@huawei.com>
[Shameer: Modified to use compatible string for errata]
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 Documentation/arm64/silicon-errata.txt                  | 1 +
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 66e8ce1..02816b1 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -70,6 +70,7 @@ stable kernels.
 |                |                 |                 |                             |
 | Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101 |
 | Hisilicon      | Hip0{6,7}       | #161010701      | N/A                         |
+| Hisilicon      | Hip0{6,7}       | #161010801      | N/A                         |
 |                |                 |                 |                             |
 | Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index c9abbf3..3b0d599 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -7,11 +7,18 @@ the PCIe specification.
 
 ** SMMUv3 required properties:
 
-- compatible        : Should include:
+- compatible        : Should be one of:
+
+                      "arm,smmu-v3"
+                      "hisilicon,hi161x-smmu-v3"
+
+                      depending on the particular implementation.
 
                       * "arm,smmu-v3" for any SMMUv3 compliant
                         implementation. This entry should be last in the
                         compatible list.
+                      * "hisilicon,hi161x-smmu-v3" for HiSilicon hi161x
+                         SMMUv3 implementation on hip06/hip07 platforms.
 
 - reg               : Base address and size of the SMMU.
 
-- 
1.9.1


