Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91536101EC
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 15:44:47 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-56ff81be091so12265037b3.0
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686757486; x=1689349486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvomj7iW2UACU6/yECNbFWEXmb4EH1aV19zctsWiNw0=;
        b=vuL1XrQpU5Uq0e2ygjk0DfQm99VPq2z9YNT+avIv27XZ5urDEgwpmKbViVzjQ8Ors2
         T0rraZDZVM0ODSgkQTw6g6hdTWSyZHC/ZwHObRZETsh7v9KsqI7mfjRVjTddqwb75Yd6
         PkKi9NkGSgecoW5IThOwn0gGyOxQIy0qaPS8Ued69ldHUGXC3bEZuqzTL/jNRXCrcJi3
         uAxDiKxWDeKXd8Icj/EZsPQK5O6GRp7wJwAZct0hM+oyxo3a3VP2+SBs18GWULEH6AcA
         +Q3vGN3bOvN8pQVCjBFeK+N8axcpPszN+TMygeq+12fShtLMkNw5EOWGCZf8F5q4Py43
         k0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757486; x=1689349486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvomj7iW2UACU6/yECNbFWEXmb4EH1aV19zctsWiNw0=;
        b=fngRaPQ4T4i421ijQC6zWtxrA9HrhpIZD7TbRwWkhM4vDhph7g+kP+W3PJdEjcgrHS
         +/DwyspqccY+CJNnY3bWQjOeKy+6NJ+pbIuMG6zOEY77FN7n7s7eQLF5xvPJoR5cdDLl
         9LBT1UzJ4K+JBeHHE1DFYPGMOb90GHgmlIRDR65PZ17cwRVsir/ElruDfB/HZQqLtjmr
         8ipYUlpR0oo7s2QXnGoTabmcPzhmaow0gp2mye7RGlEGPjQQx8BzpTWZfwHs+OII4Oys
         kwRYOl2s1fHo6Et6I95VQT1ZQXZDojwMWGp2sfOGTMUrzlQo2VcGHi69xIuMAf6WyoYb
         XYOA==
X-Gm-Message-State: AC+VfDxfitSDw248o1cDIVofDTsf/PkA7DV3A2Vt4IGVcARx3WCxo3jR
	u22HTHka+uMTHfVdfxBypW7+53js1heC
X-Google-Smtp-Source: ACHHUZ6PWgAWHwE/x5mre24ZvBjK+WBUn1h6Ifenl3MHyaJYnWLa0SO3LQyqPPJbjhH7MP8WEYsBnUmWbutp
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c6e6:49bf:5c44:5965])
 (user=mshavit job=sendgmr) by 2002:a81:440c:0:b0:56d:791:d1a4 with SMTP id
 r12-20020a81440c000000b0056d0791d1a4mr1051771ywa.7.1686757486567; Wed, 14 Jun
 2023 08:44:46 -0700 (PDT)
Date: Wed, 14 Jun 2023 23:42:02 +0800
In-Reply-To: <20230614154304.2860121-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230614154304.2860121-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614154304.2860121-11-mshavit@google.com>
Subject: [PATCH v3 10/13] iommu/arm-smmu-v3-sva: Remove bond refcount
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

