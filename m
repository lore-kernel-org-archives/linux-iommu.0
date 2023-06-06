Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1780C15ACE
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:10:31 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-56536dd5f79so97926517b3.3
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053430; x=1688645430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=83dlZFDhtSz2rg2AR6ggZ2Mh/ASzqdpRvSd02rbzaCk=;
        b=IoFA55ulrjtnJDTW5pbuUTS9XeM0qmUYpaAJ3OnF3fjh404oOtNySp8WzgeTzaaiiO
         mVRlBZ2obwVwh4OUFmiQJt7UUnDxoDMkllhaIBQAmBhFfw48M+MKZQjL4e//71A1xQ+M
         ZQe0Lx0j/uNjanZ997DNS7XHK7FjkoWOzElSxea08x+rZug6VZyihB4gEnokoKygwiFy
         oohF6tU936F+ATOKuIyJj4FuSck9QyYVTKPs6mJWVCMGD4SJTG4PI7zHHboXxVFaZsG2
         nDS7Gx45dkGyCy6J2pqiwfXPIBXnbTfVR9nkfcP+mnZCb8QJyIFTWcKIELfCjtVWDZgK
         oB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053430; x=1688645430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83dlZFDhtSz2rg2AR6ggZ2Mh/ASzqdpRvSd02rbzaCk=;
        b=YcYWOnNS/vft2+YCQ3HC8y/uwS03rnbN4QbnRvZTQnewt/r4j154+kguQq75LcC/CU
         bApLZxgo0/eIDKIJxTMA4KUZ1OBZQLg+oKrfYInNL/QKzR5APENv9m69bG/rEr/lr94r
         PGftj6e4bs22fEg2nduYqYiZOUwCtKmWSjHGMBQobkqaC18tLsXeXP9jg79afnhGfyyo
         HKZsiTMTiiA/oWuGbGhQ1WQ0LbdQ0BrJfORyhyCaPNENXf3k2CdfYMM85k/LCyYmBl+0
         3tOg7G3qo9x2zYGTagP34OspuauSqWy9D0WQZnZwDV+iMe0CI2BmX2D/9Hg0X550YXYS
         +qnA==
X-Gm-Message-State: AC+VfDx49ctP4UAXdnA+xlV/J8xNWhgTGmi8ZqS7qEVJE6b0tde5tQ1v
	LulyqgIXGjKpcyXB+qAHLqPop0E4bBX5
X-Google-Smtp-Source: ACHHUZ64pvQvCxVufeRzNt0VKrbwAwJNjh5MfrOYdfJtgOmahfaQ951Oi+PY3aJvHU4m52siOi/iL4Zbsjnl
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a81:b289:0:b0:562:837:122f with SMTP id
 q131-20020a81b289000000b005620837122fmr942001ywh.9.1686053430214; Tue, 06 Jun
 2023 05:10:30 -0700 (PDT)
Date: Tue,  6 Jun 2023 20:07:46 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-11-mshavit@google.com>
Subject: [PATCH v2 10/18] iommu/arm-smmu-v3-sva: Remove bond refcount
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The iommu-sva framework checks if a bond between a device and mm already
exists and handles refcounting at the iommu_domain level.
__arm_smmu_sva_bind is therefore only called once for a device/mm pair.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index d07c08b53c5cf..20301d0a2c0b0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -29,7 +29,6 @@ struct arm_smmu_bond {
 	struct mm_struct		*mm;
 	struct arm_smmu_mmu_notifier	*smmu_mn;
 	struct list_head		list;
-	refcount_t			refs;
 };
 
 #define sva_to_bond(handle) \
@@ -377,21 +376,12 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	if (!master || !master->sva_enabled)
 		return ERR_PTR(-ENODEV);
 
-	/* If bind() was already called for this {dev, mm} pair, reuse it. */
-	list_for_each_entry(bond, &master->bonds, list) {
-		if (bond->mm == mm) {
-			refcount_inc(&bond->refs);
-			return &bond->sva;
-		}
-	}
-
 	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
 	if (!bond)
 		return ERR_PTR(-ENOMEM);
 
 	bond->mm = mm;
 	bond->sva.dev = dev;
-	refcount_set(&bond->refs, 1);
 
 	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
 	if (IS_ERR(bond->smmu_mn)) {
@@ -570,7 +560,7 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
+	if (!WARN_ON(!bond)) {
 		list_del(&bond->list);
 		arm_smmu_mmu_notifier_put(bond->smmu_mn);
 		kfree(bond);
-- 
2.41.0.rc0.172.g3f132b7071-goog

