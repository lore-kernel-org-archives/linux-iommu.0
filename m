Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294710;
	b=xL92ZrwMQ/PSr7ub/+hvHLYKl3g0eYoQTw6egUxtwfoM4SKptPuLnKy5wBdl0hS5SAPh
	 8uHyFLDZjAUQDGy0OaT/lmRCrifHUJ/xulVmm+9z3sr2TljgO7wH8BkHfD/LNWKjLemlb
	 wi4grL3HhDAAFRPxxOs/ylm8dvI+dRZ3vFMXpcbB8JUErWEyTZR3enTE3Nc6ihEgC9r7N
	 IqJYD0FodNgPPQsXwXrs/bFkPTaHhGrIagq/ySfPhGBt/o2YPBVFkQkeZAMNIAIfNgFBY
	 FWsEnNpe7Roltf8JNaJ6Hu+VVmynYjrFJ9Sqz0RG83h2pqAwI2N/OA2t2rc6SIRW2lQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294710;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vk6XQFsmHi5+fYj5Z5LO4ofgSzJKdKgu6NS/sbE7SU4=;
	b=Wzqao0Kjku9z7ab3BhiEzOrJuo+jeIj9mYz9CmWfvykJsZz46IdokzC3MAvxhmDkpXHI
	 dg74NZ7YIwh1SzE5D2cw8yP9IhmYUF3vBLvItOirNUOJjFB8gD6c9XPhJusSyhAatitFy
	 WSJPNfIsrIymtRNtfrTv1dfdPJv+8iGLSiv8m8sTCbIP+7z2pONhNteHE9PFMGgDueYXx
	 ZrYZf1//o7Omb7LKCSZ+O7L3h8NjyQ6ouKSkTgaGxCPeUBTNt3ATVkZxNXNmEIN1r63fH
	 1HGOJ5yz0Vp7FmJOKa63FLhJTAv/lUSz+7g/2TVeuWOTVxnpMiMrUJkEy7Vwqt1d5Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiZH7EZC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE860A261B;
	Tue, 10 Nov 2026 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiZH7EZC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294710;
	b=27Icb4Dj0siM0BU2jQ7vyFEutfDe/kRKOnxH1Zp9251m5YyucXY5MklNz54szuVxQ6+a
	 srgw1veH/Gulp3ptk8joqsT818kjW8lCqKlOHiylEceLFadtkw4q0Ua83o8vb0wvk1xwy
	 c9pmeO+/7tJc4BR5/o73Ocqj83Uf4FnOQmEl7b+kTVcGLUyLk54jF1bwo9t6JOgCA6gmA
	 DpLw8qEJJs5vmyz+77r1LcZoeqDDtjb2xArT4IjETfQ9oT5SSfpmwH33wva2WoLRl1zXz
	 /yr+osjwQvtQdD8FM5m/ePQ8aUkdKyu08FYIiThMAjRimOBGlQwwQmC7ewn4b+SqYuQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294710;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vk6XQFsmHi5+fYj5Z5LO4ofgSzJKdKgu6NS/sbE7SU4=;
	b=t46bD62wX7vguKSOCJA4tAaEyEt7/lQG7BnpVHDzLkAkKAF8SRJAXKkthiTxQG5R6bdr
	 DxPFTt6Z0kgvfrctHvSQoC60hJDCQ3lil59llyz445gP50rg5/boHWiYB/kTLiP1BVBzt
	 lGv6h1bvyO8QpgI+Br05or56AYAdWSk4aYledfV4wRssRg7vQWHr9KzS+ZnHTtmAQpPJk
	 NjuaS4+rglTY7LAurSi1H6hjEKi0EtKLTMYTTp0nZ7luvyOUVJZowCASqdq9SUzs58x1m
	 6UG1DStq0DF4R4UqkRzXD1dEbH9+GKgnGj/R8IrymB550+0tgcxn2lgok/Sa8u91WsA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2E4CB1F008A5;
	Tue, 10 Nov 2026 07:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294710;
	bh=vk6XQFsmHi5+fYj5Z5LO4ofgSzJKdKgu6NS/sbE7SU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZiZH7EZCNfqurcBkR36FmPkPQwjes/U7r9QgqB3HO6On8983eXxzZNLi2EWNMB8QZ
	 u5fL/Dol/1wuuL6+dZKMXPClzSolht7yhYEi++Bo4/u1R2WcErNOD95OQ5XrMNqjVc
	 ZjO2JO8khpzFJr8ynUw26ax68KIaa0t9pnvoWKyYwqKhaJ7Afa1QEtrOujLxyHS7Zr
	 x5PT7B6octMLyYEZxd3CJ1tH1vd/SCaEAyu3DNXIXeFhXg6i4Ehcpqb2mQBaPzwdk0
	 4N6cScCzzSGnfsJpUxP176MwOnQU5pU2amVFcQ3xY4kFEtoenk8hP5eaJTUkvKVxXP
	 F8TbztpEBZocw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B44AB48947;
	Tue, 10 Nov 2026 07:11:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:11:48 +0000
Subject: [PATCH 1/5] dt-bindings: iommu: arm,smmu-v3: allow a power domain
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
Message-Id: <20261110-smmu-v3-pcie-pd-v1-1-628819ca44b9@gmail.com>
References: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
In-Reply-To: <20261110-smmu-v3-pcie-pd-v1-0-628819ca44b9@gmail.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294708; l=1167;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=TdWoGoQsKnyrm8b9EIEgWSxDN/b5wPqWn8RNCU7PWLE=;
 b=x3WlakvjrJB7bBweyNuurbxFx6ml1Crbe9R1B+W78YkdTZqbMT4BjFaIlFUU2Yq28U85BBqQ7
 QAh2R2KDz6TCenOiDzdDdC3EJcC6NonWmsjPmdZ8tgjZohMcMJXI9Pl
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

An SMMUv3 instance can sit in a switchable power domain of the SoC, for
example the MMU-600 in front of the PCIe controllers on the Rockchip
RK3588, which is part of the PCIe power domain. If the domain is not
described, nothing keeps it powered while the SMMU is bound, and any
register access after it has been turned off as unused stalls the
interconnect.

Allow a single power-domains entry, as arm,smmu.yaml already does for
the earlier SMMU architectures.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 3c044e4f03d4..c8f22dfdb1db 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -63,6 +63,9 @@ properties:
 
   msi-parent: true
 
+  power-domains:
+    maxItems: 1
+
   nvidia,cmdqv:
     description: |
       A phandle to its pairing CMDQV extension for an implementation on NVIDIA

-- 
2.55.0


