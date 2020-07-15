Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC40DC433EC
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B232065E
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="M5yRZ7ZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B232065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 637948AC0B;
	Wed, 15 Jul 2020 07:07:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xWTMNFhAf9bJ; Wed, 15 Jul 2020 07:07:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D05D58ABFE;
	Wed, 15 Jul 2020 07:07:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB658C07FF;
	Wed, 15 Jul 2020 07:07:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7C4DC0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CF6BA20529
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fNyAXhoK-sX for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 07:07:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 225512151E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 07:07:08 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id r19so1316486ljn.12
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VY6/nDkB+l4D8VdfNdnYyBq9q17cRBW9+cu/3oGCNgQ=;
 b=M5yRZ7ZNspTd64Y3T6EJeSR8BEe9OMlQ4XzMqNsOL1aKRBkPYizWm15squLSNLr9f4
 rBa60eFJit6+maotnQ0qwVNmkkLEr4LVlSlzvj50dEO69YdHS5LGWqgTJl3WaayqMB8R
 Ss6sFZTMqqjWmVvbOlQURv3BkEDVa/Hs+YtYv7dc6MrmaUbbM4HVBY0SmwiSfe+i3cFi
 4+58toaeQyrLor5BcsThGO+Y+N1NOvzG0UskCEa6PKcaO3ky/HnQ0o061JCSBoKZf7Da
 9TPt7j8CUVnAL6og2kyuNqRC+YEboLTL+BgBpgFEUYvj2Or8EzdjCQuqd1NoOSsGkyTI
 wmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VY6/nDkB+l4D8VdfNdnYyBq9q17cRBW9+cu/3oGCNgQ=;
 b=KstOJ8Nk78VfVvx1UPF6mTIRSujlAhAf/HaBuhgGV1GlFeCD4vOGimhIjtBfJD7dbs
 z8hIP0vpSiuJ9P8ue+9iPm7bREZCzeHjY0XSw60tLVEekJDsFaOxpM0fdK0gVS4NG1me
 /OEUvk8yH6bGLVYhkW9QBvT+2RumV7AZMQNZVmNOB/8Bdz6p77rqlauXvWIxPbnH5P3b
 OSnLoeSCMctGO60q9+rF1OUvG9AIzOI3nPCydEVHatbCU2hW2NH06bgI789YOTOdMlOY
 n/h/2rUeZdW607H2sW+kafd/I2F/HRMZ/N3n/rrIxLHmZLPu0aUgMYjYbB1yhpaP/5kC
 QOqw==
X-Gm-Message-State: AOAM5302MeLkuPTdTqTmbZWzuNTcjmkBCX/jWIg8xZOrQJvUys4eOQxn
 nRBSI/FDYGnGqwlFLzn6nOcx6w==
X-Google-Smtp-Source: ABdhPJwrpgLAN7Afl7yoGdK1hqq6n9x3hw3elslWkLxcDk1FTatcRnB2CeQPdKz7PyWfn5zgrTCMAQ==
X-Received: by 2002:a2e:859a:: with SMTP id b26mr4332777lji.241.1594796825939; 
 Wed, 15 Jul 2020 00:07:05 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
 by smtp.gmail.com with ESMTPSA id 83sm276040ljj.51.2020.07.15.00.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 00:07:05 -0700 (PDT)
From: Tomasz Nowicki <tn@semihalf.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Subject: [PATCH v4 4/4] arm64: dts: marvell: add SMMU support
Date: Wed, 15 Jul 2020 09:06:49 +0200
Message-Id: <20200715070649.18733-5-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715070649.18733-1-tn@semihalf.com>
References: <20200715070649.18733-1-tn@semihalf.com>
Cc: devicetree@vger.kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Marcin Wojtas <mw@semihalf.com>

Add IOMMU node for Marvell AP806 based SoCs together with platform
and PCI device Stream ID mapping.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/boot/dts/marvell/armada-7040.dtsi  | 28 +++++++++++++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 40 +++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 18 +++++++++
 3 files changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040.dtsi b/arch/arm64/boot/dts/marvell/armada-7040.dtsi
index 47247215770d..7a3198cd7a07 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-7040.dtsi
@@ -14,3 +14,31 @@
 	compatible = "marvell,armada7040", "marvell,armada-ap806-quad",
 		     "marvell,armada-ap806";
 };
+
+&smmu {
+	status = "okay";
+};
+
+&cp0_pcie0 {
+	iommu-map =
+		<0x0   &smmu 0x480 0x20>,
+		<0x100 &smmu 0x4a0 0x20>,
+		<0x200 &smmu 0x4c0 0x20>;
+	iommu-map-mask = <0x031f>;
+};
+
+&cp0_sata0 {
+	iommus = <&smmu 0x444>;
+};
+
+&cp0_sdhci0 {
+	iommus = <&smmu 0x445>;
+};
+
+&cp0_usb3_0 {
+	iommus = <&smmu 0x440>;
+};
+
+&cp0_usb3_1 {
+	iommus = <&smmu 0x441>;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
index 7699b19224c2..79e8ce59baa8 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
@@ -15,6 +15,18 @@
 		     "marvell,armada-ap806";
 };
 
+&smmu {
+	status = "okay";
+};
+
+&cp0_pcie0 {
+	iommu-map =
+		<0x0   &smmu 0x480 0x20>,
+		<0x100 &smmu 0x4a0 0x20>,
+		<0x200 &smmu 0x4c0 0x20>;
+	iommu-map-mask = <0x031f>;
+};
+
 /* The RTC requires external oscillator. But on Aramda 80x0, the RTC clock
  * in CP master is not connected (by package) to the oscillator. So
  * disable it. However, the RTC clock in CP slave is connected to the
@@ -23,3 +35,31 @@
 &cp0_rtc {
 	status = "disabled";
 };
+
+&cp0_sata0 {
+	iommus = <&smmu 0x444>;
+};
+
+&cp0_sdhci0 {
+	iommus = <&smmu 0x445>;
+};
+
+&cp0_usb3_0 {
+	iommus = <&smmu 0x440>;
+};
+
+&cp0_usb3_1 {
+	iommus = <&smmu 0x441>;
+};
+
+&cp1_sata0 {
+	iommus = <&smmu 0x454>;
+};
+
+&cp1_usb3_0 {
+	iommus = <&smmu 0x450>;
+};
+
+&cp1_usb3_1 {
+	iommus = <&smmu 0x451>;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index 7f9b9a647717..12e477f1aeb9 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -56,6 +56,24 @@
 			compatible = "simple-bus";
 			ranges = <0x0 0x0 0xf0000000 0x1000000>;
 
+			smmu: iommu@5000000 {
+				compatible = "marvell,ap806-smmu-500", "arm,mmu-500";
+				reg = <0x100000 0x100000>;
+				dma-coherent;
+				#iommu-cells = <1>;
+				#global-interrupts = <1>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			gic: interrupt-controller@210000 {
 				compatible = "arm,gic-400";
 				#interrupt-cells = <3>;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
