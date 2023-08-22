Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC2944D
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 10:58:00 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d7494be34f8so3034712276.2
        for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 03:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701879; x=1693306679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzkdckhsYM5HseENVN/oabL1JwMNZ1FUebMgW7plyuY=;
        b=eX5QmfSAFa0qUY0A/svbfjXsSnaM7Lq1++mhTi04y1JpkGTj6Z9k+aThUpCK2Qu5bJ
         DCrnGehbJlOcZk+Q9RNw9LN+Qmw55EhIaunbiudCBYzz1DpSXcz7JQceHv1iBY6FBFdX
         qmV9uB9hmcYREXGki8XaTnQN7SqN4S03GOvHVxMjxP26Gpdwo7MvUzuN7hvsNUNPD8vy
         vyO+DabGYbLIq/BjRbVVxx6ez+n1nIH+5RH6aZcSuzmendJYWYCRfKwj9UWRKZH2hSv7
         W9vihc3e3X8iy+kCkngZmkiLbOYls1c80o89A3gkBb3hnst3rNiGwPQ72zhfLV2i4R3X
         gKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701879; x=1693306679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzkdckhsYM5HseENVN/oabL1JwMNZ1FUebMgW7plyuY=;
        b=U1WkenBmM+R5FZ/H+SPIQC/VkN3WG+e4/RmB7L7LHYS+o/qW0OEzUAKLhnFtTY6NtK
         bibSRGhXBnvjvwhESjwVEt5nYjCjO84fln48huuzlNNj40ott70jXZqwSnoQzGpRSQZW
         j4ntMIlCXsJ00drTU0Xm8gi0Ysc5pSz5NcbTQs6WW3qZh6gvNE2cWHblJl2E2nb21WWO
         nedM0MqRlEh7wJ2eQ1JXYJDE/o3OCTtdPRp8x0Re/qeD3mFS5yznaWdPe2TRRAhh4VCd
         UJZfLu4Y07PiIZ1utLJNPnhn8Cu8mS5ev2L4QH6QwxOez+sSGhBKOEThMsbR2q3YAeLq
         9p/Q==
X-Gm-Message-State: AOJu0Yy4yBnNHhNP2V/ls8sGiVi/2fihzey55Qg4m//+6H1YQPnaI3E5
	T64haNwXliOGaJoajfIQKlz/zUt/BQ+rqozH09MBLB06HyUyyXho8LKxrSpzK+Bg+7AlMQuscUS
	RSoSXoTs8IwZbaXEWnd7m6+n/n3iZcpfi3mJyQc0EDmJwfqJm1Q7AXcORjhHayWw=
X-Google-Smtp-Source: AGHT+IFV24bkiqmyen2UBSpUN7ZUKb9y13tOay2zxIEBPlAvfXUwWlmoel9TmmFxhWiwkf4OA7z/lmbcvdzi
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a05:6902:118a:b0:d05:7ba4:67f9 with SMTP
 id m10-20020a056902118a00b00d057ba467f9mr92617ybu.3.1692701879189; Tue, 22
 Aug 2023 03:57:59 -0700 (PDT)
Date: Tue, 22 Aug 2023 18:56:59 +0800
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822185632.RFC.v2.3.I0f149f177e5478e28dc3223c2d10729d8f28d53a@changeid>
Subject: [RFC PATCH v2 3/9] iommu/arm-smmu-v3: Issue invalidations commands to
 multiple SMMUs
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: nicolinc@nvidia.com, tina.zhang@intel.com, jean-philippe@linaro.org, 
	will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, 
	Michael Shavit <mshavit@google.com>, Dawei Li <set_pte_at@outlook.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Assume that devices in the smmu_domain->domain list that belong to the
same SMMU are adjacent to each other in the list.
Batch TLB/ATC invalidation commands for an smmu_domain by the SMMU
devices that the domain is installed to.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v2:
- Moved the ARM_SMMU_FEAT_BTM changes into a new prepatory commit

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   6 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 134 +++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   2 +-
 3 files changed, 104 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 53f65a89a55f9..fe88a7880ad57 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -112,7 +112,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
 
 	/* Invalidate TLB entries previously associated with that context */
-	arm_smmu_tlb_inv_asid(smmu, asid);
+	arm_smmu_tlb_inv_asid(smmu_domain, asid);
 
 	xa_erase(&arm_smmu_asid_xa, asid);
 	return NULL;
@@ -252,7 +252,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 */
 	arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);
 
-	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
+	arm_smmu_tlb_inv_asid(smmu_domain, smmu_mn->cd->asid);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
@@ -340,7 +340,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 * new TLB entry can have been formed.
 	 */
 	if (!smmu_mn->cleared) {
-		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
+		arm_smmu_tlb_inv_asid(smmu_domain, cd->asid);
 		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
 	}
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index db4df9d6aef10..1d072fd38a2d6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -960,15 +960,28 @@ static int arm_smmu_page_response(struct device *dev,
 }
 
 /* Context descriptor manipulation functions */
