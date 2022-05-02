Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D05C433EF
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 08:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D03E402F2;
	Mon,  2 May 2022 08:38:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aq5fYAm23gy1; Mon,  2 May 2022 08:38:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 68E2640220;
	Mon,  2 May 2022 08:38:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47F4CC007C;
	Mon,  2 May 2022 08:38:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2839C002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 08:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE05B60BFF
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 08:38:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=quicinc.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tLhsaCeJgmKx for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 08:38:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 350D760B62
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 08:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1651480691; x=1683016691;
 h=from:to:cc:subject:date:message-id;
 bh=+H8Cn+KGxCLUnovgOg/dhAnwXPNW3VIwUWFvZftP4lM=;
 b=IGtN9hOaXJBZA41Q6ketBB85/EUlDpMzZPVkxXdXaUs0rSRxyHaCNPf5
 zILwDLL/k5Aa78rrolWLKg26Uh/3n+oKaDNKSMSKjSAGSug9K51agUz+m
 vCqrApgNICBPIJXPnYMoCuV7A1QrUVD1YsFJ/wjd4tEboP+UCFPQpjvxI c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
 by alexa-out.qualcomm.com with ESMTP; 02 May 2022 01:38:10 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
 by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA;
 02 May 2022 01:38:09 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO
 hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
 by ironmsg02-blr.qualcomm.com with ESMTP; 02 May 2022 14:07:49 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
 id 598A33BE0; Mon,  2 May 2022 14:07:48 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, ulf.hansson@linaro.org,
 agross@kernel.org, bjorn.andersson@linaro.org, adrian.hunter@intel.com,
 bhupesh.sharma@linaro.org
Subject: [PATCH 0/4] SDHCI and SMEM updates for sdx65.
Date: Mon,  2 May 2022 14:07:41 +0530
Message-Id: <1651480665-14978-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

This series adds some patches addressing comments from Bjorn and Ulf.
The patches are from the  original series "SDX65 devicetree updates" that
were needed some changes.

Thanks,
Rohit.

Rohit Agarwal (4):
  dt-bindings: mmc: sdhci-msm: Document the SDX65 compatible
  mmc: host/sdhci-msm: Add compatible string check for sdx65
  dt-bindings: arm-smmu: Add binding for SDX65 SMMU
  ARM: dts: qcom: sdx65: Add Shared memory manager support

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml  | 1 +
 arch/arm/boot/dts/qcom-sdx65.dtsi                     | 4 +++-
 drivers/mmc/host/sdhci-msm.c                          | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
