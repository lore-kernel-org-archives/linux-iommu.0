Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87AFC01
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 13:20:00 +0000 (UTC)
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-55afcc54d55so7397506a12.0
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692192000; x=1692796800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/UAVy0oAQl2r1yFUJP7LdTiXnY1bzTIFFBYzuzTc8kU=;
        b=bEsMIxGoqBSoT1IuqdARo0JAlIo5JKW5zyoZYkffEzJ7TuReXz8mJnX0O7lzXCzHFT
         9GvwbpyWQ53Rd4ol4Qatp8XOMZ4u5z+91ZBziB6FwNaSApiQr2fTYbU7oYW/6a4rtqCl
         rnexVPYzYYGjFMMtksuQtT1Yg/sL2+gpolNa3PaCClvXK7eOKtPKHQ8nZNcBpUxmTHNR
         rXkUnblZLhNyPGofQT08GOUNWJneYoECOoiPYNJ6HVEcBvKch26C2BCys2N9rDZfPNr/
         U1PCmDwfU5MOkhHHPx+uxejQ0nPMH9tMpNkje3wAdK2B68OyO9zZSl0gNsSHXQWTLWX9
         bRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692192000; x=1692796800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UAVy0oAQl2r1yFUJP7LdTiXnY1bzTIFFBYzuzTc8kU=;
        b=JSd3v+TMunLVyulwDcDi9YUFuMhR4UCi66Q1togZs1ughjGY/6FS9NEHY+nrLYkzDU
         q3P+mAz0whiCgf2Qs6z0NVX1hSU+zt0XWmSUXJt1Qyh+xnT0F6mocBisfqhPJl2t/iIn
         AhEAuToKaowEJmv3jkRtfFMrBLR8B5LfdgUOSMDdXIqkRGJckG3xrucCcNpefaRAe5c1
         iQwXEmExf3yo3GbbjV2QaoG73zvZd065/p+B2miA1NtXPuUqub0qYDIUctH1o4MhCNQY
         3oyrLPUFSeRMc/osaqZVq630PA4c5CTve0mV/nUQaleyweQN5/WBHLkxc5s0+SvXQ/kW
         bXAQ==
X-Gm-Message-State: AOJu0YwhzExB7AFrj9FUo98zy1KV8pKuECX5Dger4XldlvF4XRPmYRDf
	U7Pm9L7RQU2xvilprU83Ng7I/pUUJtVeMrfBkb1YczutbcQtPi9fNJYyQaTNe08lWJmi6n9i8QF
	2IGS+ezXT2HBxrGJ6QcNXmPzGO8WG4hdDGN+0/qRSKvDFqhgeX2YHupbePA6rqqk=
X-Google-Smtp-Source: AGHT+IEcmvzSUWhOuuvX16psvemXwtUvsKXpca0OCE+mcyewXMq7875jJ6DT1cSfnNwIb++YBp3xxbfEHN6O
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a17:90a:d248:b0:268:38e3:34f0 with SMTP id
 o8-20020a17090ad24800b0026838e334f0mr467094pjw.2.1692191999561; Wed, 16 Aug
 2023 06:19:59 -0700 (PDT)
Date: Wed, 16 Aug 2023 21:18:46 +0800
In-Reply-To: <20230816131925.2521220-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816211849.v6.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
Subject: [PATCH v6 06/10] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

With this change, each master will now own its own CD table instead of
sharing one with other masters attached to the same domain. Attaching a
stage 1 domain installs CD entries into the master's CD table. SVA
writes its CD entries into each master's CD table if the domain is
shared across masters.

Also add the device to the devices list before writing the CD to the
table so that SVA is always aware of all the CD tables that need
re-writing when it updates a CD.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v6:
- Grab the asid lock while writing the RID CD to prevent a race with
  SVA.
- Add the device to the devices list before writing the CD to the table
  and installing the CD table.
- Undo arm_smmu_finalise_s1 rename
- Minor comment fix
- Consistently check cdtab pointer instead of cdtab_dma

Changes in v5:
- Clear the 0th CD entry when the domain is detached. Not clearing it
  caused a bug in arm_smmu_write_ctx_desc which doesn't expect the entry
  to already be set.

Changes in v4:
- Added comment about the cd_table's dependency on the iommu core's
  group mutex.
- Narrowed the range of code for which the domain's init_mutex is held
  on attach since it now only protects the arm_smmu_domain_finalise
  call.

Changes in v2:
- Allocate CD table when it's first needed instead of on probe.

