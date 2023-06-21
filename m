Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353B68834
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 06:43:40 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-beb64c0d603so4492661276.1
        for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 23:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687329820; x=1689921820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzXQy+3gWCRrOq/bPJGSod35GlRHXYXuXCqPkpYte2c=;
        b=rvLyDf3473Ea5KgbE9MzK4m81ED5MczQdqagmULEilVLDvyqXUuA956dDqxQL8afkd
         I/KMEhrIM3w+cmdo4c6BxJzNUY5csQMLavWP2+i17nXGNqCj+ZP70yPu0bi+pTgs225a
         rAZ2HNjpybLfLtg0BQ98c3tHjAB9BijbI8q7UEO3+8148457WZur9CdIO5YNp4lm+Vdl
         Rq0CSZOcZtZN/6WN2azDEvWHFdlHaHUH9P77mTDTDjJVMQbgx5Uae087uO5s5uldv2nM
         l7OWmzWlWv7Q89Y0t3V/kW5ayh5OzqWwRmyT8IrUe+tNL09iKKoA09VyeydJpGmNpmxs
         Pbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329820; x=1689921820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzXQy+3gWCRrOq/bPJGSod35GlRHXYXuXCqPkpYte2c=;
        b=JL0q4oSa0/r08XLMQhLUV0lHJJsJEJFOwgZFu3QohhDNMXpdjmA/vbQmlLX4sacN8o
         JHMiRdS7n5M6b9FNF8Cp/Sz29huJ7dSxeWZbzlkRHo5hiMvz8liSMhZ1+xTvY90MjhzQ
         js8hhbXBIKIxxOqeVK0YlGLA17aMyPHDBQQ55Q9bh02prSQeS2NdXWRXNDYmz7afNpgR
         mp461orCRvBuhA3J5Dce0OFGWljhP3K+S8nC3bs690+BZEIyRcpjsMY7ZW0IaucvV4Ys
         p0jXW9N02p/W3NWxnXAV5iicbVZamUxzkGYMHUn2u8mjJuiyM1upkMO0/KvDTz3evErS
         /QgA==
X-Gm-Message-State: AC+VfDysgDxstrBUpnqhthLSvAM2slsxZUbcMH1EhLFfY1/ThAr2sIOh
	IyJkbhZ2TKDxLkuXYwrD5lyQ4AM+qfDL
X-Google-Smtp-Source: ACHHUZ6o7pYjIQ5aJehf2aHfK+lSFLWTkcaxHxTVWaWUeBs4KhACfgfWfn/usRnAdFLLIcrDe6s0cY2LaPQS
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:384f:f7da:c61d:5a3e])
 (user=mshavit job=sendgmr) by 2002:a05:6902:15c4:b0:be4:d646:48d8 with SMTP
 id l4-20020a05690215c400b00be4d64648d8mr1659256ybu.8.1687329820101; Tue, 20
 Jun 2023 23:43:40 -0700 (PDT)
Date: Wed, 21 Jun 2023 14:37:15 +0800
In-Reply-To: <20230621063825.268890-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621063825.268890-4-mshavit@google.com>
Subject: [PATCH v4 03/13] iommu/arm-smmu-v3: Refactor write_strtab_ent
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Explicity keep track of the s1_cfg and s2_cfg that are attached to a
master in arm_smmu_master, regardless of whether they are owned by
arm_smmu_master, arm_smmu_domain or userspace.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 37 +++++++++------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 023769f5ca79a..d79c6ef5d6ed4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1269,10 +1269,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	 */
 	u64 val = le64_to_cpu(dst[0]);
 	bool ste_live = false;
-	struct arm_smmu_device *smmu = NULL;
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_s1_cfg *s1_cfg = NULL;
 	struct arm_smmu_s2_cfg *s2_cfg = NULL;
-	struct arm_smmu_domain *smmu_domain = NULL;
 	struct arm_smmu_cmdq_ent prefetch_cmd = {
 		.opcode		= CMDQ_OP_PREFETCH_CFG,
 		.prefetch	= {
@@ -1280,24 +1279,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		},
 	};
 
-	if (master) {
-		smmu_domain = master->domain;
-		smmu = master->smmu;
-	}
-
-	if (smmu_domain) {
-		switch (smmu_domain->stage) {
-		case ARM_SMMU_DOMAIN_S1:
-			s1_cfg = &smmu_domain->s1_cfg;
-			break;
-		case ARM_SMMU_DOMAIN_S2:
-		case ARM_SMMU_DOMAIN_NESTED:
-			s2_cfg = &smmu_domain->s2_cfg;
-			break;
-		default:
-			break;
-		}
-	}
+	if (master->s1_cfg)
+		s1_cfg = master->s1_cfg;
+	else if (master->s2_cfg)
+		s2_cfg = master->s2_cfg;
 
 	if (val & STRTAB_STE_0_V) {
 		switch (FIELD_GET(STRTAB_STE_0_CFG, val)) {
@@ -1319,8 +1304,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	val = STRTAB_STE_0_V;
 
 	/* Bypass/fault */
-	if (!smmu_domain || !(s1_cfg || s2_cfg)) {
-		if (!smmu_domain && disable_bypass)
+	if (!(s1_cfg || s2_cfg)) {
+		if (disable_bypass)
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
 		else
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
@@ -2401,6 +2386,8 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	master->domain = NULL;
 	master->ats_enabled = false;
+	master->s1_cfg = NULL;
+	master->s2_cfg = NULL;
 	arm_smmu_install_ste_for_dev(master);
 }
 
@@ -2454,6 +2441,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	}
 
 	master->domain = smmu_domain;
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		master->s1_cfg = &smmu_domain->s1_cfg;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2 ||
+		   smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED) {
+		master->s2_cfg = &smmu_domain->s2_cfg;
+	}
 
 	/*
 	 * The SMMU does not support enabling ATS with bypass. When the STE is
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 053cc14c23969..3c614fbe2b8b9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -689,6 +689,8 @@ struct arm_smmu_master {
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
 	struct arm_smmu_s1_cfg		owned_s1_cfg;
+	struct arm_smmu_s1_cfg		*s1_cfg;
+	struct arm_smmu_s2_cfg		*s2_cfg;
 	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				stall_enabled;
-- 
2.41.0.162.gfafddb0af9-goog

