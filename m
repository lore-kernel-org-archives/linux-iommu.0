From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 2/3] dt-bindings: iommu: Add documentation for rockchip iommu
Date: Wed,  1 Oct 2014 18:20:42 +0800
Message-ID: <1412158843-8115-3-git-send-email-djkurtz@chromium.org>
References: <1412158843-8115-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412158843-8115-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, Simon Xue <xxm@rock-chips.com>, Daniel Kurtz <djkurtz@chromium.org>, Grant Grundler <grundler@chromium.org>, =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-rockchip@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Add binding documentation for Rockchip IOMMU.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Simon Xue <xxm@rock-chips.com>
---
 .../devicetree/bindings/iommu/rockchip,iommu.txt   | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
new file mode 100644
index 0000000..810e058
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
@@ -0,0 +1,26 @@
+Rockchip IOMMU
+==============
+
+A Rockchip DRM iommu translates io virtual addresses to physical addresses for
+its master device.  Each slave device is bound to a single master device, and
+shares its clocks, power domain and irq.
+
+Required properties:
+- compatible      : Should be "rockchip,iommu"
+- reg             : Address space for the configuration registers
+- interrupts      : Interrupt specifier for the IOMMU instance
+- interrupt-names : Interrupt name for the IOMMU instance
+- #iommu-cells    : Should be <0>.  This indicates the iommu is a
+                    "single-master" device, and needs no additional information
+                    to associate with its master device.  See:
+                    Documentation/devicetree/bindings/iommu/iommu.txt
+
+Example:
+
+	vopl_mmu: iommu@0xff940300 {
+		compatible = "rockchip,iommu";
+		reg = <0xff940300 0x100>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vopl_mmu";
+		#iommu-cells = <0>;
+	};
-- 
2.1.0.rc2.206.gedb03e5
