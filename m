Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F96C3B188
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 10:14:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA7D217F4
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 10:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ITOJlvKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA7D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AC98887F34;
	Thu, 13 Feb 2020 10:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Etv4ARUQoV97; Thu, 13 Feb 2020 10:14:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2FA2587ED2;
	Thu, 13 Feb 2020 10:14:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25A07C07FE;
	Thu, 13 Feb 2020 10:14:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AA9EC07FE
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EDCDB83531
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:14:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SLXPfSo9ui91 for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 10:14:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 49A7D83505
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:14:48 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id u6so5948090wrt.0
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 02:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y+lM1OggU9vK/FviSwCUPaJKK1SLUZczy02wSxpHTGA=;
 b=ITOJlvKtsqox/MA6KOfSi+vJ4namB81DtZOp6kWDIQxD7b+TlFocFAIVJlOuqeOJLw
 jnAwAYyOuE6iT1yKNsgrNsdlEVUXwo0f3f5XuFfWJeuedyhb6vC8ALBJtqp0b6WqHzE8
 qcrcDhLWP3E8SPA1MNxxhfnEcRr0f1sF8smyS60fScZh4qfp1bR0L2/19nrMx0VVcLtI
 R8R3J4ILmTuTwu4U4gig0mCX91+1y3N5G1JCG1U2azXLUt2MiXV280vRSIQCkl3byt1t
 V4PuXsmwZIfmXYs2bhHjNKBDr/fRVv7wge5cBW1xYX5hvuhkTT1LsLrJ04K0mX/sWEIs
 Z+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y+lM1OggU9vK/FviSwCUPaJKK1SLUZczy02wSxpHTGA=;
 b=siSGtPRJZLtRqViYk5IbA8ilkDOI+lXucVxYkF63yWbayT1uZOaapQKwCooy5nGZnC
 Lljwsgw7stxi1vHn8KtTAfwAcYww10ZGf1mqS+l3XFEOsqPIWLncu4dKwGmwAzEHhJWn
 a4zaotF9tDsljBtwf+t/Q82esZ+zyj1EN0Va6VxeO4jzVXPnelpvYxlKwkAEefgc0onm
 CsWiV39UfVb/YeiBeHr1kny8sE9TCs1OczSJcwHRTA3EaVicnJPV6Ih+WQa749RzXRpy
 0sPQZEcueii/dNDvMrIINVAvySf4G4AfpzaBGFt7XSeYL7/wcsRYJ4kn2Uf0ja2e+dO2
 j/1w==
X-Gm-Message-State: APjAAAU8XuZ2EraCncpDPYfE2rMKdFM/Ma1zHJwplnkba2xp49BLiS12
 +bYCWG6PB9rQVnRHl1mdGryxDQ==
X-Google-Smtp-Source: APXvYqyIF3pDX0A+K0urbcmvtOzcjcAguWoWW+hZyO7RemW9wjkDXElnYRLpdtxPkurp4xCvx2E5jQ==
X-Received: by 2002:adf:df90:: with SMTP id z16mr20487511wrl.273.1581588886767; 
 Thu, 13 Feb 2020 02:14:46 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y131sm2428059wmc.13.2020.02.13.02.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 02:14:46 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, will@kernel.org, bhelgaas@google.com
Subject: [PATCH 3/4] iommu/arm-smmu-v3: Batch context descriptor invalidation
Date: Thu, 13 Feb 2020 11:14:34 +0100
Message-Id: <20200213101435.229932-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213101435.229932-1-jean-philippe@linaro.org>
References: <20200213101435.229932-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: zhangfei.gao@linaro.org, robin.murphy@arm.com
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

Rather than publishing one command at a time when invalidating a context
descriptor, batch the commands for all SIDs in the domain.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 6b76df37025e..11123fbf22a5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1487,8 +1487,10 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 			     int ssid, bool leaf)
 {
 	size_t i;
+	int cmdn = 0;
 	unsigned long flags;
 	struct arm_smmu_master *master;
+	u64 cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_CD,
@@ -1501,13 +1503,19 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
 		for (i = 0; i < master->num_sids; i++) {
+			if (cmdn == CMDQ_BATCH_ENTRIES) {
+				arm_smmu_cmdq_issue_cmdlist(smmu, cmds, cmdn, false);
+				cmdn = 0;
+			}
+
 			cmd.cfgi.sid = master->sids[i];
-			arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+			arm_smmu_cmdq_build_cmd(&cmds[cmdn * CMDQ_ENT_DWORDS], &cmd);
+			cmdn++;
 		}
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	arm_smmu_cmdq_issue_sync(smmu);
+	arm_smmu_cmdq_issue_cmdlist(smmu, cmds, cmdn, true);
 }
 
 static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
