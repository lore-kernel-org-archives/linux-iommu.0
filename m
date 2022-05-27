Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABA2C433F5
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 21:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 765AF6F4BE;
	Fri, 27 May 2022 21:39:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 63twfeoXRR8v; Fri, 27 May 2022 21:39:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4EBE96F4B1;
	Fri, 27 May 2022 21:39:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2331EC0039;
	Fri, 27 May 2022 21:39:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06B1EC002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 21:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0C9440A9D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 21:38:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gmQx3rEfdnP5 for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 21:38:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it
 [IPv6:2001:4b7a:2000:18::165])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2DDB040A21
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 21:38:56 +0000 (UTC)
Received: from localhost.localdomain (abxh119.neoplus.adsl.tpnet.pl
 [83.9.1.119])
 by m-r1.th.seeweb.it (Postfix) with ESMTPA id A584420542;
 Fri, 27 May 2022 23:29:35 +0200 (CEST)
From: Konrad Dybcio <konrad.dybcio@somainline.org>
To: ~postmarketos/upstreaming@lists.sr.ht, linux-arm-msm@vger.kernel.org,
 bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 0/6] Fix and extend Qualcomm IOMMU support
Date: Fri, 27 May 2022 23:28:55 +0200
Message-Id: <20220527212901.29268-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Cc: marijn.suijten@somainline.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
 martin.botka@somainline.org, jamipkettunen@somainline.org,
 angelogioacchino.delregno@somainline.org
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

Due to Qualcomm's software solutions, genius or otherwise, the IOMMUs on
pre-msm8998-and-sdm630 SoCs are flawed beyond reason, and conviniently
it is all due to an (almost in all cases) irreplaceable hypervisor and TZ
stack. As end users and developers, we have no choice but to adapt to that
and follow whatever the IOMMUs expect.

This series fixes and improves the existing support (adjusts the code flow
to make sure things are written in correct order and adds a way to
properly (i.e. in compliance with the firmware's expectations) reset the
IOMMUs) and extends it with features for the SoCs that came near the end
of an era of what we call "qcom_iommu" upstream, namely 8952 family
(8917, 8937, 8952, 8956/76, 8953 and possibly more) (Aarch64 pagetables
and secured QCIOMMUv2/QCIOMMU_500 ctxs)
and at the same time builds another milestone in getting msm8974/94 IOMMU
support that has been in the works for something like 7 years, and never
got upstreamed in the end (we'll get it one day, eventually...).

The dt-bindings are NOT converted to YAML as a part of this series, that
will come in a later patchset.


AngeloGioacchino Del Regno (6):
  iommu/qcom: Use the asid read from device-tree if specified
  iommu/qcom: Write TCR before TTBRs to fix ASID access behavior
  iommu/qcom: Properly reset the IOMMU context
  iommu/qcom: Add support for AArch64 IOMMU pagetables
  iommu/qcom: Index contexts by asid number to allow asid 0
  iommu/qcom: Add support for QCIOMMUv2 and QCIOMMU-500 secured contexts

 .../devicetree/bindings/iommu/qcom,iommu.txt  |   5 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 137 ++++++++++++++----
 2 files changed, 114 insertions(+), 28 deletions(-)

-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
