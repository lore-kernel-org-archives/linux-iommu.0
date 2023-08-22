Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53132944D
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 10:58:04 +0000 (UTC)
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-26f51613d05so2296053a91.2
        for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 03:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701883; x=1693306683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=klUumB39dl+OBWmiMAnKOGBWf0KJAFVzeJ+KKuR3vwQ=;
        b=QOdvPyWOFijq9vdM4JKXlc9Z/yC655EJi71UDoHdIoa3E1exEkCClclZJ3AnpfSNdy
         2DZ07wdWinF4bADwtdysdonB6RVLAp6DvagkAG/F0pU/aytEVm0Z4NDJGVsDdGBnP5DW
         HBUbLjBDPewVyHjv46VGKLZSz342zyA3Ol8D0ntbfYTBh831xO+tsO6mLkF+5hr3Ze/A
         2wXSFj1UY72mn5v5R6GkBTJsHH1PdZhlqGBpmToV8MySPdOkSXKZlL1eaujIjBBLB1R1
         nFYWLrQjysbpQlG0Q2UM95vgzfFfCNjkiceengnYypACUamkijXuM43gQhjXt4T/OpSq
         oDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701883; x=1693306683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klUumB39dl+OBWmiMAnKOGBWf0KJAFVzeJ+KKuR3vwQ=;
        b=kBIzDJWDKLo2j33NespPAYjnaOz0JPUsYkh7FfbKugam+SB4MhY+BSbrtg/7854rvb
         GPoJEVXHLBqL+GbwQK7I0j9WhRRlauL1+hfLgSY1jMZmJ8B9TzIf+8neyH4QRkKvPfEr
         PAv8BQpYkqz8ExAyVb2QVYxvPEz0r7kQMvUeCatgFi3vemiwlwXYYGKMt5Xjv0xbQZ4m
         JG16+J5yuVWrHgd4BDxPOgqw574zTFiOOIPISQoyH3IIyZqb8MIF7J1vd6M/aoJKGr+a
         zCdhO/fjG6SouVL5JtaLEZ8/yZQ2h2MFtfRtb4QTwjpTmsJXPMFsJTovfYQyB/q/M9WU
         aLpQ==
X-Gm-Message-State: AOJu0YygjHUHdQTOeaLInfrioF0d1QYjgWwwaCPKVDhc0OR31JPzOGdi
	Mqoz68Tc1Ymm//lUnMdTod4iHhaekWslBtMsZzV7aNFi0Rl9A6IO9E+sTFz9u4TakgcbzwDfxVK
	pYaPPiDyfmMgMzjBxqbHMDE8ovOlTq2c3rTeEasJa9m0inxiMOYUsIbrw4Qyd92w=
X-Google-Smtp-Source: AGHT+IGvy5fADWCBcGzxzY/Im00oXNvC+VMa0VGSdAqQOVHtJdVI4FD8dSTU2tOb1ulf37dD57VvtOXSyH1Z
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a17:90a:e38f:b0:268:3469:d86e with SMTP id
 b15-20020a17090ae38f00b002683469d86emr1952119pjz.1.1692701883529; Tue, 22 Aug
 2023 03:58:03 -0700 (PDT)
Date: Tue, 22 Aug 2023 18:57:00 +0800
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822185632.RFC.v2.4.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
Subject: [RFC PATCH v2 4/9] iommu/arm-smmu-v3-sva: Allocate new ASID from installed_smmus
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: nicolinc@nvidia.com, tina.zhang@intel.com, jean-philippe@linaro.org, 
	will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, 
	Michael Shavit <mshavit@google.com>, Dawei Li <set_pte_at@outlook.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Pick an ASID that is within the supported range of all SMMUs that the
domain is installed to.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index fe88a7880ad57..92d2f8c4e90a8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -66,6 +66,20 @@ static int arm_smmu_write_ctx_desc_devices(struct arm_smmu_domain *smmu_domain,
 	return ret;
 }
 
+static u32 arm_smmu_domain_max_asid_bits(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_master *master;
+	unsigned long flags;
+	u32 asid_bits = 16;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices,
+			    domain_head)
+		asid_bits = min(asid_bits, master->smmu->asid_bits);
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	return asid_bits;
+}
+
 /*
  * Check if the CPU ASID is available on the SMMU side. If a private context
  * descriptor is using it, try to replace it.
@@ -76,7 +90,6 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	int ret;
 	u32 new_asid;
 	struct arm_smmu_ctx_desc *cd;
-	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain;
 
 	cd = xa_load(&arm_smmu_asid_xa, asid);
@@ -92,10 +105,12 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	}
 
 	smmu_domain = container_of(cd, struct arm_smmu_domain, cd);
-	smmu = smmu_domain->smmu;
 
-	ret = xa_alloc(&arm_smmu_asid_xa, &new_asid, cd,
-		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
+	ret = xa_alloc(
+		&arm_smmu_asid_xa, &new_asid, cd,
+		XA_LIMIT(1,
+			 (1 << arm_smmu_domain_max_asid_bits(smmu_domain)) - 1),
+		GFP_KERNEL);
 	if (ret)
 		return ERR_PTR(-ENOSPC);
 	/*
-- 
2.42.0.rc1.204.g551eb34607-goog

