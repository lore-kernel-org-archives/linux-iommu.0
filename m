Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A72CA6B
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 11:50:44 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d7b9a334ccfso3961759276.0
        for <iommu@lists.linux.dev>; Tue, 05 Sep 2023 04:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693914643; x=1694519443; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7YfE4KQ/9gmtzN9iZMl6VnrHqz0Jm4lc2KvR4R04sGA=;
        b=QYv5IOJq85jAL5GSjqFQfUpmUijE2pVz3cBwmhidOGWTkieeWhLEMdYz7Szus1Fhaq
         QFxM/2RcgCTiQUqMFRPlllpRgML2dhQBgQqg/DzwLGgH2s7BUy0ID/COYMJI6Wt6YCau
         boFtQcvQRJaXDmPtV7z45bx4n4Mfyrt6IOS3QX9Y8o8/3r5DawhBAvutdktkjCeOeksz
         6YDWNruv8hZJ5T5QnXV6+HFkvAr98aiVxspriyNTHbLOLStJ1xfZ5IjQ4S4wFY+zsZfQ
         tjDkAd32GSRI2n4MJj3UTbVJ4DQ2uEqR5xuZlSvlb9rP0UZSqZa5uuTRxc+KOmzt8sSb
         w06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693914643; x=1694519443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YfE4KQ/9gmtzN9iZMl6VnrHqz0Jm4lc2KvR4R04sGA=;
        b=CLoRVd2+EschHBtVVNOYX9W0GascuRed0qGHrvfokwIeMBKfxE38+51beb5IYYwUID
         A3R1SnubdMrquezrwXQczVCl0iQcljUZTSgThZlW9JVs96MLiONk57HpOQcUSDPd0FDU
         KtHWpDHa9/jXN0vXf4JsLvEyqDfg3gkUQC5Hr5yMsua4Pj5CVFgOrafvSgb8JSuqdIWj
         NchT/ZUrRUiLzSEueeCfiJL4cL1TuNL/VS2McGeUNlIkejYeBLlcrFeXG18THy0MVy2x
         TVdiYeedB/l04oipEHm2zjFi4rODWhVdeElFF6x/yEInohDSn5sQU94/5Tner0h1Sabj
         Lr7A==
X-Gm-Message-State: AOJu0YxyIXZq1qniBeHiKDwqpCZ/xIUcKNXCCBIn762Ugx8hkgsgBoYl
	PtJsVAUdGNhFYm0+uo8n8nSwauN5Ugx+vQOIN4/9c/qL7HQCweSHv1Myvk58vtMheBhRlPdfhzx
	e+EqkawDwFpzt59/0Z6E2AlD6arL6x2OXhVD6p1Ym1vFfkdoznNbrfAsIBPShGTE=
X-Google-Smtp-Source: AGHT+IFMJMhyDh+Mk2ZERpecJKF5C6idpkbhpOKinywWmUZVBJ+h6wHJCjYqmxx/sEbPLpU9spECoGysuOhb
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c4a8:fdce:d8d3:7b02])
 (user=mshavit job=sendgmr) by 2002:a25:ad03:0:b0:d7b:b648:f0da with SMTP id
 y3-20020a25ad03000000b00d7bb648f0damr403350ybi.6.1693914643302; Tue, 05 Sep
 2023 04:50:43 -0700 (PDT)
Date: Tue,  5 Sep 2023 19:49:12 +0800
In-Reply-To: <20230905115013.1572240-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230905115013.1572240-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230905194849.v1.1.Ib483f67c9e2ad90ea2254b4b5ac696e4b68aa638@changeid>
Subject: [PATCH v1 1/3] iommu/arm-smmu-v3-sva: Remove unused iommu_sva handle
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	jean-philippe@linaro.org, jgg@nvidia.com, tina.zhang@intel.com, 
	Michael Shavit <mshavit@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, Tomas Krcka <krckatom@amazon.de>, 
	Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"

The __arm_smmu_sva_bind function returned an unused iommu_sva handle
that can be removed.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947eb..32784758ccce6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -25,7 +25,6 @@ struct arm_smmu_mmu_notifier {
 #define mn_to_smmu(mn) container_of(mn, struct arm_smmu_mmu_notifier, mn)
 
 struct arm_smmu_bond {
-	struct iommu_sva		sva;
 	struct mm_struct		*mm;
 	struct arm_smmu_mmu_notifier	*smmu_mn;
 	struct list_head		list;
@@ -320,8 +319,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	arm_smmu_free_shared_cd(cd);
 }
 
-static struct iommu_sva *
-__arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
+static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 {
 	int ret;
 	struct arm_smmu_bond *bond;
@@ -330,7 +328,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
 	if (!master || !master->sva_enabled)
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
 	/* If bind() was already called for this {dev, mm} pair, reuse it. */
 	list_for_each_entry(bond, &master->bonds, list) {
@@ -342,10 +340,9 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 
 	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
 	if (!bond)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	bond->mm = mm;
-	bond->sva.dev = dev;
 	refcount_set(&bond->refs, 1);
 
 	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
@@ -355,11 +352,11 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
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
@@ -537,13 +534,10 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
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
2.42.0.283.g2d96d420d3-goog

