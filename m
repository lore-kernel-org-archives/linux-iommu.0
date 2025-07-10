Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6128CF40
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135901; cv=none; b=FjZGQCviGbX8BnuqTxtbyxbsx/s3JmLrsp6TD8eD5IIgkbiJwC4r/hQI/0Ww+k6vYu3JtUzk8gUwDzWxwjfdwRcH/1/yDhUHZZZoWsQ++U52lUbUIhFRb94+M0R0w8P9J8C774gXnpyuLE2PVj18dd4giuNhdpRNnJRh41Q70nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135901; c=relaxed/simple;
	bh=q5GwU4MYKLNZYOjfJdedkBXBEIKaRbZFbJqlrk3qFCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh+vZ4OlpWlNGydjh/Hl8wh3wTXK2lH1B4b0E06VXSY7aMIbVkMjdO/tSuY1qm6Wbxf3bIE0+bNPB/HSncpc4cy7Lz4vqLJdmN924C8ZsVPaFMxAjwOfj4RfAfhG0xo6oEQXCQRTXzJrdO2JNmhonhXttm6+cs35xJHVuxEMXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A/igRqiv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A/igRqiv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752135897;
	bh=q5GwU4MYKLNZYOjfJdedkBXBEIKaRbZFbJqlrk3qFCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/igRqivVdN502VAKRZUmCNutGLkb+hn+6OKfh1r9LPQdsnCMeey22v4Uo3CDzSQJ
	 k0VD6ZYtnOvEL3zLqYPYz81PLzgEgPYtwO+haKYPBlOVaZdfk1tdR9c1C1sjMxLxH9
	 eMPfBhNviBRs0h8x3xTC6HK49zM/4LVM/mgKQkmVx8tl/P0YVJxJBmeV6VThhcrnRu
	 0ul/DenKBDLfNTPvmt+O7FVgqDyc4TP4LaMjAz59tyiVSqEKs6TGT+Cz679n2BDzEB
	 6kSCnZqI1l2V+Wq5w9kgwAcfTfO2TLPQBKV2iLIonFBK3Lex8LOUpIgSx4TkigfR8e
	 uzxek0IAKNxag==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:9f5a:8ea0:8d89:78d4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4BEF017E1090;
	Thu, 10 Jul 2025 10:24:57 +0200 (CEST)
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
Subject: [PATCH v6 4/5] arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
Date: Thu, 10 Jul 2025 10:24:45 +0200
Message-ID: <20250710082450.125585-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
References: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
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

