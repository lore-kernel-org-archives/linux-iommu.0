Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628DA2EAB86
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255779; cv=none; b=VDXwDivkz5hwyIxXXwwvv1aR6HtCn0AvaJ7Dj7csoJBiukBVuSeLxC/QsXY/pWWsNoZYvlPlRLGbqKCtdz8h7HXP76oExe7t9L5Z5csDnEqLdR2sTaHs49fdYJW5jZDYr4J0mttBaUhY8BpnDMam01F0M1HR2o5bTFMqfT1bJxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255779; c=relaxed/simple;
	bh=AS5vS0kNr8fbh9RMX5hZfhDJ6mHcu0j9xwH0HYgDEoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WabnHkdEj3hNeaKXJ4fBAXSXf0CET0O3HUidQE+NXSe+7WX6OeKLnUL43ShvVLf6L7L5kOnNuOIL0Ou+r/vX01f3/XQc2lqUQdFoflMpNag2sY6Rbl/wwN+Hm4PEbez1/WP7MLRm2DNG1/y+mXb0kxqV8Wzwx1iqR+RyiDUN9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LFxv+BlO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LFxv+BlO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750255775;
	bh=AS5vS0kNr8fbh9RMX5hZfhDJ6mHcu0j9xwH0HYgDEoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFxv+BlOrkt5Rd9dIfIUUJWO+dclWvPRbhi9/ir0VNNnbxK6ylR5Iomd4xstMh5Bo
	 eKp4P3n6q37RHRXl7R7tyyHAAzorCSTZvtiY+3UvnRVQ2xdcFy5qzd0r+X1JFa6GQQ
	 bGEjAdwk7JiP5BZtTsqngzoU66NRNIXwgHHeLNlcenAGaBGlHiu5I5QuLzkGDLr5PC
	 U/4IF/1Z0YKKrCmoyqENIpKZJ9TDixUFCcYdH2LNkNI9NgUVtBFs1U7EdlosqMHIRT
	 PmsEZZTNHrIhxh8fdhREr/45nYeC3RYc2eU7qqytUBHNwcoL+HY+KmuisyWvW5hkkz
	 yX1AfoOUaWR1w==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:45c6:994a:f902:5c74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 33BEE17E156E;
	Wed, 18 Jun 2025 16:09:35 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 4/5] arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
Date: Wed, 18 Jun 2025 16:09:13 +0200
Message-ID: <20250618140923.97693-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
References: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device tree node for the Verisilicon IOMMU present
in the RK3588 SoC.
This IOMMU handles address translation for the VPU hardware blocks.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
changes in version 2:
- Change compatible to "rockchip,rk3588-av1-iommu"

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 70f03e68ba55..ef20a160f857 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1263,6 +1263,17 @@ av1d: video-codec@fdc70000 {
 		clock-names = "aclk", "hclk";
 		power-domains = <&power RK3588_PD_AV1>;
 		resets = <&cru SRST_A_AV1>, <&cru SRST_P_AV1>, <&cru SRST_A_AV1_BIU>, <&cru SRST_P_AV1_BIU>;
+		iommus = <&av1d_mmu>;
+	};
+
+	av1d_mmu: iommu@fdca0000 {
+		compatible = "rockchip,rk3588-av1-iommu";
+		reg = <0x0 0xfdca0000 0x0 0x600>;
+		interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_AV1>, <&cru PCLK_AV1>;
+		clock-names = "core", "iface";
+		#iommu-cells = <0>;
+		power-domains = <&power RK3588_PD_AV1>;
 	};
 
 	vop: vop@fdd90000 {
-- 
2.43.0

