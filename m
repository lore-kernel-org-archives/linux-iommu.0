Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66C15ACE
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:10:01 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5693861875fso89868347b3.1
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686053400; x=1688645400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q3oiLY+ykJwBM19GqpOciDwpUp4BC6bUpIyUkrOw/lU=;
        b=3hPQpvgL+wDxU0OjZQfIfZ4PvVC+sRTH9qlAAPJqZw1xiM2Q3iNaeKDiXdelb0sVio
         D6xhz8ENSzVt3nnIIlVKdYJfctHXIAa0AVbONky2oo5QejO9Xh6VEvVppH5VVD/R0DTg
         Rz+4hNgCNRDD7UxQBbLKaWHBeXwxqhF9abdIbDSldq7wOSbdk8rtegg1ed7wG1S+DX4F
         9gDbr52SBPiRvOlnYTCDE5jSJQThXBeNqvfSEcx2+4zLLOYwZ5zlaQVcRWkWS8JjZRaJ
         XFM2GVTbPxXllz89+WNgxWz51t+GrQPq+ZkabafS5wNcTuWm2e98+FU9XPrgilTH4onp
         qvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686053400; x=1688645400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3oiLY+ykJwBM19GqpOciDwpUp4BC6bUpIyUkrOw/lU=;
        b=iOnp80A1zZFYwY5cPppX2/KMe9zpC/95USW3IM7gvNmPG13+HF67SznCYA+92Kgzoh
         jOIAlQ39UcRRrQNW0SfjuCDc2eD/Jw/JouC8w8PjWLgtYJSyU12GL2pGEMtsqGS7ppHj
         JX2cAWq42bkEnTzSYIsg2nisJwmQDA7tk1Fp3EAGacWrpuTqWRmmMzh/HsZbD6S5QZ5O
         b2yKiL1thW2nfoJraunihZcxSGFfJ1hQdRyg1uFXFJ0syr/dpFp+Z5C5/ITq0HzkMUhJ
         XKvNWRWnxOOAYLCvDNoxXT/y5Y2M7KdELUSM53/q8Se6xRTzRCIq0+NyfZdrUFaSbJwY
         hzKw==
X-Gm-Message-State: AC+VfDxClp+ArBVqlxc1rWXIpuqH2SvWJCKVbSejG63AND1Lvych+3LJ
	Mcgm39bX1ogm3+ot+sIOEQm5/z5n/wrD
X-Google-Smtp-Source: ACHHUZ4SbzdX0vrWGGzX8FEpBXrbLqYVs8p8cs/JwhdTrNJ2i2fH3FCcYmqUDP7FZD+MtLPKPWmNhTPp6j14
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a615:63d5:b54e:6919])
 (user=mshavit job=sendgmr) by 2002:a05:6902:10c8:b0:ba8:797c:9bc7 with SMTP
 id w8-20020a05690210c800b00ba8797c9bc7mr1064725ybu.11.1686053400830; Tue, 06
 Jun 2023 05:10:00 -0700 (PDT)
Date: Tue,  6 Jun 2023 20:07:42 +0800
In-Reply-To: <20230606120854.4170244-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606120854.4170244-7-mshavit@google.com>
Subject: [PATCH v2 06/18] iommu/arm-smmu-v3: Simplify arm_smmu_enable_ats
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
necessary, and it's easier to reason about arm_smmu_enable_ats if it
only issues invalidation commands for the current master.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
v1->v2: Fix commit message wrapping
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 08f440fe1da6d..dc7a59e87a2b4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2286,7 +2286,7 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	pdev = to_pci_dev(master->dev);
 
 	atomic_inc(&smmu_domain->nr_ats_masters);
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
+	arm_smmu_atc_inv_master(master);
 	if (pci_enable_ats(pdev, stu))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

