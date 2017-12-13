From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v11 3/3] arm64:dts:hisilicon Disable hisilicon smmu node on hip06/hip07
Date: Wed, 13 Dec 2017 11:58:30 +0000
Message-ID: <20171213115830.61872-4-shameerali.kolothum.thodi@huawei.com>
References: <20171213115830.61872-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171213115830.61872-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, robin.murphy@arm.com, marc.zyngier@arm.com, will.deacon@arm.com
Cc: joro@8bytes.org, john.garry@huawei.com, xuwei5@hisilicon.com, guohanjun@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linuxarm@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

The HiSilicon erratum 161010801 describes the limitation of
HiSilicon platforms hip06/hip07 to support the SMMUv3 mappings
for MSI transactions.

PCIe controller on these platforms has to differentiate the
MSI payload against other DMA payload and has to modify the
MSI  payload. This makes it difficult for these platforms to
have SMMU translation for MSI. In order to workaround this,
ARM SMMUv3 driver requires a quirk to treat the MSI regions
separately. Such a quirk is currently missing for DT based
systems and therefore we need to explicitly disable the
hip06/hip07 smmu entries in dts.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hip06.dtsi | 55 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 24 ++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index a049b64..d0d5933 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -291,6 +291,13 @@
 			#interrupt-cells = <2>;
 			num-pins = <128>;
 		};
+
+		mbigen_pcie0: intc_pcie0 {
+			msi-parent = <&its_dsa 0x40085>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			num-pins = <10>;
+		};
 	};
 
 	mbigen_dsa@c0080000 {
@@ -312,6 +319,30 @@
 		};
 	};
 
+	/** HiSilicon erratum 161010801: This describes the limitation
+	 *  of HiSilicon platforms hip06/hip07 to support the SMMUv3
+	 *  mappings for PCIe MSI transactions.
+	 *  PCIe controller on these platforms has to differentiate the
+	 *  MSI payload against other DMA payload and has to modify the
+	 *  MSI payload. This makes it difficult for these platforms to
+	 *  have a SMMU translation for MSI. In order to workaround this,
+	 *  ARM SMMUv3 driver requires a quirk to treat the MSI regions
+	 *  separately. Such a quirk is currently missing for DT based
+	 *  systems. Hence please make sure that the smmu pcie node on
+	 *  hip06 is disabled as this will break the PCIe functionality
+	 *  when iommu-map entry is used along with the PCIe node.
+	 *  Refer:https://www.spinics.net/lists/arm-kernel/msg602812.html
+	 */
+	smmu0: smmu_pcie {
+		compatible = "arm,smmu-v3";
+		reg = <0x0 0xa0040000 0x0 0x20000>;
+		#iommu-cells = <1>;
+		dma-coherent;
+		smmu-cb-memtype = <0x0 0x1>;
+		hisilicon,broken-prefetch-cmd;
+		status = "disabled";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -676,6 +707,30 @@
 				     <637 1>,<638 1>,<639 1>;
 			status = "disabled";
 		};
+
+		pcie0: pcie@a0090000 {
+			compatible = "hisilicon,hip06-pcie-ecam";
+			reg = <0 0xb0000000 0 0x2000000>,
+			      <0 0xa0090000 0 0x10000>;
+			bus-range = <0  31>;
+			msi-map = <0x0000 &its_dsa 0x0000 0x2000>;
+			msi-map-mask = <0xffff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			ranges = <0x02000000 0 0xb2000000 0x0 0xb2000000 0
+				 0x5ff0000 0x01000000 0 0 0 0xb7ff0000
+				 0 0x10000>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <0x0 0 0 1 &mbigen_pcie0 650 4
+					0x0 0 0 2 &mbigen_pcie0 650 4
+					0x0 0 0 3 &mbigen_pcie0 650 4
+					0x0 0 0 4 &mbigen_pcie0 650 4>;
+			status = "disabled";
+		};
+
 	};
 
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 2c01a21..58fe013 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1083,6 +1083,30 @@
 		};
 	};
 
+	/** HiSilicon erratum 161010801: This describes the limitation
+	 *  of HiSilicon platforms hip06/hip07 to support the SMMUv3
+	 *  mappings for PCIe MSI transactions.
+	 *  PCIe controller on these platforms has to differentiate the
+	 *  MSI payload against other DMA payload and has to modify the
+	 *  MSI payload. This makes it difficult for these platforms to
+	 *  have a SMMU translation for MSI. In order to workaround this,
+	 *  ARM SMMUv3 driver requires a quirk to treat the MSI regions
+	 *  separately. Such a quirk is currently missing for DT based
+	 *  systems. Hence please make sure that the smmu pcie node on
+	 *  hip06 is disabled as this will break the PCIe functionality
+	 *  when iommu-map entry is used along with the PCIe node.
+	 *  Refer:https://www.spinics.net/lists/arm-kernel/msg602812.html
+	 */
+	smmu0: smmu_pcie {
+		compatible = "arm,smmu-v3";
+		reg = <0x0 0xa0040000 0x0 0x20000>;
+		#iommu-cells = <1>;
+		dma-coherent;
+		smmu-cb-memtype = <0x0 0x1>;
+		hisilicon,broken-prefetch-cmd;
+		status = "disabled";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
1.9.1


