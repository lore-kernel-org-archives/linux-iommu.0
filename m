Return-Path: <SRS0=lDAf=5C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B4DC3F2CE
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 15:09:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68F820752
	for <iommu@archiver.kernel.org>; Tue, 17 Mar 2020 15:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="T8xYNRCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68F820752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C3E2B86DBF;
	Tue, 17 Mar 2020 15:09:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bi6Qyw6tv0bI; Tue, 17 Mar 2020 15:09:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4818F850E6;
	Tue, 17 Mar 2020 15:09:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1453DC1D85;
	Tue, 17 Mar 2020 15:09:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD06BC013E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 15:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9C3A886538
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 15:09:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C2XO4FT9LpJq for <iommu@lists.linux-foundation.org>;
 Tue, 17 Mar 2020 15:09:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 697A4850E6
 for <iommu@lists.linux-foundation.org>; Tue, 17 Mar 2020 15:09:30 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1584457774; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=DQyTxctuBEZTN8fXLm5dooxaiNu334g2EQVY7vU8oHo=;
 b=T8xYNRCcQywmLJELRdWcol49ydgmnC+P0fu74UDJto68RFHacn1qzD5ctGbseAniseoIGoY9
 Da8s9XBxMcs3wgLiMmlWOBv+E1nIWH7zijzbH5Ffk1lHAzHOA6iEmzzJBZ8HVUi3uZHXUBk1
 v1fZDVrkgGJmYJw0nsTwBbAk+G4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e70e824.7fd9cd9a8570-smtp-out-n01;
 Tue, 17 Mar 2020 15:09:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 00AF3C433CB; Tue, 17 Mar 2020 15:09:23 +0000 (UTC)
Received: from blr-ubuntu-87.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: sibis)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A07AC433D2;
 Tue, 17 Mar 2020 15:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A07AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org, robh+dt@kernel.org, joro@8bytes.org,
 robin.murphy@arm.com
Subject: [PATCH v2 0/3] Request direct mapping for modem device
Date: Tue, 17 Mar 2020 20:39:07 +0530
Message-Id: <20200317150910.26053-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Cc: ohad@wizery.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dianders@chromium.org, iommu@lists.linux-foundation.org, agross@kernel.org,
 Sibi Sankar <sibis@codeaurora.org>
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

The Q6 modem sub-system has direct access to DDR through memnoc and
an indirect access routed through a SMMU which MSS CE (crypto engine
sub-component of MSS) uses during out of reset sequence. Request direct
mapping for the modem device since smmu is not expected to provide access
control/translation for these SIDs (sandboxing of the modem is achieved
through XPUs engaged using SMC calls). This is done on platforms which
don't have TrustZone (which programs the modem SIDs) to prevent the
following global faults seen on Cheza/Trogdor:

Cheza:
arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
arm-smmu 15000000.iommu: GFSR 0x80000002, GFSYNR0 0x00000000,
			 GFSYNR1 0x00000781, GFSYNR2 0x00000000

Trogdor:
arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
arm-smmu 15000000.iommu: GFSR 0x80000002, GFSYNR0 0x00000000,
			 GFSYNR1 0x00000461, GFSYNR2 0x00000000

V2:
 * Request direct mapping from SoC-specific corner of the SMMU
   driver [Robin]
 * Add iommu property to remoteproc modem node on Cheza

Depends on:
https://lore.kernel.org/patchwork/cover/1183528/

Sibi Sankar (3):
  dt-bindings: remoteproc: qcom: Add iommus property
  remoteproc: qcom_q6v5_mss: Request direct mapping for modem device
  arm64: dts: qcom: sdm845-cheza: Add iommus property

 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 3 +++
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                 | 4 ++++
 drivers/iommu/arm-smmu-qcom.c                              | 6 ++++++
 3 files changed, 13 insertions(+)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
