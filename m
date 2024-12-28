Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94558158520
	for <iommu@lists.linux.dev>; Sat, 28 Dec 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735388566; cv=none; b=fXVMfN+SgSLg8Iewb0lanMiCFj5Wr9GQRcW61jdr9Jlo5hYSSMpOE+e+BOvabCckqngFDOSpKZe4irMDgUxzyE3OVVw7+nbTHpNshhRTo84VKF/9VRhN5be5f2c4Fl0qV47RpyekctVsr9qJp6Y4K6qkOI7OtoldOdmNO8gCrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735388566; c=relaxed/simple;
	bh=petIqcJlxd8iSmQvvgYtdeeRpq68TUj90UxIHs7udJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvO/fX5ID+HMAshFojI28/pTLLqqzpNG6o9k4ZCdqjO4ZfHlU4QflfdLaGGlt4HWoeTgP+5ZelfHhx1ofT6mPEzZcgsY7dslnxgFMvVHxjxdRi9qgOAYpQc7A8qYc5A+JWznJnFXDbvbLC8Wf0t6YZkldvSKJ6t40gF/pKtI+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WtK6hEZG; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WtK6hEZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=bhOPV
	k7Vqm2NJKMlmrYXdJYomM5xUIUvFVc3xFQAy60=; b=WtK6hEZGPNPUa1cDv++4K
	YhvVzr0WIfR2a9UbzogKbhS0CorgWXWc8AZD3m4gcUJYZvkjUb7qW1l+cY9Iv28r
	73gH9ToxTDxjAg6O/tMj+efdDYOLZ7G70jQpR00rTJ5RXGM1GlLjZBHKBLnklDZa
	Us2bXlj+Tn9HYT60153eU0=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3t0tl7W9nUxdCCQ--.1009S9;
	Sat, 28 Dec 2024 20:22:09 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de,
	krzk+dt@kernel.org,
	joro@8bytes.org
Cc: cl@rock-chips.com,
	robh@kernel.org,
	hjc@rock-chips.com,
	vkoul@kernel.org,
	devicetree@vger.kernel.org,
	detlev.casanova@collabora.com,
	cristian.ciocaltea@collabora.com,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 7/8] arm64: dts: rockchip: Add hdmi for rk3576
Date: Sat, 28 Dec 2024 20:21:50 +0800
Message-ID: <20241228122155.646957-8-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228122155.646957-1-andyshrk@163.com>
References: <20241228122155.646957-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t0tl7W9nUxdCCQ--.1009S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFW3uFWUJFWUKr43CFy8Krg_yoW5Wr4rp3
	ZrCrWrXr4kWF12qasIkr1kJrZ5J395CFs5Kr1xAFyUtryagryakFWxXrn2yasFqr4UXanr
	tFsrCry8KFs2qw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jgCztUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqArDXmdv62k-WwAAsR

From: Andy Yan <andy.yan@rock-chips.com>

Add hdmi and it's phy dt node for rk3576.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 130d11a2cc89..b83f421dc11d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -450,6 +450,11 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
+		hdptxphy_grf: syscon@26032000 {
+			compatible = "rockchip,rk3576-hdptxphy-grf", "syscon";
+			reg = <0x0 0x26032000 0x0 0x100>;
+		};
+
 		sys_grf: syscon@2600a000 {
 			compatible = "rockchip,rk3576-sys-grf", "syscon";
 			reg = <0x0 0x2600a000 0x0 0x2000>;
@@ -894,6 +899,46 @@ vop_mmu: iommu@27d07e00 {
 			status = "disabled";
 		};
 
+		hdmi: hdmi@27da0000 {
+			compatible = "rockchip,rk3576-dw-hdmi-qp";
+			reg = <0x0 0x27da0000 0x0 0x20000>;
+			clocks = <&cru PCLK_HDMITX0>,
+				 <&cru CLK_HDMITX0_EARC>,
+				 <&cru CLK_HDMITX0_REF>,
+				 <&cru MCLK_SAI6_8CH>,
+				 <&cru CLK_HDMITXHDP>,
+				 <&cru HCLK_VO0_ROOT>;
+			clock-names = "pclk", "earc", "ref", "aud", "hdp", "hclk_vo1";
+			interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "avp", "cec", "earc", "main", "hpd";
+			phys = <&hdptxphy>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&hdmi_txm0_pins &hdmi_tx_scl &hdmi_tx_sda>;
+			power-domains = <&power RK3576_PD_VO0>;
+			resets = <&cru SRST_HDMITX0_REF>, <&cru SRST_HDMITXHDP>;
+			reset-names = "ref", "hdp";
+			rockchip,grf = <&ioc_grf>;
+			rockchip,vo-grf = <&vo0_grf>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				hdmi_in: port@0 {
+					reg = <0>;
+				};
+
+				hdmi_out: port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
 		qos_hdcp1: qos@27f02000 {
 			compatible = "rockchip,rk3576-qos", "syscon";
 			reg = <0x0 0x27f02000 0x0 0x20>;
@@ -1655,6 +1700,19 @@ uart11: serial@2afd0000 {
 			status = "disabled";
 		};
 
+		hdptxphy: hdmiphy@2b000000 {
+			compatible = "rockchip,rk3576-hdptx-phy", "rockchip,rk3588-hdptx-phy";
+			reg = <0x0 0x2b000000 0x0 0x2000>;
+			clocks = <&cru CLK_PHY_REF_SRC>, <&cru PCLK_HDPTX_APB>;
+			clock-names = "ref", "apb";
+			resets = <&cru SRST_P_HDPTX_APB>, <&cru SRST_HDPTX_INIT>,
+				 <&cru SRST_HDPTX_CMN>, <&cru SRST_HDPTX_LANE>;
+			reset-names = "apb", "init", "cmn", "lane";
+			rockchip,grf = <&hdptxphy_grf>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		sram: sram@3ff88000 {
 			compatible = "mmio-sram";
 			reg = <0x0 0x3ff88000 0x0 0x78000>;
-- 
2.34.1

