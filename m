Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999077;
	b=IWWKQVKDZn5WoDIvJkHE+BWS7NyT/q9oXTtYZtyZyTzNblRziUFST0hWOVEObyxRPAHE
	 uTXsxSgFjIjWbdcPFGCOrhli+mkytOar1Dl21Ot4gSFBxJ2FseP8CVe947Z7dThdErZeb
	 i1UMYgFAKBs+ypyS7lJD0jt3Gka9GAETpTAapSs9Z77jvDVtodRuP38KTaKxKGCES41Bx
	 /9OkI1S5n/EZDfGOwdEpnn4k4tUlKYSI9AlgziS8m17JQ1VQwwT/75wUMhHEgGjcJcK0H
	 dSnZaYGIb/0PYhclroU1t5uhFXnzmFwL/DGptUTqTgGzqLK9ZaJ5l0+NDNmTH8mbGcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999077;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=EfIRKQI8PX+6U6ygvekU+kTb4/7Reb6EURSmwPgXyt8=;
	b=1ZCN9Xx1/An6o6yx22yEFKVE1eIef0d6MeodLbbA54JYpIpDRim59JDfnA+m17GPC6Os
	 edI11FEaJbidTrkCcGlG3ZG5gJTAiCBIkmBMfb/psNnH6Si5uCcZsSMN5oxp3HqhnUABl
	 3EgKfg8drzJSSzgNCE5Ok3TONNSlOv4VAd2V2OlL/KRIjjJ25A4f/fTlNpld27tEM/CdT
	 SPhAB56eK2GSAJyzGUkxKrOX6G1Jr5DW7kgguLdwhOv8FtMzJtxpT7iOdicEI3VpnoGNT
	 9pUGsb4rzeZxN+W9rTaLbyNmrJ/CnJgS/ogx238FWqZIGqsGLwWCW74cnwvYlg5S6ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=YccW+n0f;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8C606EE8D;
	Fri,  6 Nov 2026 21:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C8C606EE8D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=YccW+n0f
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793999074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EfIRKQI8PX+6U6ygvekU+kTb4/7Reb6EURSmwPgXyt8=;
	b=YccW+n0feezvsv2aNOcEnvNT3PUPykUf4qTxWJFaJH4PVkbGvuxDy5is5z1O10LbkL76Qb
	YsF9ss2gkRxOgRoIZmEaLzq+CWRWHh0l5Mku3AsqQ3pBtiVY8rDYXAqoLQ357VQKjUnQlT
	3mgbhFTW3FLzGAVAk0+NMRKvdfhbMa4=
Date: Fri, 06 Nov 2026 22:04:21 +0100
Subject: [PATCH 12/15] arm64: dts: apple: t8132: Add NVMe nodes
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-apple-dts-m4-m5-nvme-v1-12-22f4827b4ece@cyberchaos.dev>
References: <20261106-apple-dts-m4-m5-nvme-v1-0-22f4827b4ece@cyberchaos.dev>
In-Reply-To: <20261106-apple-dts-m4-m5-nvme-v1-0-22f4827b4ece@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, Yureka Lilian <yureka@cyberchaos.dev>

Add the device nodes for the internal NVMe SSD on the Apple M4 (t8132)
SoC. Keep ps_apcie_phy_sw powered on matching t8122.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 arch/arm64/boot/dts/apple/t8132-pmgr.dtsi |  1 +
 arch/arm64/boot/dts/apple/t8132.dtsi      | 41 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8132-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8132-pmgr.dtsi
index 6fbf09e8f981..c9deb9b8b096 100644
--- a/arch/arm64/boot/dts/apple/t8132-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8132-pmgr.dtsi
@@ -824,6 +824,7 @@ ps_apcie_phy_sw: power-controller@550 {
 		#reset-cells = <0>;
 		label = "apcie_phy_sw";
 		power-domains = <&ps_apcie_sys_st>, <&ps_apcie_sys_gp>;
+		apple,always-on;
 	};
 
 	ps_msr: power-controller@560 {
diff --git a/arch/arm64/boot/dts/apple/t8132.dtsi b/arch/arm64/boot/dts/apple/t8132.dtsi
index e2e79c7e7fd0..e7d27620a9f7 100644
--- a/arch/arm64/boot/dts/apple/t8132.dtsi
+++ b/arch/arm64/boot/dts/apple/t8132.dtsi
@@ -472,6 +472,47 @@ serial0: serial@3ad200000 {
 
 			status = "disabled";
 		};
+
+		ans_mbox: mbox@481608000 {
+			compatible = "apple,t8132-asc-mailbox",
+				     "apple,asc-mailbox-v4";
+			reg = <0x4 0x81608000 0x0 0x4000>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1003 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 1004 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 1005 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 1006 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+					  "recv-empty", "recv-not-empty";
+
+			#mbox-cells = <0>;
+			power-domains = <&ps_ans>;
+		};
+
+		sart: sart@485c50000 {
+			compatible = "apple,t8132-sart", "apple,t6000-sart";
+			reg = <0x4 0x85c50000 0x0 0x10000>;
+			power-domains = <&ps_ans>;
+		};
+
+		nvme: nvme@4c5cc0000 {
+			compatible = "apple,t8132-nvme-ans2";
+			reg = <0x4 0xc5cc0000 0x0 0x60000>,
+			      <0x4 0x81600000 0x0 0x4000>;
+			reg-names = "nvme", "ans";
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1018 IRQ_TYPE_LEVEL_HIGH>;
+
+			mboxes = <&ans_mbox>;
+
+			power-domains = <&ps_ans>, <&ps_apcie_sys_st>;
+			power-domain-names = "ans", "apcie0";
+			resets = <&ps_ans>;
+
+			apple,sart = <&sart>;
+		};
 	};
 
 	timer {

-- 
2.56.0

