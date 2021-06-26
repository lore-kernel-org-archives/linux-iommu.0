Return-Path: <SRS0=OQ2u=LU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FC6C49EAF
	for <iommu@archiver.kernel.org>; Sat, 26 Jun 2021 11:02:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F2D61490
	for <iommu@archiver.kernel.org>; Sat, 26 Jun 2021 11:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F2D61490
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 897E7403F3;
	Sat, 26 Jun 2021 11:02:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jiybTxp53nLl; Sat, 26 Jun 2021 11:02:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1133A40435;
	Sat, 26 Jun 2021 11:02:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0CB4C002C;
	Sat, 26 Jun 2021 11:02:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFE73C000E
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 11:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A0F74029F
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 11:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LLSj7L13C2LW for <iommu@lists.linux-foundation.org>;
 Sat, 26 Jun 2021 11:02:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46023403B2
 for <iommu@lists.linux-foundation.org>; Sat, 26 Jun 2021 11:02:14 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GBrTm3lznzZj8Z;
 Sat, 26 Jun 2021 18:59:08 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:11 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:11 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC 6/8] iommu/arm-smmu-v3: Ensure that a set of associated
 commands are inserted in the same ECMDQ
Date: Sat, 26 Jun 2021 19:01:28 +0800
Message-ID: <20210626110130.2416-7-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210626110130.2416-1-thunder.leizhen@huawei.com>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
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

The SYNC command only ensures that the command that precedes it in the
same ECMDQ must be executed, but cannot synchronize the commands in other
ECMDQs. If an unmap involves multiple commands, some commands are executed
on one core, and the other commands are executed on another core. In this
case, after the SYNC execution is complete, the execution of all preceded
commands can not be ensured.

Prevent the process that performs a set of associated commands insertion
from being migrated to other cores ensures that all commands are inserted
into the same ECMDQ.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 40 +++++++++++++++++----
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d7b590e911a879d..d5205030710bd1a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -233,6 +233,18 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
 	return 0;
 }
 
+static void arm_smmu_preempt_disable(struct arm_smmu_device *smmu)
+{
+	if (smmu->ecmdq_enabled)
+		preempt_disable();
+}
+
+static void arm_smmu_preempt_enable(struct arm_smmu_device *smmu)
+{
+	if (smmu->ecmdq_enabled)
+		preempt_enable();
+}
+
 /* High-level queue accessors */
 static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 {
@@ -1016,6 +1028,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 		},
 	};
 
+	arm_smmu_preempt_disable(smmu);
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
 		for (i = 0; i < master->num_streams; i++) {
@@ -1026,6 +1039,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_preempt_enable(smmu);
 }
 
 static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
@@ -1814,30 +1828,36 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 
 static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 {
-	int i;
+	int i, ret;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds = {};
+	struct arm_smmu_device *smmu = master->smmu;
 
 	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
 
+	arm_smmu_preempt_disable(smmu);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
-		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
+		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 	}
 
-	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
+	ret = arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_preempt_enable(smmu);
+
+	return ret;
 }
 
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size)
 {
-	int i;
+	int i, ret;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
 	struct arm_smmu_cmdq_batch cmds = {};
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
+	if (!(smmu->features & ARM_SMMU_FEAT_ATS))
 		return 0;
 
 	/*
@@ -1859,6 +1879,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
+	arm_smmu_preempt_disable(smmu);
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
 		if (!master->ats_enabled)
@@ -1866,12 +1887,15 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
-			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 		}
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
+	ret = arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_preempt_enable(smmu);
+
+	return ret;
 }
 
 /* IO_PGTABLE API */
@@ -1924,6 +1948,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		num_pages = size >> tg;
 	}
 
+	arm_smmu_preempt_disable(smmu);
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 			/*
@@ -1955,6 +1980,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		iova += inv_range;
 	}
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_preempt_enable(smmu);
 }
 
 static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
-- 
2.26.0.106.g9fadedd


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
