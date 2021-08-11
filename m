Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E57C43214
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 11:55:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C8FD60F55
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 11:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C8FD60F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9AC5401D7;
	Wed, 11 Aug 2021 11:55:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hw-t9VPpYl-T; Wed, 11 Aug 2021 11:55:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B0C9840393;
	Wed, 11 Aug 2021 11:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B018C0010;
	Wed, 11 Aug 2021 11:55:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D61C3C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 11:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7A1340172
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 11:55:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VUzgpobKYuEc for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 11:55:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB72740393
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 11:55:13 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gl7Xq0vdhz1CVgS;
 Wed, 11 Aug 2021 19:54:51 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 19:55:05 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 19:55:05 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] iommu/arm-smmu-v3: Add and use static helper function
 arm_smmu_cmdq_issue_cmd_with_sync()
Date: Wed, 11 Aug 2021 19:48:50 +0800
Message-ID: <20210811114852.2429-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210811114852.2429-1-thunder.leizhen@huawei.com>
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

The obvious key to the performance optimization of commit 587e6c10a7ce
("iommu/arm-smmu-v3: Reduce contention during command-queue insertion") is
to allow multiple cores to insert commands in parallel after a brief mutex
contention.

Obviously, inserting as many commands at a time as possible can reduce the
number of times the mutex contention participates, thereby improving the
overall performance. At least it reduces the number of calls to function
arm_smmu_cmdq_issue_cmdlist().

Therefore, function arm_smmu_cmdq_issue_cmd_with_sync() is added to insert
the 'cmd+sync' commands at a time.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c81cd929047f573..282f95659580267 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -845,8 +845,9 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	return ret;
 }
 
-static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
-				   struct arm_smmu_cmdq_ent *ent)
+static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
+				     struct arm_smmu_cmdq_ent *ent,
+				     bool sync)
 {
 	u64 cmd[CMDQ_ENT_DWORDS];
 
@@ -856,12 +857,19 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 		return -EINVAL;
 	}
 
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, false);
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, sync);
 }
 
-static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
+static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
+				   struct arm_smmu_cmdq_ent *ent)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
+	return __arm_smmu_cmdq_issue_cmd(smmu, ent, false);
+}
+
+static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
+					     struct arm_smmu_cmdq_ent *ent)
+{
+	return __arm_smmu_cmdq_issue_cmd(smmu, ent, true);
 }
 
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
@@ -929,8 +937,7 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 		.tlbi.asid = asid,
 	};
 
-	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
+	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }
 
 static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
@@ -1211,8 +1218,7 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 		},
 	};
 
-	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
+	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }
 
 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
@@ -1824,8 +1830,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-		arm_smmu_cmdq_issue_sync(smmu);
+		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 	}
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
 }
@@ -3339,18 +3344,16 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 	/* Invalidate any cached configuration */
 	cmd.opcode = CMDQ_OP_CFGI_ALL;
-	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
+	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 
 	/* Invalidate any stale TLB entries */
 	if (smmu->features & ARM_SMMU_FEAT_HYP) {
 		cmd.opcode = CMDQ_OP_TLBI_EL2_ALL;
-		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 	}
 
 	cmd.opcode = CMDQ_OP_TLBI_NSNH_ALL;
-	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
+	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 
 	/* Event queue */
 	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-- 
2.26.0.106.g9fadedd

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
