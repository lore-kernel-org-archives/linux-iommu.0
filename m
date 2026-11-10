Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294710;
	b=rJ7KePk8TAqJ8mAVuV+lR716b0hcCm4+XLHr3plk4MwhZyECrDe1d4YCztZnFvnMxxuh
	 cWec71LwDt0VEvjh+Q7pgZBo7s5vmodeB2R+2AtPTTIKP/Uzm2FsJQXQt9AQDW0ZC133B
	 07G07mGpE5FiS6abgmdMtP9C0+na+b7aLjX3+7FMgf+WtO8Z2kKll/xXwXjsXi4TE7CIA
	 iCWhWGjk+EKXoTXk9hz8kQWwxpT2I9NqmpUi2eMJf7wV88JCFRW6frKkVQy2RUN9Yv0te
	 2Ia8BX9hpKvq++Q/YqX3Sp6lSPutJ8tU8H6cAi7yHK8Y3CT+B3A7Ms3Srmeyx2bhAQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294710;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=x3ztbNUFuuQCzB/tqQ7N8CqDzjsIOlgjuxNyu7v0y2Q=;
	b=X6XMV9teVoAoy/L/0gnpGJx5M+4YfVLHVBiVQVVX0HKOHG64FG8XaLTQUHWvIvwbHGsQ
	 8ma5ltf4RCJh7eaSQpGzcEIIZSIG06Y83O8kSc4+2/wrY2F7dSbeEguRpWrBL0xiGxpCG
	 PHUUvStgaWRR5skYuj5aZqK+CkP+qOpsJNOB7iEjlHN1LA/qszOzCAPly4WccKurtJGiA
	 RNItff68kUosBuv8RbvpbUe11rb4QdtxTX56eZZB2FvUrgAuJB+MpObrYKQwxZMlffFn3
	 mkfLUqEJKVO8Zekyoub0kKp5IJgcQjAwZdIhYzZ39x5CWHVdRp0TK7FmZgguCQP/r5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THUXTWWt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78387606A32E;
	Tue, 10 Nov 2026 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THUXTWWt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294710;
	b=oqtyaTwiyo0Be38kd0G3ra0wjJ1UCXD96DI8lzXifu7mlmWnNmni9CblbtGahCQBi3Lr
	 UK9Z47yYccEYVc12rtm+YAuV0h3h+GaQF6zgvUu/VxQBbNZAR5feyBg1HOnlia3/mNEVQ
	 y9IXo6dPW1SKPkK+W7SRQwXwEHNab5V+E3z4wsD3R2Ld2jJYTw+64WzfTvhTgQNl+S5Ux
	 Zom4LBkTKbpYGjZwsECH3sCaGe/3luDK7r1ZVLb77VLY2wcFmPxYmbwGj4n07hsTdAFcw
	 xuhYMw//qTWtoI1R9zYQzfn0LH896cnwXByAlmsUpXLniycDTbwpgW/8urImlDqDUOw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294710;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=x3ztbNUFuuQCzB/tqQ7N8CqDzjsIOlgjuxNyu7v0y2Q=;
	b=KgvkPUa/TQ0rlwpSWgx359MwFTy1zPwCOhCUO1nJbyu42Ju4MBlatx4ffmIpuqiuMr/2
	 kKa9+PdkAKtiBKooTIoERAD8Dmj9JLn/hNkVNfflCy6N0Mtre6y2o03VOQBTDdCRL5jNJ
	 NxPAv7bY6bgHzXTtI1UebniEqTlEStcwJgYR0dQ1B7Z0VDLB5siyHc+gtrrvZ+Rj7+C3L
	 PY/c8xfTOQXh6h+/be6AbU+XqVC0/GTNDgckPLIbGHSKXGWvhB+UzSq5Ur9r9NB9rsBaO
	 Uwb3pwavtdP2nFD46LZXiSiwdjWmoC17uNeTKYlj4pSGYUH14EyMtZRGj7yK2IBcV9A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3DA041F008AB;
	Tue, 10 Nov 2026 07:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294710;
	bh=x3ztbNUFuuQCzB/tqQ7N8CqDzjsIOlgjuxNyu7v0y2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=THUXTWWt28JCcNgo+Vi8lSOVeSVQu4HvpXjETa+h/wVaR2p5aqFrmPpEqp+pZTVBr
	 hwzvuAPIiDQ5HhSR50oStvfVSpYTJOSkKJw1kVviBU88Yb3BWD9hfumtwXghco7kvz
	 sWtQSMXw3pNDQtXgYcYXoo22ANrDhb0bPOxdkd7buQHzZvTuwthWu5ex5UujMPHJNC
	 w7w5c59BmVyVWIoQbFjMjOKixkYnpn5p8NtQMhIDPKnTJurV54enAy6GYMLkwPAaJT
	 9RFl3C6GOimcTEZCxlfBi6bLCV6xGwkrKorzsC6wFcLDVKRFw3IkB1X/lZBgpj1CbX
	 wPsXWX4u6f62A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C59E548943;
	Tue, 10 Nov 2026 07:11:48 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:11:49 +0000
Subject: [PATCH 2/5] dt-bindings: iommu: arm,smmu-v3: allow clocks
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
Message-Id: <20261110-smmu-v3-pcie-pd-v1-2-628819ca44b9@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294708; l=1190;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=e3I86t0a2cKOracDfZB99pIl0HZ6AOgZkYX+gUkTyuk=;
 b=tBT8b/4LYX8rdPkNdY6YZ3Uugf78rotGYU+jpwCP66IokWm6Ao3oFELzJCwqsK6jWIT6zWrVg
 dmmp2igf4A2AJylfNxi90PXlJSKrdARCH+fF/ti/lPJg2lEF2QR0zEj
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Some SoCs feed the SMMUv3 from a clock that the OS controls. On the
Rockchip RK3588 the MMU-600 for PCIe runs from ACLK_MMU_PCIE, whose only
other consumers are the PCIe controllers. When no PCIe controller is
enabled, the clock framework gates it as unused, and the SMMU can no
longer be accessed.

Allow up to four clocks, so that such a clock can be described and held
by the SMMU driver.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index c8f22dfdb1db..f8a74730667c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -63,6 +63,13 @@ properties:
 
   msi-parent: true
 
+  clocks:
+    minItems: 1
+    maxItems: 4
+    description:
+      Clocks needed to access the SMMU registers and to keep its translation
+      units running, if they are not managed by firmware.
+
   power-domains:
     maxItems: 1
 

-- 
2.55.0


