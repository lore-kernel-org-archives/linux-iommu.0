Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF93314AA6
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 18:21:13 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-58caf216c55so23593737b3.0
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296473; x=1692901273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+2D70KRXNWhhcPVOCTxbPCzMxKwpJ9kMCl7BCRH1CBA=;
        b=1NQIxdGPIzv1vancVXQRAGHurPC01AwEAqcGXQTQl9qCYLaSwcIlJdYW6lNI2TWvpH
         R2MyLLU+DOV4GNLeTp9GRLMCQTw7wIxqU09tVY4UZI5XJprmcDT0ET8UDA0YtAneia3Z
         t7m6FEjtL5va24FqykgIETi5D1Wmx0ENeDDOn0jBmqlWnGBVgZ311fTdbe5JwrNXWmFs
         iqTb3j8D1RDbRI5ZwA79ITr5+AuHVHyKpk5l83+q4sM/rqAKYb5Fu9vN+Rlj53dZTsd+
         Zt5UFlfJ176IjzITRNvEWDvbTJIuWK79YMmus1BVEzTMbuM/22ZTOEEFRcfp5LzmQw4j
         op6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296473; x=1692901273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2D70KRXNWhhcPVOCTxbPCzMxKwpJ9kMCl7BCRH1CBA=;
        b=TNZBGxWKAaQT3PaoYhQ4oTzVU33GhxLmFwRebZpWPxnunCd8AVkzpfxdNWB9gD6XPZ
         6EyMRXGWeKIoaximl4jqsueOPGQ+iPOlACIMWQkEs4I/3Jh9ZGy5E0FLt5O3OheenG+e
         3OvFCdfEsV5MAua5UpZIWG9sus1bmYRBHEMnbr7/X+cBLtRnw6J9sMpbmhC7UIC9TfWg
         08pQiwrdnw8mAF77YFeaSXcU8ohoQkqNNSxXQzQMJMWewHNUkcy5ctzwCIdKhwb5cKYL
         wsIlCnNFvzVBYHaDnlJGgLYM7jLucpHoq3NESvxcT3Jq2uRbwMygulNzen7z6vPdCijq
         IUHA==
X-Gm-Message-State: AOJu0YyAK6eKUtqeBqnyk/JOM41gnOWItQ9Vd2CgFxSqKJYkOUDA0Fat
	hrmRk0ZEcV18sER2oIYsV2tL8WDpVtNuSu36RJVNBnYK43lp0j8s7amNRXzQ3jXM6d5GvSZ7lt9
	EeHVgjBFGulvFr6tUKfb7dJc29wdeqN5HGusucCqmtfSXlEBHWLavmtZdwrwT9Ho=
X-Google-Smtp-Source: AGHT+IEfGIdi50eVGb7u0h+TWz7zRSXVqh1WuPmcOmzYvjkcKgmVMU4WPccj8sV7aIFWIbA0pRIoE9IkWWP4
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a25:d152:0:b0:ca3:3341:6315 with SMTP id
 i79-20020a25d152000000b00ca333416315mr4578ybg.0.1692296472695; Thu, 17 Aug
 2023 11:21:12 -0700 (PDT)
Date: Fri, 18 Aug 2023 02:16:23 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.1.I9df3dec9e33165276eba8e2dbf7025bfee286d90@changeid>
Subject: [RFC PATCH v1 1/8] iommu/arm-smmu-v3: Add list of installed_smmus
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com, tina.zhang@intel.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new arm_smmu_installed_smmu class to aggregate masters belonging
to the same SMMU that a domain is attached to.
Update usages of the domain->devices list to first iterate over this
parent installed_smmus list.

