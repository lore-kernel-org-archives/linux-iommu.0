Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6988482
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 06:44:46 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5706641dda9so73687167b3.3
        for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 23:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329886; x=1689921886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1HNFofEgftQ/0viD8hP2C9StxNG8tEEj8VIgof4alao=;
        b=NwyrXz6ubgbYeu5se4OnmTGRl/ECZnN/7JXUGfb3yfJHIleuEhl/vBOWZdfzMER6Gx
         BiPVvWA9Zp+4QaWrnn9OAzgPxD8EtCxqeits8Wu66pkUEHOGaiwDQhRW/J+yNdDMsAlF
         y8tREQZuazgzoLW1lJOdMAgC3jROf3yU6f6/ooGUM/ed0cdMK69TTIuHL8pi8+hdgxg4
         sMmuWLwUHHqnGxYMofKOeij/4hhaVO7yrHVtyCzzPIP3fz7HtdUP47sUq7HkSrrLt0u4
         AKIy0MweTpJJB47zOUsszP8BDsLy6b518MCCeqGT4lRkc+iJWu0D/oSX+S9wtNgHByFL
         IhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329886; x=1689921886;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HNFofEgftQ/0viD8hP2C9StxNG8tEEj8VIgof4alao=;
        b=Eg1XkGT1CDl0cgo6CG5MFHVSZ1FX7kFiq7RY4juuhu+YoEexCmNaUIsFas9StfBKev
         24lORR9HWYZ71Wlke6gaq8bMW3Edqj2hAm4pZKqTEZdxR7rl6UEY1jcsjDwZzFr4jlen
         NuOmT8Zlig1pRhwvAXgHm4amCuE9l1uXlc8J+O5fru/HJxIAVlvB2bU+67ts1HFqn0kK
         ForSPwT8gXxYPp0HSNHYAcCLVI9x4nzlZBM0ncRX+6HdmdC9ef+1hVXK44gRdUBHaOsc
         mRJlfGwn8guDb6xJ5W/YoaPGl4JwffP0l0Ubof4a6ZQi78ADxk64w+A+T+SiGh6khDxJ
         F75w==
X-Gm-Message-State: AC+VfDxR4EdTV4bklbmjsZnruQvMq//LNF6pdtUilMfiTRnZ/1H0if2Y
	DakyseiExaq6SKSX/7hTs18oVZpKWy+M
X-Google-Smtp-Source: ACHHUZ7QGJG0D7z7/43AEtJ6RwcS6kiSb09I0mWwsorRzmgb/ZEaTmvkUNbdIb93dJYPVoc71NOppCwfYFjW
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a81:bc4d:0:b0:56f:2841:aa24 with SMTP id
 b13-20020a81bc4d000000b0056f2841aa24mr6215155ywl.10.1687329885894; Tue, 20
 Jun 2023 23:44:45 -0700 (PDT)
Date: Wed, 21 Jun 2023 14:37:23 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-12-mshavit@google.com>
Subject: [PATCH v4 11/13] iommu/arm-smmu-v3-sva: Clean unused iommu_sva
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

