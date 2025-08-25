Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0822FF656
	for <iommu@lists.linux.dev>; Mon, 25 Aug 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136104; cv=none; b=XzrYEV/um50o8Dyr+eeV7RV2WyfRIZWgc69JbU+xO4nrxgWS/C1NdRyXxZX7Kg0w+hYStnJlIItw+9SKjNy2y0rx4hosMemHqe81LTZZ64cKPJ5Jmpi0sVXWggsd8SLGPF6lDrjuE+kx1f1PO8seks3M6jYGVlEOJC/qsxwquA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136104; c=relaxed/simple;
	bh=q5GwU4MYKLNZYOjfJdedkBXBEIKaRbZFbJqlrk3qFCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPw3DDZuFoi6TDvJWZEfgjkHKUe1QYhniOgLfdu6YksZSmJhFfhuxvlDXw1LFgp4lCCrS/j7oIdvziUhSwHCQGfgCdYZbl0+zuZHWKgwdEdPmqOQjX9KLBiGF1k1aKxrHtDg+2E6AudQM0MQK6/8iUrFCfKUGdmXlV36kPevwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pJXK99r8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pJXK99r8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756136099;
	bh=q5GwU4MYKLNZYOjfJdedkBXBEIKaRbZFbJqlrk3qFCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJXK99r8q7qfgWHLV5nCqYBArceAS8ycljzwYSVpiBAeVF9kQV8nFXeI70r4aVXXy
	 6+vepSn7R4VV5a2aBpIzFN1mitzokM8Nv1Kq4rONz3oLocTc8G8vhoEcZZ8HWxOVQe
	 +5cGJJsypITs6qCNsf4b7HdrYj7BbwdBAG9EEQkPPchc4mImcwpXbpCrVFdb/tIfCu
	 7y6jsPwK5KxWZ59+H8xrh0ghrnzoWaNgQutWOtrhkwpvevRpybSmwBPMysGDLM/D/S
	 dVTEUreMGQezN5eoQm8O8cdaAq7+wCjfWCpb1kYA0N/17ueoD2cKzcljlQ5lQbT0uK
	 mWyQm0Mwp0vNQ==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:f39:d9a9:8ef1:f69a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EC8C817E0985;
	Mon, 25 Aug 2025 17:34:58 +0200 (CEST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	jgg@ziepe.ca,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	linux-media@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 5/6] arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
Date: Mon, 25 Aug 2025 17:34:44 +0200
Message-ID: <20250825153450.150071-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
References: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
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
index 70f03e68ba55..8656e46ad288 100644
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

