Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FA9C433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:26:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814B4613C0
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 17:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814B4613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C1A7405CE;
	Tue, 20 Apr 2021 17:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Y-gu_MjrSVL; Tue, 20 Apr 2021 17:26:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3353405D7;
	Tue, 20 Apr 2021 17:26:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C3C7C0021;
	Tue, 20 Apr 2021 17:26:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D878CC000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:26:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D250B405B0
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:26:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sEeMzoZoKojG for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 17:25:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B65B9405C3
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 17:25:56 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id v6so58169420ejo.6
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5XPg2JTh3w1fx1am6Kys492A+zbxOg5+Kzr89NKkTvM=;
 b=q+cKD5R5kLe2YX3/JfSu01Lye4CPFM83EgMSjAIlJxLmUhhdTRtAnuwLSDMLLXtwJJ
 DDzu0JB8OP3wdaOY1T6bC4xJTVAJBk0IStF8zz/yQjo8y24e8xPFL5wuXvhRHkpz8uw0
 sLqlMEUb163YSl+WD5U+daa8MSiQvIki+z5FXKsb65w3CD9Z2XVi9BsRo/6TrrZzdc4N
 HRxdPUQx6IlgvXKEZ/Dr1iJEWdJR5QxtFbHcJkkuRR6+Y5DTUCk1q8q6t3rzLdCQ7y1x
 4agxD623pevDdU1Wz/pZprfScIf0SwhY9lj3glZKyABiNuT6H9yDeW7EGfeZuU1GVDhp
 2Z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5XPg2JTh3w1fx1am6Kys492A+zbxOg5+Kzr89NKkTvM=;
 b=IiYG8QbEj4umMJjzmNS0/dWSkqyW7xl1C9/tuitOWIVsjOjY3Yy5nk4IuoogSD1nPu
 f+RZSol+ZBGy49zHkKTrFjN7LAyN3V5wgvxyk4n/kriHjMklLPjUJE2DmSWZjlbaiPxw
 /jrrC73Ce4mIN9a4zoK5nwHleup3B/Hs/+ccVieGwoW4Kgptn0wSWVISOAYUKsdVYlTC
 Gg9iTqu8Lxva+0kXd8k4G6p6gx/wqyxxU90GqGKXNXpu8+YvbBINBUK3SasyWhW3J8DS
 6tJ0MXAJdmBLmtxAibiHdPwxbuOidaRjhW9hGDTpz4wqRHouB9Gqaqca7L595GxiYKmU
 LhXw==
X-Gm-Message-State: AOAM531pE8tm9iguc8EK4DuckD4jJ2BTC21sB3HwoCUezkK63RRuC2+9
 O254w8Vdga9g1Omfy2l94y0=
X-Google-Smtp-Source: ABdhPJw9oEAqsf8xMPS7lkRZP02Qf37iOcl4clpo0e8CcVOjSMlCef1sN8vBxnkU1ihTbDlUFD3pYw==
X-Received: by 2002:a17:906:ad9a:: with SMTP id
 la26mr28499401ejb.190.1618939554914; 
 Tue, 20 Apr 2021 10:25:54 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id d15sm9875609edu.86.2021.04.20.10.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 10:25:53 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 09/10] arm64: tegra: Enable SMMU support on Tegra194
Date: Tue, 20 Apr 2021 19:26:18 +0200
Message-Id: <20210420172619.3782831-10-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420172619.3782831-1-thierry.reding@gmail.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Thierry Reding <treding@nvidia.com>

