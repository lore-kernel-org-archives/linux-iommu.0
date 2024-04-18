Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62BD165FC0
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449733; cv=none; b=uy6b7Zv7savy1CVriq84iExZHNBLs0N508tBS85CxDPk917et6v6HrdnIsnNZPeuDb16jzL347la1EfeR+PuDyierLBYB59qvw38jiqUEvoS6MWJEYcMYooptJNLTis4hqLnUMwdUeio/iKTicgM8UPY0GTOy1XR4Mv4EKs/dFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449733; c=relaxed/simple;
	bh=y2pVSKogPc8iaWi7QsK7qOvg3yK0ln6WuGNCkruGp3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv6jyiC2lWxpQ/GxUDpSRxDCw0VVu4Es2dpEHIx8x+IsSynIllWxYRWLoBGfufHwdDUlHH1zyetkMHotToERqFC7cJc6fhs2qIqoO1EXJlhhjLuSgt1DWbby/x5xFCmVS0/CFO8rIYB2KkN5dUIeCiTYN494zxmDCUMSW6k5Imc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 6A17C10D1B07; Thu, 18 Apr 2024 16:15:14 +0200 (CEST)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: linux-kernel@vger.kernel.org
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH v4 2/2] arm64: dts: rockchip: Add one VEPU121 to rk3588
Date: Thu, 18 Apr 2024 16:15:06 +0200
Message-ID: <20240418141509.2485053-3-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418141509.2485053-1-linkmauve@linkmauve.fr>
References: <20240418141509.2485053-1-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TRM (version 1.0 page 385) lists five VEPU121 cores, but only four
interrupts are listed (on page 24), and the driver would expose them all
as different video nodes so only one of them is exposed for now.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Formerly-Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 87b83c87bd55..5c6cc4cd81df 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -2488,6 +2488,35 @@ gpio4: gpio@fec50000 {
 		};
 	};
 
+	/*
+	 * Currently only one of the four JPEG encoders is exposed, this
+	 * reduces the optimal throughput by four.
+	 *
+	 * Once the driver is made to expose all four devices as a single video
+	 * node, the rest can be enabled again, see the full patch here:
+	 * https://lore.kernel.org/linux-media/20240327134115.424846-1-linkmauve@linkmauve.fr/T/#m3a6df0ba15e4af40b998b0ff2a02b0dd0d730c8e
+	 */
+
+	jpeg_enc0: video-codec@fdba0000 {
+		compatible = "rockchip,rk3588-vepu121", "rockchip,rk3568-vepu";
+		reg = <0x0 0xfdba0000 0x0 0x800>;
+		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_JPEG_ENCODER0>, <&cru HCLK_JPEG_ENCODER0>;
+		clock-names = "aclk", "hclk";
+		iommus = <&jpeg_enc0_mmu>;
+		power-domains = <&power RK3588_PD_VDPU>;
+	};
+
+	jpeg_enc0_mmu: iommu@fdba0800 {
+		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg = <0x0 0xfdba0800 0x0 0x40>;
+		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_JPEG_ENCODER0>, <&cru HCLK_JPEG_ENCODER0>;
+		clock-names = "aclk", "iface";
+		power-domains = <&power RK3588_PD_VDPU>;
+		#iommu-cells = <0>;
+	};
+
 	av1d: video-codec@fdc70000 {
 		compatible = "rockchip,rk3588-av1-vpu";
 		reg = <0x0 0xfdc70000 0x0 0x800>;
-- 
2.44.0

