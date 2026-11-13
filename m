Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794559507;
	b=rODef0VsSjxiznMmc74SBg+VLkDVwAa6X8h0JxuAMjrWUNKfZ3MYVVZ88x5tFFctjfux
	 g6HmrynpDD5IiXhlq7U925EAgqmxsQ1xjmVcR82aCOL6HW49E5k+qy/yz0Vc33/h2XHMc
	 DInAz2cjVVsvnw6RhPyt7/GM5zZu+a9P8ilxfkridbK/QstgArvgjq/KVlAosKYwc1VJv
	 1zZvdwAH1cluexx4hJlgGfQ4WTyHucaWea47S3JUk0CjzeI70gaWuDae0uqeON9ImVEnR
	 cgjqECIuYCG3zmXYqSid/ZBivASwHzTnDzpWvKf6CUfUr8AHc0dAKnp9KUcFgGtrm9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559507;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Lmr+Elr9OpIQ5ZPemcYMeDSVJeWYJTiqTeKhrH7JLDQ=;
	b=eW8KzuLcPdCqK1e+t6XubHDK3O+EfflRhbWaPN6ODs2ukEYYzUpt1WrwR8sTWjJE1wDT
	 UKR5sib84Ggvpie+VpET+IoVsFbCTZiV2ekcz5aM+3PLZmygbXZVcFanx02tlCQ7Yq7FP
	 JQA20419z6ud0ynnZ4aIWiNWEb2rEQ6t08Wow/qEl9YCSXh1T1AA8x7k/PfAjX8hOsK0X
	 f49Y+5SrxxbgX0eNY+Ufmhnu7YEUHgbL6cpzXN1VYTWy1QnMUcyoWWkqy3/M+MxM/4WfR
	 piNe1PdtuNlVBvMKDfrBljLc9OVOd5O5caMOH3xNkCbmAEyU0RlV49rdqOGRCAqgkuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KB6NVbQD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA4A60A6F6B;
	Fri, 13 Nov 2026 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KB6NVbQD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794559507;
	b=IsDWLR8H+UBhI3MHI6qPzGkA7wX80YG+0/mrEmbBa2lRnOZ+TS/+Glb2yjA7JYsz8zJN
	 65RZqnh0OauKw2MKZ/YbFgKzjY+Ew5nziWhsm257Gt3zxD0RcuGNBE5E4YjwnFDDVfrE4
	 ZqI1Vz/SvC6+zK/G2RALwCu7AOkcDVeghbdctnaZmneydwo8hDh0VllruxlWmQ2WxMnqX
	 6sy7fRcuXsTJSDMTwJbfO/s3rdp1XX9S6WmJL7SVyfI3tr5Nl1Ge0We6VC56ZKRoOfa2L
	 YxvfzgOxFK1JUOfcQymAwbGo/XxS8wPTLpafYQbTlUP4rTcBGCBzTDlGEBMf2NUGckQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794559507;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Lmr+Elr9OpIQ5ZPemcYMeDSVJeWYJTiqTeKhrH7JLDQ=;
	b=X6FzvJYqPvShyfh8CihTxuoySd3LQzbIIId7A71Jqq3991lUr60NDBMsNdqgbE7FBbVq
	 wN9RBFEDGRosGR4KUud9miVtk43j4KN4YA5fk5nYD62QitcJQR41Cl0zSEJnWsoOYL1ls
	 QRGMiuB7GgsBV2e15hGPunlniY9IA7QKpjtjwc315FAVKvqNy/PlR+PtkJW6YDKxKc7Hc
	 VCt8dVg/9//VfILf/UiSJQ6B7RbfpCH6Z6e/cB45F04cpmSvSwgDnHEwNvi2O1UODREJ6
	 aQDgOQzi7OyG57gvisUc9uAC3aQpktl0TKpLnaxJzFkWG7+H0X+AN4WEFt4TgICtqxw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 309A01F000CD;
	Fri, 13 Nov 2026 08:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794559507;
	bh=Lmr+Elr9OpIQ5ZPemcYMeDSVJeWYJTiqTeKhrH7JLDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KB6NVbQDL8/GFM1yuFWNnJoYtM9AQ1HmMWgwxyzB88AkhhlNDEfqgZ2Y6LPDoqRiw
	 sdf0s32wKCJ1zxpSmJEteL1HvMdvjK19iYUBOHA1xfhrM7epWQ2ydkQ8syaDAIVhnA
	 l+XsljHH06Xutwa+hmJYnsdSETkrNEGJrUgnJfDH7puDXsMTGiOyoHvGtQhLU7f2SA
	 I2rPT1Iy8dV0FnwaHseBhDGp2ovmKip2lmX5hzjnnSbi3stzSEk5Ms6X8eaaRFKc7b
	 UAUChRMxu4I1U1iY1o9ey79741HzgmmAoAdZFt77GwmBN8ejWgaWo/R0n7HUta+Doa
	 A8qgKFOtRS4HQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ADE5A476D1;
	Fri, 13 Nov 2026 08:45:05 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 08:45:07 +0000
Subject: [PATCH v3 3/3] arm64: dts: rockchip: Add the clock and reset of
 the RK3588 PCIe SMMU
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
Message-Id: <20261113-smmu-v3-pcie-pd-v3-3-39eb4f919529@gmail.com>
References: <20261113-smmu-v3-pcie-pd-v3-0-39eb4f919529@gmail.com>
In-Reply-To: <20261113-smmu-v3-pcie-pd-v3-0-39eb4f919529@gmail.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794559505; l=1300;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=aCMSqAU5WbX0kmyurBhD544RJoO9ROFPyNVyyC5PiCw=;
 b=xbQO8OmwQeLvZibAIEHXHgkcx69pXkcQHoUG3vrRDW/NWEL/vMQIm1fjAqge7Ggi6eBIPdsMG
 +3xn2EdC2PZB1UZGg5so/JiSWEXxmGAVdMFval8/gVhEJqkzV5ftYW1
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

mmu600_pcie is enabled in rk3588-base.dtsi, but its node lacks its
clock, ACLK_MMU_PCIE. On a board without an enabled PCIe controller
(e.g. the Orange Pi 5 with its M.2 slot in SATA mode) nothing holds the
clock, it is gated as unused, and reboot hangs in
arm_smmu_device_shutdown() until the watchdog fires.

Add the clock, so the SMMU driver keeps it running, and the reset,
SRST_A_MMU_PCIE.

Fixes: da92d3dfc871 ("arm64: dts: rockchip: enable the mmu600_pcie IOMMU on the rk3588 SoC")
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index aa69fd3793fd..45c1bb335447 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -559,6 +559,8 @@ mmu600_pcie: iommu@fc900000 {
 			     <GIC_SPI 374 IRQ_TYPE_EDGE_RISING 0>,
 			     <GIC_SPI 367 IRQ_TYPE_EDGE_RISING 0>;
 		interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+		clocks = <&cru ACLK_MMU_PCIE>;
+		resets = <&cru SRST_A_MMU_PCIE>;
 		#iommu-cells = <1>;
 	};
 

-- 
2.55.0