Add the device tree node for the dual-SMMU found on Tegra194 and hook up
peripherals such as host1x, BPMP, HDA, SDMMC, EQOS and VIC.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 86 ++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 4d37ee0ea4d1..6ed296e27158 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -62,6 +62,7 @@ ethernet@2490000 {
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_EQOSR &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_EQOSW &emc>;
 			interconnect-names = "dma-mem", "write";
+			iommus = <&smmu TEGRA194_SID_EQOS>;
 			status = "disabled";
 
 			snps,write-requests = <1>;
@@ -733,6 +734,7 @@ sdmmc1: mmc@3400000 {
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_SDMMCRA &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_SDMMCWA &emc>;
 			interconnect-names = "dma-mem", "write";
+			iommus = <&smmu TEGRA194_SID_SDMMC1>;
 			nvidia,pad-autocal-pull-up-offset-3v3-timeout =
 									<0x07>;
 			nvidia,pad-autocal-pull-down-offset-3v3-timeout =
@@ -759,6 +761,7 @@ sdmmc3: mmc@3440000 {
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_SDMMCR &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_SDMMCW &emc>;
 			interconnect-names = "dma-mem", "write";
+			iommus = <&smmu TEGRA194_SID_SDMMC3>;
 			nvidia,pad-autocal-pull-up-offset-1v8 = <0x00>;
 			nvidia,pad-autocal-pull-down-offset-1v8 = <0x7a>;
 			nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
@@ -790,6 +793,7 @@ sdmmc4: mmc@3460000 {
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_SDMMCRAB &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_SDMMCWAB &emc>;
 			interconnect-names = "dma-mem", "write";
+			iommus = <&smmu TEGRA194_SID_SDMMC4>;
 			nvidia,pad-autocal-pull-up-offset-hs400 = <0x00>;
 			nvidia,pad-autocal-pull-down-offset-hs400 = <0x00>;
 			nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
@@ -821,6 +825,7 @@ hda@3510000 {
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_HDAR &emc>,
 					<&mc TEGRA194_MEMORY_CLIENT_HDAW &emc>;
 			interconnect-names = "dma-mem", "write";
+			iommus = <&smmu TEGRA194_SID_HDA>;
 			status = "disabled";
 		};
 
@@ -1300,6 +1305,84 @@ pmc: pmc@c360000 {
 			interrupt-controller;
 		};
 
+		smmu: iommu@12000000 {
+			compatible = "nvidia,tegra194-smmu", "nvidia,smmu-500";
+			reg = <0x12000000 0x800000>,
+			      <0x11000000 0x800000>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			stream-match-mask = <0x7f80>;
+			#global-interrupts = <2>;
+			#iommu-cells = <1>;
+
+			nvidia,memory-controller = <&mc>;
+			status = "okay";
+		};
+
 		host1x@13e00000 {
 			compatible = "nvidia,tegra194-host1x";
 			reg = <0x13e00000 0x10000>,
@@ -1319,6 +1402,7 @@ host1x@13e00000 {
 			ranges = <0x15000000 0x15000000 0x01000000>;
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_HOST1XDMAR &emc>;
 			interconnect-names = "dma-mem";
+			iommus = <&smmu TEGRA194_SID_HOST1X>;
 
 			display-hub@15200000 {
 				compatible = "nvidia,tegra194-display";
@@ -1430,6 +1514,7 @@ vic@15340000 {
 				interconnects = <&mc TEGRA194_MEMORY_CLIENT_VICSRD &emc>,
 						<&mc TEGRA194_MEMORY_CLIENT_VICSWR &emc>;
 				interconnect-names = "dma-mem", "write";
+				iommus = <&smmu TEGRA194_SID_VIC>;
 			};
 
 			dpaux0: dpaux@155c0000 {
@@ -2136,6 +2221,7 @@ bpmp: bpmp {
 				<&mc TEGRA194_MEMORY_CLIENT_BPMPDMAR &emc>,
 				<&mc TEGRA194_MEMORY_CLIENT_BPMPDMAW &emc>;
 		interconnect-names = "read", "write", "dma-mem", "dma-write";
+		iommus = <&smmu TEGRA194_SID_BPMP>;
 
 		bpmp_i2c: i2c {
 			compatible = "nvidia,tegra186-bpmp-i2c";
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
