Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8037EC433F1
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54351207BB
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCMH28yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54351207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 463A08694A;
	Thu, 23 Jul 2020 15:06:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ixhiIsvQ3K3E; Thu, 23 Jul 2020 15:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9783886910;
	Thu, 23 Jul 2020 15:06:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83DA6C004E;
	Thu, 23 Jul 2020 15:06:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95536C004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 91B9786910
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7eLjgqg5teNJ for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 15:05:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8E3368665E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:05:58 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id lx13so6750061ejb.4
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wskuJloDXQffCZslMedcsZLhDNM/RTcftR4W5M+lmWM=;
 b=aCMH28yfVT0dvw1jNUUZbraQg0/4QDSbSz+ipcvfIDhdbz2vRFp3gQyyZcGEeOpIOf
 Rk6ZnzcSzfP5U5s7YRqSVsQpUjLMeafohbmXpBJ7W3cP6eonBGltklz41+NaxrRh6KXR
 8nNwD3m8wK5KJI5I9RTCs8hDN+qtGUb0sL89irJmOnt7TQswOSqjyvx+Wz0jNW/5DKde
 fBEmAZK5nmCq5IqFkb7+f6r0CSP5mi6nGaFF2fC/yjVrGHFemFsd/NxvuU7UB/IEY2QF
 6M6jVyc3K+eUpLxJwuaNq2xpP+hdAOSlWiiFig33xtIJIKR1oyfLwAn2X87VVQSoEQqK
 xLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wskuJloDXQffCZslMedcsZLhDNM/RTcftR4W5M+lmWM=;
 b=BkWRBSg+Lt/PY18dwZ/eGsKD+5QSR2N5BAcENOczVHK/VyouaZVgfd0oBBfO7iD3bJ
 MNsY/begdw/TLfnc4sStWaK/A7v9uk/+mUFq2il5FBHjNkKxDghwcfIsnoXFd5F+eRjw
 y68vPiIFcZoMIFy9TZxwiI5QE/IVqkAYKuxWqqXKXoHQ0joiBdYK0GWO6UPl+y+fxrh1
 o/WgY03gjgx5kOi+WH4qh8sO0H8NOjxyt44ZqoD5QLktQhgY75SWQXL7yDaS7LGRO1l6
 z2cSjyzwVGgi05s7iQcWYJ7GukaXQsb6Mu8A6rL9PcoWDyfYY5IpVtuJszxzuZ+AHop5
 qfWw==
X-Gm-Message-State: AOAM532Xm1FPaGMHBISN9jJbKuyVhi4Ufj5Ov338fWAwhGGt3jdfZAKF
 UOS3SsNbh4+KD7xhG/bPfFWWxVbfm4s=
X-Google-Smtp-Source: ABdhPJyB1Vkh5KERl8YmjBS8VfddZR0PFejHbSzUL2vYjqtEO7CwYUzdDRG0iR2rh/YcuHmXTAF++A==
X-Received: by 2002:a17:906:1747:: with SMTP id
 d7mr4752761eje.39.1595516756567; 
 Thu, 23 Jul 2020 08:05:56 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k15sm2145952eji.49.2020.07.23.08.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 08:05:56 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v9 09/13] iommu/arm-smmu-v3: Seize private ASID
Date: Thu, 23 Jul 2020 16:57:21 +0200
Message-Id: <20200723145724.3014766-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723145724.3014766-1-jean-philippe@linaro.org>
References: <20200723145724.3014766-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhengxiang9@huawei.com, zhangfei.gao@linaro.org, will@kernel.org
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
 drivers/iommu/arm-smmu-v3.h     |  3 +++
 drivers/iommu/arm-smmu-v3-sva.c | 36 +++++++++++++++++++++++++++++++--
 drivers/iommu/arm-smmu-v3.c     | 34 +++++++++++++++++++------------
 3 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.h b/drivers/iommu/arm-smmu-v3.h
index 6b06a6f19604..90c08f156b43 100644
--- a/drivers/iommu/arm-smmu-v3.h
+++ b/drivers/iommu/arm-smmu-v3.h
@@ -678,6 +678,9 @@ struct arm_smmu_domain {
 extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 
+int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
+			    struct arm_smmu_ctx_desc *cd);
+void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm-smmu-v3-sva.c b/drivers/iommu/arm-smmu-v3-sva.c
index 7c1541864688..d590c864bdf3 100644
--- a/drivers/iommu/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm-smmu-v3-sva.c
@@ -10,10 +10,19 @@
 #include "arm-smmu-v3.h"
 #include "io-pgtable-arm.h"
 
+/*
+ * Try to reserve this ASID in the SMMU. If it is in use, try to steal it from
+ * the private entry. Careful here, we may be modifying the context tables of
+ * another SMMU!
+ */
 static struct arm_smmu_ctx_desc *
 arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 {
+	int ret;
+	u32 new_asid;
 	struct arm_smmu_ctx_desc *cd;
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_domain *smmu_domain;
 
 	cd = xa_load(&arm_smmu_asid_xa, asid);
 	if (!cd)
@@ -27,8 +36,31 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 		return cd;
 	}
 
-	/* Ouch, ASID is already in use for a private cd. */
-	return ERR_PTR(-EBUSY);
+	smmu_domain = container_of(cd, struct arm_smmu_domain, s1_cfg.cd);
+	smmu = smmu_domain->smmu;
+
+	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
+		       XA_LIMIT(1, 1 << smmu->asid_bits), GFP_KERNEL);
+	if (ret)
+		return ERR_PTR(-ENOSPC);
+	/*
+	 * Race with unmap: TLB invalidations will start targeting the new ASID,
+	 * which isn't assigned yet. We'll do an invalidate-all on the old ASID
+	 * later, so it doesn't matter.
+	 */
+	cd->asid = new_asid;
+	/*
+	 * Update ASID and invalidate CD in all associated masters. There will
+	 * be some overlap between use of both ASIDs, until we invalidate the
+	 * TLB.
+	 */
+	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
+
+	/* Invalidate TLB entries previously associated with that context */
+	arm_smmu_tlb_inv_asid(smmu, asid);
+
+	xa_erase(&arm_smmu_asid_xa, asid);
+	return NULL;
 }
 
 __maybe_unused
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 06f148a9ed82..4a47b977ed01 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -873,6 +873,17 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 }
 
 /* Context descriptor manipulation functions */
+void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
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
@@ -953,8 +964,8 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
 	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
 }
 
-static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
-				   int ssid, struct arm_smmu_ctx_desc *cd)
+int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
+			    struct arm_smmu_ctx_desc *cd)
 {
 	/*
 	 * This function handles the following cases:
@@ -1610,15 +1621,6 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
@@ -1626,8 +1628,14 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
