Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB015ACE
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:10:37 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-569e7aec37bso11863867b3.2
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053437; x=1688645437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0QGlHe+zKTAk3+6sKXLWwU9ZaaAOqSw/Vt2fUhgy2WA=;
        b=bS4nn54XlFs3QFnaLf26ObLJelQ97e9PnCVNdve77ggjCR3JfNlgF6+o8d1vUqjrUM
         wvbXSNOisrmhnBwK5+9Sazm5rU2Zgirf/L3AYbVVxxno+05JhYVLwDDz3CWGUB4CgacW
         7FI2dvkLiNurNExQW8FFZfErrWB4Og5cGkpTlMRWPQdtpgidl8RlYM87aELCqrHicqXT
         zpsqKEpKie2x+xoq6gnaxrUin3F+7UedVAY8bBpVCRRrbKzzvtt973F6bc+QBgFcfs/w
         A85oh7tf3LR1d+Jaic4iI6vwBIZt8daoHhctT54OQIG6Li3F73eKCdyQ6LRcKn5ogmAj
         Q1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053437; x=1688645437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QGlHe+zKTAk3+6sKXLWwU9ZaaAOqSw/Vt2fUhgy2WA=;
        b=NqEgQh2Z7CY+JcWb0ri0BA58MZaB+/2lknLAEt0i6hR3o3F7WbyESV7Omr3Eqc8n3n
         dh2PAqsFsAFlGLAi7F1YlojUUWEuf85FuXkH/hSofJOyaG1cdE2N16PzRoqIxTSnttV7
         oXhw00tMgK50IMtQREwHrApMYafC1lrfMlWgpyEnKnZ/FPRdg8rAGWXYMk9cz64jh3W0
         Wgy/ZXIW+wiJRJ5gJTU+j8AQGscq36Gz1ObCeUyI9nS3eTdDhm9djwX6rFANsyhOVA4t
         DvTQozo5oX2GDvldAI58Wvzk7eLXcIVyxcF3QANx36PzSREXe1zMaBlREBaiBsWB3yYg
         hPPg==
X-Gm-Message-State: AC+VfDwyddeYAcFPvO2XqnGoDXcXlV5NjKcPT41AqNlffHUmbXHXIO+M
	zRjy8NvAoSeO0k7YoN4qGGa5LWvKhQgp
X-Google-Smtp-Source: ACHHUZ6jnEzs4FzKbc1eucPM21c1GLeALy+/7ZK+Ce8gDScxpZwrM/NUIO/Lv/HW4xE6mHRkm8wTRbjilPxN
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a05:6902:703:b0:bac:f608:7113 with SMTP id
 k3-20020a056902070300b00bacf6087113mr1100722ybt.4.1686053437004; Tue, 06 Jun
 2023 05:10:37 -0700 (PDT)
Date: Tue,  6 Jun 2023 20:07:47 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-12-mshavit@google.com>
Subject: [PATCH v2 11/18] iommu/arm-smmu-v3-sva: Clean unused iommu_sva
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The __arm_smmu_sva_bind function returned an unused iommu_sva handle
that can be removed.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 20301d0a2c0b0..650c9c9ad52f1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -25,7 +25,6 @@ struct arm_smmu_mmu_notifier {
 #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
 
 struct arm_smmu_bond {
-	struct iommu_sva		sva;
 	struct mm_struct		*mm;
 	struct arm_smmu_mmu_notifier	*smmu_mn;
 	struct list_head		list;
@@ -364,8 +363,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	arm_smmu_free_shared_cd(cd);
 }
 
-static struct iommu_sva *
-__arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
+static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 {
 	int ret;
 	struct arm_smmu_bond *bond;
@@ -374,14 +372,13 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
 	if (!master || !master->sva_enabled)
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
 	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
 	if (!bond)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	bond->mm = mm;
-	bond->sva.dev = dev;
 
 	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
 	if (IS_ERR(bond->smmu_mn)) {
@@ -390,11 +387,11 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	}
 
 	list_add(&bond->list, &master->bonds);
-	return &bond->sva;
+	return 0;
 
 err_free_bond:
 	kfree(bond);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
@@ -572,13 +569,10 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 				      struct device *dev, ioasid_t id)
 {
 	int ret = 0;
-	struct iommu_sva *handle;
 	struct mm_struct *mm = domain->mm;
 
 	mutex_lock(&sva_lock);
-	handle = __arm_smmu_sva_bind(dev, mm);
-	if (IS_ERR(handle))
-		ret = PTR_ERR(handle);
+	ret = __arm_smmu_sva_bind(dev, mm);
 	mutex_unlock(&sva_lock);
 
 	return ret;
-- 
2.41.0.rc0.172.g3f132b7071-goog

