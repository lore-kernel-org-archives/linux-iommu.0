Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E2486E77;
	Fri, 25 Sep 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329673; cv=none; b=TVjRTrN7yfkVTinoVCwxXfJueCfY5MEGdOuxegd1uPyg8M1PK1YmYZfMfWgJ7B0bKKP6sjmlP7rzsROKMmxe9btxIFUr4vprLbZ8ZFTrv3tm8DZh4r53DAvJvIYQY69kqVQEtxoP15miIbj+JdHgliymrGjBHEc26mw3BleEdD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329673; c=relaxed/simple;
	bh=OUQ0tyP82NCPCd11TV1rj4Yk5hugce5ZTuFSNoDywmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CogISjiVhKw3aLSYfWQKG7MLs1OMXVl4oZpl5DFj7YymtPdQ1YkbMjUDbVg+2J5fYN+052p+0PMlwtjZYeM3mQmjb5JQSOGmYsJANambv6dI2Wtwjb9PGC40i1zL0cnSbgwEKQFtc9d0aP6iPYAmdYg2259gp3gvR2Yi1aW09iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=iiDM9Kmn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iFLbFa7Q; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="iiDM9Kmn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iFLbFa7Q"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFCCA14000DA;
	Fri, 25 Sep 2026 05:47:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Sep 2026 05:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790329670;
	 x=1790416070; bh=NWAz1gBkX5FpaLcLypEwhgTve9qtSgCES3iEhptwBnE=; b=
	iiDM9KmngJk5/h3BI6WBEEJIeoCNPt32J1iL9XAtcoK/xQZAjsDWY0qmv45g582E
	PtRWnsv7oDFPgwyG9ztTEj6qJOwYF+2C6wL37E6C5UqiPJssBhLR+i1dn1t+v+zB
	J6pvxBIKKuXxVi4Vxhl0CwBHyiL6CZwCaJtMI01gXtHB6mPv/uJhpxrySaB/+upe
	WhDTRPOr65PW42MuOZJz/VuEGjICHO9hnb8tpSa1Ojo0EfxYdU0nyHeHFgtKyyOw
	DEKGp3htCff0fDeiOsBjlMUV2UdxOEuvetuoR/KjRJ8VcoOCwyWfTtXpyALOoGBU
	Wm2Fo1zM2x0o1Kz17dzI3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790329670; x=
	1790416070; bh=NWAz1gBkX5FpaLcLypEwhgTve9qtSgCES3iEhptwBnE=; b=i
	FLbFa7QmUo0cPQF/QIRAo5kmT0bolymDnuF6MhcFwWhTCe2VaAYrbugYBRHsrSgL
	ZB3sYuwyXkN0bppWwCx40UKkSW0hlykjJNizDm31Tc+1goN6kZV9yFaKX26JYf1U
	YpC7OSW4yH8sTRrQHIf15AASa2YrN3kZJEBQkiwyL1+MngncbnaCcDUtq1h09D6L
	NZ8kC6E/7BqhQPg/tUAuQ1Nr5bZm6zGc44eFVZecgToEKjbI3/i3XJUci7Zs565F
	pf8RQSrbP3PQa6dFjVTmnjxzMzbu6wQC2Ho+AXwPDJaELJl9QtLN0nVyUVZF1QTG
	opdB7MAliq4dqT23/3jtQ==
X-ME-Sender: <xms:RkO2aqjyJDXHHVgldO9CBkTnZmm9VBAdJRYe2rPAqTOPwt_nsdha5g>
    <xme:RkO2aiHY-fUy53_QmmFikKxiLeepzsKimC2svTWeDHMt7K6Ov5jPYhEndOYOaHIqv
    MDLlNtRftwxztNPPPm_zb4oak1o5vfP94_tMju82JVXIp_PtKMp56Q>
X-ME-Received: <xmr:RkO2apzNxBmVY-r2xdGWPIYzObFKq72H4hxXFulFCaVLbpmTjEsCBZKTs_SBlJFPaGWAM6U>
X-ME-Proxy-Cause: dmFkZTEbJhpSeMD7LDnpXCsQixag+cvxD3bFoso28WtgwG8J22LA5vwA2EmaCBywrGkNVk
    fJMjIB1Awjw+5D30C7m+Dp9Vxht3KEjZe6Lqrn96FVDODdxJTXUrAFR/eapVtvwXhviQS/
    JjIqmjL9odLytU7DATY/m+docx/hb3FWUj64crzCk+tps7ekg8phg3zCMXxYaP0Ob+waHV
    cSSktW8VoIuVmdCIqemuf0fMDG7R4dEOgW1ZWVrHKk37AKRJ6VGIvRwRezkqZ1pcO4AQYm
    oPUZAjyu+mKYQUVO4Gg0cdt3FfSRHd0FcPgbe7x6n5fIfG3GTyJW626LUIjETbYg6L0HO8
    7UwaPglk6wN7UlJ3N+dBxAvqIwsDa2cd+rZzGJ24Uzv5WDB07tcPbx5m+7AMx5VQyMV+Fl
    HOgpub/D2SrZJkh9p4m9J+fkdmgYOOpT+JZWS5Yxvsws1+wwXybSLapFL7beOhdPFx2UNE
    NpeAHklWqYytQRGWfjYNxWpuBFFSyREtoudIF4NSy2h1E2Fqy6pYo0pMGIRHniNba2XUcI
    vRVI6g8SrhZ0hI8ucti9VyvcYu4/Zv71qdeqI/U6Su+oBiZcYaNDYE3C91ZuY8OXmGh4EK
    E5RsPdVNOKmvdKbyQ4YkunVktoNh9asm7f8LRxO4VIlC+C0ayPfBaDV/v3kg
