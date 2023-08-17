Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123814AA6
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 18:21:17 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d72403b9e03so170095276.0
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296477; x=1692901277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dlff986mDTuh88xnoYU7qWi9LJ6LPdznBw3Cx6Wp8ic=;
        b=Fx01aa3MMPqV39cLRnUyr9E9lf3TH3IQ4P9zdBPjkxG32QZEaPvFSRb5dyvFhI8oe+
         LU0YtvQU9MsW4Mu1sIqjitiCZ+zKwqDdgPQ2/rFBH5UAGUz5DZPFzn2gR1ICLIHHEVGw
         u9Gv7LpHkP/N1uVvw3trUTmnnO/LkQZ1UV4n3mWHNYuxMejbcf11Cfpy4B+IP8NTnO+6
         NUrjj7ZAxuGBJoriZDcr3tj4krA5ec6sihUMKd8xCwUXxe61oFVaiQZap/AqSbAu3sRG
         lmS+D5V4ek9xRmAq97Zb/nV83CTedrqcUKETC//qBvdS/xaEG3BS3+g6KcMy5Pa+SSXR
         n9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296477; x=1692901277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlff986mDTuh88xnoYU7qWi9LJ6LPdznBw3Cx6Wp8ic=;
        b=iq2mjEbIZhL5L66S3iv4Crs8qAAEp/onRzbx7zlMKhKESzZhfBHVxUhr/AslIHMJDC
         Hk0MT3nx7MksdIjf/7Mfvd1IhGai84C0XdpyuVBStwRZrIFlxD3vYUi+ZEm3dElCVqCl
         MG1eDCpzcMlc6S3/ORdaN9zDUoAkg3RfsjzuZvc0M/AmB66rg7kJbm9sPYwZU3jZ0FOj
         5ykF9GzqtXTM7jDwzTnEKGH+BJ69+jOIVt5q7E+ZOpc/RjjeKDpMo01FZWAF3tSZGz22
         0ojOS59w6PNbxvV1Q8qKY2UnOXWPo17YMLz4jZj2FtL2fQpAbOVgza1k3FjcfaNqcG8P
         fdHA==
X-Gm-Message-State: AOJu0YxcRrEJ4D7D+3iY9vv045FLBqrgjo7A6S5Ut+mu5iAuKeUC5IQb
	Zwc/0Fu+4Hjje9LICD7euJeGsAAT6YgwKuHYFvhNR8MkwTq1bx332Q7fjbD9uQMFG0o1JV0byaS
	8NnT8VSlpY8XxAtpWHL1uHNUkK5SZ9pVOFdgb1FMlqch/YIjEoHaUIYri3tHoVjw=
X-Google-Smtp-Source: AGHT+IGdALDSXiB3fz3jj70ES4a6LBmf4Gpn2Bwj2fYCMit39y7AonYobS4zUgzf8RWZOvLAo7/C/E1aM421
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a25:408:0:b0:d62:7f3f:621d with SMTP id
 8-20020a250408000000b00d627f3f621dmr4246ybe.11.1692296476914; Thu, 17 Aug
 2023 11:21:16 -0700 (PDT)
Date: Fri, 18 Aug 2023 02:16:24 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
Subject: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over installed_smmus
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com, tina.zhang@intel.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

Prepare and batch invalidation commands for each SMMU that a domain is
installed onto.
Move SVA's check against the smmu's ARM_SMMU_FEAT_BTM bit into
arm_smmu_tlb_inv_range_asid so that it can be checked against each
installed SMMU.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
It's not obvious to me whether skipping the tlb_inv_range_asid when
ARM_SMMU_FEAT_BTM is somehow specific to SVA? Is moving the check into
arm_smmu_tlb_inv_range_asid still valid if that function were called
outside of SVA?

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  11 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 103 +++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +-
 3 files changed, 80 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a4e235b4f1c4b..58def59c36004 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -128,7 +128,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
 
 	/* Invalidate TLB entries previously associated with that context */
-	arm_smmu_tlb_inv_asid(smmu, asid);
+	arm_smmu_tlb_inv_asid(smmu_domain, asid);
 
 	xa_erase(&arm_smmu_asid_xa, asid);
 	return NULL;
@@ -246,9 +246,8 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	 */
 	size = end - start;
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
-		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
-					    PAGE_SIZE, false, smmu_domain);
+	arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
+				    PAGE_SIZE, false, smmu_domain);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
 }
 
@@ -269,7 +268,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 */
 	arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);
 
-	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
+	arm_smmu_tlb_inv_asid(smmu_domain, smmu_mn->cd->asid);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
@@ -357,7 +356,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 * new TLB entry can have been formed.
 	 */
 	if (!smmu_mn->cleared) {
-		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
+		arm_smmu_tlb_inv_asid(smmu_domain, cd->asid);
 		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 	}
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index cb4bf0c7c3dd6..447af74dbe280 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -960,15 +960,24 @@ static int arm_smmu_page_response(struct device *dev,
 }
 
 /* Context descriptor manipulation functions */
