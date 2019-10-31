Return-Path: <SRS0=DWjf=YY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A50CA9ECB
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 00:07:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177C120873
	for <iommu@archiver.kernel.org>; Thu, 31 Oct 2019 00:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="A+/XV1P0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177C120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7C711E9F;
	Thu, 31 Oct 2019 00:07:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C61B3CDD
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 00:07:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 73A80876
	for <iommu@lists.linux-foundation.org>;
	Thu, 31 Oct 2019 00:07:31 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
	hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5dba25c80002>; Wed, 30 Oct 2019 17:07:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
	by hqpgpgate101.nvidia.com (PGP Universal service);
	Wed, 30 Oct 2019 17:07:31 -0700
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Wed, 30 Oct 2019 17:07:31 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
	(172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Thu, 31 Oct 2019 00:07:30 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
	(172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Thu, 31 Oct 2019 00:07:30 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
	(172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
	Frontend Transport; Thu, 31 Oct 2019 00:07:30 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
	hqnvemgw02.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
	id <B5dba25c20000>; Wed, 30 Oct 2019 17:07:30 -0700
From: Krishna Reddy <vdumpa@nvidia.com>
To: 
Subject: [PATCH v4 4/6] arm64: tegra: Add Memory controller DT node on T194
Date: Wed, 30 Oct 2019 17:07:15 -0700
Message-ID: <1572480437-28449-5-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572480437-28449-1-git-send-email-vdumpa@nvidia.com>
References: <1572480437-28449-1-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1572480456; bh=hRANYpP2XS4X2iTAl/T+hd2FdaXreD0LfCPfta2oI4c=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	In-Reply-To:References:X-NVConfidentiality:MIME-Version:
	Content-Type;
	b=A+/XV1P0Z9ui7GnEtzCXA/B0bpCu2hyHBepqr2LO38YNOjmtui27qfxBGe/NC2lpB
	jCQy0UeWlsb2mlOeas3GLUuvwxAI0B9Pysmsab0kGBg+9do7v7rITFo+8WLgeMi71i
	9ct9tXdY5ONhGVsfP6kLTmMo477vSRdp/GAgdiglFa1GwUgCBEamWLSken2br/78sj
	63BY25lX+eG/H77ZPbfXXD8XYKtnsiJ/7j7b0cjfu3mPM6YgODmRijAHPM8BLwSq9s
	Ktsg/I1wE640vMCD2BZtdXmLLC9GXM0kuVXxuqe0MDvpIGFn/O4P8HdaR7z83U7Go0
	5kJblyH/dLJ0g==
Cc: snikam@nvidia.com, jtukkinen@nvidia.com, mperttunen@nvidia.com,
	will@kernel.org, linux-kernel@vger.kernel.org,
	praithatha@nvidia.com, talho@nvidia.com,
	iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
	linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
	robin.murphy@arm.com, avanbrunt@nvidia.com,
	linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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

Add Memory controller DT node on T194 and enable it.
This patch is a prerequisite for SMMU enable on T194.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 4 ++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi       | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 4c38426..82a02490 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -47,6 +47,10 @@
 			};
 		};
 
+		memory-controller@2c00000 {
+			status = "okay";
+		};
+
 		serial@3110000 {
 			status = "okay";
 		};
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 3c0cf54..1e0b54b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -163,6 +163,12 @@
 			};
 		};
 
+		memory-controller@2c00000 {
+			compatible = "nvidia,tegra186-mc";
+			reg = <0x02c00000 0xb0000>;
+			status = "disabled";
+		};
+
 		uarta: serial@3100000 {
 			compatible = "nvidia,tegra194-uart", "nvidia,tegra20-uart";
 			reg = <0x03100000 0x40>;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
