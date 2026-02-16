Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955212F3C10
	for <iommu@lists.linux.dev>; Mon, 16 Feb 2026 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771235516; cv=none; b=MRMv7hlf6gjJqnlNbjOngWruWk1tFWRORylNPkE+vFsfmy0GAihm0abw4PjL7I0yiD7nmY7/aU9yR1NWZhdTnQXkGCTNjkAQ5Jk+C4zh2y8jwF1RIJxZN50ntYmdrWgTfwPPX7yfTEg1/3fJjeS9rEP0K/REypwP8FcZ1lr4rOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771235516; c=relaxed/simple;
	bh=/nY2b2RK5AxXHbnU7nMRbsf2en656j2woA6QCojM2Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAT0fHVjZlOvRrjlPGbNSuVkUBGiPAzojXrWpUTYsSqHQKzcOCesjlTkRMP2mpDXsEGdI2QicNg97wXM1f2/wdbaNVSr2cTmfevwCF9FpYxuDzAiHMM+JqlaUO3ATTiAZft0wr7GSQNsx/Vs6EeTKuWiGbqrVyUF4/g+Mwt5Xpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TnsXBftm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TnsXBftm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771235513;
	bh=/nY2b2RK5AxXHbnU7nMRbsf2en656j2woA6QCojM2Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnsXBftmluUHFErdWgtrxNbqUTkOz92tpuV5NF0NA35Mp0XHu/bqmhh7hhmOnSFlg
	 bUamH0lyYTqORNPtpkGOU1CDCXYR7UXpFmfhaki2G7Kcxv2KqZzSLXmjqSMaHfVHCj
	 xfkpwJARD4Q3K8RmatOIrD7PA2kq+SJU8HrVZBtJag68NVBbG2x67WbCxUFDN21wYo
	 A/rTq+4TW1MslaBR2gtPeW+ixm9FpzElSHhc7zqh+UH5qvfypYBm8EwK6kbYyglwjj
	 LEdBdefTnMpkEUT5e+gJBOayYSa0sJHRPj7LRfyMXGv2syrV7AZt2R4mmXsfJCzDL1
	 y7cVgFSPQLfAA==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f6d2:8ed9:560e:4f27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9075917E35C4;
	Mon, 16 Feb 2026 10:51:52 +0100 (CET)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-media@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v13 5/6] arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
Date: Mon, 16 Feb 2026 10:51:37 +0100
Message-ID: <20260216095144.107356-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216095144.107356-1-benjamin.gaignard@collabora.com>
References: <20260216095144.107356-1-benjamin.gaignard@collabora.com>
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
index 7ab12d1054a7..7cde7326c6c4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1364,6 +1364,17 @@ av1d: video-codec@fdc70000 {
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

