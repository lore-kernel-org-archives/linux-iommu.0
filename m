Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41517F384
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200395; cv=none; b=elETjwk8idxMPFOU5qb7chSBK47IqsO0lrmXQYhsizdi9n1ci3aTIc4fla5vJJJUaTyLFaBCIrpGRRN7T98uUFxl3FDL6kh8RwYyqcLqpE0nudgD6GjsHXIIHfwUjVKtFsqmN9bfPDmzpOw+EzCOcYeX8mQfQNjHcRNM/fTFzN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200395; c=relaxed/simple;
	bh=2ksgBeMoDxxU9lmoxZOewpWRGNambwfo3QRSZmh5AUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OHcrmhsx5GpVgcOc0KnF41x9/vRZlxeP7kTJL1lu3CM7LnvX+1ttA5KJN/UbaOIWmdZ7SDt5sPKwannxw7DaE2J8PqJgdY48egvY0dZSc23+cWNPR5X58QuXN70ugFIViceGipKo8QguolYkag6rHd3pZ8TrYuBgT1l1QoCN4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bbdc237f0so2917737e87.0
        for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 06:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200391; x=1718805191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg0+/XjLA9DMNjh74DM615g/08bNgkZOcZb3JbFI57w=;
        b=gZ3FbSU+ejJgtNBuEMOIrQhJSwog+MVHWd9KMeo59MIy9cseaZqx1rJ5dK8+WWkBVd
         x6oTb7Ak+WwDW5mPm89B2jLVwdgUjZKX+T/cEznvq6XPDmiNTT945hBt7NCEYWxuwzk1
         wujPEWafGy3vTgzc40VQ5hiWHsMwfyu3eMO9kG+BiZaag0Hz0s/I7m/RXdw6e2x342Gp
         1gV7yeP7ho5zeOERe127fBgxht5Taxalx2H6+8ST4cmibVlAtBrrT1+1Vtiezt9I2hwz
         Wx6t/61wOoqv8Sy0/jj3HK5guSkMi6AKekCMExRc3sHKBiwMzCxoL9SYwQfidbDSVYLu
         7iIQ==
X-Gm-Message-State: AOJu0YzDskT2zD5C6DoQiZZ2osOswRM8ZR2RazltxuwomX2NvgXiHBdv
	6Sx1nmf8GMitCBkyoye3KuPOPYM5vTBRgZdM2Q0bQihCHsWkbzUM
X-Google-Smtp-Source: AGHT+IFb5KiASexlYfqJGzCdUiz4DDkx8C0TVnq0cahH+zxyS5x49RXEnxhGffyDz+kuMTXlB2fIdQ==
X-Received: by 2002:a05:6512:1391:b0:52c:82c7:bdff with SMTP id 2adb3069b0e04-52c9a3b963bmr1947827e87.13.1718200391086;
        Wed, 12 Jun 2024 06:53:11 -0700 (PDT)
Received: from ramallet.home (cst-prg-45-36.cust.vodafone.cz. [46.135.45.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422871ec9e6sm28201695e9.38.2024.06.12.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:53:10 -0700 (PDT)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 12 Jun 2024 15:52:57 +0200
Subject: [PATCH 4/9] arm64: dts: rockchip: Add nodes for NPU and its MMU to
 rk3588s
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-6-10-rocket-v1-4-060e48eea250@tomeuvizoso.net>
References: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
In-Reply-To: <20240612-6-10-rocket-v1-0-060e48eea250@tomeuvizoso.net>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Tomeu Vizoso <tomeu.vizoso@tomeuvizoso.net>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
X-Mailer: b4 0.13.0

See Chapter 36 "RKNN" from the RK3588 TRM (Part 1).

This is a derivative of NVIDIA's NVDLA, but with its own front-end
processor.

Mostly taken from downstream.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 53 +++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 6ac5ac8b48ab..a5d53578c8f6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -2665,6 +2665,59 @@ gpio4: gpio@fec50000 {
 			#interrupt-cells = <2>;
 		};
 	};
+
+	rknn: npu@fdab0000 {
+		compatible = "rockchip,rk3588-rknn", "rockchip,rknn";
+		reg = <0x0 0xfdab0000 0x0 0x9000>,
+		      <0x0 0xfdac0000 0x0 0x9000>,
+		      <0x0 0xfdad0000 0x0 0x9000>;
+		interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "npu0_irq", "npu1_irq", "npu2_irq";
+		clocks = <&scmi_clk SCMI_CLK_NPU>, <&cru ACLK_NPU0>,
+			 <&cru ACLK_NPU1>, <&cru ACLK_NPU2>,
+			 <&cru HCLK_NPU0>, <&cru HCLK_NPU1>,
+			 <&cru HCLK_NPU2>, <&cru PCLK_NPU_ROOT>;
+		clock-names = "clk_npu",
+			      "aclk0", "aclk1", "aclk2",
+			      "hclk0", "hclk1", "hclk2",
+			      "pclk";
+		assigned-clocks = <&scmi_clk SCMI_CLK_NPU>;
+		assigned-clock-rates = <200000000>;
+		resets = <&cru SRST_A_RKNN0>, <&cru SRST_A_RKNN1>, <&cru SRST_A_RKNN2>,
+			 <&cru SRST_H_RKNN0>, <&cru SRST_H_RKNN1>, <&cru SRST_H_RKNN2>;
+		reset-names = "srst_a0", "srst_a1", "srst_a2",
+			      "srst_h0", "srst_h1", "srst_h2";
+		power-domains = <&power RK3588_PD_NPUTOP>,
+				<&power RK3588_PD_NPU1>,
+				<&power RK3588_PD_NPU2>;
+		power-domain-names = "npu0", "npu1", "npu2";
+		iommus = <&rknn_mmu>;
+		status = "disabled";
+	};
+
+	rknn_mmu: iommu@fdab9000 {
+		compatible = "rockchip,rk3588-iommu";
+		reg = <0x0 0xfdab9000 0x0 0x100>,
+		      <0x0 0xfdaba000 0x0 0x100>,
+		      <0x0 0xfdaca000 0x0 0x100>,
+		      <0x0 0xfdada000 0x0 0x100>;
+		interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "npu0_mmu", "npu1_mmu", "npu2_mmu";
+		clocks = <&cru ACLK_NPU0>, <&cru ACLK_NPU1>, <&cru ACLK_NPU2>,
+			 <&cru HCLK_NPU0>, <&cru HCLK_NPU1>, <&cru HCLK_NPU2>;
+		clock-names = "aclk0", "aclk1", "aclk2",
+			      "iface0", "iface1", "iface2";
+		#iommu-cells = <0>;
+		power-domains = <&power RK3588_PD_NPUTOP>,
+				<&power RK3588_PD_NPU1>,
+				<&power RK3588_PD_NPU2>;
+		power-domain-names = "npu0", "npu1", "npu2";
+		status = "disabled";
+	};
 };
 
 #include "rk3588s-pinctrl.dtsi"

-- 
2.45.2

