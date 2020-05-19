Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4839EC43463
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A0720823
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="huY/boZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A0720823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 094EC86D6B;
	Tue, 19 May 2020 18:02:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xaLi1inut-wx; Tue, 19 May 2020 18:02:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0E07786D6E;
	Tue, 19 May 2020 18:02:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEB09C088F;
	Tue, 19 May 2020 18:02:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F9C1C0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3B5F88801A
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ibVcxSBZ4MIM for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 18:01:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9DFAF87ED9
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:01:57 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id j5so434419wrq.2
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 11:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XBKcHNY1n69RPE8RkPPU5z/rlngsZCnS/EuX/PAz4IU=;
 b=huY/boZ2R0L8m0KTImbAnN89+/2ewwTJYLMEBBCpcua+DalBUsakIScasPz1tAUdut
 jRLy3r1jNosv70oYwSU9jO/ND777I99T3vTcwtDuvS+z4ts3JBiyyelU4xrccZtfv65M
 OoGGVHnkE3+NYPIRcGlfJu3caej4l9TJmqKGkN/NstG1NCG63dxqwgHHgFCMfUm4mrj0
 z1oeTNy0tARikd0eyqDO4i543e7oQYPFKVv5hf9WWhxCUW3E5Cn6ju0kq0tTnDeE3Ux8
 tvYYtC0GsBVoEtefsfPtLyyXRmMJBG1+xMkQ9hQtTSnIhJWUYukG+coDDK6CSirzk1XF
 Ki2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XBKcHNY1n69RPE8RkPPU5z/rlngsZCnS/EuX/PAz4IU=;
 b=FSS9Hs9i6FjsHeCCseqGcq7MNGEPCLUzj17qp8NHr+RrFea2cYifOPtXh7UZP6pKGb
 E458JbafiHBHpnmeytOBbcLfyk740vDTv/d/u7D52HY8lNbsfVnNEb1OPPsjDJFwSuX0
 G+wh+oP1SYJ77MOQqlIf72OU+dkSWvlpZ58U3LUKE5I3LMfjQwKlHsejjmzj1OEDo0Fi
 X9FiVG0/7tPXOwmID4gAgpGmB25/A21GX75XwpQymfcfxBWFNG3CeQXZN+EMhVcsocJ5
 xL9XqR/YYXD/LmyfBq0kalt3T7JY3Sct5mtKxjcEVuKH9QeA2H5GxDH3RFDQJQYrqcm6
 sTlQ==
X-Gm-Message-State: AOAM533iiwWeRKnTWxfoX+KUKrlScdUFzW77QfXEiaa8b97oX+U0ezN/
 X8kbdP39ndiyghJ2WPH4v4KAABF4OcidYQ==
X-Google-Smtp-Source: ABdhPJyaRoZ2ct/6xg1Cpi+87CQAyXoR+7ccakgkN9wxMnUzVPrjQA/FX1kAYbsrPwmNn+nen9KjLQ==
X-Received: by 2002:adf:ec88:: with SMTP id z8mr126757wrn.44.1589911314539;
 Tue, 19 May 2020 11:01:54 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:01:54 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v7 11/24] iommu/arm-smmu-v3: Seize private ASID
Date: Tue, 19 May 2020 19:54:49 +0200
Message-Id: <20200519175502.2504091-12-jean-philippe@linaro.org>
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

The SMMU has a single ASID space, the union of shared and private ASID
sets. This means that the SMMU driver competes with the arch allocator
for ASIDs. Shared ASIDs are those of Linux processes, allocated by the
arch, and contribute in broadcast TLB maintenance. Private ASIDs are
allocated by the SMMU driver and used for "classic" map/unmap DMA. They
require command-queue TLB invalidations.

When we pin down an mm_context and get an ASID that is already in use by
the SMMU, it belongs to a private context. We used to simply abort the
bind, but this is unfair to users that would be unable to bind a few
seemingly random processes. Try to allocate a new private ASID for the
context, and make the old ASID shared.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v6->v7: Replace context_lock spinlock with asid_lock mutex, remove
  GFP_ATOMIC changes, add comments about locking.
---
 drivers/iommu/arm-smmu-v3.c | 100 ++++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 52cbdf08f5e2..403871d36438 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -733,6 +733,7 @@ struct arm_smmu_option_prop {
 };
 
 static DEFINE_XARRAY_ALLOC1(asid_xa);
+static DEFINE_MUTEX(asid_lock);
 static DEFINE_MUTEX(sva_lock);
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
@@ -1537,6 +1538,17 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 }
 
 /* Context descriptor manipulation functions */
+static void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
+{
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_TLBI_NH_ASID,
+		.tlbi.asid = asid,
+	};
+
+	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+	arm_smmu_cmdq_issue_sync(smmu);
+}
+
 static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 			     int ssid, bool leaf)
 {
@@ -1795,9 +1807,18 @@ static bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
 	return free;
 }
 
