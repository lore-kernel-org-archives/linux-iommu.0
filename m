From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH 1/2] dt-bindings: pci: Add drop mask property for MSI and IOMMU
Date: Fri,  7 Jul 2017 12:39:58 +0530
Message-ID: <1499411399-25103-2-git-send-email-srinath.mannam@broadcom.com>
References: <1499411399-25103-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499411399-25103-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, Frank Rowand <frowand.list@gmail.com>
Cc: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Srinath Mannam <srinath.mannam@broadcom.com>, Anup Patel <anup.patel@broadcom.com>, Oza Pawandeep <oza.oza@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds info about optional DT properties
iommu-map-drop-mask and msi-map-drop-mask.

A drop mask represents the bits which will be
removed/dropped by system from Requester ID before
mapping it to msi ID or stream ID.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../devicetree/bindings/pci/pci-iommu.txt          | 31 ++++++++++++++++++++
 Documentation/devicetree/bindings/pci/pci-msi.txt  | 33 ++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt b/Documentation/devicetree/bindings/pci/pci-iommu.txt
index 0def586..499cb27 100644
--- a/Documentation/devicetree/bindings/pci/pci-iommu.txt
+++ b/Documentation/devicetree/bindings/pci/pci-iommu.txt
@@ -44,6 +44,9 @@ Optional properties
 - iommu-map-mask: A mask to be applied to each Requester ID prior to being
   mapped to an IOMMU specifier per the iommu-map property.
 
+- iommu-map-drop-mask: A drop mask represents the bits which will be
+  removed/dropped by system from Requester ID before mapping it to
+  stream ID.
 
 Example (1)
 ===========
@@ -169,3 +172,31 @@ Example (4)
 			    <0x8000 &iommu_b 0x0000 0x8000>;
 	};
 };
+
+Example (5)
+===========
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	iommu: iommu@a {
+		reg = <0xa 0x1>;
+		compatible = "vendor,some-iommu";
+		#iommu-cells = <1>;
+	};
+
+	pci: pci@f {
+		reg = <0xf 0x1>;
+		compatible = "vendor,pcie-root-complex";
+		device_type = "pci";
+
+		/*
+		 * The sideband data provided to the IOMMU is a 10bit
+		 * data derived from the RID by dropping 4 MSBs
+		 * of device number and 2 MSBs of function number.
+		 */
+		iommu-map = <0x0 &iommu 0x0 0x1024>;
+		iommu-map-drop-mask = <0xff09>;
+	};
+};
diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt b/Documentation/devicetree/bindings/pci/pci-msi.txt
index 9b3cc81..1de3f39 100644
--- a/Documentation/devicetree/bindings/pci/pci-msi.txt
+++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
@@ -49,6 +49,10 @@ Optional properties
 - msi-map-mask: A mask to be applied to each Requester ID prior to being mapped
   to an msi-specifier per the msi-map property.
 
+- msi-map-drop-mask: A drop mask represents the bits which will be
+  removed/dropped by system from Requester ID before mapping it to
+  msi ID.
+
 - msi-parent: Describes the MSI parent of the root complex itself. Where
   the root complex and MSI controller do not pass sideband data with MSI
   writes, this property may be used to describe the MSI controller(s)
@@ -218,3 +222,32 @@ Example (5)
 			  <0x0000 &msi_b 0x0000 0x10000>;
 	};
 };
+
+Example (6)
+===========
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	msi: msi-controller@a {
+		reg = <0xa 0x1>;
+		compatible = "vendor,some-controller";
+		msi-controller;
+		#msi-cells = <1>;
+	};
+
+	pci: pci@f {
+		reg = <0xf 0x1>;
+		compatible = "vendor,pcie-root-complex";
+		device_type = "pci";
+
+		/*
+		 * The sideband data provided to the  MSI controller is
+		 * a 10bit data derived from the RID by dropping
+		 * 4 MSBs of device number and 2 MSBs of function number.
+		 */
+		msi-map = <0x0 &msi_a 0x0 0x100>,
+		msi-map-drop-mask = <0xff09>
+	};
+};
-- 
2.7.4
