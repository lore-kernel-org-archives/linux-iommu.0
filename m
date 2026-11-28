Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795854622;
	b=I7essGrDbkBRkBL+95y6qdPPolqf7wTDJLBqexE5hlJVzsmp3HdOLivfD7t9kYOHvp6h
	 w0uvBq2jkRQyIv0Tf1rrbke/ZatMZtD7ttPf0F9Dn/iRMBNXhuSHtAoqDLfR73hhQ7YSd
	 hurKN5FonP44BKJqGqMEO+7SwtCrMh36wiez5yyHQWz+wKsrLLV56mxejEZGxcUrrCMjc
	 gVi99YPF4nK3ItDDgMrOX1EyZ4B61W+XNpKaSIFfN/Vv79JZpJ5CzVXGwbLTL5DXyCoil
	 wn8XGp0L/JwPpJ97Ce+QNpyX/EGUL3Qby6Uyi7iBwBrOAGsdY2ZzNcD+MRSzsC5DIBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795854622;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R2eFuVKMuKx/HT5/2aCPbO7MjOp+iQ1ERiIlQILhiRQ=;
	b=LCZzKlVpZ7IJKg8juLxIOyA0vtXJDVJAujzkOafHym1k+o2ZJKCfLSSyiuMIqgQzNaA/
	 bE9bOcy5bZPhrOWW9Vz8P9lg7CKJPKYRt7ndO2oU0REKH3k8+YXdOn1qKZInt9gUJTK8W
	 Cy1kfpxn8qSbb1ngbZjnrgoFOJFb6zjj9POShlUIqHyYt9HteJCHT1WrFvGQlPo6mQltA
	 ux7xMHmGdaH0WFY0+2Y/sW9rrm62+LmrubsVvUQzeqZIoHWrWg2hl1VHxQyegFDTbvRKz
	 DkpwHM1CY8tEb02QdXFaSBqlWU77XgjdEpm4DLYid4YA+irCSp+FlQjDZ4LeacIhNGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuhvrpyW;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52637606A323;
	Sat, 28 Nov 2026 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuhvrpyW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795854621;
	b=yGD1cac/w6hBae7Dc9oQR0fwLCwlNFcClPTOdfKnV4NGi+KTVMWrz3aQ+f9PfF7JcrCD
	 BkUkzH87erqlWS5+YUARGMsHtYVGWY2jdLDsvzxbeoR8NqxaQAqnag5XuQdkL62Cy29/q
	 s65yK2K83PRJVcrx4pM5Xb2BKsEWdd4IDsIgrg7RflqqoLaWyxxtIE2/lh9bdbWitTAXl
	 pIiOXO1nbRzC1CTXhCd6dkHbqmb+OKpwf6/MwTv5xYK72mstHkEE47GU+aEgJw5qTGL01
	 /uuAn61RngRdcAonosQchczMDbAfpJs3wBlAkRjMzuFE9jx/zccKFywYGi8DYLJ1aHA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795854621;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R2eFuVKMuKx/HT5/2aCPbO7MjOp+iQ1ERiIlQILhiRQ=;
	b=O+tT53Ghj+fTfurnHZXpQ9ZnCj4iLhvvvpcjfFvg/ylc3/a1YvMhFfpSydddAq5HqGLz
	 UcpMUuuTT4ZZPBl3DrC3NUl5yq8MgRiZh+5LgJx7gguX/eQB3o+9GJ0ZaFkXMbK+qLcJN
	 HGel5QyZsoM8bMu4OGvSiG4EXF9cX81+tgZb9h6vKlyOS/Z9jgZarHQCA7cAbKJeVMDJf
	 0EDAaKZowYOrXleJV0gZ3SxgaPLVqQSRCAL71HuSXwhDvR2DI/Anj1g1jOIfiz6LRqVcy
	 +GEwJ8KTcGo6RzWyU7qnxMvi11ldDQHIWvquDd/lZSW4iSvqzxNdZ/Qz2YZoP67toBA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 134D01F0089A;
	Sat, 28 Nov 2026 08:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795854621;
	bh=R2eFuVKMuKx/HT5/2aCPbO7MjOp+iQ1ERiIlQILhiRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SuhvrpyWvW9we7JcIUNK8BjGD2ZyoMuYwY3K5l3dqfVIKncWBCo8EnSbHrsMeMPqG
	 Juou09bfzCJ3eYg7sUoJ49CwyG3+VsgygWgyIMJFV/QWmQGxabCOLaqv10Tj+4lXlA
	 It2xRruoI0O6T8zshWPu5B4J1Z2Cf/dcI6NGfdsJpnMZGviEZU21PNJpnhipoWzbK1
	 4ow9EPE1pKBYVZZTie8Y969x8upxTlH02i94AuogY1ufziiW4xav795wqkhzNTaX1s
	 IfOfvcnvu214OePIzNeMN/Yjo9f7vK61bmILuo/a+aBgYVrsEyWhYC+w0PMjsbqSeX
	 0lOaq7BmXUAPA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9413B4E04A;
	Sat, 28 Nov 2026 08:30:08 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 28 Nov 2026 08:30:10 +0000
Subject: [PATCH v6 4/4] arm64: dts: rockchip: Add IEP2 deinterlacer to
 RK3588
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261128-iep2-v6-4-5f4f10a0dbeb@gmail.com>
References: <20261128-iep2-v6-0-5f4f10a0dbeb@gmail.com>
In-Reply-To: <20261128-iep2-v6-0-5f4f10a0dbeb@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Alex Bee <knaerzche@gmail.com>, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795854607; l=1631;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=pLFuCmNVRbb5CYDpQgDI0o9UDTdkG7B7CO7SPDGMaZU=;
 b=DjEC58q6wp80xCKxtbYHGEqqSMvv8+VI1JCLLwNVjznFZD2Do6rjtj0aFp76OH2ADcxrfQR1W
 4rLY1lGdrqEBgDL7e7+lFt5ZcLJ2Hx4AY6YrN9DFwrnIxbhIjiaINS6
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Add the IEP2 deinterlacer and its IOMMU to the RK3588 base dtsi. Both
share GIC SPI 117 and sit in the VDPU power domain.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index aa69fd3793fd..5297519bd251 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1397,6 +1397,28 @@ vepu121_3_mmu: iommu@fdbac800 {
 		#iommu-cells = <0>;
 	};
 
+	iep: deinterlace@fdbb0000 {
+		compatible = "rockchip,rk3588-iep2", "rockchip,rk3568-iep2";
+		reg = <0x0 0xfdbb0000 0x0 0x500>;
+		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_IEP2P0>, <&cru HCLK_IEP2P0>, <&cru CLK_IEP2P0_CORE>;
+		clock-names = "aclk", "hclk", "sclk";
+		resets = <&cru SRST_A_IEP2P0>, <&cru SRST_H_IEP2P0>, <&cru SRST_IEP2P0_CORE>;
+		reset-names = "axi", "ahb", "core";
+		power-domains = <&power RK3588_PD_VDPU>;
+		iommus = <&iep_mmu>;
+	};
+
+	iep_mmu: iommu@fdbb0800 {
+		compatible = "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg = <0x0 0xfdbb0800 0x0 0x100>;
+		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_IEP2P0>, <&cru HCLK_IEP2P0>;
+		clock-names = "aclk", "iface";
+		power-domains = <&power RK3588_PD_VDPU>;
+		#iommu-cells = <0>;
+	};
+
 	vdec0: video-codec@fdc38000 {
 		compatible = "rockchip,rk3588-vdec";
 		reg = <0x0 0xfdc38000 0x0 0x100>,

-- 
2.55.0


