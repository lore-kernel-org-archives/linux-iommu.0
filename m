Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65314C433E0
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 21:52:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1A922573
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 21:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1A922573
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 896BB203BE;
	Mon, 25 Jan 2021 21:52:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Tq5HjPZZbvR; Mon, 25 Jan 2021 21:52:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 02AA420368;
	Mon, 25 Jan 2021 21:52:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9978C0FA7;
	Mon, 25 Jan 2021 21:52:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5284C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 21:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B34D5870D0
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 21:52:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rl1j8YokRRki for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 21:52:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-8.mailgun.net (m42-8.mailgun.net [69.72.42.8])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3848487098
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 21:52:45 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1611611567; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=wjOwZ7hnkSut6Udf2hJQbonOlbKoFsbqZco5e9Oswzk=;
 b=R4CjTIgLgVv7s5Hwscw4KturdfzIOvAzA1tYrACXufG7GtQC7hIP8mdKPj+4xdX42kK3+7FD
 2Nu88tc2sBB+ky8xa4fYxdnBSo3zyVwX6IrcM+yxtyUuQKsK0lGPb20JHZ/zVigRmudPiznC
 GeVp+hPhfagAKbO8wy7E0XqWJD4=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 600f3da0fb02735e8c23fbb0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 25 Jan 2021 21:52:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 31C17C43463; Mon, 25 Jan 2021 21:52:32 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id EB1D3C433CA;
 Mon, 25 Jan 2021 21:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB1D3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 bjorn.andersson@linaro.org
Subject: [PATCH] iommu/arm-smmu-qcom: Fix mask extraction for bootloader
 programmed SMRs
Date: Mon, 25 Jan 2021 13:52:25 -0800
Message-Id: <1611611545-19055-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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

When extracting the mask for a SMR that was programmed by the
bootloader, the SMR's valid bit is also extracted and is treated
as part of the mask, which is not correct. Consider the scenario
where an SMMU master whose context is determined by a bootloader
programmed SMR is removed (omitting parts of device/driver core):

->iommu_release_device()
 -> arm_smmu_release_device()
  -> arm_smmu_master_free_smes()
   -> arm_smmu_free_sme() /* Assume that the SME is now free */
   -> arm_smmu_write_sme()
    -> arm_smmu_write_smr() /* Construct SMR value using mask and SID */

Since the valid bit was considered as part of the mask, the SMR will
be programmed as valid.

Fix the SMR mask extraction step for bootloader programmed SMRs
by masking out the valid bit when we know that we're already
working with a valid SMR.

Fixes: 07a7f2caaa5a ("iommu/arm-smmu-qcom: Read back stream mappings")
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Cc: stable@vger.kernel.org
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index bcda170..abb1d2f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -206,6 +206,8 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
 
 		if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
+			/* Ignore valid bit for SMR mask extraction. */
+			smr &= ~ARM_SMMU_SMR_VALID;
 			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
 			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
 			smmu->smrs[i].valid = true;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
