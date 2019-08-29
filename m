Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3BBC3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 22:47:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB40021874
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 22:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QPfX3Cop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB40021874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F27E859DB;
	Thu, 29 Aug 2019 22:47:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1505659BC
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 22:45:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 95F09887
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 22:45:43 +0000 (UTC)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
	hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5d6855980004>; Thu, 29 Aug 2019 15:45:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
	by hqpgpgate102.nvidia.com (PGP Universal service);
	Thu, 29 Aug 2019 15:45:43 -0700
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Thu, 29 Aug 2019 15:45:43 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
	(172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Thu, 29 Aug 2019 22:45:42 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL109.nvidia.com
	(172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
	Frontend Transport; Thu, 29 Aug 2019 22:45:42 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
	hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
	id <B5d6855960007>; Thu, 29 Aug 2019 15:45:42 -0700
From: Krishna Reddy <vdumpa@nvidia.com>
To: 
Subject: [PATCH 6/7] arm64: tegra: Add DT node for T194 SMMU
Date: Thu, 29 Aug 2019 15:47:06 -0700
Message-ID: <1567118827-26358-7-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1567118745; bh=gX59JWlIEhcC/UhKYXmwo4rcyDGrhtHKW4+lTuofYJY=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	In-Reply-To:References:X-NVConfidentiality:MIME-Version:
	Content-Type;
	b=QPfX3CopDpyhRAS9BFxP9ADzozwea1hBuUBEUnI31uunLleQIthOrTmEJlsGDcUSb
	hQPFTH3loGfIFY/d86Uqtuzaiwxa0MgeQO5CfQFRvp5YQ+FsSejOcx2f9+9abacdVn
	xflMQo9NpE/sXeEz55IbUhh5jMZGJp+eDNefmsa0zIdYqPEnJdl9i9Z8xchxa/BR0D
	oUfMs6f0E7sHqhTAKIVFQ0TJGSzlhhYyHFdeSHH6dWKw+y00f4ehGvfXdtzdiUMkmA
	xThAxllumM4qGl4K6bSS4jXuryaqu6dhjoWCPp3aK94f8gdl/QBNYtSSjCusydySl1
	/0AAYBIYIwHqw==
Cc: snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
	mperttunen@nvidia.com, praithatha@nvidia.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	talho@nvidia.com, yhsu@nvidia.com, linux-tegra@vger.kernel.org,
	treding@nvidia.com, avanbrunt@nvidia.com,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Add DT node for T194 SMMU to enable SMMU support.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 75 ++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index d906958..ad509bb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1401,6 +1401,81 @@
 			  0x82000000 0x0  0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
 	};
 
+	smmu: iommu@12000000 {
+		compatible = "nvidia,smmu-v2";
+		reg = <0 0x12000000 0 0x800000>,
+		      <0 0x11000000 0 0x800000>,
+		      <0 0x10000000 0 0x800000>;
+		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+		stream-match-mask = <0x7f80>;
+		#global-interrupts = <1>;
+		#iommu-cells = <1>;
+	};
+
 	sysram@40000000 {
 		compatible = "nvidia,tegra194-sysram", "mmio-sram";
 		reg = <0x0 0x40000000 0x0 0x50000>;
-- 
2.1.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
