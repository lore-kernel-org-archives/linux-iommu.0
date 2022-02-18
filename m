Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F838C433FE
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 12:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 369DC40297;
	Fri, 18 Feb 2022 12:12:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tcayYyEh6yD1; Fri, 18 Feb 2022 12:12:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CCBAB405CB;
	Fri, 18 Feb 2022 12:12:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A74F6C0021;
	Fri, 18 Feb 2022 12:12:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0117C0039
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:12:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCD7584C4A
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:12:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tDzpGOZjLAbH for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 12:12:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 17BD984C48
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kI2Y6FC34ujTihl6CDjHGjleimjTYg+32wil4qWAtbY=; b=emjAyPEwTpAqQAVxDRmqRV/8sS
 4VBE36vI/5WUgsMkA9/QqmWfR+sG5GYt67RwJ/7HFQbpux6Nhc/YruZamH7d07p+6JdAYdnr3m4Xx
 6mRnbDAO3CKx2S+iGOer4H+gpgKxeChyxG3Lm7qGZ6xz2fUGxxwEJSPMWQO1Tmh6UY1ID6yHNw1oB
 56moj3NbDdB93/eU7N1F3eDIYzBOSsfztW3u1ASdkZPD+MgeVFiOoEm+IibZHBRwClcufLq/HvRlN
 BGBwVOAaU3NdbrGb44gKFYcYD+jdFezlj4/D7URTtyC/zoUyxTACgdicILBBgqveXcfKHPllJV6sU
 MIXKwV7w==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=toshino.localdomain)
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <mperttunen@nvidia.com>)
 id 1nL1fq-0006eP-9v; Fri, 18 Feb 2022 13:43:42 +0200
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
Subject: [PATCH v3 6/9] arm64: tegra: Add Host1x context stream IDs on
 Tegra186+
Date: Fri, 18 Feb 2022 13:39:49 +0200
Message-Id: <20220218113952.3077606-7-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220218113952.3077606-1-mperttunen@nvidia.com>
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: mperttunen@nvidia.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
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
From: Mikko Perttunen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mikko Perttunen <mperttunen@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add Host1x context stream IDs on systems that support Host1x context
isolation. Host1x and attached engines can use these stream IDs to
allow isolation between memory used by different processes.

The specified stream IDs must match those configured by the hypervisor,
if one is present.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
* Added context devices on T194.
* Use iommu-map instead of custom property.
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index c91afff1b757..7c49a0281986 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1406,6 +1406,18 @@ host1x@13e00000 {
 
 		iommus = <&smmu TEGRA186_SID_HOST1X>;
 
+		memory-contexts {
+			iommu-map = <
+				0 &smmu TEGRA186_SID_HOST1X_CTX0 1
+				1 &smmu TEGRA186_SID_HOST1X_CTX1 1
+				2 &smmu TEGRA186_SID_HOST1X_CTX2 1
+				3 &smmu TEGRA186_SID_HOST1X_CTX3 1
+				4 &smmu TEGRA186_SID_HOST1X_CTX4 1
+				5 &smmu TEGRA186_SID_HOST1X_CTX5 1
+				6 &smmu TEGRA186_SID_HOST1X_CTX6 1
+				7 &smmu TEGRA186_SID_HOST1X_CTX7 1>;
+		};
+
 		dpaux1: dpaux@15040000 {
 			compatible = "nvidia,tegra186-dpaux";
 			reg = <0x15040000 0x10000>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 2d48c3715fc6..240202f2669b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1686,6 +1686,18 @@ host1x@13e00000 {
 			interconnect-names = "dma-mem";
 			iommus = <&smmu TEGRA194_SID_HOST1X>;
 
+			memory-contexts {
+				iommu-map = <
+					0 &smmu TEGRA194_SID_HOST1X_CTX0 1
+					1 &smmu TEGRA194_SID_HOST1X_CTX1 1
+					2 &smmu TEGRA194_SID_HOST1X_CTX2 1
+					3 &smmu TEGRA194_SID_HOST1X_CTX3 1
+					4 &smmu TEGRA194_SID_HOST1X_CTX4 1
+					5 &smmu TEGRA194_SID_HOST1X_CTX5 1
+					6 &smmu TEGRA194_SID_HOST1X_CTX6 1
+					7 &smmu TEGRA194_SID_HOST1X_CTX7 1>;
+			};
+
 			nvdec@15140000 {
 				compatible = "nvidia,tegra194-nvdec";
 				reg = <0x15140000 0x00040000>;
-- 
2.35.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
