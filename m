Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3906C433FE
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 09:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8448740A05;
	Mon, 11 Apr 2022 09:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yvhm1c1xYpnB; Mon, 11 Apr 2022 09:50:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B54A416C5;
	Mon, 11 Apr 2022 09:50:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4668C0033;
	Mon, 11 Apr 2022 09:50:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D9E4C0083
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 09:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7D6E82AA9
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 09:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=quicinc.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lBsg1fb80_sM for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 09:50:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 145CF82951
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 09:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1649670647; x=1681206647;
 h=from:to:cc:subject:date:message-id;
 bh=FwIfYF2sW0uBB3HT6Ujtl39ujKcPOfiLJ8Kif3t6TUQ=;
 b=q0PzwOckVK8GQL+YPML3NhwAIybWc9yHY4dHquc5Sf+aXlsMv7QtaCco
 klqM/jv+cGXD9oEz6rtWxtcQ7ipd4iy7umhleJmlyVprsIhDzkGgJAkkl
 94jjpERf34SqmQKXscOmTnU6GYV/c/0HGYBP4pLoxvJQI0rC6o9/gahL4 Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
 by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 02:50:47 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
 by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA;
 11 Apr 2022 02:50:45 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO
 hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
 by ironmsg02-blr.qualcomm.com with ESMTP; 11 Apr 2022 15:20:24 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
 id 76E3C3A9B; Mon, 11 Apr 2022 15:20:23 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzk+dt@kernel.org, ulf.hansson@linaro.org, agross@kernel.org,
 bjorn.andersson@linaro.org
Subject: [PATCH v2 0/7] SDX65 devicetree updates
Date: Mon, 11 Apr 2022 15:20:08 +0530
Message-Id: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rohit Agarwal <quic_rohiagar@quicinc.com>,
 manivannan.sadhasivam@linaro.org, linux-arm-kernel@lists.infradead.org
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

This series adds devicetree nodes for SDX65. It adds reserved memory 
nodes, SDHCI, smmu and tcsr mutex support.

Changes from v1:
 - Addressed Mani's Comments and made necessary.
 - Rebased on top of v5.18-rc2.

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
