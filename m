Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0827EC80
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051228; cv=none; b=u34hkIUUt7WkkBeJy5aObt7Vz8H26Ok8LVD7bXULyfZbCa2WJaOjRG96AvKXZIm6lMrJL5CfqL7JwLhExYl5N8d+jXoecLawp9TA1Ziux8TmXBSdS/MHjDEXySp9eqpRmZyXCjZaASBu/+lMPbCLsWt97QDBXPewWqTNT0Pkv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051228; c=relaxed/simple;
	bh=q5GwU4MYKLNZYOjfJdedkBXBEIKaRbZFbJqlrk3qFCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hr19RcYWG7khxurqEYwHFm++5drgWgaXh6fRubgCwcVkywRNdQf2dTP6kojisXk6DE4GHHBjNNLLbR3p7DeVnOtzyutjgAnbjHNoBqy8euGQi9z8lo8KH3OqF9fH3SEi5Xl0eqYlD0W835xrb6YEBYlnojBEar8kC8TNfudB3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FSxNeRsp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FSxNeRsp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752051225;
	bh=q5GwU4MYKLNZYOjfJdedkBXBEIKaRbZFbJqlrk3qFCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FSxNeRspTT0qu5iHuPV6H/ICPvoYKyoxPGPEjowy1s6uIjtjOrE2kJN4w82M68dMC
	 1TNZUVSMi3mRQpj2JJLSm0v5S0jPoHpvxEX4YzgicTO1aYOZQXTiqQFUYuBVGwm0Rt
	 oq6yMllyZILlNjhVQeA0t1dGuWBFOPUjgntvo0BN/FDDc4DHQNLKly4q+yUpd9qejI
	 WtRK7iTxg9VfervLj9o7Vzu0WiLkX6eahbwFgBH7r+W1vxmweTN86/wGBAWQ+kWKbP
	 s/MZLCY9cWxSC1YpsmWdX0yCAtKbuuCmPkmliA6n4AXhpVEa1lch+MDqVP47D6uNug
	 bEeD5A/yHgQgA==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:8d6b:4a4d:ad13:46c1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AC8D917E1045;
	Wed,  9 Jul 2025 10:53:44 +0200 (CEST)
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
Subject: [PATCH v5 4/5] arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
Date: Wed,  9 Jul 2025 10:53:29 +0200
Message-ID: <20250709085337.53697-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
References: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
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