X-ME-Proxy: <xmx:RkO2appnZGd40sD2GylD7gdapP0jADIqz8i5WCuhdc9oUfQuJdZe0Q>
    <xmx:RkO2akeGhsegZvZdX2kfdPeo3JbkGAsPoOCi5WnOOHqthqE9iIH5cw>
    <xmx:RkO2aninMMoF_ruwAFI-Bqk5fgbizOwoKHkxJa5Bly6Ps2XpoRXXXg>
    <xmx:RkO2aqIi_Nr9jIV1OHzQhVCcEn2u9Ve8oLvzSG03iyFey68OywKv_g>
    <xmx:RkO2aniiIHoS3MGQBCxBbrWPbdVG-BRd-K27QcQfEn8gT-PcGnkJuaqW>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 05:47:50 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 25 Sep 2026 10:22:53 +0200
Subject: [PATCH 6/7] arm64: dts: apple: t6031: Add NVMe device nodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-m3-nvme-v1-6-5e832e2f4aa9@jannau.net>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
In-Reply-To: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, iommu@lists.linux.dev, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; i=j@jannau.net;
 h=from:subject:message-id; bh=OUQ0tyP82NCPCd11TV1rj4Yk5hugce5ZTuFSNoDywmM=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxtzjo9Oox+xVOKQ5cbWZ94sWheyTvzZpGrR8w0zymdO
 7tNyXhGx0QWBjEuBksxRZYk7ZcdDKtrFGNqH4TBzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 RjrGOkYMXJwCMNWnpzH8j435ym3ZYis239o5Uc+a8diTk8rSyi9Ptlr6rhZvuz4/meF/Yu8ivge
 R2U/+nDOfrvlh7/Mf51b+TW2WtpM2lz9R0mnNCAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Apple silicon SoCs have a built-in NVMe host controller. Using it
requires device nodes for its IOMMU (SART), its mailbox and the ANS
coprocessor implementing the NVMe host controller.
Since the NAND chips on the M3 Ultra are connected to its second die use
t6031-nvme.dtsi for the NVMe device nodes.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t6031-nvme.dtsi | 46 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/apple/t6031.dtsi      |  1 +
 arch/arm64/boot/dts/apple/t6032.dtsi      |  1 +
 3 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6031-nvme.dtsi b/arch/arm64/boot/dts/apple/t6031-nvme.dtsi
new file mode 100644
index 000000000000..d3831bbc2bf2
--- /dev/null
+++ b/arch/arm64/boot/dts/apple/t6031-nvme.dtsi
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * NVMe related devices for Apple T603x SoCs.
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+&SOC_NODE {
+	DIE_NODE(ans_mbox): mbox@349408000 {
+		compatible = "apple,t6031-asc-mailbox", "apple,asc-mailbox-v4";
+		reg = <0x3 0x49408000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ DIE_NO 1274 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ DIE_NO 1275 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ DIE_NO 1276 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ DIE_NO 1277 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "send-empty", "send-not-empty",
+				  "recv-empty", "recv-not-empty";
+		#mbox-cells = <0>;
+		power-domains = <&DIE_NODE(ps_ans)>;
+	};
+
+	DIE_NODE(sart): sart@34dc50000 {
+		compatible = "apple,t6031-sart", "apple,t6000-sart";
+		reg = <0x3 0x4dc50000 0x0 0x10000>;
+		power-domains = <&DIE_NODE(ps_ans)>;
+	};
+
+	DIE_NODE(nvme): nvme@34dcc0000 {
+		compatible = "apple,t6031-nvme-ans2", "apple,t8103-nvme-ans2";
+		reg = <0x3 0x4dcc0000 0x0 0x40000>,
+		      <0x3 0x49400000 0x0 0x4000>;
+		reg-names = "nvme", "ans";
+		interrupt-parent = <&aic>;
+		/* The NVME interrupt is always routed to die 0 */
+		interrupts = <AIC_IRQ 0 2366 IRQ_TYPE_LEVEL_HIGH>;
+		mboxes = <&DIE_NODE(ans_mbox)>;
+		power-domains = <&DIE_NODE(ps_ans)>,
+				<&DIE_NODE(ps_apcie_sys_st)>,
+				<&DIE_NODE(ps_apcie_sys_st1)>;
+		power-domain-names = "ans", "apcie0", "apcie1";
+		resets = <&DIE_NODE(ps_ans)>;
+
+		apple,sart = <&DIE_NODE(sart)>;
+	};
+};
diff --git a/arch/arm64/boot/dts/apple/t6031.dtsi b/arch/arm64/boot/dts/apple/t6031.dtsi
index a2aa64ea9db9..30a91c1a47d2 100644
--- a/arch/arm64/boot/dts/apple/t6031.dtsi
+++ b/arch/arm64/boot/dts/apple/t6031.dtsi
@@ -39,6 +39,7 @@ soc: soc {
 #include "t6031-die0.dtsi"
 #include "t6031-dieX.dtsi"
 #include "t6031-gpio-pins.dtsi"
+#include "t6031-nvme.dtsi"
 #include "t6031-pmgr.dtsi"
 
 #undef DIE
diff --git a/arch/arm64/boot/dts/apple/t6032.dtsi b/arch/arm64/boot/dts/apple/t6032.dtsi
index efe56d2a9a79..2a3a1fed59df 100644
--- a/arch/arm64/boot/dts/apple/t6032.dtsi
+++ b/arch/arm64/boot/dts/apple/t6032.dtsi
@@ -362,6 +362,7 @@ die1: soc@2200000000 {
 #define SOC_NODE die1
 
 #include "t6031-dieX.dtsi"
+#include "t6031-nvme.dtsi"
 #include "t6031-pmgr.dtsi"
 
 /delete-node/ &ps_pmp_die1;

-- 
2.55.0