+/*
+ * Try to reserve this ASID in the SMMU. If it is in use, try to steal it from
+ * the private entry. Careful here, we may be modifying the context tables of
+ * another SMMU!
+ */
 static struct arm_smmu_ctx_desc *arm_smmu_share_asid(u16 asid)
 {
+	int ret;
+	u32 new_asid;
 	struct arm_smmu_ctx_desc *cd;
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_domain *smmu_domain;
 
 	cd = xa_load(&asid_xa, asid);
 	if (!cd)
@@ -1809,11 +1830,31 @@ static struct arm_smmu_ctx_desc *arm_smmu_share_asid(u16 asid)
 		return cd;
 	}
 
+	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
+	smmu = smmu_domain->smmu;
+
+	ret = xa_alloc(&asid_xa, &new_asid, cd,
+		       XA_LIMIT(1, 1 << smmu->asid_bits), GFP_KERNEL);
+	if (ret)
+		return ERR_PTR(-ENOSPC);
+	/*
+	 * Race with unmap: TLB invalidations will start targeting the new ASID,
+	 * which isn't assigned yet. We'll do an invalidate-all on the old ASID
+	 * later, so it doesn't matter.
+	 */
+	cd->asid = new_asid;
+
 	/*
-	 * Ouch, ASID is already in use for a private cd.
-	 * TODO: seize it.
+	 * Update ASID and invalidate CD in all associated masters. There will
+	 * be some overlap between use of both ASIDs, until we invalidate the
+	 * TLB.
 	 */
-	return ERR_PTR(-EEXIST);
+	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
+
+	/* Invalidate TLB entries previously associated with that context */
+	arm_smmu_tlb_inv_asid(smmu, asid);
+
+	return NULL;
 }
 
 __maybe_unused
@@ -1839,7 +1880,20 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 
 	arm_smmu_init_cd(cd);
 
+	/*
+	 * Serialize against arm_smmu_domain_finalise_s1() and
+	 * arm_smmu_domain_free() as we might need to replace the private ASID
+	 * from an existing CD.
+	 */
+	mutex_lock(&asid_lock);
 	old_cd = arm_smmu_share_asid(asid);
+	if (!old_cd) {
+		ret = xa_insert(&asid_xa, asid, cd, GFP_KERNEL);
+		if (ret)
+			old_cd = ERR_PTR(ret);
+	}
+	mutex_unlock(&asid_lock);
+
 	if (IS_ERR(old_cd)) {
 		ret = PTR_ERR(old_cd);
 		goto err_free_cd;
@@ -1853,11 +1907,6 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 		return old_cd;
 	}
 
-	/* Fails if a private ASID has been allocated since we last checked */
-	ret = xa_insert(&asid_xa, asid, cd, GFP_KERNEL);
-	if (ret)
-		goto err_free_cd;
-
 	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
 	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
 	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
@@ -2401,15 +2450,6 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cmdq_ent cmd;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= CMDQ_OP_TLBI_NH_ASID;
-		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
-		cmd.tlbi.vmid	= 0;
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-	}
-
 	/*
 	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
 	 * PTEs previously cleared by unmaps on the current CPU not yet visible
@@ -2417,8 +2457,14 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * insertion to guarantee those are observed before the TLBI. Do be
 	 * careful, 007.
 	 */
-	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
-	arm_smmu_cmdq_issue_sync(smmu);
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
+	} else {
+		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
+		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+		arm_smmu_cmdq_issue_sync(smmu);
+	}
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
 }
 
@@ -2602,9 +2648,15 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
+		/*
+		 * Prevent arm_smmu_share_asid() from rewriting CD#0 while we're
+		 * freeing it.
+		 */
+		mutex_lock(&asid_lock);
 		if (cfg->cdcfg.cdtab)
 			arm_smmu_free_cd_tables(smmu_domain);
 		arm_smmu_free_asid(&cfg->cd);
+		mutex_unlock(&asid_lock);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
@@ -2626,10 +2678,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 
 	arm_smmu_init_cd(&cfg->cd);
 
+	/*
+	 * Prevent arm_smmu_share_asid() from seizing the private ASID we're
+	 * allocating here until it is written to the CD.
+	 */
+	mutex_lock(&asid_lock);
 	ret = xa_alloc(&asid_xa, &asid, &cfg->cd,
 		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	cfg->s1cdmax = master->ssid_bits;
 
@@ -2657,12 +2714,15 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_free_cd_tables;
 
+	mutex_unlock(&asid_lock);
 	return 0;
 
 out_free_cd_tables:
 	arm_smmu_free_cd_tables(smmu_domain);
 out_free_asid:
 	arm_smmu_free_asid(&cfg->cd);
+out_unlock:
+	mutex_unlock(&asid_lock);
 	return ret;
 }
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
