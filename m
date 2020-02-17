Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10C9C34024
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 18:29:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC1424656
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 18:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtlZm5C8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC1424656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 98F962042B;
	Mon, 17 Feb 2020 18:29:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KOtaPG+TBVpV; Mon, 17 Feb 2020 18:29:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 902E520009;
	Mon, 17 Feb 2020 18:29:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77905C08A0;
	Mon, 17 Feb 2020 18:29:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 152F3C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 18:29:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 10BA486E1A
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 18:29:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jm3I2SFXx7P5 for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 18:29:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D517786DAD
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 18:29:28 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id a5so323811wmb.0
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 10:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qgbH6DAhDEcjUIoTkC0vIf476YB12oIaCGkw17tdaOk=;
 b=qtlZm5C8jXyjJjOg6IbqpV8KD54qXiTLQcDnwQ/W57TA3fWjbvwv6Iv2AZyBV9TfY8
 Izy1q1hmXeRt+8FKVC96d77+U9eiVlmcnrNqgVmllsNiNxIjKBrbSr9VYCixuKVo8YNM
 cDHIkig1xpdp1IM31757Mw3CnfWBbTLWkzvY9G9c52sI4t1qPtZfwihR5sEdkXStvIY+
 i44zIYWQPoi/tmaeqKFh7hcfUvBhQoRyZd3BFLklOH6V6IlRq+cUBFB7ety+3qe6FHgb
 Jq/8DHo/EusV2DaOJQZoMtRZksN4raEB2O3/yFikBeucz4uaUGb/x2h/U7yqG/PB4Bz2
 FpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qgbH6DAhDEcjUIoTkC0vIf476YB12oIaCGkw17tdaOk=;
 b=JETRad3wNyxhRv/QhOByDWPPE20MGarFrbjG5DtU39LnzjKrvIWgJ+/Nhe7S0ba8Vf
 WU6rCWr7onhLCksjuyIlWM6sFM2e7Zb0GS+d61fE2bWh0Rdkb8ap88mLJofeD6Thz70d
 4DFDIiZQEg9x8vcy7ziq1T0JIWS6g5hwxP/UuZR8emU1y6yhwoFfMF1K7QgCMeSY+DEu
 a+Dcz7MZYALEMAkk1XG1hm6YzU9mYHms/5dRsEtUNPQQYO7k1SIbZF5mjkBO1XUWAKZZ
 KIeSLzqbbjeLXrJVHg/Y9scYEWem0WAONMJakKf2gBx1ro8IGRf8zTfgl2WFxHb9S8h+
 UsFg==
X-Gm-Message-State: APjAAAUNUP3kNUYnkfs5vYnkOreLQiLzKho2kmUETkqP/KJ1WX5cD2bx
 3I5XyUhDWHtcyCWYHQ/q+MDnrw==
X-Google-Smtp-Source: APXvYqyaMD0oVCsJvrATvvKvPscfu239rotGRZo42mMqwnmR3xag2jXnV5T+04JDoRGRVmHimJbRcA==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr257638wmg.147.1581964167153;
 Mon, 17 Feb 2020 10:29:27 -0800 (PST)
