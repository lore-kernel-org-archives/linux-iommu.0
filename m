Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E555C433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 08:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDCD583F53;
	Mon, 11 Apr 2022 08:01:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JmBZXkaTCWRq; Mon, 11 Apr 2022 08:01:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BBB9382FCB;
	Mon, 11 Apr 2022 08:01:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 240E7C0088;
	Mon, 11 Apr 2022 08:01:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DF9DC002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18AED4150F
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=quicinc.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mN1hH_NfBlkM for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 07:02:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 599BE41513
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1649660535; x=1681196535;
 h=from:to:cc:subject:date:message-id;
 bh=aRKhlH11BYG4D30HiNuvL9KWitrjNW8cRlhyWm2s6Sg=;
 b=XJM8Ma1vyM3UV5ztb1WpdHZzOC9qq+H91O2lXdD/T4BcyAer1fTvq56J
 6v1n74tmUAyQ+3A7z2/noOHYMwY5RnOJClVB7ShzrT02Y4msWFZPIdc1x
 Qc+d9/sORhn7Ag3hmcLbxy9PICp/Wev2tNiuLhflL3S3EFA45UkwLtVZ8 4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
 by alexa-out.qualcomm.com with ESMTP; 10 Apr 2022 23:56:12 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
 by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA;
 10 Apr 2022 23:56:11 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO
 hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
 by ironmsg01-blr.qualcomm.com with ESMTP; 11 Apr 2022 12:25:51 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
 id A84B437D9; Mon, 11 Apr 2022 12:25:50 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzk+dt@kernel.org, ulf.hansson@linaro.org, agross@kernel.org,
 bjorn.andersson@linaro.org
Subject: [PATCH 0/7] SDX65 devicetree updates
Date: Mon, 11 Apr 2022 12:25:36 +0530
Message-Id: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Mon, 11 Apr 2022 08:01:02 +0000
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rohit Agarwal <quic_rohiagar@quicinc.com>,
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

Hello,

This series adds devicetree nodes for SDX65. It adds
reserved memory nodes, SDHCI, smmu and tcsr mutex support.

Thanks,
Rohit.

Rohit Agarwal (7):
  ARM: dts: qcom: sdx65: Add reserved memory nodes
  dt-bindings: mmc: sdhci-msm: Document the SDX65 compatible
  ARM: dts: qcom: sdx65: Add support for SDHCI controller
  dt-bindings: arm-smmu: Add binding for SDX65 SMMU
  ARM: dts: qcom: sdx65: Enable ARM SMMU
  ARM: dts: qcom: sdx65: Add support for TCSR Mutex
  ARM: dts: qcom: sdx65: Add Shared memory manager support

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 arch/arm/boot/dts/qcom-sdx65-mtp.dts               |  21 ++++
 arch/arm/boot/dts/qcom-sdx65.dtsi                  | 110 +++++++++++++++++++++
 4 files changed, 133 insertions(+)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
