Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999077;
	b=oeIFOYi+G+es1VvRQ38FinpqNytxYtQRIcr+XqZv2rF0fv7rxgtybiKGRwMJWQc7ZjLw
	 1Q6IJyULCKy2s6Zn+OYK/rGp+i+79T0IubLL6JFlJMUlGYgGbaMqV+Aks399hbuTm5FK8
	 5MbOgxA4Dv6AyeKHOdb+yj158rOK1urfOyIQDBnMOYaxT3FxaY+k57xiXkbj0XAoP9g54
	 zBDzHgRkoPOx6MrlBx2rocxKU8wAqP4UBrVH9dUShy4OBEsl+UON3CjS1OIV5bxMUExWh
	 LVi/9+U2SnqEX+qFX0o5jWDBORV10hbw3n9xYvc56J7FiQfeitUmauHCly4ThV0X27w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999077;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=leZ0DMFlEYwLl56NU7dNF7zQDEc0KXwSFbg2dW83f/I=;
	b=0pFuPr6AATJu4Q1WT/j/EOH4nArul1dbOGwBj6ayxx4A/xBUOvouNhyvAXFOADiej8no
	 PV3XkEStoSmwOY1c4ZsF19tba2JNp2zbkNvBvj/cE/Sok/zeHwzIl7J82bgfFYfCJJXC/
	 0a1FRNhIWoh2strmJtwKM6UqT+RRwqpznQ7u019+28iztft8K7i9cDD+PEg5YiQt+X0db
	 eyPihGyHlb4Hqz9kgY138HDN4gTsvrRBnGpBmb0vzu1IqWpQjE8b/U5UaIf8eco5Lv97B
	 75ULVe536hzC5jlQoekz84m+4Ymt/8ymQUXcFqVwXNQ0OPZZq6w0JQBjZdrmMkkK98A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=kHx7me7L;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B84606EE97;
	Fri,  6 Nov 2026 21:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46B84606EE97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=kHx7me7L
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793999075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=leZ0DMFlEYwLl56NU7dNF7zQDEc0KXwSFbg2dW83f/I=;
	b=kHx7me7LH4thttAK0jGglb50QEhk+PO/2xZR0ys8N4G87Wd//ubGjiim8fx5UOSJI7p1Pr
	lPwxstiDznlWon1E20V01ewDEPZxwZc7XiBpWQ7FO3SQD+b+WN6rJDnPcFRhrsYdvsBRPs
	2A+MvtNNs8w93MB2v6v/6s96Yq+ucnA=
Date: Fri, 06 Nov 2026 22:04:22 +0100
Subject: [PATCH 13/15] arm64: dts: apple: t8140: Add NVMe nodes
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
Message-Id: <20261106-apple-dts-m4-m5-nvme-v1-13-22f4827b4ece@cyberchaos.dev>
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

Add the device nodes for the internal NVMe SSD on the Apple A18 Pro
(t8140) SoC. Keep ps_apcie_phy_sw powered on matching t8122.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 arch/arm64/boot/dts/apple/t8140-pmgr.dtsi |  1 +
 arch/arm64/boot/dts/apple/t8140.dtsi      | 42 +++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8140-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8140-pmgr.dtsi
index dd43520394ac..ac69e57cc140 100644
--- a/arch/arm64/boot/dts/apple/t8140-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8140-pmgr.dtsi
@@ -556,6 +556,7 @@ ps_apcie_phy_sw: power-controller@3c0 {
 		#power-domain-cells = <0>;
 		power-domains = <&ps_apcie_sys_st>, <&ps_apcie_sys_gp>;
 		#reset-cells = <0>;
+		apple,always-on;
 	};
 
 	ps_pmp: power-controller@3d0 {
diff --git a/arch/arm64/boot/dts/apple/t8140.dtsi b/arch/arm64/boot/dts/apple/t8140.dtsi
index 3b4f7695552b..4230af506fca 100644
--- a/arch/arm64/boot/dts/apple/t8140.dtsi
+++ b/arch/arm64/boot/dts/apple/t8140.dtsi
@@ -351,6 +351,48 @@ serial0: serial@385200000 {
 
 			status = "disabled";
 		};
+
+		ans_mbox: mbox@389608000 {
+			compatible = "apple,t8140-asc-mailbox",
+				     "apple,asc-mailbox-v4";
+			reg = <0x3 0x89608000 0x0 0x4000>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1007 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 1008 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 1009 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 1010 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+					  "recv-empty", "recv-not-empty";
+
+			#mbox-cells = <0>;
+			power-domains = <&ps_ans>;
+		};
+
+		sart: sart@38dc50000 {
+			compatible = "apple,t8140-sart", "apple,t6000-sart";
+			reg = <0x3 0x8dc50000 0x0 0x10000>;
+			power-domains = <&ps_ans>;
+		};
+
+		nvme: nvme@3cdcc0000 {
+			compatible = "apple,t8140-nvme-ans2",
+				     "apple,t8132-nvme-ans2";
+			reg = <0x3 0xcdcc0000 0x0 0x60000>,
+			      <0x3 0x89600000 0x0 0x4000>;
+			reg-names = "nvme", "ans";
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1039 IRQ_TYPE_LEVEL_HIGH>;
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

