Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3B1374
	for <iommu@lists.linux.dev>; Sun, 13 Nov 2022 13:40:22 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id v17so7905866plo.1
        for <iommu@lists.linux.dev>; Sun, 13 Nov 2022 05:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYxv6p0OLRmJkUIoXHmmBGT6rx0buZmGw9eP/QrShps=;
        b=Rj/iJfv0rIsMHplpy1NT9E5C+qNpv1eGioa3tlmokQmPmawH3NQbixi4zClFuG799m
         ABH7U671c2WbWgSazv3xIRQDn+vnVD7PwaywOVNLx0IiOEfR3eBYWDn9YQefSO3hUpoe
         uAXcUVoCjsc6TFITDVamWW/jsmuYTMMYAIlENTehZOZMYMUfXaDfyfFAl7QAMtR+Cz17
         v14VZORKrWWCoxpqAo7+ytUQHjHqBCX9YdGmE6ihvbrBGy57Z79pwawHo+jUa/TLMot6
         SFzO0s0E74e5HoBfIgfaTBpmuKIEIMs4prl5KimNZ3M+bjtWf16HPhFXsqrk082mRAFS
         gE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYxv6p0OLRmJkUIoXHmmBGT6rx0buZmGw9eP/QrShps=;
        b=Y6LRmkikFJVUWgKZIgIpoCNdfannoxLp7nFYn5GtWfpqR/NJQQHPUzZVAFK+HfrqzU
         u6D0i2vhfckGtw7F5N3wuQ1mecOBjRFOh0fpVHvPkGvjEU0f06lXxI9mtYCdOtSNdxiV
         2eQAmUBcFAKrc5RodlcgvHjUlQ+lWeNchcQ88IhNLKtooTeHe7826c6jByXZb2sQGKHZ
         dRyeGYWyuxVJuBONag6uRZwVuvTP/Hj0Mfbfry4hHK7zkpJ/wgWjSc/kjYtUlHTpEBPm
         3hYgcA7yraxb1jTDp9oiTS+9PuZeBOADnUcf7uHeLtp1zV4wgc/aSSijgg2+S9fnWSxL
         KbDA==
X-Gm-Message-State: ANoB5pl/Hidv2zOxZuDHAumMA7SuNcipQ21T9kh02DMvbwQR0PXXtgWU
	OC/3BeCKcD77diIFQRD4dW8=
X-Google-Smtp-Source: AA0mqf6S0VekRYqzT4gXdrYWjNR7ft9Yxhiv3X+xyTB4zAMvuqVM46n4qobIGziuZl2traSj0S/aqg==
X-Received: by 2002:a17:90a:f286:b0:20a:6106:a283 with SMTP id fs6-20020a17090af28600b0020a6106a283mr10119996pjb.107.1668346821873;
        Sun, 13 Nov 2022 05:40:21 -0800 (PST)
Received: from junjun.localdomain ([1.83.223.231])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902d58b00b001868d4600b8sm5204943plh.158.2022.11.13.05.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 05:40:21 -0800 (PST)
From: Harry Song <jundongsong1@gmail.com>
To: will@kernel.org
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	jundongsong1@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: Optimize checking for invalid values
Date: Sun, 13 Nov 2022 21:38:55 +0800
Message-Id: <20221113133855.6219-1-jundongsong1@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the check of invalid value (iotlb_gather->pgsize = 0) from
arm_smmu_iotlb_sync() to __arm_smmu_tlb_inv_range() for iotlb sync
to make the code clearer.

Signed-off-by: Harry Song <jundongsong1@gmail.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d5df91c5..e51b9f506 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1873,7 +1873,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 	size_t inv_range = granule;
 	struct arm_smmu_cmdq_batch cmds;
 
-	if (!size)
+	if (!size || !inv_range)
 		return;
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
@@ -2507,9 +2507,6 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 
-	if (!gather->pgsize)
-		return;
-
 	arm_smmu_tlb_inv_range_domain(gather->start,
 				      gather->end - gather->start + 1,
 				      gather->pgsize, true, smmu_domain);
-- 
2.25.1

