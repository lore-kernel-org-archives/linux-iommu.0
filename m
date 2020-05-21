Return-Path: <SRS0=DnMm=7D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8344C433DF
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 23:31:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D1C20825
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 23:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oXQHWs4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D1C20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 88C8B203B0;
	Thu, 21 May 2020 23:31:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CZVxDFwNGuZ4; Thu, 21 May 2020 23:31:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 38F2C24F8D;
	Thu, 21 May 2020 23:31:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00BCFC0891;
	Thu, 21 May 2020 23:31:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53413C0176
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4111D24F13
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:31:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nzzlt1jv-ONd for <iommu@lists.linux-foundation.org>;
 Thu, 21 May 2020 23:31:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by silver.osuosl.org (Postfix) with ESMTPS id C24EE203B0
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 23:31:24 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ec70ebb0002>; Thu, 21 May 2020 16:28:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 21 May 2020 16:31:24 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 21 May 2020 16:31:24 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 May
 2020 23:31:23 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 21 May 2020 23:31:23 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
 hqnvemgw03.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5ec70f4b0005>; Thu, 21 May 2020 16:31:23 -0700
From: Krishna Reddy <vdumpa@nvidia.com>
To: 
Subject: [PATCH v5 5/5] arm64: tegra: enable SMMU for SDHCI and EQOS on T194
Date: Thu, 21 May 2020 16:31:07 -0700
Message-ID: <20200521233107.11968-6-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521233107.11968-1-vdumpa@nvidia.com>
References: <20200521233107.11968-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1590103739; bh=gpJ7zVDEktQWdt8OOZ30mXZsuHmqPjP7Fg0Tdm8sNVg=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=oXQHWs4XYEP3NOSJsoPvq5vf2dtfVy1SUVU04A6jGkEO9Xjnwilh0d0R67zhOygcU
 3cI8gKO47XqWKY4T6/73ueHdnDpUFQMuU5e6HcgEeAIred5f8d1h9SlgHKIVee6VH0
 WlfIPFaAxJgVQuzTTzGFW7mbHQo1z/hlJOknUrIIKnnduU7R1Rxu4aFavb0aj1IsIY
 FIgn8wonsiRy5EyoG3psUr3W9x3LihXYGBMkDjAghvMgwg1e0cg+FLMresg7UomVJG
 BoV/gBkEO8wKFPNfKUZJ26h3Y2VytZMDRDhG8Scafj0WxmO7IBU4A1ixhXB9L4F4Kz
 totbuTXOTMY6Q==
Cc: snikam@nvidia.com, mperttunen@nvidia.com, bhuntsman@nvidia.com,
 will@kernel.org, linux-kernel@vger.kernel.org, praithatha@nvidia.com,
 talho@nvidia.com, iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
 linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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

Enable SMMU translations for SDHCI and EQOS transactions on T194.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index f7c4399afb55..706bbb439dcd 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -59,6 +59,7 @@ ethernet@2490000 {
 			clock-names = "master_bus", "slave_bus", "rx", "tx", "ptp_ref";
 			resets = <&bpmp TEGRA194_RESET_EQOS>;
 			reset-names = "eqos";
+			iommus = <&smmu TEGRA194_SID_EQOS>;
 			status = "disabled";
 
 			snps,write-requests = <1>;
@@ -457,6 +458,7 @@ sdmmc1: sdhci@3400000 {
 			clock-names = "sdhci";
 			resets = <&bpmp TEGRA194_RESET_SDMMC1>;
 			reset-names = "sdhci";
+			iommus = <&smmu TEGRA194_SID_SDMMC1>;
 			nvidia,pad-autocal-pull-up-offset-3v3-timeout =
 									<0x07>;
 			nvidia,pad-autocal-pull-down-offset-3v3-timeout =
@@ -479,6 +481,7 @@ sdmmc3: sdhci@3440000 {
 			clock-names = "sdhci";
 			resets = <&bpmp TEGRA194_RESET_SDMMC3>;
 			reset-names = "sdhci";
+			iommus = <&smmu TEGRA194_SID_SDMMC3>;
 			nvidia,pad-autocal-pull-up-offset-1v8 = <0x00>;
 			nvidia,pad-autocal-pull-down-offset-1v8 = <0x7a>;
 			nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
@@ -506,6 +509,7 @@ sdmmc4: sdhci@3460000 {
 					  <&bpmp TEGRA194_CLK_PLLC4>;
 			resets = <&bpmp TEGRA194_RESET_SDMMC4>;
 			reset-names = "sdhci";
+			iommus = <&smmu TEGRA194_SID_SDMMC4>;
 			nvidia,pad-autocal-pull-up-offset-hs400 = <0x00>;
 			nvidia,pad-autocal-pull-down-offset-hs400 = <0x00>;
 			nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
