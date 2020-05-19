Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9BCC433F8
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D952720873
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GIa5rX/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D952720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C948786D88;
	Tue, 19 May 2020 18:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t9t6S91XxtC0; Tue, 19 May 2020 18:02:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1961B86D6B;
	Tue, 19 May 2020 18:02:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F401CC0891;
	Tue, 19 May 2020 18:02:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B893CC088F
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A5BB088070
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L6Sii4boVq1E for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 18:02:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9507388051
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:03 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id z4so174466wmi.2
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NGZBqF0MKtBmW3+eHctFURo6Y3LrBwBhNb0YCIPd+HA=;
 b=GIa5rX/V8vIRUfbiSlnvp1rb1ufNakvQ3BYq7CuxJ+6y04cFET10DnyGSuz8dr3ewS
 JGseTTPXmL7lwcTCfvuDUhqkNilVMaDjuQ//i6hqiluDgcT0daJQF0ZXvlOgKbk9wkOW
 1jRPjJj48+VVv/cC08UVBJb93oXj9wXN1497znOMJqUBmpgLrzIA+Ph396uYjUQPVZbX
 AIaX+B5fwrmyfAF/BmsLI+gJYujooLP1Tp7H/jLQePAYx8ysxfvr0p+lJL0LQfiJWnwA
 B4yKFupzyAMy9bWEGLeMFauoiCf9VF4iQMiMpH4CwZAX+jVasWUxjcfoRlCPBeIBUx3y
 3+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NGZBqF0MKtBmW3+eHctFURo6Y3LrBwBhNb0YCIPd+HA=;
 b=JBfgstxBafmGSM8mSRLv9yYPFcPThwpFt89O+D8t1+WsK0CjJKzooTe5SlM0oxzr89
 53xGOBgYjb6tL4sB/IvuOv+5RGl4Cstyq5nfoRDyULBJQSbKW6VVa9EBAS/+CcCd8joh
 0Pb64krsFQ49t6vZloVdUTYXa6nKK0p0TqB/6LUucbAIbL1ptJRr/1NhvrOnyCUwKcIH
 83gEYUzSRGyQZ0z2+CoYWVKy1zQrUpQnKY+YTfdZM5tzxn8s5T1ZmtGp1NptjcOfTGkR
 vpLM1IOyZdqS3/M40E2a5EUra6dBsRQNbpif6zAufAzy9GiAXO2+zBEAPrEIE+bBAifg
 /xuw==
X-Gm-Message-State: AOAM531Fat9vUEOcjk0RUeXLyOYAYRDGO/740q53MOQKoLf3+6ZpImio
 CP8CFco1t64RyZhyBazfzO3UNQPghiIRIQ==
X-Google-Smtp-Source: ABdhPJzkEAJ1N27WjhAzpGiM0SWJrYRN6tSSh0kfb4HAwQvH5gMWf60VDilJ/HWg5+gL5FnDijwbkw==
X-Received: by 2002:a1c:49:: with SMTP id 70mr569224wma.184.1589911321556;
 Tue, 19 May 2020 11:02:01 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:02:01 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v7 17/24] iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
Date: Tue, 19 May 2020 19:54:55 +0200
Message-Id: <20200519175502.2504091-18-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 felix.kuehling@amd.com, will@kernel.org, christian.koenig@amd.com
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

The invalidate_range() notifier is called for any change to the address
space. Perform the required ATC invalidations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v6->v7: invalidate() doesn't need RCU protection anymore.
---
 drivers/iommu/arm-smmu-v3.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 00a9342eed99..1386d4d2bc60 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2392,6 +2392,20 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	size_t inval_grain_shift = 12;
 	unsigned long page_start, page_end;
 
+	/*
+	 * ATS and PASID:
+	 *
+	 * If substream_valid is clear, the PCIe TLP is sent without a PASID
+	 * prefix. In that case all ATC entries within the address range are
+	 * invalidated, including those that were requested with a PASID! There
+	 * is no way to invalidate only entries without PASID.
+	 *
+	 * When using STRTAB_STE_1_S1DSS_SSID0 (reserving CD 0 for non-PASID
+	 * traffic), translation requests without PASID create ATC entries
+	 * without PASID, which must be invalidated with substream_valid clear.
+	 * This has the unpleasant side-effect of invalidating all PASID-tagged
+	 * ATC entries within the address range.
+	 */
 	*cmd = (struct arm_smmu_cmdq_ent) {
 		.opcode			= CMDQ_OP_ATC_INV,
 		.substream_valid	= !!ssid,
@@ -2435,12 +2449,12 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	cmd->atc.size	= log2_span;
 }
 
-static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
+static int arm_smmu_atc_inv_master(struct arm_smmu_master *master, int ssid)
 {
 	int i;
 	struct arm_smmu_cmdq_ent cmd;
 
-	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
+	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
 	for (i = 0; i < master->num_sids; i++) {
 		cmd.atc.sid = master->sids[i];
@@ -2968,7 +2982,7 @@ static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation via the SMMU.
 	 */
 	wmb();
-	arm_smmu_atc_inv_master(master);
+	arm_smmu_atc_inv_master(master, 0);
 	atomic_dec(&smmu_domain->nr_ats_masters);
 }
 
@@ -3169,7 +3183,10 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 					 struct mm_struct *mm,
 					 unsigned long start, unsigned long end)
 {
-	/* TODO: invalidate ATS */
+	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
+
+	arm_smmu_atc_inv_domain(smmu_mn->domain, mm->pasid, start,
+				end - start + 1);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -3190,7 +3207,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &invalid_cd);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	/* TODO: invalidate ATS */
+	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -3281,7 +3298,7 @@ void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 */
 	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		/* TODO: invalidate ATS */
+		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 	}
 
 	/* Frees smmu_mn */
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
