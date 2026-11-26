Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795722701;
	b=sC632TTJnRd5MHjrXA9B2ndzul8dnXKr5U3wpxLwstg/6Ofqjnt0JZKutwNIrsv6JaVN
	 eeaYiU4hHrby5cGTeouH5tHSIuG4khnmUwEXTteCWg6D7hKzPgw1kMTDZR51OIwoDJd7A
	 YlmSJOBRJa2Pj+VHDc75sKPO9z/exC+BcABXb0d/GjBkbbdiZ0Nyi6lhhS/nbqcbfz3aj
	 TJSylNSR7USqr8/UyV5rXI+tBiwY+dbCN00VJ0Lv4eJ26yekXg308KmpEs67A+QHutT03
	 ePEdJ4LY2lPzM0iDhFtSmv4uAuTA7coWSjcDjfLY7a2HSieWm2VzrguyBm1CfeJURkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722701;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R2eFuVKMuKx/HT5/2aCPbO7MjOp+iQ1ERiIlQILhiRQ=;
	b=jEHi/hM3qo9M+BAHkrKcndgShWUDGMHjSxiEqfl7pULcYsCcwHTlkZC+Ei8Bv3cfM/yn
	 QjTVsqmvXf0TS8tP+GnVPKQbUnn2rbZwsi7FAz/uNlwAKL7c/4gIAc0I0oYNI7Q90rPWq
	 UDTJI9tuea4VyFFAkLUoskfLSIfdlIOsKEJjCqjQaakUUCy+XkneFm6q/e4VJuOEZ43aA
	 FvswaO/pr/A9OrJV85p5oy8P9ZLDP8LBY8uPXTlGpcIisHmlHdY0LDfQ7X52OJSiW2e3W
	 MZYcD4eMlryf4yWHNU/buu0sW0lm0nGwuXkbCU5NDoDMNuV8v5G1cD4we3fZ4j89qcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oe0R7jCk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB728606A339;
	Thu, 26 Nov 2026 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oe0R7jCk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795722700;
	b=zw27A1A5zJTnqU9MKgz/LGAfb/QfVcKOlZbapK45m0pboCZq//ODWOwFWS8x/K2pxaDl
	 0C9i2ZadN1mUeS2tyB++mJ06AzQuf1Lh0RqQ1J3Jgf1/4HbyGn6wMnrJ5JMOv6yVDGWDn
	 0WffJCL18zucZB3ijHtXhPczEIQ4iTfKR28a6k0ebAumWKWxbJmBWRt0E56NuiLnNU4cO
	 582oYzZRaawjwQ6T2rP9NeEnBcPqg9t8Yfv18mk2piXWuKU3ZHNxY9541W1MThuhoW5LP
	 eJuuJ3UB5th7L+N4NSprHYsskAEe+CCexob/MvTMUfcO9ks182ggNVQWI/lrWv5P8Jg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795722700;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R2eFuVKMuKx/HT5/2aCPbO7MjOp+iQ1ERiIlQILhiRQ=;
	b=HKptJJ9rqW8dfG6cA1Yk9PO3k14hJWiaFp+8GkWtHpiTx/DlKivHz7Hkgo/4UCVKMD2/
	 sUZiyONiKSXMKDNNmcoA8Bf62SSoUFRXi2H3W1fMakkbq9OxzNfVfPQTtq0JIx7oj5tsQ
	 lv5oyJV8SY3AtDCCwAiJOWHFKlU45TGHaN2qkZ8Z1KJ3ydTnZjiIs+cg3conCxSWXh7vX
	 QKtLg215gptFeJ+Vs/HtPBBjo5r+CinbjxjIKejNbuavZHi6mpv+9PLCp7MNnkY75Yg7O
	 DjElo5/1yuPu3+0V3Kr13YkHEQ0lUURukjuc9QNOfWJtWokriVuW3IM44Q4Yid20KDg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 52C7B1F000D0;
	Thu, 26 Nov 2026 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795722700;
	bh=R2eFuVKMuKx/HT5/2aCPbO7MjOp+iQ1ERiIlQILhiRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Oe0R7jCk6cOqGTdPFcS95Otvw48XMn4d13CDXz++UA0kDzVUcsqBxGmEdbCOLeNxv
	 Ydslxd/yYUgjG/2ZmadUf3qPqbYENo9ky4Dwx54EqLs8KcuUfr9MQC6X7ckfucCumQ
	 Xs5IX0xFsEF9xzMgnABSBoE4OxwA1/NdPs0EvYVRyILYrCJ56Ds6UAjxbJngAXo6YW
	 QN8uHrSjWlTzAOL3SzIFZCRxHDM6rviajsvagN5xxjzoZmlRQWH156cshTPsxmAONa
	 DPX42HDMLusJhr7gm3JrAaWx9YPpf1FRqHOdzlneX80DWyfbo56U00WAKDsL+cRaNY
	 koME2pr436i2Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D38E14D7D6;
	Thu, 26 Nov 2026 19:51:28 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 19:51:30 +0000
Subject: [PATCH v5 4/4] arm64: dts: rockchip: Add IEP2 deinterlacer to
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
Message-Id: <20261126-iep2-v5-4-3deac0976f10@gmail.com>
References: <20261126-iep2-v5-0-3deac0976f10@gmail.com>
In-Reply-To: <20261126-iep2-v5-0-3deac0976f10@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795722687; l=1631;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=pLFuCmNVRbb5CYDpQgDI0o9UDTdkG7B7CO7SPDGMaZU=;
 b=alHddsvsruCU7g11zR0BvJGXQYO6bpOx0AAe6gWdgS0Sh/ZGoU/3GK0SwCsupSBCow5AyPtDf
 9etk8sa0MR4Cty6Wj3u3qvSj0PN0Ab9w0elVXIDA1KEThQ73jR86FK2
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


