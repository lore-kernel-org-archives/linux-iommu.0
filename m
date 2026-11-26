Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795686882;
	b=LAKbjO6GZjD1ie2+h6wJy4yXMGwE9NHsJQO1WQ9tnnV717UJrBde2k1Q7Y2FHWqeAbC9
	 TmOoyWwD2X4iKiMOqu4D9X882mreg4qHu7iTgzsEKXOQn+oiUrTRsPs4ju+X9EHUtIaCb
	 JdM3Zwx0VHFuqVSHwYqbPB/fKAztse9W51Anp35+uecTGi4HzZT8HKqWphTwdcfolOblN
	 RqLQuMFnay3HXZ5ORteEUAzBVz+GVTpQm8GY9xpDU1vtu1Q4EwEi7z2gEyW4SFS/rUI6S
	 /LRhyHQ1a3VjpBwHPa6NK6Bz54jMxFrBVcjW3LHNPX2DPCIdW9V3jGgS5V6gvTfRjlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686882;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ko8str36Y12VEA9xT5kCWL6hEqZTLIJjFfZDzsoUQ7s=;
	b=sPZXg3JvCPzyiaTs1+nxTjXFzzMUI+U3kan3yXCcDjWcdD4eA6tsOocOH6IjRUPDmfwL
	 U+HV2NeJl5okdF5Da+6I6mxNnh+Tg5/cmwO9Y/CUy9vyo0z/VSw2H51ucKS8W1SMCdhgE
	 F31Vrcag5WMgpBHTY9KXcGWzhWWvyiqw4IdHx66ndWmAAYTdShPZ8pRPUQ3UfynDUMMzv
	 ZmYFDB0q8PeJjotXJVMVL4qZciCU6Qe0F+YVSjsiGVgs2ShOQIPrcU/cLecnxizx0kTPF
	 TG8ho0k0HoYRpiRmVXVtLaFtrfKnnYvRYPBXvFEym090geX7PILWskp/VZmr7BO8ZwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbOBTvQW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B07606A33A;
	Thu, 26 Nov 2026 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbOBTvQW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795686881;
	b=3VOMeTQCd7ahVRJ3Cg5ponkHBX7NiraYHOirTe0u3lw1JSN0UHE37z3O8VjGVqwVT35a
	 W4BkNL44tqvLqdErarDQht/Yhe+0zTxPbYuqrn0GfryT3ejnTBbPwA8U+DeVIKy4nXWP9
	 xJ2yiGlU6VVoOfL0hWGtYyGPU2BjpzVxhhXdB9WPYgegqvmoKirnk7rop7euAEZjymwZO
	 b2ZolR09L+BSTcXPgeFbncXYCHaEJDBt4mgmYj24t6eaXmntgdAdh7pcjeT0IKTU8+utx
	 LJV2X0/BTJAFEJD+TT6HWJMKby8ZEPFgs0tVBhJGnYGsn0lkoayh0DLtyhVGFlZ6OSQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795686881;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ko8str36Y12VEA9xT5kCWL6hEqZTLIJjFfZDzsoUQ7s=;
	b=x/Xvcrr9e/K4fm3rB9RDeryh72kyxzKIGls87qoIDPIdoBOoPnKQcd52a8Yfj0pnmXgr
	 IFqgJVbWTujMVXodSdFaYBqc8WfE52A8sD+hW5QM9hgfqJJeb4tPLEZyqZ5hjmjDFK2lU
	 0gtayx99o+W2ecuQoIVxTuUiN4rqxdWZn8ZPXgLHkfGsNTp25bs4M8E30Rw9jA9XjObPw
	 yaVyueXW1Em3Z5I9vUnhLu/UBj/xdj1KZb8eJ+mLb4N9Nfhij0C6TvYkQyg6DN6yh7vMe
	 QjReZAdM37RyKsBj+0n6HlpzMNHVpSnwflKGheU4KBjak3lguNxYDvH/dFxK+lf0BPw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0E6C01F000D4;
	Thu, 26 Nov 2026 09:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795686881;
	bh=ko8str36Y12VEA9xT5kCWL6hEqZTLIJjFfZDzsoUQ7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FbOBTvQW4ITzQfMoKly2H5M9RzgdY7IVIKN55v8vSm3P7n23XPUbXlgyPwQtyodeA
	 otM7MSwSW3CDnZvsWWOSj4eKuvktVfAkZGstlvN8srDaBtu6ZWVOrkfN6ZbPTg1/iw
	 l8seurWXmoDUzWsaNa6i0ZrSf3Cjyggp3BylVzLDVxa17+aZ3MW6PwnMD8ps/0idRE
	 GOIM9ivPtMTv7hKXztYrbuXKhgvanlcQb1U3nHd9WVlpjcn/nSTTZdJsY1oSb5zsvC
	 BWY6j+kR5mq8F4BhTd4qQWdlTtUKhOuWyXjG4IouDsmSbgiMrqTUrLq4fFgkA7d9jj
	 3XmKp0NDJlJdQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9182D4D3D9;
	Thu, 26 Nov 2026 09:54:13 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:54:15 +0000
Subject: [PATCH v4 3/3] arm64: dts: rockchip: Add the clock and reset of
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
Message-Id: <20261126-smmu-v3-pcie-pd-v4-3-c340c2dbd1d2@gmail.com>
References: <20261126-smmu-v3-pcie-pd-v4-0-c340c2dbd1d2@gmail.com>
In-Reply-To: <20261126-smmu-v3-pcie-pd-v4-0-c340c2dbd1d2@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795686852; l=1037;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=t/g+pNBiRoD0rdFZrx0NxcKY5w4/gVZZrK4FzRkJKzY=;
 b=dVSUoKZCcDEloFC8vGOhrfdcx4yBewn57BI5g7crGv4jL/SfdhTDB9uFGDppVN77KMuJ8kT0C
 Tfb0dv1eFSWA8V3LiU8bhh9Xp7cBBr4nPLuYxSxqs9HaP1F07VPhODm
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

With no PCIe controller enabled (e.g. Orange Pi 5, M.2 in SATA mode),
ACLK_MMU_PCIE is gated as unused and reboot hangs in SMMU shutdown.

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


