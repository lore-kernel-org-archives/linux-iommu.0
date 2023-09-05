Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD98BCA6B
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 11:50:48 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-58e49935630so39261447b3.0
        for <iommu@lists.linux.dev>; Tue, 05 Sep 2023 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693914648; x=1694519448; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kiLWhPR0jjr+cIjF17/kc7vpb8l797DMDN7j160OqHY=;
        b=4+oAFmGddvHk+UoWWWUTtYaMOE3UHfEy+O0XhJAq5n+tTU/Oq3MFla94BiJThZN7+B
         q5229DiyKn28yEbiNopfhRghrijvb8XQka+fAM7v+aABHr2zI6OzLJLysmJj0CkTAmIr
         MHoDcde2Fpl4+o1O6THQbGtfcMiiX1z23z0tjx6IbbQUuJ4sgrDbu3leBhk4crGlEvws
         9v3OaIdLgNEZscWRTK6HPXs1BNzetIYcsrovq+7go5tzXdTNDBhJfyU5yS6Tb+Ea4DPn
         283vngAWcRQVH+fcLB5qXO/jivgVrK9LKSRrCemI5l07BZekdCwH0/B1CItpDq20oDcf
         Nd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693914648; x=1694519448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiLWhPR0jjr+cIjF17/kc7vpb8l797DMDN7j160OqHY=;
        b=XbtWJs7qRpIresvEUy9JAaxdw4PJ5PPBz3sqyZPshBtMAz+5TspxYCUEhjY+Ij/MGl
         on1jz1GgxrRvr63ASX+zu9FURkR18O3dfYMeJf6cnMS+x2JfjV1Gi/XE90LBUbphOjbi
         5BkwQGy3yoslD3V1SyEkF8Q5yuyeS1QOi0EogQziR8jxDJ64FR6obtbTna9oOtMj5uFJ
         z0KrhsDg58mEIktyNSQ+iqRLk8jrB3L2ZvIurgH7pXOB0wa7Zb7NeCerz71W2Ym2O5j0
         1Ia1/AZR4F/PtGcfWPyGZ59zQLEC49hTAb3hKmJXUWa8GF+T9XIyKJRt6r+/fR/8xFl4
         QHmg==
X-Gm-Message-State: AOJu0Yz1E1oxKo4WyiNKWyXYrdu7Xrgdjcn7v/gbdNoGDpceybmH/0dH
	una3Y3HLBmniUpIX0hiQfDDrNkC8gKJIHnDid/MJQyTSDA6u4qbCxDtaQ1iy5bp9W//4Q0wuoUA
	uUxjzDmWGzeJt+16vpRd3lAEZOECVgwvMxiLeQwS+cjU0a+6dj0IIxX0a4jxrEBw=
X-Google-Smtp-Source: AGHT+IGymTxyTPXDcoYXyE6qZoihZHB7S/W+Yq4eYVfv8eLSmaPP4Buo5WAaDyqII2ZPuy1FBGzp51eq/fFg
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:c4a8:fdce:d8d3:7b02])
 (user=mshavit job=sendgmr) by 2002:a05:690c:2b8b:b0:594:f596:e232 with SMTP
 id en11-20020a05690c2b8b00b00594f596e232mr325586ywb.2.1693914647753; Tue, 05
 Sep 2023 04:50:47 -0700 (PDT)
Date: Tue,  5 Sep 2023 19:49:13 +0800
In-Reply-To: <20230905115013.1572240-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230905115013.1572240-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230905194849.v1.2.Id3ab7cf665bcead097654937233a645722a4cce3@changeid>
Subject: [PATCH v1 2/3] iommu/arm-smmu-v3-sva: Remove bond refcount
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

Always allocate a new arm_smmu_bond in __arm_smmu_sva_bind and remove
the bond refcount since arm_smmu_bond can never be shared across calls
to __arm_smmu_sva_bind.

The iommu framework will not allocate multiple SVA domains for the same
(device/mm) pair, nor will it call set_dev_pasid for a device if a
domain is already attached on the given pasid. There's also a one-to-one
mapping between MM and PASID. __arm_smmu_sva_bind is therefore never
called with the same (device/mm) pair, and so there's no reason to try
and normalize allocations of the arm_smmu_bond struct for a (device/mm)
pair across set_dev_pasid.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
Note that this is true today because iommu_sva_bind_device calls
iommu_get_domain_for_dev_pasid to elude the iommu_attach_device_pasid if
a domain is already attached.
But even with Tina's patch series where iommu_get_domain_for_dev_pasid
is no longer used, iommu_attach_device_pasid also checks whether a
domain is already attached in the group's pasid_array.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 32784758ccce6..9fb6907c5e7d4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -28,7 +28,6 @@ struct arm_smmu_bond {
 	struct mm_struct		*mm;
 	struct arm_smmu_mmu_notifier	*smmu_mn;
 	struct list_head		list;
-	refcount_t			refs;
 };
 
 #define sva_to_bond(handle) \
@@ -330,20 +329,11 @@ static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	if (!master || !master->sva_enabled)
 		return -ENODEV;
 
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
 		return -ENOMEM;
 
 	bond->mm = mm;
-	refcount_set(&bond->refs, 1);
 
 	bond->smmu_mn = arm_smmu_mmu_notifier_get(smmu_domain, mm);
 	if (IS_ERR(bond->smmu_mn)) {
@@ -522,7 +512,7 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
+	if (!WARN_ON(!bond)) {
 		list_del(&bond->list);
 		arm_smmu_mmu_notifier_put(bond->smmu_mn);
 		kfree(bond);
-- 
2.42.0.283.g2d96d420d3-goog

