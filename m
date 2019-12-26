Return-Path: <SRS0=Rrtl=2Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40418C2D0C0
	for <iommu@archiver.kernel.org>; Thu, 26 Dec 2019 22:23:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033B1206CB
	for <iommu@archiver.kernel.org>; Thu, 26 Dec 2019 22:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQmFVNA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033B1206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BE25C20518;
	Thu, 26 Dec 2019 22:23:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id phsA38D+z9Dx; Thu, 26 Dec 2019 22:23:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1A3C4204A9;
	Thu, 26 Dec 2019 22:23:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC690C18DD;
	Thu, 26 Dec 2019 22:23:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CB5AC0881
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 22:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1518D85188
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 22:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iEp6nWDmWtbc for <iommu@lists.linux-foundation.org>;
 Thu, 26 Dec 2019 22:23:26 +0000 (UTC)
X-Greylist: delayed 00:05:41 by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2F89585239
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 22:23:26 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id y8so10941493pll.13
 for <iommu@lists.linux-foundation.org>; Thu, 26 Dec 2019 14:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tubUT90M6ZUsQq/NCNWX8+4auD3W82M3BMPow6ghbj8=;
 b=UQmFVNA7UILTF3d5FkPUjDuMXwndbRHZm1U93zjabv/K6dGhtSfmt4s9JIg+xMq75d
 Y23XDZw4It10l4QHXqaDJ2gjQ7UgsgsYKUABY6o6xlTM6PcI9JGpvxzOiNBkPbauQJQX
 rOb03V74Q2iuvkeRbjoJ25qWSvTN+tewTjT3wPd/ueVoyCzibclmSE33cOkd0g/LLhFE
 PwN21iKGHN6E0QaX+a9jOmpxp/0FWhAO0E6515STbaiPfJvHp37nOVMDlntvCQ+pVwZD
 /Ct2qloyyzoXbev8IsVQDmVybAPP5fOQHljHSIHCexni+dNs47E8KE1BxAOlCHWLI6ls
 AFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tubUT90M6ZUsQq/NCNWX8+4auD3W82M3BMPow6ghbj8=;
 b=gpK6zOQW35iOTA9Xx02tgc4jMq2VmjpFwiBQkwAVXIlTZYAMMlZ/aUso1Cxr86vzJC
 F1/4GHwgPYnP0E2rRUzX4adnIpo3gxjrevXZUOGIh1bMA+fIg48L/prfnsN6sI+nfgul
 RgXQrNpx87rhBf+4PGvJyZqTu8+u8+ZZkdGf0oLPn8rttVpqVDCrM+6DS01N3c3HM85E
 fuJWlvvBrdzMhuStocTRHURDXpe68RXrqhPd04LxpiWDdhJ49v+AyoWEhbwBq7CVFBT4
 NZh2iyKiqH07e0zE8dD3rpSIe0yU4TXbZ55JZKFzD88ymsVyzd/Q2W1+lBO/ZcahkS2j
 Y2VQ==
X-Gm-Message-State: APjAAAWkjxqFzpzgHwWPMgp3Fx3bl8D7g7yNoyoG0iqC9Y2J9JHAmf2g
 OhXobAOt/AdoW2e1PnzpgPzJ3A==
X-Google-Smtp-Source: APXvYqzsnGwMryOZ8OSkxJxnL0bgVLu9XUOFhXRRLNcQ4apGus/dVePA/bPEIWlQsBQNQtZUk1Rydw==
X-Received: by 2002:a17:90a:9f04:: with SMTP id
 n4mr22039896pjp.76.1577398665952; 
 Thu, 26 Dec 2019 14:17:45 -0800 (PST)
Received: from localhost.localdomain
 (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id 2sm11779409pjh.19.2019.12.26.14.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2019 14:17:45 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/3] iommu/arm-smmu: Don't blindly use first SMR to calculate
 mask
Date: Thu, 26 Dec 2019 14:17:07 -0800
Message-Id: <20191226221709.3844244-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
References: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: Patrick Daly <pdaly@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Pratik Patel <pratikp@codeaurora.org>, linux-arm-kernel@lists.infradead.org
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

With the SMRs inherited from the bootloader the first SMR might actually
be valid and in use. As such probing the SMR mask using the first SMR
might break a stream in use. Search for an unused stream and use this to
probe the SMR mask.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since RFC:
- Deal with EXIDS
- Use arm_smmu_gr0_read/write()

 drivers/iommu/arm-smmu.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4f1a350d9529..6ca6a4e072c8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -945,24 +945,43 @@ static void arm_smmu_write_sme(struct arm_smmu_device *smmu, int idx)
  */
 static void arm_smmu_test_smr_masks(struct arm_smmu_device *smmu)
 {
+	u32 s2cr;
 	u32 smr;
+	int idx;
 
 	if (!smmu->smrs)
 		return;
 
+	for (idx = 0; idx < smmu->num_mapping_groups; idx++) {
+		if (smmu->features & ARM_SMMU_FEAT_EXIDS) {
+			s2cr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_S2CR(idx));
+			if (!FIELD_GET(S2CR_EXIDVALID, s2cr))
+				break;
+		} else {
+			smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(idx));
+			if (!FIELD_GET(SMR_VALID, smr))
+				break;
+		}
+	}
+
+	if (idx == smmu->num_mapping_groups) {
+		dev_err(smmu->dev, "Unable to compute streamid_mask\n");
+		return;
+	}
+
 	/*
 	 * SMR.ID bits may not be preserved if the corresponding MASK
 	 * bits are set, so check each one separately. We can reject
 	 * masters later if they try to claim IDs outside these masks.
 	 */
 	smr = FIELD_PREP(SMR_ID, smmu->streamid_mask);
-	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_SMR(0), smr);
-	smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(0));
+	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_SMR(idx), smr);
+	smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(idx));
 	smmu->streamid_mask = FIELD_GET(SMR_ID, smr);
 
 	smr = FIELD_PREP(SMR_MASK, smmu->streamid_mask);
-	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_SMR(0), smr);
-	smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(0));
+	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_SMR(idx), smr);
+	smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(idx));
 	smmu->smr_mask_mask = FIELD_GET(SMR_MASK, smr);
 }
 
-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