-void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
+void arm_smmu_tlb_inv_asid(struct arm_smmu_domain *smmu_domain, u16 asid)
 {
+	struct arm_smmu_installed_smmu *installed_smmu;
+	struct arm_smmu_device *smmu;
 	struct arm_smmu_cmdq_ent cmd = {
-		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
-			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
 		.tlbi.asid = asid,
 	};
+	unsigned long flags;
 
-	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus,
+			    list) {
+		smmu = installed_smmu->smmu;
+		cmd.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
+			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID;
+		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
 }
 
 static void arm_smmu_sync_cd(struct arm_smmu_master *master,
@@ -1818,9 +1827,6 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 	struct arm_smmu_cmdq_batch cmds;
 	struct arm_smmu_installed_smmu *installed_smmu;
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
-		return 0;
-
 	/*
 	 * Ensure that we've completed prior invalidation of the main TLBs
 	 * before we read 'nr_ats_masters' in case of a concurrent call to
@@ -1862,12 +1868,29 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 	return ret;
 }
 
+static void arm_smmu_tlb_inv_vmid(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_installed_smmu *installed_smmu;
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_TLBI_S12_VMALL,
+		.tlbi.vmid = smmu_domain->s2_cfg.vmid,
+	};
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus,
+			    list) {
+		smmu = installed_smmu->smmu;
+		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
+}
+
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_cmdq_ent cmd;
 
 	/*
 	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
@@ -1877,11 +1900,9 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * careful, 007.
 	 */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
+		arm_smmu_tlb_inv_asid(smmu_domain, smmu_domain->cd.asid);
 	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+		arm_smmu_tlb_inv_vmid(smmu_domain);
 	}
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
 }
@@ -1889,9 +1910,9 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 				     unsigned long iova, size_t size,
 				     size_t granule,
-				     struct arm_smmu_domain *smmu_domain)
+				     struct arm_smmu_domain *smmu_domain,
+				     struct arm_smmu_device *smmu)
 {
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	unsigned long end = iova + size, num_pages = 0, tg = 0;
 	size_t inv_range = granule;
 	struct arm_smmu_cmdq_batch cmds;
@@ -1956,21 +1977,32 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 					  size_t granule, bool leaf,
 					  struct arm_smmu_domain *smmu_domain)
 {
+	struct arm_smmu_installed_smmu *installed_smmu;
+	struct arm_smmu_device *smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.tlbi = {
 			.leaf	= leaf,
 		},
 	};
+	unsigned long flags;
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
-				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
-		cmd.tlbi.asid	= smmu_domain->cd.asid;
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus,
+			    list) {
+		smmu = installed_smmu->smmu;
+		if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+			cmd.opcode = smmu->features & ARM_SMMU_FEAT_E2H ?
+					     CMDQ_OP_TLBI_EL2_VA :
+					     CMDQ_OP_TLBI_NH_VA;
+			cmd.tlbi.asid = smmu_domain->cd.asid;
+		} else {
+			cmd.opcode = CMDQ_OP_TLBI_S2_IPA;
+			cmd.tlbi.vmid = smmu_domain->s2_cfg.vmid;
+		}
+		__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain,
+					 smmu);
 	}
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
 
 	/*
 	 * Unfortunately, this can't be leaf-only since we may have
@@ -1983,16 +2015,30 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
 				 struct arm_smmu_domain *smmu_domain)
 {
+
+	struct arm_smmu_installed_smmu *installed_smmu;
+	struct arm_smmu_device *smmu;
+	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd = {
-		.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
-			  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
 		.tlbi = {
 			.asid	= asid,
 			.leaf	= leaf,
 		},
 	};
-
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus,
+			    list) {
+		smmu = installed_smmu->smmu;
+		if (smmu->features & ARM_SMMU_FEAT_BTM)
+			continue;
+		cmd.opcode = smmu->features &
+					     ARM_SMMU_FEAT_E2H ?
+				     CMDQ_OP_TLBI_EL2_VA :
+				     CMDQ_OP_TLBI_NH_VA;
+		__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain,
+					 smmu);
+	}
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
 }
 
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
@@ -2564,8 +2610,7 @@ static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (smmu_domain->smmu)
-		arm_smmu_tlb_inv_context(smmu_domain);
+	arm_smmu_tlb_inv_context(smmu_domain);
 }
 
 static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a9202d2045537..2ab23139c796e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -756,7 +756,7 @@ extern struct arm_smmu_ctx_desc quiet_cd;
 
 int arm_smmu_write_ctx_desc(struct arm_smmu_master *smmu_master, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
-void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
+void arm_smmu_tlb_inv_asid(struct arm_smmu_domain *smmu_domain, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
 				 struct arm_smmu_domain *smmu_domain);
-- 
2.42.0.rc1.204.g551eb34607-goog

