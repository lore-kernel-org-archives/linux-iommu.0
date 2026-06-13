Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB6394EB7
	for <iommu@lists.linux.dev>; Sat, 13 Jun 2026 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333926; cv=none; b=ksihfxcgQxUEUh2Fb1wtv6RyfO6JD6yMlj1pWdl+u+DfLlZldNaEBAw/RplH5L5Q8Qp2HFi2S9yyGewRga5A4ff0UoIBE2ISY6qJCAxBFlZsxm8DNR/YGjtwaQNe1//u61Gr2Y9fyJ5BvhCysYqkEM1ofQwZlnzazZf+/udvrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333926; c=relaxed/simple;
	bh=zamBZHvXT+SrkZYZqomb0TPLxTZiVMFSO+6rV6o1c+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RHh15gKsKQqKEcgL5fKuPmHN/ybOLpx0S9lCqvzjaK8+ig1hzGXCKX4VBnJLrpDLMkHSP0odOGNu3ER6i+5/RBDHf1BBpRnykSfk6/eAluDoj64gwAWowmCf4qTjUYU3LlxpCd6B4SFP0DokR6x39JCwL9ykiqZO4XR5AP/bXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f730b84M; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f730b84M"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490ac357c55so15186955e9.1
        for <iommu@lists.linux.dev>; Fri, 12 Jun 2026 23:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333921; x=1781938721; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExjVQvO4/iWqbTjsUJjExpq/Pad0yGuPxgZEv8g/Xlo=;
        b=f730b84MzWxwmlU57a2sNhaAhELO73A+oGmT/yalnIacbGk+KyYVohDf3AfpOBAlA/
         7yYtLK6GHR7BTXxLzQ6X8QfnFZE2s4zVkNgeUPdySRaGKMEEDnhqmOBdvt9yZxW/gIFz
         fM16W2pVJxOXXoTrx6wWDC8c0EyrgKhwZu1rBZBSKCOt34EEp1gfBkfzdP9X+q1CLktB
         KEh/nzucCKKQFgsSTd1g0QcXW4Qn1P+WLLuSquVsj5P3Ra08uzDS8E/rrWO1h5ix0izh
         tQOFEcPndtOGoggZFCcIlx1SyE3YqEZsPEgfbroCD3gnMhzI2oAleeyZDYYoJMBACE3b
         c+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333921; x=1781938721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ExjVQvO4/iWqbTjsUJjExpq/Pad0yGuPxgZEv8g/Xlo=;
        b=bAFZ3pLOLehG1cug3H3jBpSWUFQpaw1fVRQEO0qWMXhVT5LeHidTm/6wXCsoucjhdo
         jkegHLJCuN2bK6gQA6QCepz1CFBdR3IKv9mWEz2W5bGOghjG5cO5j1ur3ePnTywgR88c
         ZjpM5zgz/M1Em9CdneljyxUu42ArkA86qfVtUR7j0s86cH79psGsG3+1nVlBl9/v7Hwo
         eSAgdawTGfTLhq8oeuccN0TrqTFJjukeXF1tDKVj4zujxq5IQgyHl7sHh0MXVCpQ3aEB
         kdCTFBRcifhlVD00o32I9t7k2wLD6UFehvui1ygnTzC2PnSigrveiDiTvaEShD+tXNPN
         aOBw==
X-Forwarded-Encrypted: i=1; AFNElJ8RfeBbb4jy4mDffzi5pTIh24is/8+1eDc3C4DwbZ4N9zSShC2P2QwLJfy13SBXrefV6VHnbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHEpql5k00gFoXNaWnwS0NAMed2UIvYlIHI8ph6kK7qQdZReZk
	CmO0c2891G2TMHtQ862T/TOcPQUxNZLd3UFEyAeW+GcsE0nKmMsfV4iy
