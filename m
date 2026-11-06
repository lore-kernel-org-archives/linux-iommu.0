Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999078;
	b=cQ0V2xApUruocxvGRduvSfrLMRZxd7GJls6WCQalHF2ghLfc6lb7S6HMCm7Y6HzKQFrS
	 Wqf9PhNGBE1bKaI/dV1j2dGx5diniy2/VOvIwttB0tr3rdeFcUZb6Uvs8obzZaKZjvhq3
	 eAQlRq+JVr3cHNpGWUnY3C95XKBlx93bLCIv03XUNGMf0aHyyaqfJhK22Umlu8hP4J09F
	 IQZkH3jwDEcGIlMKX4e5bX9ZdDtG1IubBSPgzvOs+toEGf19P7L37/NA3rURNvJlGSE+S
	 suxkGeF0vdWAo5SEysHnjbft+0p4l/Ron1oy2LE6vO3Y/sibpKCe65Ec3pnbMVv4iXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999078;
	h=DMARC-Filter:From:DKIM-Signature:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=Q3gp6Avq1u4KULHEJJcxqqSSLUCUEG88RkHz8ESxDdk=;
	b=kwRimzm93vUEQODTM1gRXG06Yjb5TFL50IKc47xH1c3iZ09ENwGU793GieMsJqJNjb7L
	 4Lrt+MckjCXGcQ1zZDmU9oZtH80yozY7UR+z1ItOhKgxrgH+M1PxqzxDOx55kLBhka9Ax
	 NoGgHy0kiA00NNS8SiDU3G+Lpo22sd+osKEBYosJd/TgXjmSprRi+UvSZ4V0P9x0gDYEf
	 2QqzO3rbIUxFcBXodes9+y3XEUdsw7N/v5v47Ek1MwqkQJvxWOUUxNdvHRTTxk4G7fNRn
	 BdSPB6i0wy8yzGqq41J1YTVhA+0cmZOVYX4VD4KLcSz06R2IlAPgkEk2nCJZi8Fpz4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b="bT/BQtXo";
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B5606D827;
	Fri,  6 Nov 2026 21:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 644B5606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=bT/BQtXo
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1793999076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3gp6Avq1u4KULHEJJcxqqSSLUCUEG88RkHz8ESxDdk=;
	b=bT/BQtXovkizs+c+VsP9NgTvpgd7VCTp/BXmluKo/a3SjIGkra4tSyd9sb4CDLdPLntq4S
	ENQhbgfs2ar5+oWiulN8B9/KflmPMXMBwB89nnaRFrlo12W1NRF9Oy2h5xzJ6DPLEBr+lC
	HVk3kB+9jxx/QKMP7f2cZERkCbXSeEs=
Date: Fri, 06 Nov 2026 22:04:23 +0100
Subject: [PATCH 14/15] arm64: dts: apple: t604x: Add NVMe nodes
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
Message-Id: <20261106-apple-dts-m4-m5-nvme-v1-14-22f4827b4ece@cyberchaos.dev>
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

Add the device nodes for the internal NVMe SSD on the Apple M4 Pro/Max
(t6040/t6041) SoCs. Keep ps_apcie_phy_sw powered on matching t603x.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 arch/arm64/boot/dts/apple/t6041-pmgr.dtsi |  1 +
 arch/arm64/boot/dts/apple/t6041.dtsi      | 44 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6041-pmgr.dtsi b/arch/arm64/boot/dts/apple/t6041-pmgr.dtsi
index 7da82f8a036b..029ecd3bda82 100644
--- a/arch/arm64/boot/dts/apple/t6041-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t6041-pmgr.dtsi
@@ -824,6 +824,7 @@ ps_apcie_phy_sw: power-controller@398 {
 		#power-domain-cells = <0>;
 		power-domains = <&ps_apcie_sys_st0>, <&ps_apcie_sys_st1>;
 		#reset-cells = <0>;
+		apple,always-on;
 	};
 
 	ps_jpg: power-controller@3a0 {
diff --git a/arch/arm64/boot/dts/apple/t6041.dtsi b/arch/arm64/boot/dts/apple/t6041.dtsi
index 9110d05c896d..e7c3e33f8f69 100644
--- a/arch/arm64/boot/dts/apple/t6041.dtsi
+++ b/arch/arm64/boot/dts/apple/t6041.dtsi
@@ -329,6 +329,29 @@ pmgr_gfx: power-management@288e80000 {
 			#size-cells = <1>;
 		};
 
+		ans_mbox: mbox@409608000 {
+			compatible = "apple,t6041-asc-mailbox",
+				     "apple,asc-mailbox-v4";
+			reg = <0x4 0x09608000 0x0 0x4000>;
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1530 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 1531 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 1532 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 1533 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+					  "recv-empty", "recv-not-empty";
+
+			#mbox-cells = <0>;
+			power-domains = <&ps_ans>;
+		};
+
+		sart: sart@40dc50000 {
+			compatible = "apple,t6041-sart", "apple,t6000-sart";
+			reg = <0x4 0x0dc50000 0x0 0x10000>;
+			power-domains = <&ps_ans>;
+		};
+
 		i2c0: i2c@429010000 {
 			compatible = "apple,t6041-i2c", "apple,t8103-i2c";
 			reg = <0x4 0x29010000 0x0 0x4000>;
@@ -501,6 +524,27 @@ serial0: serial@429200000 {
 			status = "disabled";
 		};
 
+		nvme: nvme@44dcc0000 {
+			compatible = "apple,t6041-nvme-ans2",
+				     "apple,t8132-nvme-ans2";
+			reg = <0x4 0x4dcc0000 0x0 0x60000>,
+			      <0x4 0x09600000 0x0 0x4000>;
+			reg-names = "nvme", "ans";
+
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 2583 IRQ_TYPE_LEVEL_HIGH>;
+
+			mboxes = <&ans_mbox>;
+
+			power-domains = <&ps_ans>,
+					<&ps_apcie_sys_st0>,
+					<&ps_apcie_sys_st1>;
+			power-domain-names = "ans", "apcie0", "apcie1";
+			resets = <&ps_ans>;
+
+			apple,sart = <&sart>;
+		};
+
 		pmgr: power-management@502280000 {
 			compatible = "apple,t6041-pmgr", "apple,t8103-pmgr",
 			             "syscon", "simple-mfd";

-- 
2.56.0

