Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D14BC352A3
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 20:56:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4BD720848
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 20:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BD720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B53F98623F;
	Thu, 13 Feb 2020 20:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CNiyOode5BVq; Thu, 13 Feb 2020 20:56:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 18D8886239;
	Thu, 13 Feb 2020 20:56:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFAECC07FE;
	Thu, 13 Feb 2020 20:56:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39A14C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 20:56:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 23F9686239
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 20:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lIuK1oisreFu for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 20:56:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8EF3E86228
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 20:56:02 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id p8so6951500oth.10
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 12:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8T4KZ9WPX/QG720bALpUhREygAU9QP3LfeGnDm+c2RA=;
 b=BWDDgHgvgpbEiitYunjLSOK/EZv4V20YsWFXgHUlrmpEXE6Ugke10fui+1SWUL3iPU
 bjDILov0F67EXxcBU5rNVrf19tBX7OYdr4gFk2TWtNM55gS99GvkBSpTq+RFAW/5d88o
 7daTU8DL+K2SrpA6YnB1wJ5bpxUbVR4Tg/uoDQE8WqB8vgeAiYQvUy+yWUq2NgBaaHbs
 W4zN+DRAXwAHEDch3OynP2Ilc98z0ySZZIi+pbaTttU+i+OrvLbTXdfpekYGCCRWl2sn
 YJUhzcUInALYjoTTz27bAlUP6yj02LKQ6Y9c6UkhDotTbUkr20Emg1du9Uib59vIIrPB
 yShg==
X-Gm-Message-State: APjAAAW3yyuWBSDbHms7hEKdqcTgebMN3m2QoqF0Z3S4329yXBy60UgU
 xZF7/5IgE13/tQ5KPe4nonE7aYg=
X-Google-Smtp-Source: APXvYqyjQU7dv79E9GbBxsmRvWQGcRrem7mUgXwGmLPvnHpl2Xl7OXrwF+Jt97aDkPa6p9cgvuSJFg==
X-Received: by 2002:a9d:7e99:: with SMTP id m25mr14436716otp.212.1581627361538; 
 Thu, 13 Feb 2020 12:56:01 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id t131sm1051285oih.35.2020.02.13.12.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 12:56:01 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2] iommu/arm-smmu-v3: Batch ATC invalidation commands
Date: Thu, 13 Feb 2020 14:56:00 -0600
Message-Id: <20200213205600.19690-1-robh@kernel.org>
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

As there is only one caller of arm_smmu_atc_inv_master() left, we can
simplify it and avoid passing in struct arm_smmu_cmdq_ent.

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Simplify arm_smmu_atc_inv_master()
 - Rebase on v5.6-rc1

 drivers/iommu/arm-smmu-v3.c | 38 ++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index aa3ac2a03807..8161d9e6c068 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2132,17 +2132,16 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
-static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
-				   struct arm_smmu_cmdq_ent *cmd)
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 {
 	int i;
+	struct arm_smmu_cmdq_ent cmd;
 
-	if (!master->ats_enabled)
-		return 0;
+	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
 
 	for (i = 0; i < master->num_sids; i++) {
-		cmd->atc.sid = master->sids[i];
-		arm_smmu_cmdq_issue_cmd(master->smmu, cmd);
+		cmd.atc.sid = master->sids[i];
+		arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
 	}
 
 	return arm_smmu_cmdq_issue_sync(master->smmu);
@@ -2151,10 +2150,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
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
@@ -2179,11 +2179,25 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
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
@@ -2611,7 +2625,6 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 
 static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 {
-	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (!master->ats_enabled)
@@ -2623,8 +2636,7 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation via the SMMU.
 	 */
 	wmb();
-	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
-	arm_smmu_atc_inv_master(master, &cmd);
+	arm_smmu_atc_inv_master(master);
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
