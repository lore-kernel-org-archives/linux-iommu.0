Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A980101EC
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 15:45:03 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-bc505a8dd60so857545276.2
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757502; x=1689349502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rIYz1+kUM82lpQwp18pWI6n2YGQKaG9udPtQlpxJvZA=;
        b=ITLTLTaLCsc9HGbm9o39sZh1FY+PCkOK3DqheGkhRPBC/5m4sMot8zJeqp6fvfWE1r
         t3T//BbToTEl9NchoFS4gdxcOle/PsfltFonLoaAgA2DAOWZERwJ7kzdxMSY2fW6ZZ8y
         pY+tDn0S1BbfL62uKyPVDPJuYg7OXqEm7XeJ9+DUWbpMulT67bfgJEo9dgHiDVDe4FGN
         rscahF06lVNVc5DgWu9mjCNiD2g7elxaGjWG9gVInQls6qTkbGhdTgpJbQc97OTMvGT9
         oNdhtFouxQm4yOzmlFFhwPGSPEOZr2p+ZrgnJzHBF4mAXsbdtpPsvzu8r/CxQgvc5R+4
         6r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757502; x=1689349502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIYz1+kUM82lpQwp18pWI6n2YGQKaG9udPtQlpxJvZA=;
        b=eld27ZkoGdRDQ70/+XkGWiMI8V3PXgJGG3NNDrHq01mm0P/DEi4/XyiLdgpGHBQvT0
         lrzwLMdK5Z34mFmUzosF4NYnxhqtMNrDP4t4NtjTA8QdYpC4ChWnU9K3jXU5K2K8GjZ4
         sflASVgNgqgT9KJJcXXlgVUsdCRDYZk0B/328wK/Ha+e4yLL1YjfOcsklEd1bg0W/ITX
         PIm0vDMGDNujJdIjwon6Vt7rfcqwCBUuguTh3cu8iSNwTyZEKD2UUtq37cQ07YvAv+ze
         UjPdUd6yZG7ZE1K1iimbZfGrutTtcKM7C7WZwarJLiiEH90XpO1YlxNCV9R1t86y/TK3
         weEg==
X-Gm-Message-State: AC+VfDxki4RWgg4EnYRlYs4xhnJthlVI/q5KSqFesqtAcfW0elmmhFwe
	xepYS2O2NNMgOIgIWR2ceffcspX+ivh0
X-Google-Smtp-Source: ACHHUZ7a8fpXcjdm9ERgwJcGejxZs5tL9yslpX+iW/oP0DV08UZci/UMc92nS9z9HRLv/d8ZvhGulclwoYLQ
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a25:ab85:0:b0:ba8:4ba3:5b54 with SMTP id
 v5-20020a25ab85000000b00ba84ba35b54mr311468ybi.11.1686757502482; Wed, 14 Jun
 2023 08:45:02 -0700 (PDT)