Changes in v1:
- The master's CD table allocation was previously split to a different
  commit. This change now atomically allocates the new CD table, uses
  it, and removes the old one.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 100 +++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   7 +-
 2 files changed, 60 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 64c1ec557dbc1..8c5e5fcd55713 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1025,7 +1025,7 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->domain->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
 
 	if (cdcfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
 		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
@@ -1062,7 +1062,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	u64 val;
 	bool cd_live;
 	__le64 *cdptr;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &master->domain->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	if (WARN_ON(ssid >= (1 << cd_table->s1cdmax)))
 		return -E2BIG;
@@ -1125,14 +1125,13 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	return 0;
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 {
 	int ret;
 	size_t l1size;
 	size_t max_contexts;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
 
 	cdcfg->stall_enabled = master->stall_enabled;
 	cdcfg->s1cdmax = master->ssid_bits;
@@ -1176,12 +1175,12 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
 	return ret;
 }
 
-static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
 {
 	int i;
 	size_t size, l1size;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
 
 	if (cdcfg->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
@@ -1289,7 +1288,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	if (smmu_domain) {
 		switch (smmu_domain->stage) {
 		case ARM_SMMU_DOMAIN_S1:
-			cd_table = &smmu_domain->cd_table;
+			cd_table = &master->cd_table;
 			break;
 		case ARM_SMMU_DOMAIN_S2:
 		case ARM_SMMU_DOMAIN_NESTED:
@@ -2075,14 +2074,10 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
-	/* Free the CD and ASID, if we allocated them */
+	/* Free the ASID or VMID */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
-
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
-		if (cd_table->cdtab)
-			arm_smmu_free_cd_tables(smmu_domain);
 		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
@@ -2113,10 +2108,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
-	if (ret)
-		goto out_free_asid;
-
 	cd->asid	= (u16)asid;
 	cd->ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
 	cd->tcr		= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
@@ -2128,17 +2119,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
 	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
 
-	ret = arm_smmu_write_ctx_desc(master, 0, cd);
-	if (ret)
-		goto out_free_cd_tables;
-
 	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 
-out_free_cd_tables:
-	arm_smmu_free_cd_tables(smmu_domain);
-out_free_asid:
-	arm_smmu_free_asid(cd);
 out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
@@ -2400,6 +2383,16 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	master->domain = NULL;
 	master->ats_enabled = false;
 	arm_smmu_install_ste_for_dev(master);
+	/*
+	 * The table is uninstalled before clearing the CD to prevent an
+	 * unnecessary sync in arm_smmu_write_ctx_desc. Although clearing the
+	 * CD entry isn't strictly required to detach the domain since the
+	 * table is uninstalled anyway, it helps avoid confusion in the call to
+	 * arm_smmu_write_ctx_desc on the next attach (which expects the entry
+	 * to be empty).
+	 */
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 && master->cd_table.cdtab)
+		arm_smmu_write_ctx_desc(master, 0, NULL);
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
@@ -2434,22 +2427,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
 		ret = arm_smmu_domain_finalise(domain, master);
-		if (ret) {
+		if (ret)
 			smmu_domain->smmu = NULL;
-			goto out_unlock;
-		}
-	} else if (smmu_domain->smmu != smmu) {
-		ret = -EINVAL;
-		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   master->ssid_bits != smmu_domain->cd_table.s1cdmax) {
+	} else if (smmu_domain->smmu != smmu)
 		ret = -EINVAL;
-		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   smmu_domain->cd_table.stall_enabled != master->stall_enabled) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
+
+	mutex_unlock(&smmu_domain->init_mutex);
+	if (ret)
+		return ret;
 
 	master->domain = smmu_domain;
 
@@ -2463,16 +2448,43 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
-	arm_smmu_install_ste_for_dev(master);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_add(&master->domain_head, &smmu_domain->devices);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		if (!master->cd_table.cdtab) {
+			ret = arm_smmu_alloc_cd_tables(master);
+			if (ret) {
+				master->domain = NULL;
+				goto out_list_del;
+			}
+		}
+
+		/*
+		 * Prevent SVA from concurrently modifying the CD or writing to
+		 * the CD entry
+		 */
+		mutex_lock(&arm_smmu_asid_lock);
+		ret = arm_smmu_write_ctx_desc(master, 0, &smmu_domain->cd);
+		mutex_unlock(&arm_smmu_asid_lock);
+		if (ret) {
+			master->domain = NULL;
+			goto out_list_del;
+		}
+	}
+
+	arm_smmu_install_ste_for_dev(master);
+
 	arm_smmu_enable_ats(master);
+	return 0;
+
+out_list_del:
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_del(&master->domain_head);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-out_unlock:
-	mutex_unlock(&smmu_domain->init_mutex);
 	return ret;
 }
 
@@ -2717,6 +2729,8 @@ static void arm_smmu_release_device(struct device *dev)
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
+	if (master->cd_table.cdtab)
+		arm_smmu_free_cd_tables(master);
 	kfree(master);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 00f8e6388848e..2f4b832e0deb4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -695,6 +695,8 @@ struct arm_smmu_master {
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
+	/* Locked by the iommu core using the group mutex */
+	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				stall_enabled;
@@ -721,11 +723,8 @@ struct arm_smmu_domain {
 
 	enum arm_smmu_domain_stage	stage;
 	union {
-		struct {
 		struct arm_smmu_ctx_desc	cd;
-		struct arm_smmu_ctx_desc_cfg	cd_table;
-		};
-		struct arm_smmu_s2_cfg	s2_cfg;
+		struct arm_smmu_s2_cfg		s2_cfg;
 	};
 
 	struct iommu_domain		domain;
-- 
2.41.0.694.ge786442a9b-goog