This allows functions that batch commands to an SMMU to first iterate
over the list of installed SMMUs before preparing the batched command
from the set of attached masters.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  28 ++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 109 ++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  14 ++-
 3 files changed, 118 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 238ede8368d10..a4e235b4f1c4b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -48,21 +48,37 @@ static int arm_smmu_write_ctx_desc_devices(struct arm_smmu_domain *smmu_domain,
 					   int ssid,
 					   struct arm_smmu_ctx_desc *cd)
 {
+	struct arm_smmu_installed_smmu *installed_smmu;
 	struct arm_smmu_master *master;
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		ret = arm_smmu_write_ctx_desc(master, ssid, cd);
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus, list) {
+		list_for_each_entry(master, &installed_smmu->devices, list) {
+			ret = arm_smmu_write_ctx_desc(master, ssid, cd);
+			if (ret) {
+				list_for_each_entry_from_reverse(
+					master, &installed_smmu->devices, list)
+					arm_smmu_write_ctx_desc(master, ssid,
+								NULL);
+				break;
+			}
+		}
 		if (ret) {
-			list_for_each_entry_from_reverse(master, &smmu_domain->devices, domain_head)
-				arm_smmu_write_ctx_desc(master, ssid, NULL);
+			list_for_each_entry_continue_reverse(
+				installed_smmu, &smmu_domain->installed_smmus,
+				list) {
+				list_for_each_entry(
+					master, &installed_smmu->devices, list)
+					arm_smmu_write_ctx_desc(master, ssid,
+								NULL);
+			}
 			break;
 		}
 	}
 
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
 	return ret;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f17704c35858d..cb4bf0c7c3dd6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1811,10 +1811,12 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size)
 {
 	int i;
+	int ret;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
 	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_installed_smmu *installed_smmu;
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
 		return 0;
@@ -1838,21 +1840,26 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
-	cmds.num = 0;
-
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		if (!master->ats_enabled)
-			continue;
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus, list) {
+		cmds.num = 0;
+		list_for_each_entry(master, &installed_smmu->devices, list) {
+			if (!master->ats_enabled)
+				continue;
 
-		for (i = 0; i < master->num_streams; i++) {
-			cmd.atc.sid = master->streams[i].id;
-			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
+			for (i = 0; i < master->num_streams; i++) {
+				cmd.atc.sid = master->streams[i].id;
+				arm_smmu_cmdq_batch_add(installed_smmu->smmu,
+							&cmds, &cmd);
+			}
 		}
+		ret = arm_smmu_cmdq_batch_submit(installed_smmu->smmu, &cmds);
+		if (ret)
+			break;
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
 
-	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
+	return ret;
 }
 
 /* IO_PGTABLE API */
@@ -2049,8 +2056,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return NULL;
 
 	mutex_init(&smmu_domain->init_mutex);
-	INIT_LIST_HEAD(&smmu_domain->devices);
-	spin_lock_init(&smmu_domain->devices_lock);
+	INIT_LIST_HEAD(&smmu_domain->installed_smmus);
+	spin_lock_init(&smmu_domain->installed_smmus_lock);
 	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
 	return &smmu_domain->domain;
@@ -2353,9 +2360,66 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 	pci_disable_pasid(pdev);
 }
 
-static void arm_smmu_detach_dev(struct arm_smmu_master *master)
+static void arm_smmu_installed_smmus_remove_device(
+	struct arm_smmu_domain *smmu_domain,
+	struct arm_smmu_master *master)
 {
+	struct arm_smmu_installed_smmu *installed_smmu;
+	struct arm_smmu_device *smmu;
 	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus,
+			    list) {
+		smmu = installed_smmu->smmu;
+		if (smmu != master->smmu)
+			continue;
+		list_del(&master->list);
+		if (list_empty(&installed_smmu->devices)) {
+			list_del(&installed_smmu->list);
+			kfree(installed_smmu);
+		}
+		break;
+	}
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
+}
+
+static int
+arm_smmu_installed_smmus_add_device(struct arm_smmu_domain *smmu_domain,
+				    struct arm_smmu_master *master)
+{
+	struct arm_smmu_installed_smmu *installed_smmu;
+	struct arm_smmu_device *smmu = master->smmu;
+	bool list_entry_found = false;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus,
+			    list) {
+		if (installed_smmu->smmu == smmu) {
+			list_entry_found = true;
+			break;
+		}
+	}
+	if (!list_entry_found) {
+		installed_smmu = kzalloc(sizeof(*installed_smmu), GFP_KERNEL);
+		if (!installed_smmu) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+		INIT_LIST_HEAD(&installed_smmu->devices);
+		installed_smmu->smmu = smmu;
+		list_add(&installed_smmu->list, &smmu_domain->installed_smmus);
+	}
+	list_add(&master->list, &installed_smmu->devices);
+unlock:
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
+	return ret;
+}
+
+static void arm_smmu_detach_dev(struct arm_smmu_master *master)
+{
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (!smmu_domain)
@@ -2363,9 +2427,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	arm_smmu_disable_ats(master);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_del(&master->domain_head);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	arm_smmu_installed_smmus_remove_device(smmu_domain, master);
 
 	master->domain = NULL;
 	master->ats_enabled = false;
@@ -2385,7 +2447,6 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
-	unsigned long flags;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -2435,9 +2496,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_add(&master->domain_head, &smmu_domain->devices);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	ret = arm_smmu_installed_smmus_add_device(smmu_domain, master);
+	if (ret) {
+		master->domain = NULL;
+		return ret;
+	}
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		if (!master->cd_table.cdtab) {
@@ -2467,9 +2530,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 
 out_list_del:
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_del(&master->domain_head);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	arm_smmu_installed_smmus_remove_device(smmu_domain, master);
 
 	return ret;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 83d2790b701e7..a9202d2045537 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -690,12 +690,20 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+/* List of smmu devices that a domain is installed to */
+struct arm_smmu_installed_smmu {
+	struct list_head	list;
+	/* List of masters that the domain is attached to*/
+	struct list_head	devices;
+	struct arm_smmu_device	*smmu;
+};
+
 /* SMMU private data for each master */
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
 	struct arm_smmu_domain		*domain;
-	struct list_head		domain_head;
+	struct list_head		list;
 	struct arm_smmu_stream		*streams;
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
@@ -731,8 +739,8 @@ struct arm_smmu_domain {
 
 	struct iommu_domain		domain;
 
-	struct list_head		devices;
-	spinlock_t			devices_lock;
+	struct list_head		installed_smmus;
+	spinlock_t			installed_smmus_lock;
 
 	struct list_head		mmu_notifiers;
 };
-- 
2.42.0.rc1.204.g551eb34607-goog

