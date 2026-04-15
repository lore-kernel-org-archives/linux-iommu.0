Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C939A7E1
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237840; cv=none; b=h/t8pimqdJrEEfhUioCfy4E+AV/H5JP2j8nz0HlAPM56nxhlrRAj/LEP6Thvuh7s0UPRDRLtA6R01avemC4oHiP/OxAudzO+Ay9iTw3HRJLm++KbnuentiFJXAsuYfBX/swJXPC/wohSs1yGqPdRrz9GyBH3GvgPaPFwWBSze30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237840; c=relaxed/simple;
	bh=LlXq/U/YSTcXP/hcTIR6RtPx9lTAqG8OjX6Oh88UwRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgfxbZP9P7QNYCfv8IcbVALV+m9EQbUbjl2xrMq46KeYCz8btzXxO8KLi7XIIF0YkabbA8x5pJcsnWrLfAiNkljiPUaoiNYIUAFLqU7ZrkNa9WDjHECGVL8NGUwcnYscQ2VPjGnSLoX1xGhv/pMcbLtcMFu2WPMSMf0PV0O3Gxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dkZfUA+r; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dkZfUA+r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776237837;
	bh=LlXq/U/YSTcXP/hcTIR6RtPx9lTAqG8OjX6Oh88UwRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dkZfUA+rrV0vvJchW2Ug/pjKYtdUur1ExfZ6l8HTkPzrd1Mdds6FzURhN1kZw0hAw
	 ERI5bmXCVq180PIJ0f1U38hxNADUC3knfP4ayjomqBQFoLqfQj4PFkeymvSDUaxD6C
	 eJkFtCOTR7MKfnlYBOCA90kacP8smrcrEs6Iol2s2tJMYp9Fvav8bufHhr4H1OwMKj
	 j01UJf4ht9zszoLpgohmaN3XLHaSIvoyUIb210vD02MXQZvKdjvDwk3yfo3q49MYUR
	 /gTyxvC92AAz+8CZaoiv5PX80sD6ppJByT1HchdXOmKJEIvVOymlRjjfSBkwb2O0Km
	 6XP37ihSvJmVw==
Received: from benjamin-XPS-13-9310.. (unknown [100.64.1.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DC9F417E1428;
	Wed, 15 Apr 2026 09:23:56 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v14 4/5] arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
Date: Wed, 15 Apr 2026 09:23:40 +0200
Message-ID: <20260415072349.44237-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415072349.44237-1-benjamin.gaignard@collabora.com>
References: <20260415072349.44237-1-benjamin.gaignard@collabora.com>
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
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 7fe9593d8c19..7fde18feeaf8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1428,6 +1428,17 @@ av1d: video-codec@fdc70000 {
 		clock-names = "aclk", "hclk";
 		power-domains = <&power RK3588_PD_AV1>;
 		resets = <&cru SRST_A_AV1>, <&cru SRST_P_AV1>, <&cru SRST_A_AV1_BIU>, <&cru SRST_P_AV1_BIU>;
+		iommus = <&av1d_mmu>;
+	};
+
+	av1d_mmu: iommu@fdca0000 {
+		compatible = "rockchip,rk3588-av1-iommu", "verisilicon,iommu-1.2";
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

