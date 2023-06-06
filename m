Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B815ACE
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:11:27 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-56536dd5f79so97943197b3.3
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053486; x=1688645486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=690IhMaVKQOheawjxO/ZDJYW5nna84UvkxSb29OMpJY=;
        b=eW2xKOUzDLrIwpVZxF6w1AffFH+eybFfzAor2EtdG3o/dhStpX5h+hko1PkiB6GL7y
         mmS6o7zPFxcUQRSRX5DG/d0PY60IviKLBvNBEtNsYPu/n5rjxNTwETco8yESLc1KVOOd
         wk+YW7cQw9e9JkvXKhVdJLpbLQn3z9yJ/KLwX3YpX8iS5O24ALewvrvR0jWyO9RzWlM8
         oBsNOOWQlcWJkiplzzMhLA+1nJr7ffwmXaxT30h7zIprl7PUkqEBHdk4bIQdyCKLuL2P
         Z/jOGUaNT82GRH9Ra+nCHqqwczwcKPcwLQGL1DiptDxhlo6Fn6zbRcEFclgC4GlKyr69
         EAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053486; x=1688645486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=690IhMaVKQOheawjxO/ZDJYW5nna84UvkxSb29OMpJY=;
        b=XdidzkbK77AAdbz3gHGUaQXMypZTquMIX2MUm6gsOnEEuhFs12Wm1bXS5zT9d04MFF
         0EVbA5ge+XR9nW51bGiq6tgYvjKvuv694ZAFZPy9n0j12WG5rUyLm1GIY4CeyOaykYpR
         lT7b2WZdIZJ2R2aYBKkfwfq2ah+c7aeLJh9vMRA7KwSYW3vitxV4UIED71QgILtL85Ck
         SwQc/D6+b4WAxWGSOlQib6QYsgbKMhnNxlkj7LBRXXQUXBBOXTPBNQBDuxvA/CMri0Y8
         TusM/ScNIA6CIQaqahY1obK8AfjcC6SvrUiSVmNWbKWeLt1xQOaDb9E8RP+EsAgktpjh
         I5mg==
X-Gm-Message-State: AC+VfDxo4qXgIGSmx5bY9z/jCnh+ABLu06eHTjpW7Aku9bZTnn1MsYDx
	hxCO2H+esUW9QHIMeXwU0K0Vvny/fwi7
X-Google-Smtp-Source: ACHHUZ4AJPXtcMUNlSjrot0SIGIe1VeYT3TxZRBKLGtRsB13dquq7jBw5UDlIYSeITtYdyny8gcWeIoq4RF3
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a05:6902:100b:b0:bad:600:1833 with SMTP id
 w11-20020a056902100b00b00bad06001833mr1035863ybt.0.1686053486705; Tue, 06 Jun
 2023 05:11:26 -0700 (PDT)
Date: Tue,  6 Jun 2023 20:07:54 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-19-mshavit@google.com>
Subject: [PATCH v2 18/18] iommu/arm-smmu-v3-sva: Remove atc_inv_domain_ssid
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

arm_smmu_atc_inv_domain is sufficient in all cases now that
arm_smmu_domain always tracks all the master/ssids that it is attached
to. Also remove the last usage of mm->pasid in arm-smmu-v3-sva.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  9 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 21 +++----------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 ++--
 3 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 3e49838e4f55c..5a124281bbef6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -211,7 +211,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
 		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
 					    PAGE_SIZE, false, smmu_domain);
-	arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, start, size);
+	arm_smmu_atc_inv_domain(smmu_domain, start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -241,7 +241,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, 0, 0);
+	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -304,7 +304,6 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_device *smmu,
 
 static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 {
-	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
 	struct arm_smmu_domain *smmu_domain = &smmu_mn->domain;
 
@@ -318,7 +317,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 */
 	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, 0, 0);
+		arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 	}
 
 	/* Frees smmu_mn */
@@ -347,7 +346,7 @@ static int __arm_smmu_sva_bind(struct device *dev,
 
 	master->nr_attached_sva_domains += 1;
 	smmu_domain = &sva_domain->smmu_mn->domain;
-	ret = arm_smmu_domain_set_dev_pasid(dev, master, smmu_domain, mm->pasid);
+	ret = arm_smmu_domain_set_dev_pasid(dev, master, smmu_domain, id);
 	if (ret) {
 		arm_smmu_mmu_notifier_put(sva_domain->smmu_mn);
 		return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e68c5264c6171..1e02e73e586f7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1821,13 +1821,8 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_atc_inv_master_ssid(master, 0);
 }
 
-/*
- * If ssid is non-zero, issue atc invalidations with the given ssid instead of
- * the one the domain is attached to. This is used by SVA since it's pasid
- * attachments aren't recorded in smmu_domain yet.
- */
-int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
-				 unsigned long iova, size_t size)
+int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+			    unsigned long iova, size_t size)
 {
 	int i;
 	unsigned long flags;
@@ -1866,11 +1861,7 @@ int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
 		master = attached_domain->master;
 		if (!master->ats_enabled)
 			continue;
-		if (ssid != 0)
-			arm_smmu_atc_inv_cmd_set_ssid(ssid, &cmd);
-		else
-			arm_smmu_atc_inv_cmd_set_ssid(attached_domain->ssid, &cmd);
-
+		arm_smmu_atc_inv_cmd_set_ssid(attached_domain->ssid, &cmd);
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
 			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
@@ -1881,12 +1872,6 @@ int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
 	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
 }
 
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
-			    unsigned long iova, size_t size)
-{
-	return arm_smmu_atc_inv_domain_ssid(smmu_domain, 0, iova, size);
-}
-
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 041b0e532ac3d..9c382bc8c0549 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -759,8 +759,8 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
 				 struct arm_smmu_domain *smmu_domain);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
-int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
-				 unsigned long iova, size_t size);
+int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+			    unsigned long iova, size_t size);
 int arm_smmu_domain_set_dev_pasid(struct device *dev,
 				  struct arm_smmu_master *master,
 				  struct arm_smmu_domain *smmu_domain,
-- 
2.41.0.rc0.172.g3f132b7071-goog