Received: from myrica ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y8sm330395wma.10.2020.02.17.10.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 10:29:26 -0800 (PST)
Date: Mon, 17 Feb 2020 19:29:18 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Batch ATC invalidation commands
Message-ID: <20200217182918.GE1650092@myrica>
References: <20200213205600.19690-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20200213205600.19690-1-robh@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2020 at 02:56:00PM -0600, Rob Herring wrote:
> Similar to commit 2af2e72b18b4 ("iommu/arm-smmu-v3: Defer TLB
> invalidation until ->iotlb_sync()"), build up a list of ATC invalidation
> commands and submit them all at once to the command queue instead of
> one-by-one.
> 
> As there is only one caller of arm_smmu_atc_inv_master() left, we can
> simplify it and avoid passing in struct arm_smmu_cmdq_ent.
> 
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


Since I'm adding a third user of cmdq batching [1], I had a go at
factoring them. I can send the attached patch with my next version, if it
looks OK.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/20200213101435.229932-4-jean-philippe@linaro.org/


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-iommu-arm-smmu-v3-Factor-command-queue-batching.patch"

From b304f322e6293be4ec8b5a01e2ef67e8fa34143c Mon Sep 17 00:00:00 2001
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Mon, 17 Feb 2020 17:42:54 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Factor command queue batching

Factor the code for command queue batching, which is now repeated three
times for TLB, ATC and CFG invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 66 +++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 45da5c251b65..04c3077589be 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -548,6 +548,11 @@ struct arm_smmu_cmdq {
 	atomic_t			lock;
 };
 
+struct arm_smmu_cmdq_batch {
+	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
+	int				num;
+};
+
 struct arm_smmu_evtq {
 	struct arm_smmu_queue		q;
 	u32				max_stalls;
@@ -1482,15 +1487,33 @@ static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
 }
 
+static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
+				    struct arm_smmu_cmdq_batch *cmds,
+				    struct arm_smmu_cmdq_ent *cmd)
+{
+	if (cmds->num == CMDQ_BATCH_ENTRIES) {
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
+		cmds->num = 0;
+	}
+	arm_smmu_cmdq_build_cmd(&cmds->cmds[cmds->num * CMDQ_ENT_DWORDS], cmd);
+	cmds->num++;
+}
+
+static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
+				      struct arm_smmu_cmdq_batch *cmds)
+{
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+}
+
+
 /* Context descriptor manipulation functions */
 static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 			     int ssid, bool leaf)
 {
 	size_t i;
-	int cmdn = 0;
 	unsigned long flags;
 	struct arm_smmu_master *master;
-	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
+	struct arm_smmu_cmdq_batch cmds = {};
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_CD,
@@ -1503,19 +1526,13 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
 		for (i = 0; i < master->num_sids; i++) {
-			if (cmdn == CMDQ_BATCH_ENTRIES) {
-				arm_smmu_cmdq_issue_cmdlist(smmu, cmds, cmdn, false);
-				cmdn = 0;
-			}
-
 			cmd.cfgi.sid = master->sids[i];
-			arm_smmu_cmdq_build_cmd(&cmds[cmdn * CMDQ_ENT_DWORDS], &cmd);
-			cmdn++;
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 		}
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	arm_smmu_cmdq_issue_cmdlist(smmu, cmds, cmdn, true);
+	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
 static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
@@ -2160,11 +2177,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 				   int ssid, unsigned long iova, size_t size)
 {
-	int i, cmdn = 0;
+	int i;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
-	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
+	struct arm_smmu_cmdq_batch cmds = {};
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
 		return 0;
@@ -2194,20 +2211,13 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 			continue;
 
 		for (i = 0; i < master->num_sids; i++) {
-			if (cmdn == CMDQ_BATCH_ENTRIES) {
-				arm_smmu_cmdq_issue_cmdlist(smmu_domain->smmu,
-					cmds, cmdn, false);
-				cmdn = 0;
-			}
-
 			cmd.atc.sid = master->sids[i];
-			arm_smmu_cmdq_build_cmd(&cmds[cmdn * CMDQ_ENT_DWORDS], &cmd);
-			cmdn++;
+			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
 		}
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	return arm_smmu_cmdq_issue_cmdlist(smmu_domain->smmu, cmds, cmdn, true);
+	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
 }
 
 /* IO_PGTABLE API */
@@ -2242,10 +2252,9 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 				   size_t granule, bool leaf,
 				   struct arm_smmu_domain *smmu_domain)
 {
-	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	unsigned long start = iova, end = iova + size;
-	int i = 0;
+	struct arm_smmu_cmdq_batch cmds = {};
 	struct arm_smmu_cmdq_ent cmd = {
 		.tlbi = {
 			.leaf	= leaf,
@@ -2264,18 +2273,11 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 	}
 
 	while (iova < end) {
-		if (i == CMDQ_BATCH_ENTRIES) {
-			arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, false);
-			i = 0;
-		}
-
 		cmd.tlbi.addr = iova;
-		arm_smmu_cmdq_build_cmd(&cmds[i * CMDQ_ENT_DWORDS], &cmd);
+		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 		iova += granule;
-		i++;
 	}
-
-	arm_smmu_cmdq_issue_cmdlist(smmu, cmds, i, true);
+	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 
 	/*
 	 * Unfortunately, this can't be leaf-only since we may have
-- 
2.25.0


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--ew6BAiZeqk4r7MaW--