-void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
+void arm_smmu_tlb_inv_asid(struct arm_smmu_domain *smmu_domain, u16 asid)
 {
+	struct arm_smmu_device *smmu = NULL;
+	struct arm_smmu_master *master;
 	struct arm_smmu_cmdq_ent cmd = {
-		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
-			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
 		.tlbi.asid = asid,
 	};
+	unsigned long flags;
 
-	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices,
+			    domain_head) {
+		if (!smmu)
+			smmu = master->smmu;
+		if (smmu != master->smmu ||
+		    list_is_last(&master->domain_head, &smmu_domain->devices)) {
+			cmd.opcode = smmu->features & ARM_SMMU_FEAT_E2H ?
+			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
+			arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+		}
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 }
 
 static void arm_smmu_sync_cd(struct arm_smmu_master *master,
@@ -1811,14 +1824,13 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size)
 {
 	int i;
+	int ret = 0;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_device *smmu = NULL;
 	struct arm_smmu_master *master;
 	struct arm_smmu_cmdq_batch cmds;
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
-		return 0;
-
 	/*
 	 * Ensure that we've completed prior invalidation of the main TLBs
 	 * before we read 'nr_ats_masters' in case of a concurrent call to
@@ -1839,28 +1851,56 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
 	cmds.num = 0;
-
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
 		if (!master->ats_enabled)
 			continue;
+		if (!smmu)
+			smmu = master->smmu;
+		if (smmu != master->smmu ||
+		    list_is_last(&master->domain_head, &smmu_domain->devices)) {
+			ret = arm_smmu_cmdq_batch_submit(smmu, &cmds);
+			if (ret)
+				break;
+			cmds.num = 0;
+		}
 
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
-			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 		}
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
+	return ret;
+}
+
+static void arm_smmu_tlb_inv_vmid(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = NULL;
+	struct arm_smmu_master *master;
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_TLBI_S12_VMALL,
+		.tlbi.vmid = smmu_domain->s2_cfg.vmid,
+	};
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices,
+			    domain_head) {
+		if (!smmu)
+			smmu = master->smmu;
+		if (smmu != master->smmu ||
+		    list_is_last(&master->domain_head, &smmu_domain->devices))
+			arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 }
 
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_cmdq_ent cmd;
 
 	/*
 	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
@@ -1870,11 +1910,9 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
@@ -1882,9 +1920,9 @@ static void arm_smmu_tlb_inv_context(void *cookie)
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
@@ -1949,21 +1987,36 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 					  size_t granule, bool leaf,
 					  struct arm_smmu_domain *smmu_domain)
 {
+	struct arm_smmu_device *smmu = NULL;
+	struct arm_smmu_master *master;
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
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		if (!smmu)
+			smmu = master->smmu;
+		if (smmu != master->smmu ||
+		    list_is_last(&master->domain_head, &smmu_domain->devices)) {
+			if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+				cmd.opcode = smmu->features &
+							     ARM_SMMU_FEAT_E2H ?
+						     CMDQ_OP_TLBI_EL2_VA :
+						     CMDQ_OP_TLBI_NH_VA;
+				cmd.tlbi.asid = smmu_domain->cd.asid;
+			} else {
+				cmd.opcode = CMDQ_OP_TLBI_S2_IPA;
+				cmd.tlbi.vmid = smmu_domain->s2_cfg.vmid;
+			}
+			__arm_smmu_tlb_inv_range(&cmd, iova, size, granule,
+						 smmu_domain, smmu);
+		}
 	}
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	/*
 	 * Unfortunately, this can't be leaf-only since we may have
@@ -1977,19 +2030,33 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 bool skip_btm_capable_devices,
 				 struct arm_smmu_domain *smmu_domain)
 {
+	struct arm_smmu_device *smmu = NULL;
+	struct arm_smmu_master *master;
 	struct arm_smmu_cmdq_ent cmd = {
-		.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
-			  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
 		.tlbi = {
 			.asid	= asid,
 			.leaf	= leaf,
 		},
 	};
+	unsigned long flags;
 
-	if (skip_btm_capable_devices &&
-	    smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)
-		return;
-	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		if (!smmu)
+			smmu = master->smmu;
+		if (smmu != master->smmu ||
+		    list_is_last(&master->domain_head, &smmu_domain->devices)) {
+			if (skip_btm_capable_devices &&
+			    smmu->features & ARM_SMMU_FEAT_BTM)
+				continue;
+			cmd.opcode = smmu->features & ARM_SMMU_FEAT_E2H ?
+					     CMDQ_OP_TLBI_EL2_VA :
+					     CMDQ_OP_TLBI_NH_VA;
+			__arm_smmu_tlb_inv_range(&cmd, iova, size, granule,
+						 smmu_domain, smmu);
+		}
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 }
 
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
@@ -2523,8 +2590,7 @@ static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (smmu_domain->smmu)
-		arm_smmu_tlb_inv_context(smmu_domain);
+	arm_smmu_tlb_inv_context(smmu_domain);
 }
 
 static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 05599914eb0a0..b0cf9c33e6bcd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -748,7 +748,7 @@ extern struct arm_smmu_ctx_desc quiet_cd;
 
 int arm_smmu_write_ctx_desc(struct arm_smmu_master *smmu_master, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
-void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
+void arm_smmu_tlb_inv_asid(struct arm_smmu_domain *smmu_domain, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
 				 bool skip_btm_capable_devices,
-- 
2.42.0.rc1.204.g551eb34607-goog

