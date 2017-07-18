From: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 3/4] ARM64: dts: rockchip: rk3368 add iommu nodes
Date: Tue, 18 Jul 2017 18:02:04 +0800
Message-ID: <1500372125-114261-3-git-send-email-xxm@rock-chips.com>
References: <1500372125-114261-1-git-send-email-xxm@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1500372125-114261-1-git-send-email-xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Simon <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Add IEP/ISP/VOP/HEVC/VPU iommu nodes

Signed-off-by: Simon <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 6d5dc05..ed9a56c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -724,6 +724,54 @@
 		status = "disabled";
 	};
 
+	iep_mmu: iommu@ff900800 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff900800 0x0 0x100>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "iep_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	isp_mmu: iommu@ff914000 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff914000 0x0 0x100>,
+		      <0x0 0xff915000 0x0 0x100>;
+		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "isp_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vop_mmu: iommu@ff930300 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff930300 0x0 0x100>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vop_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	hevc_mmu: iommu@ff9a0440 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff9a0440 0x0 0x40>,
+		      <0x0 0xff9a0480 0x0 0x40>;
+		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "hevc_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vpu_mmu: iommu@ff9a0800 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff9a0800 0x0 0x100>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vepu_mmu", "vdpu_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@ffb71000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
1.9.1