X-Gm-Gg: Acq92OHfXKI2USGmfsI9YGe079NCLA5fcmoGyboVjEHgoJWOoFYln6062gA8W3TTGty
	CCXWb7SERsWfSRl5uEGi9rKqdSxX/tgxFjW/FrzmxOQaHpOPxJfKTynISVi4dr8fHKw0jhnpH8R
	RbwPJf0B/IDAu/9mQUx0b9lnAYEGNw10JNrRAty3K23tEJrCTjdhJFOI8mKiYxbXBI2OiZWGMmu
	hZsG030NFbUM3zVBrBb72+Bw6emwzmoSxqW8/KsJ5IcoRGgzn0Z8Ke6KFI/Sl2beeFPtI3Rl3WN
	7IKbzGCwJ0dCaZNJ73bTfjxfv4V4w9I4lrMTSHZJuLbaffxqu81BTwYM+1o6pjfrWBpAtp1bpDs
	0dsGp+MhYpZTBXp5DtFsrqHAeTXMm11Y2mz0+3ELZGYXoItpcHO9k4HBB6vzmNF6pnEcaKAweD9
	FGo2Id8WwVzT5oLU7YxOyDaOpHL4IM+KB8fKXg/1kf4g==
X-Received: by 2002:a05:600c:a47:b0:490:52c0:744c with SMTP id 5b1f17b1804b1-490ec4ee63cmr73748795e9.20.1781333920798;
        Fri, 12 Jun 2026 23:58:40 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:40 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 7/9] arm64: dts: rockchip: rk356x: Add the NPU and its IOMMU
Date: Sat, 13 Jun 2026 09:01:14 +0200
Message-Id: <20260613070116.438906-8-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

The RK3568 has an NVDLA-derived NPU at fde40000 with its own IOMMU at
fde4b000. Add both nodes (disabled by default) and the NPU power-domain
child under the PMU power-controller, and point rockchip,pmu at the PMU
syscon that controls the NPU NoC bus-idle.

Besides the SCMI compute clock, assign the CRU CLK_NPU so the NPU AXI
bus clock comes up at 200 MHz rather than the 12 MHz boot default.

The power-domain deliberately carries no pm_qos: qos_npu sits behind the
NPU NoC, which is gated until the NPU is brought up, so a genpd power-off
QoS save would fault reading it.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 64bdd8b7754b5..313db59c1aed8 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -512,6 +512,13 @@ power-domain@RK3568_PD_GPU {
 				#power-domain-cells = <0>;
 			};
 
+			pd_npu: power-domain@RK3568_PD_NPU {
+				reg = <RK3568_PD_NPU>;
+				clocks = <&cru ACLK_NPU_PRE>,
+					 <&cru HCLK_NPU_PRE>;
+				#power-domain-cells = <0>;
+			};
+
 			/* These power domains are grouped by VD_LOGIC */
 			power-domain@RK3568_PD_VI {
 				reg = <RK3568_PD_VI>;
@@ -572,6 +579,37 @@ power-domain@RK3568_PD_RKVENC {
 		};
 	};
 
+	rknn_core_0: npu@fde40000 {
+		compatible = "rockchip,rk3568-rknn-core";
+		reg = <0x0 0xfde40000 0x0 0x1000>,
+		      <0x0 0xfde41000 0x0 0x1000>,
+		      <0x0 0xfde43000 0x0 0x1000>;
+		reg-names = "pc", "cna", "core";
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_NPU>, <&cru HCLK_NPU>,
+			 <&scmi_clk SCMI_CLK_NPU>, <&cru PCLK_NPU_PRE>;
+		clock-names = "aclk", "hclk", "npu", "pclk";
+		assigned-clocks = <&scmi_clk SCMI_CLK_NPU>, <&cru CLK_NPU>;
+		assigned-clock-rates = <200000000>, <600000000>;
+		resets = <&cru SRST_A_NPU>, <&cru SRST_H_NPU>;
+		reset-names = "srst_a", "srst_h";
+		power-domains = <&power RK3568_PD_NPU>;
+		rockchip,pmu = <&pmu>;
+		iommus = <&rknn_mmu_0>;
+		status = "disabled";
+	};
+
+	rknn_mmu_0: iommu@fde4b000 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xfde4b000 0x0 0x40>;
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "aclk", "iface";
+		clocks = <&cru ACLK_NPU>, <&cru HCLK_NPU>;
+		power-domains = <&power RK3568_PD_NPU>;
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	gpu: gpu@fde60000 {
 		compatible = "rockchip,rk3568-mali", "arm,mali-bifrost";
 		reg = <0x0 0xfde60000 0x0 0x4000>;
-- 
2.39.5

