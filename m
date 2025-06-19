Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2C2472AF
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338763; cv=none; b=ORS8ZUSEFK/hJERrc1xN+j/xAC9hp4QiauQ5r7NnoYN95xh8VZDuv3mdHF13FvJu+uQMNIr1a8sZSNUIWCrBPFL2Ujzu/pe5PqAyVu3tn1wIKdpkYp2hoOsAbI9ZJdVeLUxd13la3765I8UehKGDL2Y4tJyxs4PVqmOg8QR7/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338763; c=relaxed/simple;
	bh=+NY3GCsxRLO2Jbz8nrVqCE9qh9gb1hvQsPE9AeSJ0ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/vrmiy05yDwVbH/TgnYEaupXrYO8aM7Qsxd1r/BEAG/z1ZY5rRoqmNxdH7bGodjTxr04p7godgHW8ye/QlTB7uMF1MClrGR+yKN6pDj1shN6TsOyg70IEU7IH9DGAZ82omK5NCBxbg6a1+Ss1ykEjlJNsoRbaZUPpCwjdy25UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UY61/scz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UY61/scz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750338759;
	bh=+NY3GCsxRLO2Jbz8nrVqCE9qh9gb1hvQsPE9AeSJ0ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UY61/sczAvge80wz748vFwuQ6OzGS4j1WdYhZxZhrLD6MyfKDIwoTGaa5Ssv48URQ
	 dsgAwzFx3Qr0dw99tTzk9z6X33RzsWhVVX5LVcend8D5X1Y63anVx/E4EDTHW/HBeD
	 S2ve/LhEsvDxbJkmsUIvZc37PjGthdguGB6gKETGH0TN0ZdtqraNXdJXFucmhVoTpj
	 EKINlxqgj8mXSsKHBq1rURqXaeXIxH8fblM3dGjsbORBagmhg+/A721dPnbhJkJi/k
	 baUOLy26i4BqfzZpbdi6NtvTCy/lB6yd/GV3SVeGROvuvpv3Aix9zvwxrzog7kZDJi
	 IomGV8QPR5fNQ==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:ba4e:a6e2:6d63:7f02])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6774717E0CE6;
	Thu, 19 Jun 2025 15:12:39 +0200 (CEST)
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
Subject: [PATCH v3 4/5] arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
Date: Thu, 19 Jun 2025 15:12:25 +0200
Message-ID: <20250619131232.69208-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
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
changes in version 3:
- Update DT to use "rockchip,rk3588-iommu-1.2" compatible

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 70f03e68ba55..ab97f06eea74 100644
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
+		compatible = "verisilicon,iommu","rockchip,rk3588-iommu-1.2";
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

