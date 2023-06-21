Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E528482
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 06:44:38 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-bfee5fd909aso664361276.1
        for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 23:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329877; x=1689921877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvomj7iW2UACU6/yECNbFWEXmb4EH1aV19zctsWiNw0=;
        b=bFIfZORz4qlyvHdesSBGaoACwrXyukUmDFr+sNMMwiGcbhJJOqX5vCINTCGVK/kqb1
         M2pwDMPHBCg5EsNV8co3V/w8l6vhX4vTin9L9Y5GtkOrDe1gld2dyDd8Gs1HqLfNwdN1
         G1FtBdPsy2NHnG2IC3hIdVsnPTWng2eGQ+qtojfzCdm1ORIt9R40o+eakI5Ec4ojnwqT
         F2VattLO/4nUSbZD2O/jFgdRuiN0pvkwRjTfp2vimZsBjB7peBN0fhLflu4T05WVZiO1
         hJkx9W1oX0Pcb7kL4Ccd0fi2GEjiJaL7AxA3aaF5kFJsUz+3Ce+yO5GZBwoTHZZ/M+Ot
         GroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329877; x=1689921877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvomj7iW2UACU6/yECNbFWEXmb4EH1aV19zctsWiNw0=;
        b=WBYNmPBQnHe2ZkDy4cjTXBYWr2jYTjAkGkMQyuJRkouOgARaL/uxtPXgGdCHEhLE9K
         F0WRGbeYNbHKckLgMLrQyHeTSa24FheX2M9ynS9K9mzf6kTyGfJ94by37nfq+azauU8R
         boVmfkvVcgTunqTHh08geqll4mT6HNWHU+aZfSDdg2cURSj7zLgkfdtu/+z0nFtGODkD
         qIDFmd8c+q3fqLYUdXHDSvRiyuCTpuQwYL2cUTZ7NkQBnxqcYdCFdZFEhWQfUfQG0zx2
         B8fm/5G12y4CJhpuF4F1PZf43l+nGz9BgXVdWqrJbqRwm9zCLE86uaIEH7DQ1tM1SVgn
         GVOw==
X-Gm-Message-State: AC+VfDzy6cMNxT/VD9wT24sw0eTn6zKeiAfNchcr9W1KMhZQ9DM94QEy
	+srQ4bm/m7K8TQ7RTht1/ToS/JvOZXyD
X-Google-Smtp-Source: ACHHUZ4Hv0OtvqUjdHD4vH+y719Y6q1CiVIktPp2laFj3DNmpEvjIkRNUnFgjTd048rLwQnXunTIxIImH8Cz
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a25:d658:0:b0:bbb:8c13:ce26 with SMTP id
 n85-20020a25d658000000b00bbb8c13ce26mr5885974ybg.11.1687329877614; Tue, 20
 Jun 2023 23:44:37 -0700 (PDT)
Date: Wed, 21 Jun 2023 14:37:22 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-11-mshavit@google.com>
Subject: [PATCH v4 10/13] iommu/arm-smmu-v3-sva: Remove bond refcount
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
2.41.0.162.gfafddb0af9-goog

