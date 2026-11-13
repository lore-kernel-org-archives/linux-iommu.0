Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794559507;
	b=DivJOLT8jvWjqcvoyyGoEY+BeBaJDWlIilE1mc3QvIwxzQTW+KXa4pOCg7MndHcXJfRN
	 /dBK+K1i8WxrKvOFxekaiIWnpH+Cylig2HbVc3abOS513RS5rshp35mmq1F75zhAnsx0R
	 9Zy6S8lkssNAT7/u/oP/0P+ijwkTNW4PBl4GNJ60yCKABrsNqA1/myar7zLuCE7AxAVKG
	 cZn2z1OALCZjLTHv0b1J95pJShHjdgrWBIlVL61Hk5e3Hec3Zv50l2gBouKWXamNUnYjQ
	 ZMLfD9KBKBpyIs9SJx0PqY9GdZNw16+0vTqnNgGnWdw0bNSK6tx28/vka8Z3YFkLphw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559507;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AGOtK77h1IMEUh2ILX1I4QN6zn+UjhgWbqlbQNGAxok=;
	b=hiajifNAJt4oDSjICvm/zZfj3yb32zqkWr4cwTd73+WZS+18WLf0eACZB5B2yGi8XPkE
	 o+xVY6QhlVcN1Paym63e47kL/JnHoyAZcylVsGG6uA/mjq90GQYLIfZOmQqP2OxVb/hXJ
	 ndRYv/Re2ChWMAshnsOiewNqC9rppX6qw6MiEBs0BtTNBPwdBBI6sbK9SaJkQvoM2O14i
	 vpbZvSBNAN/FcJAahYOgiu00uAQ6nh+6cv8Vpht8EItu0B5g4WvrGhQdNd0vRsOuS23o3
	 177QYO+wvKzCkn9tNtWwUXoiytss9rCf9LuWga6vdTo63s4UZo7lyATCBm+dtOnj+lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6xb33TA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C060A6F77;
	Fri, 13 Nov 2026 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6xb33TA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794559507;
	b=NmHekQ1a8gJEKefNT4z8v1nsbrWa3Rr8oPugmfwN+eZSSPM13PHVYgKcOkrIVgNkk9rB
	 GrGFpqWAJwHbqZMS3BhAih+0fyhw2SvVy13NBlMDgKaAf+9ntCOxy7EU1N0Z2cZH02cYj
	 cMZB37BHcM/qw9C3fsFd/Z9s2c5HAKlI5mi5WPpREwa+Vj/10HTNjTwDEs8wD/aWyA9Mm
	 srK2wcSsw1Q/2HjIe94imWdDOBqvPzekqx4n7Wz/7bZia2jSaFSH0iGmeJD19a9ywwmIJ
	 oZNmdSl9Iu7SoRkhKt6CbZ3sxvJaFTahkvKWH1/3Blo3wyCTUMi8PWLG9SJ8HMnsF5g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794559507;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AGOtK77h1IMEUh2ILX1I4QN6zn+UjhgWbqlbQNGAxok=;
	b=3IxqA4na3pnfpbkR7M4r3AMpmsGVPVjmYarPh45UiEmksxTrHov+5eu8mH8zKNAUTtU/
	 H6QIwVSi3NXvmSwmDdStAYLM//VxN8scgVtxh334XW6IEEwEOKnyMGxvfK9LGUZu73zVg
	 C3d2QXcEJL8joor41R4L/shGrMLWxtTfjvgVLSMt76lX0iCI4icswA8VDYNLDBzhK/hut
	 XPUOHmRiztyrL0KRvxh7BSZ9qAxAxjF0aG5DU8UIdHpEmlIXlNDgQuEiTu4f8PLQ3u7Ca
	 ZQThfwi83poemAf/JHP6BelsWfoPwRougdZZNBDKz+rCsrM1Zs/OrYuqqECw1+WoLKQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1C0041F000C7;
	Fri, 13 Nov 2026 08:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794559507;
	bh=AGOtK77h1IMEUh2ILX1I4QN6zn+UjhgWbqlbQNGAxok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=U6xb33TAxfuLZluegmNIW64e08evLCOkFt2cRYfTjulfFD2j8pG2tqOZGRdQulV2K
	 3Oq+1+i3W/LPlehEIsLvMa04yvX3Uvbgqj3RCrUWcYKQXvB7yV0+Lc9NKahFY5HbhF
	 C2SU2XAk1/ZN6qTAJkp5F2vXP8Y9liBFQ/Kd8eRV4U7rX0+u6ugmQZAlUWULIAFj2V
	 nUopOqJ2ULPcyqZn36LCX0SVljvFrUv9dSE+FcXbItIkLY5pwioaKST7oXTt+Ez0hD
	 T+nFTXgjv4+eZWxGSlC53uXjk+XC/9jUelRDGxWKzeX5TAdVFvTgsbvF8vpIBdScw9
	 eS/L2/441qEaA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 84085476C8;
	Fri, 13 Nov 2026 08:45:05 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 08:45:05 +0000
Subject: [PATCH v3 1/3] dt-bindings: iommu: arm,smmu-v3: Allow a clock and
 a reset
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
Message-Id: <20261113-smmu-v3-pcie-pd-v3-1-39eb4f919529@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794559505; l=1030;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=SG9fFTOzKpSkhJ/pzr/TczrngVXDEsaz0Xd0nLP1l2E=;
 b=zvewCNzhQBIlNRliWXhF1vEqy3EpLyfIGKH2wQS/4ZlC1ARQC9YQRNNt7njPZkT4WDvEAYCao
 bsnfPcnNH6jCEB8J8orvs1j2essY7HehjzB1vsoPLxYRSLVFFNSdjHv
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The RK3588 PCIe MMU-600 has a clock (ACLK_MMU_PCIE) and a reset
(SRST_A_MMU_PCIE) in the CRU. When no PCIe controller holds the clock,
it is gated as unused and the SMMU stops responding. Allow one clock and
one reset.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 3c044e4f03d4..9ab80142a485 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -63,6 +63,14 @@ properties:
 
   msi-parent: true
 
+  clocks:
+    maxItems: 1
+    description:
+      Clock of the SMMU's register and memory interfaces.
+
+  resets:
+    maxItems: 1
+
   nvidia,cmdqv:
     description: |
       A phandle to its pairing CMDQV extension for an implementation on NVIDIA

-- 
2.55.0