Date: Wed, 14 Jun 2023 23:42:04 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-13-mshavit@google.com>
Subject: [PATCH v3 12/13] iommu/arm-smmu-v3-sva: Remove arm_smmu_bond
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There's a 1:1 relationship between arm_smmu_bond and the iommu_domain
used in set_dev_pasid/remove_dev_pasid. arm_smmu_bond has become an
unnecessary complication. It's more natural to store any needed
information at the iommu_domain container level.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 69 +++++++------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 3 files changed, 24 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 650c9c9ad52f1..b615a85e6a54e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -24,14 +24,13 @@ struct arm_smmu_mmu_notifier {
 
 #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
 
-struct arm_smmu_bond {
-	struct mm_struct		*mm;
+struct arm_smmu_sva_domain {
+	struct iommu_domain		iommu_domain;
 	struct arm_smmu_mmu_notifier	*smmu_mn;
-	struct list_head		list;
 };
 
-#define sva_to_bond(handle) \
-	container_of(handle, struct arm_smmu_bond, sva)
+#define to_sva_domain(domain) \
+	container_of(domain, struct arm_smmu_sva_domain, iommu_domain)
 
 static DEFINE_MUTEX(sva_lock);
 
@@ -363,10 +362,10 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	arm_smmu_free_shared_cd(cd);
 }
 
-static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
+static int __arm_smmu_sva_bind(struct device *dev,
+			       struct arm_smmu_sva_domain *sva_domain,
+			       struct mm_struct *mm)
 {
-	int ret;
-	struct arm_smmu_bond *bond;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -374,24 +373,14 @@ static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	if (!master || !master->sva_enabled)
 		return -ENODEV;
 
-	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
-	if (!bond)
-		return -ENOMEM;
-
-	bond->mm = mm;
-
-	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
-	if (IS_ERR(bond->smmu_mn)) {
-		ret = PTR_ERR(bond->smmu_mn);
-		goto err_free_bond;
+	sva_domain->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain,
+							mm);
+	if (IS_ERR(sva_domain->smmu_mn)) {
+		sva_domain->smmu_mn = NULL;
+		return PTR_ERR(sva_domain->smmu_mn);
 	}
-
-	list_add(&bond->list, &master->bonds);
+	master->nr_attached_sva_domains += 1;
 	return 0;
-
-err_free_bond:
-	kfree(bond);
-	return ret;
 }
 
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
@@ -521,7 +510,7 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 {
 	mutex_lock(&sva_lock);
-	if (!list_empty(&master->bonds)) {
+	if (master->nr_attached_sva_domains != 0) {
 		dev_err(master->dev, "cannot disable SVA, device is bound\n");
 		mutex_unlock(&sva_lock);
 		return -EBUSY;
@@ -545,23 +534,12 @@ void arm_smmu_sva_notifier_synchronize(void)
 void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t id)
 {
-	struct mm_struct *mm = domain->mm;
-	struct arm_smmu_bond *bond = NULL, *t;
+	struct arm_smmu_sva_domain *sva_domain = to_sva_domain(domain);
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
 	mutex_lock(&sva_lock);
-	list_for_each_entry(t, &master->bonds, list) {
-		if (t->mm == mm) {
-			bond = t;
-			break;
-		}
-	}
-
-	if (!WARN_ON(!bond)) {
-		list_del(&bond->list);
-		arm_smmu_mmu_notifier_put(bond->smmu_mn);
-		kfree(bond);
-	}
+	master->nr_attached_sva_domains -= 1;
+	arm_smmu_mmu_notifier_put(sva_domain->smmu_mn);
 	mutex_unlock(&sva_lock);
 }
 
@@ -572,7 +550,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	struct mm_struct *mm = domain->mm;
 
 	mutex_lock(&sva_lock);
-	ret = __arm_smmu_sva_bind(dev, mm);
+	ret = __arm_smmu_sva_bind(dev, to_sva_domain(domain), mm);
 	mutex_unlock(&sva_lock);
 
 	return ret;
@@ -590,12 +568,11 @@ static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
 
 struct iommu_domain *arm_smmu_sva_domain_alloc(void)
 {
-	struct iommu_domain *domain;
+	struct arm_smmu_sva_domain *sva_domain;
 
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-	if (!domain)
+	sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
+	if (!sva_domain)
 		return NULL;
-	domain->ops = &arm_smmu_sva_domain_ops;
-
-	return domain;
+	sva_domain->iommu_domain.ops = &arm_smmu_sva_domain_ops;
+	return &sva_domain->iommu_domain;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a6fa56585c219..b7f834dde85d1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2784,7 +2784,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	master->dev = dev;
 	master->smmu = smmu;
-	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 
 	ret = arm_smmu_insert_master(smmu, master);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 48795a7287b69..3525d60668c23 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -705,7 +705,7 @@ struct arm_smmu_master {
 	bool				stall_enabled;
 	bool				sva_enabled;
 	bool				iopf_enabled;
-	struct list_head		bonds;
+	unsigned int			nr_attached_sva_domains;
 	unsigned int			ssid_bits;
 	unsigned int			nr_attached_pasid_domains;
 };
-- 
2.41.0.162.gfafddb0af9-goog

