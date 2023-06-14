Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF69101EC
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 15:44:55 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ba88ec544ddso991956276.1
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757494; x=1689349494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1HNFofEgftQ/0viD8hP2C9StxNG8tEEj8VIgof4alao=;
        b=miKKuVOqy3O5VFZtsBJw0DWAr4nJ6ea8nlIylue8vHaIsdYyKs5VFM0KTJacu51Qzm
         +DH3Zl9jsvtSJPHee4tayDVENGPTKWf9gWXrcL4hC1Sc2GgiVQBtqQ7FnZG8+YwqkBPh
         yA8Et/DjbQCMxnJvenLQiNf7A7GFBipkyxcRcbX25mPlSQAORH+f6lepCF7STCNnbSjz
         QEVoAOVVQy/KvCuZreeHmBUtlj6a0/QT8lJ7Ls6W5a6m4+Xc6bUdeRYUvj91Jh2RQGIL
         1UcOZtIRMZQKKjjJou6pQavpNlTolKJ9ovsaIENZITg6nYLeQ/1+rErxMkqfwI2pqIqu
         2vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757494; x=1689349494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HNFofEgftQ/0viD8hP2C9StxNG8tEEj8VIgof4alao=;
        b=NzZoamVGzqabI+2HMZw0PnwapDO0CeFTA53J1a8qpQxC3SopB201tBalRiTZQlsgez
         htinKfassgLuSYz9Gjqlg97DmxCGfykBxCW9zIjdGJW86NTkIsCFZOPoOAuartRb6FcI
         wWFbSqPmw3vO5fRC3X5r3UiK8d1CFk8iiMNCbexs676KIoyh05GBeFUx5/CvGWF5wv4T
         RVw8CL2m2EBH7Xj8ndbn25z82Mli+4Cenj0HzXA/CUohNuchQj42o+zu1kdT2Ezf++ag
         Lf+ktO3inX+x9EUDD4PiZtfgDpeOfw857F6Icnd+uRjzCIe6zzQCrHmmLr9k0Idf7ab/
         aqFg==
X-Gm-Message-State: AC+VfDyMUHVYU/URY9m4jqe68SKo18l6GMVvR891F5JaN/QwUh1ZJsvH
	Ckxu1/uGqJ3ZJ5uI+Rc0N2/0mFYbOyyN
X-Google-Smtp-Source: ACHHUZ78kKfpFZreseZ4ojfWuvi9sDnPV/0PlekSvb+T1K6vSEDreVSyrSqoVe2hWBnfSGsU5TgB/jwAdAGz
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a25:7356:0:b0:bc7:f6af:8cff with SMTP id
 o83-20020a257356000000b00bc7f6af8cffmr1176382ybc.2.1686757494488; Wed, 14 Jun
 2023 08:44:54 -0700 (PDT)
Date: Wed, 14 Jun 2023 23:42:03 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-12-mshavit@google.com>
Subject: [PATCH v3 11/13] iommu/arm-smmu-v3-sva: Clean unused iommu_sva
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
2.41.0.162.gfafddb0af9-goog

