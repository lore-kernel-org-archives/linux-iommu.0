Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6836C11D32
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA9720836
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 16:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVNhbcg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA9720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A6E1E87526;
	Mon, 24 Feb 2020 16:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fNmWaEHs9nVb; Mon, 24 Feb 2020 16:59:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BE5E086CD7;
	Mon, 24 Feb 2020 16:59:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACCA2C18DA;
	Mon, 24 Feb 2020 16:59:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D565AC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BEDF420505
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gcnRt8F35aGe for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 16:59:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 67A1C20507
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 16:59:09 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id t23so55548wmi.1
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8wR4JvjjnPlxADINM207T0IRGzt73ZsNoWPOZadfSNk=;
 b=MVNhbcg8wD57oQ9I2JyLERVR2yKCiLO+U8+KIMgmDXq5uE3Xz17SRqISJlYfd4ir0f
 R4kd49dYtzzGIjmUKtm2Nil6peOKseDxSX6LLgZymQYn3PjxOlFG7DMwufOltiWTpMwW
 nAvv/0bXQehpLWgHnz/JM8FzL1XTmsAaoNNKJDC2OGvlpi33JinznQOQFLaMEP8oSMB6
 p2D8+W5IrG6gxs6dgpvB2oEc9zTKeiWuWpX4iz8pcAiJETSzXOdN8W2cI7+0K3InfFhi
 mhvq6KoZzQD35eEblEKVN/M5SfSNB4cjLRfBZyi4z0D6gsum8FD4M5GXqNy0vqyUQ8Ek
 kgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8wR4JvjjnPlxADINM207T0IRGzt73ZsNoWPOZadfSNk=;
 b=T39cS7i0lCbE3Km/e5S/kCBVUjtsytD2710U3oxMNPYCVHJYCgCNbxmZzCnofCsHIC
 1F0J7vH506lb78SBHtMhyoQ0NlWFV+G6n0BgTzA3qRM1lPgu2cKIb8+UZXf183Xr+hta
 PBsVh76LO4eHijegYwxmJ7s9Hrv8dA9yLqQuBJzaX/Ss+q/L/3M5c41soPpivQqsu+xV
 qrTqjNfMxULUbOMKsRbyW0o5MkLj6i9QwI2bo+LYph0vfLdk5Equu9HyIq0kr4L5WEAQ
 ZjhQMnLGLveYGaDqEhLfgoiUqEpmgdRV0ZqMkdObqfR7W2aKYR8Ztg4CzxDWcsXAbLc1
 NnVw==
X-Gm-Message-State: APjAAAViD56Gh1heDZFElH3KCmavDD1yjaPbTGhtUPF/a3qLQm5kfYtY
 cre+cAhbLWdCAZpHugGQUlp8fQ==
X-Google-Smtp-Source: APXvYqy5NCQ4cadqxMUKN5tm7gQWKMw6tJ7/zLaq1h3uCOJopLS3L3IpJR06WXC/akjTuCTTeW4gnw==
X-Received: by 2002:a05:600c:54e:: with SMTP id
 k14mr22152694wmc.115.1582563547735; 
 Mon, 24 Feb 2020 08:59:07 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b10sm19473978wrt.90.2020.02.24.08.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 08:59:07 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, will@kernel.org, bhelgaas@google.com
Subject: [PATCH v2 6/6] iommu/arm-smmu-v3: Batch ATC invalidation commands
Date: Mon, 24 Feb 2020 17:58:46 +0100
Message-Id: <20200224165846.345993-7-jean-philippe@linaro.org>
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

From: Rob Herring <robh@kernel.org>

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
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 12b2a0fa747e..4f0a38dae6db 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2158,17 +2158,16 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
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
@@ -2177,10 +2176,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 				   int ssid, unsigned long iova, size_t size)
 {
-	int ret = 0;
+	int i;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
+	struct arm_smmu_cmdq_batch cmds = {};
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
 		return 0;
@@ -2205,11 +2205,18 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head)
-		ret |= arm_smmu_atc_inv_master(master, &cmd);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		if (!master->ats_enabled)
+			continue;
+
+		for (i = 0; i < master->num_sids; i++) {
+			cmd.atc.sid = master->sids[i];
+			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
+		}
+	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	return ret ? -ETIMEDOUT : 0;
+	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
 }
 
 /* IO_PGTABLE API */
@@ -2629,7 +2636,6 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 
 static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 {
-	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (!master->ats_enabled)
@@ -2641,8 +2647,7 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation via the SMMU.
 	 */
 	wmb();
-	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
-	arm_smmu_atc_inv_master(master, &cmd);
+	arm_smmu_atc_inv_master(master);
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
