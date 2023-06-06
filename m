Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001B15ACE
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:11:19 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-568ab5c813eso97983037b3.2
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053479; x=1688645479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4Hj/7++tZGwCPYZCwYpw7ebOJKZDYQm/8wAZtGxvBQ=;
        b=tvcKBuXmjcLSD6iUqEdjKkd3pjcW4Bgh2u7k7FhSOJ9MGZTQnIaSWKko/P99xTYVVN
         iQnaTLb8zj7e/VoY15bc6Mw1W9iPTt0hZMjbPFyPEYnptWJCScPiJPt4tWdXsyXHsO+P
         gp36FkV0kxNfBjzogTXR9DDW9oucqrdXHcWBZLfDLsvddtSL990dMhINvFRRLE7S0+MX
         ZynWgj6jxtuOzKbhLTqSqz3k6XpUEVduVIFfHenqn5whjfD/DaqykP3VEdW3yujAx8OO
         aoDD2uEAol7D8se7oYPQAf+WTlEmk3xSuhFYNAY0mS+9pV4pFZDuvyzqmGrDYSDktahz
         d0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053479; x=1688645479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4Hj/7++tZGwCPYZCwYpw7ebOJKZDYQm/8wAZtGxvBQ=;
        b=bfal1e2/kA4EGydsupm0gLCXWj/uYOTRJSj8xZy5I9z4tmOErhtLvX1BHLgee0WNtw
         NrqtRs/5NPkMQUOz2AsUd87fsft0PxD36321XT3XDZYWcLIlQIFtb25FgYw9jVDN3fGp
         VI9df8WSMPlP/ZgL+3V3bXi5iaXm0/4IWbvsgqEwTn0flkIGQ9aTBfMKarVkBYcZ9+jV
         ceICi51h50zYYSZ2Imo2iAHobSx6wu51RM6+0h36dGIAan4FZa1qULNipZdAaoQVXFfW
         eOReZSePa+G7t/HhSMEacgfbUB/4kvfePkp+mPmMq+B8AvCVVwLIaPG91UF5cOCF/PPS
         b9Qw==
X-Gm-Message-State: AC+VfDz7uZl9O6J7Hebvr0IVIb1rmRZagNZ5f3Zj1+2QOuTqYMzcHaUs
	ZoKHjDcJgYDcqhIbQjCt5kDfGkwjYHni
X-Google-Smtp-Source: ACHHUZ5K9xZ7uAxAugHtHkCI/mVJfPep/YguDaCB7GWP0kSNToN9Vq9i1EmKFOq+y4/UV6U9gPdF7J95aSTk
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a81:aa12:0:b0:55a:3133:86fa with SMTP id
 i18-20020a81aa12000000b0055a313386famr966118ywh.3.1686053479602; Tue, 06 Jun
 2023 05:11:19 -0700 (PDT)
Date: Tue,  6 Jun 2023 20:07:53 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-18-mshavit@google.com>
Subject: [PATCH v2 17/18] iommu/arm-smmu-v3-sva: Alloc notifier for {smmu,mn}
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The arm_smmu_nofitier for an mn can be shared across all devices with
the same upstream smmu. This breaks the last remaining explicit
dependency on the device's primary domain in arm-smmu-v3-sva.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 18 +++++++-----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c    |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h    |  4 ++--
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 9a2da579c3563..3e49838e4f55c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -258,17 +258,16 @@ static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
 	.free_notifier		= arm_smmu_mmu_notifier_free,
 };
 
-/* Allocate or get existing MMU notifier for this {domain, mm} pair */
+/* Allocate or get existing MMU notifier for this {smmu, mm} pair */
 static struct arm_smmu_mmu_notifier *
 arm_smmu_mmu_notifier_get(struct arm_smmu_device *smmu,
-			  struct arm_smmu_domain *smmu_domain,
 			  struct mm_struct *mm)
 {
 	int ret;
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_mmu_notifier *smmu_mn;
 
-	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
+	list_for_each_entry(smmu_mn, &smmu->mmu_notifiers, list) {
 		if (smmu_mn->mn.mm == mm) {
 			refcount_inc(&smmu_mn->refs);
 			return smmu_mn;
@@ -296,9 +295,8 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_device *smmu,
 	}
 	arm_smmu_init_shared_cd_domain(smmu, &smmu_mn->domain, cd);
 
-	list_add(&smmu_mn->list, &smmu_domain->mmu_notifiers);
+	list_add(&smmu_mn->list, &smmu->mmu_notifiers);
 	return smmu_mn;
-
 err_free_cd:
 	arm_smmu_free_shared_cd(cd);
 	return ERR_PTR(ret);
@@ -314,7 +312,6 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 		return;
 
 	list_del(&smmu_mn->list);
-
 	/*
 	 * If we went through clear(), we've already invalidated, and no
 	 * new TLB entry can have been formed.
@@ -331,18 +328,17 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 
 static int __arm_smmu_sva_bind(struct device *dev,
 			       struct arm_smmu_sva_domain *sva_domain,
-			       struct mm_struct *mm)
+			       struct mm_struct *mm,
+			       ioasid_t id)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_domain *smmu_domain;
 	int ret;
 
 	if (!master || !master->sva_enabled)
 		return -ENODEV;
 
 	sva_domain->smmu_mn = arm_smmu_mmu_notifier_get(master->smmu,
-							smmu_domain,
 							mm);
 	if (IS_ERR(sva_domain->smmu_mn)) {
 		sva_domain->smmu_mn = NULL;
@@ -533,7 +529,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	struct mm_struct *mm = domain->mm;
 
 	mutex_lock(&sva_lock);
-	ret = __arm_smmu_sva_bind(dev, to_sva_domain(domain), mm);
+	ret = __arm_smmu_sva_bind(dev, to_sva_domain(domain), mm, id);
 	mutex_unlock(&sva_lock);
 
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3c5ff4f58934a..e68c5264c6171 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2058,7 +2058,6 @@ static void arm_smmu_init_smmu_domain(struct arm_smmu_domain *smmu_domain)
 	mutex_init(&smmu_domain->init_mutex);
 	INIT_LIST_HEAD(&smmu_domain->attached_domains);
 	spin_lock_init(&smmu_domain->attached_domains_lock);
-	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 }
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
@@ -2859,6 +2858,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		goto err_free_master;
 	}
 
+	INIT_LIST_HEAD(&smmu->mmu_notifiers);
 	return &smmu->iommu;
 
 err_free_master:
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2c33c0461036d..041b0e532ac3d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -674,6 +674,8 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+
+	struct list_head		mmu_notifiers;
 };
 
 struct arm_smmu_stream {
@@ -737,8 +739,6 @@ struct arm_smmu_domain {
 
 	struct list_head			attached_domains;
 	spinlock_t				attached_domains_lock;
-
-	struct list_head			mmu_notifiers;
 };
 
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
-- 
2.41.0.rc0.172.g3f132b7071-goog

