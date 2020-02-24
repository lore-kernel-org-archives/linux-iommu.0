Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42817C11D34
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1496920880
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cYA2Ki37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1496920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E671220505;
	Mon, 24 Feb 2020 16:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qfmawbqngp76; Mon, 24 Feb 2020 16:59:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 42E2820507;
	Mon, 24 Feb 2020 16:59:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ABBBC18DA;
	Mon, 24 Feb 2020 16:59:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61677C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5CDD48602E
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tExTlyzwXXkU for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 16:59:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7BCE8861D2
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:07 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id s144so313061wme.1
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XLHzcG1rM7CKaHACIaWqlr851SfTiMG1TWiRRSjmhnI=;
 b=cYA2Ki3712y1AnkYyhSFyI0gPtpDlkJM+1q36yhaQXLM5yHq3MpQEGpQGFn5acTJNq
 F0BBJHCxoFTbdxkeT2vlUqDSU2bBZcU0lb8elvwHyd4Vg/zVkkyjhd5+jJVBYTxNoe/1
 T887AvB5daQAFRCqRCHFVryjl79Ik52OOPX76rCW6nsW+PTelLhaY0/XaXm/hm7XJZOT
 bDtyCARPGJe9qEjvAqV4E1zbPS4JHztKZyP48RYwOQ+6UtYGoT41rVTvmBpGTezTRswQ
 jOK+z0mNca9ZAwbWfU/DpnD214mbXaRo45wfSK3F3fh4dc+SQHsQqOySm7gSx2MTFu0R
 hVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XLHzcG1rM7CKaHACIaWqlr851SfTiMG1TWiRRSjmhnI=;
 b=ZltjG7EdJPvo75hC2HIV7/yetKdvprCkJ2bW42+YTqUmngwhUh77+FZHbXxFS486k8
 /d7RDS9eePtetNCMa4v0wW8xPxFxfeR5YDJVK9eEmGRoqoJPTQI1G5fnjUyQId1JLFJm
 Iy5sIUHfp4ucn64dHrwx+Y9UMZGQoYT9qL+/BR8pKaIB9EkR7t8hpdSS+KguAjaIy2jO
 ZxlEFT9HifJS/yv+p4ya9IBTllFpjpa3gZhH472boU4KJMyjd2OaUNM5pW6li5S4+Wt6
 oIAsTvzdAAg6GczJsHp+O0M6ILpmz6WeO1JOCAyq9olN8tBJqqLxzsQbJRC6A7w7LREP
 pSoQ==
X-Gm-Message-State: APjAAAUrh012tVmdWBOXcW4SwbYqzca1aA6FqJKXanVlr9GWHiAXLmt9
 R5Os/qdjUqttdjmPpkAf86cDFA==
X-Google-Smtp-Source: APXvYqyAQvDHFPlwol084YtmoxeK9ALvce8BoTf5MrLynyThLVJi07+L0kfZvMdagU1zen+M1p+zPA==
X-Received: by 2002:a7b:c088:: with SMTP id r8mr33668wmh.18.1582563545996;
 Mon, 24 Feb 2020 08:59:05 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b10sm19473978wrt.90.2020.02.24.08.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 08:59:05 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, will@kernel.org, bhelgaas@google.com
Subject: [PATCH v2 4/6] iommu/arm-smmu-v3: Add command queue batching helpers
Date: Mon, 24 Feb 2020 17:58:44 +0100
Message-Id: <20200224165846.345993-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224165846.345993-1-jean-philippe@linaro.org>
References: <20200224165846.345993-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: zhangfei.gao@linaro.org, robin.murphy@arm.com, robh@kernel.org
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

As more functions will implement command queue batching, add two helpers
to simplify building a command list.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 068a16d0eabe..beeec366bc41 100644
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
@@ -1482,6 +1487,24 @@ static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
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
 /* Context descriptor manipulation functions */
 static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 			     int ssid, bool leaf)
@@ -2220,10 +2243,9 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
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
@@ -2242,18 +2264,11 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
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

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
