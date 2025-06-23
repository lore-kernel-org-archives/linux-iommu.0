Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232B28D8ED
	for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693183; cv=none; b=PEF0NTuwbsuJXmmFDqh7nlRZTYPXPLDg1icrgpgSQ5f0FL2sM/2GAEYJUzAel7gLBVs2oWzIpZ48A4IQMUL7SfwOsxV8JMPGLdBIZRI3KIQQIcWCbCItpSfca3tvu0TlVnHtKrKvUO0GxGz5xgliJON3lQiio9Zw5QqYhCx1C7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693183; c=relaxed/simple;
	bh=q5GwU4MYKLNZYOjfJdedkBXBEIKaRbZFbJqlrk3qFCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sT3/iy9158fePEcUbNwhYD5X/2yd1Wqll/S827H0a23/aeHkhmvO5L/jk1D5KxLwD0ZXPHJHo9fpBWCt9+AhvQXMZFhFzUG0VOBrr8pgSblS5XF3LDKvLjEzoouGXfhK8roGBhNj/+ZgJXYzt4I2FmUdknTByqg3z85gUE3WEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IxW8/NIY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IxW8/NIY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750693179;
	bh=q5GwU4MYKLNZYOjfJdedkBXBEIKaRbZFbJqlrk3qFCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IxW8/NIY5TEA59sBGtiU39Is73MhHKxo5AfnXWIwD2KjpoAXDVICoZHHzJEKvRczN
	 bwCD7CbglmiU0xXxVPJ9mFfnLL6tcMV31Z2IjD6DlLuu1K7/ghk0CG7S+eAFop3l3H
	 Q19AeoN1RtZManJR2cnOUBYh79pgQS78ZIZv5aSdsZNqOre+hzFKVBaqcwxjwGevYy
	 UMBnHhKNyE15Bvv2UiFnWJjAmVOnO0kCPiTsBdLj9wJ6PdcgeVYvD8vz5JvEW3vd4y
	 fugHUi42xLd7GQL4Lt+KZl3/nv/Yvs/RdYMz9lmr91h78+UoK+yg3/RnhyuOuJNwl6
	 J5llSyQmP98mQ==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:d44b:b63b:15ee:9c1d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 00C6B17E1580;
	Mon, 23 Jun 2025 17:39:38 +0200 (CEST)
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
Subject: [PATCH v4 4/5] arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
Date: Mon, 23 Jun 2025 17:39:28 +0200
Message-ID: <20250623153931.158765-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623153931.158765-1-benjamin.gaignard@collabora.com>
References: <20250623153931.158765-1-benjamin.gaignard@collabora.com>
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

