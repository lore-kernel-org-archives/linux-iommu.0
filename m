Return-Path: <SRS0=W82T=3C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11186C33CAD
	for <iommu@archiver.kernel.org>; Mon, 13 Jan 2020 14:39:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E8D20678
	for <iommu@archiver.kernel.org>; Mon, 13 Jan 2020 14:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E8D20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A81E586762;
	Mon, 13 Jan 2020 14:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WZlf8Hs+0KrA; Mon, 13 Jan 2020 14:39:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 73E0F86187;
	Mon, 13 Jan 2020 14:39:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 578F1C18DD;
	Mon, 13 Jan 2020 14:39:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FAFDC077D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 14:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4600820417
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 14:39:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OxHGX1ZUGoOS for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jan 2020 14:39:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 8513C20411
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 14:39:08 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id z9so6991320oth.5
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 06:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VtgiiMw/nSVvHGkHXZg14Y2SSF3Fx9R0a3AgHhFUHIk=;
 b=kqLK5VRVd6xXkgoFAZtC6jxr13gfMHr34XiM6FIIaxvgw6Y1BeTqFaYvYWDTw0Q90G
 gJeDMGqti7zR/Ikex+tsWfKfPC9rodXOSoieqNXYF2Vyf7b7JRbHzE/cHtMtoraIti3I
 MHlH2XgchsKBuRpJabReeuL0zLap62xfemQiW34e66e5ZC9pcKdwaYJgvw2/cVpnhtlj
 AbPqnY7RXVtgUIKKuHIDvh0sEj4XaWAXvBBqdDSYyvEUIBQs120NsqxXghC1S0Sv+P72
 YzJisg3fdKIRG881YJZZIV7m893QgMQvIKeg9elNZqLJaY7baxm1o82N7SWFBqCx12Dy
 1Lig==
X-Gm-Message-State: APjAAAU/RtlulhCEd/JLqehAGJd7ZIo2zjcv2mZeWiwT/VYzBo0IQXX+
 +MGHfMisPwfw8ztQsa7/eoJ4Cjs=
X-Google-Smtp-Source: APXvYqx40v9ylI3py5hHwlwa3VsVzEwMz5HBJYylHRKFudS95stYyegw9PC7rrp0iP+RxFjgsgWYcw==
X-Received: by 2002:a9d:7e8a:: with SMTP id m10mr12380578otp.27.1578926347370; 
 Mon, 13 Jan 2020 06:39:07 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id m3sm4188519otf.13.2020.01.13.06.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 06:39:06 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/arm-smmu-v3: Batch ATC invalidation commands
Date: Mon, 13 Jan 2020 08:39:06 -0600
Message-Id: <20200113143906.11121-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Similar to commit 2af2e72b18b4 ("iommu/arm-smmu-v3: Defer TLB
invalidation until ->iotlb_sync()"), build up a list of ATC invalidation
commands and submit them all at once to the command queue instead of
one-by-one.

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index effe72eb89e7..e91b4a098215 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1919,10 +1919,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 				   int ssid, unsigned long iova, size_t size)
 {
-	int ret = 0;
+	int i, cmdn = 0;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
+	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
 		return 0;
@@ -1947,11 +1948,25 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head)
-		ret |= arm_smmu_atc_inv_master(master, &cmd);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		if (!master->ats_enabled)
+			continue;
+
+		for (i = 0; i < master->num_sids; i++) {
+			if (cmdn == CMDQ_BATCH_ENTRIES) {
+				arm_smmu_cmdq_issue_cmdlist(smmu_domain->smmu,
+					cmds, cmdn, false);
+				cmdn = 0;
+			}
+
+			cmd.atc.sid = master->sids[i];
+			arm_smmu_cmdq_build_cmd(&cmds[cmdn * CMDQ_ENT_DWORDS], &cmd);
+			cmdn++;
+		}
+	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	return ret ? -ETIMEDOUT : 0;
+	return arm_smmu_cmdq_issue_cmdlist(smmu_domain->smmu, cmds, cmdn, true);
 }
 
 /* IO_PGTABLE API */
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
