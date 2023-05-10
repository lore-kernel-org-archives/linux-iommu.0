Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85D21CDD
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 20:51:16 +0000 (UTC)
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-24deb9c5f8dso4123767a91.0
        for <iommu@lists.linux.dev>; Wed, 10 May 2023 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683751876; x=1686343876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DMTIUjk5Ind647HSgdl65AQXCGi9ZS5fYo432OHDtSQ=;
        b=KPCdBXKKrCR73vDaoJkOuz1eCOKkI8LYLClUu3ZrD6Rg2/zc1ZSSm1qiKat0BbRArq
         FzmRUM7rp0v+9GCIQNvhfqNy6gVsr5Z+UcEeGdXWHGtGkuO8UqQD+KxCtxreNbiahZ4y
         WRs9ZnTK8MAfnni7I6rJo6ZgF2pU32hZo8ijPo0ne33mYgduNBv5MO3HGN+bs9Od89QK
         i2LHTDL9KXS/yzLi1erv9ZaYyyIhnsYBtHV6e5vK7hSE63IfP6ma2qN7HjsasosoGTdT
         Q5gvPvvoQSCTowCCHHUlbYR2j7v0iItW60tukvbIeG92nL1GMCHNrDjF6xU3rK/ctXeO
         aY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751876; x=1686343876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMTIUjk5Ind647HSgdl65AQXCGi9ZS5fYo432OHDtSQ=;
        b=VL2JyJKvNv9RLpXIXgtOk+Z2MSmSkiFJAiz134V8Lxehq8kKOZbu9gRbgIz/xC0Tj9
         RoIl8scdH2/VvlALOrxW3eSK2LERxVNCaCEuxjrcGc26kbgcwFoRF3ntrPjzLFpYmuwG
         rFReXIN6oGnGfpm26bP1vnxwNXkPp4WPhV10IDuU5L4ZYIIOFMR1FiiuCc35wM5t4kvf
         g/vGcRqBfP5M205XPa5EhN90dQ70tU4BIKMPDaPv+dy+xE4ocvPlzaLCAaqQTS8mJQGJ
         Dx3eFAIo6rilaZv9zL7ctwjJgtbWkbMH714RxD4+TouTO00Okv0N9LmfTVWDUu4iMmSe
         Dlcg==
X-Gm-Message-State: AC+VfDw2Kutgjukh4MwXwOEBezOD5jd45ZC8gXhTxvtzGH2wupE7reJh
	LudLU8XBtaBZfIMZi+6qz9YSyvXvrkJG
X-Google-Smtp-Source: ACHHUZ47UrMzz7gfleKmwaFULxZzolcnVNmCc5mUtValZYiJTjKDcV7CB0gT7x4GUYJvV4hW6CYE2C8IA55d
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:2b1f:8d06:7923:f154])
 (user=mshavit job=sendgmr) by 2002:a17:90a:db0f:b0:24d:f863:458c with SMTP id
 g15-20020a17090adb0f00b0024df863458cmr5910104pjv.1.1683751876335; Wed, 10 May
 2023 13:51:16 -0700 (PDT)
Date: Thu, 11 May 2023 04:50:50 +0800
In-Reply-To: <20230510205054.2667898-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510205054.2667898-4-mshavit@google.com>
Subject: [PATCH v1 3/5] iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

arm_smmu_enable_ats's call to inv_domain would trigger an invalidation
for all masters that a domain is attached to everytime it's attached to
another ATS-enabled master. It doesn't seem like those invalidations are
necessary, and it's easier to reason about arm_smmu_enable_ats if it only
issues invalidation commands for the current master.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7b4399b5ba68b..47dda287a4736 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2275,7 +2275,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	pdev = to_pci_dev(master->dev);
 
 	atomic_inc(&smmu_domain->nr_ats_masters);
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
+	arm_smmu_atc_inv_master(master);
 	if (pci_enable_ats(pdev, stu))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
-- 
2.40.1.521.gf1e218fcd8-goog

