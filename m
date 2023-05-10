Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671921CDD
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 20:51:11 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-b9a25f6aa0eso14317663276.1
        for <iommu@lists.linux.dev>; Wed, 10 May 2023 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683751870; x=1686343870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JD2T39BHpHecI5MHeo7qoTsLquM2+wzDMKb634oTpbY=;
        b=rGEDpjfKVDSXnegP2Yoh1oS4RKGCm1S/1oh0YrY6TInsUUuT/TatwSrlR5ReWbSpVR
         3CEPJJWurPhFZiuXAtH3qfoSNnpYU5t7ee5qT488zgJ7RlD97QkBhrvYViqMbX+qpdw4
         bHWVtApzrNDQgPDj41iH5pfZsgCbPXXC/7XLzg+tUpY3lRKKv4NwXsRJGhBgg9bkNd6T
         dM7JDKt8kuPXk1NdgoJKuDBgvuKJFO7r2pfBj7HS+RnLwVuOiBsVt23rHj38lxD07exT
         Z1ASuFFRLZkAO7HaK6Taom7jnJaqOj5GAj9Pe7YYwcfnbrwtoaxSXgzy79zc/lPDAd0c
         ILuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751870; x=1686343870;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JD2T39BHpHecI5MHeo7qoTsLquM2+wzDMKb634oTpbY=;
        b=IvfPLG17h5W0kt5YrtsQsLk/CD69U9bHVnN08qxoY+870ulQr+04inkcque4zFsLSc
         VzUzyhstJDnICZrcNKGD3ko36bIqbPVGjIzhnrYbXm1p+//coOPY25mCc1W3Hefek7aN
         1YzqhgCNCcQ6fFN3KSNS6GL0dwUKfhoa1AIqm41Mvac16pmKc7tNeeoqsAHfRXN8+oUp
         5H4xgz+ccc/gqoeqqVg8f9vQ7SjBiKmYoTuKchExwn6sqjLNkpcD3IGVHY/QirJJifIM
         5xPNJ6aFjNnpmBcxOzHaHusUGG1x+Wzy4IRTZX9sxc2hMNwVMJRq/n0mpZa2XNunjlWv
         BZRg==
X-Gm-Message-State: AC+VfDy7ogQbutfovxPTN+OA9FGp5169b2JZ602p+l+3UQmMqxgwVp2o
	r5pneMbs9HLxZLAc53koRKb1IW2lH8sp
X-Google-Smtp-Source: ACHHUZ73kuLRRbrNDuMDON5LT7h7WGSfJ99ThVHL6jicRwMCqCmXO9hfOilEc2kjetoWphmNCF9awexTlbaQ
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:2b1f:8d06:7923:f154])
 (user=mshavit job=sendgmr) by 2002:a25:bbc9:0:b0:b95:518b:4921 with SMTP id
 c9-20020a25bbc9000000b00b95518b4921mr8254206ybk.12.1683751870775; Wed, 10 May
 2023 13:51:10 -0700 (PDT)
Date: Thu, 11 May 2023 04:50:49 +0800
In-Reply-To: <20230510205054.2667898-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230510205054.2667898-1-mshavit@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230510205054.2667898-3-mshavit@google.com>
Subject: [PATCH v1 2/5] iommu/arm-smmu-v3: Add has_stage1 field
From: Michael Shavit <mshavit@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org, nicolinc@nvidia.com, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Inferring the state of the STE based on attached domains becomes tricker
when multiple domains can be attached to a master on different PASIDs.
The new field allows the smmu driver to directly query the state of the
STE (S1 present, S2 present, neither) instead of inferring it from the
attached domain.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 +++++++--------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index cee3efff3c9fa..7b4399b5ba68b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -980,9 +980,9 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 	};
 
 	/*
-	 * There's nothing to sync if the STE isn't valid yet.
+	 * There's nothing to sync if stage 1 hasn't been installed yet.
 	 */
-	if (!master->domain)
+	if (!master->has_stage1)
 		return;
 
 	cmds.num = 0;
@@ -1278,20 +1278,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			.sid	= sid,
 		},
 	};
-	struct iommu_domain *domain = NULL;
-
 	if (master) {
 		smmu = master->smmu;
-		if (master->domain)
-			domain = &master->domain->domain;
-	}
-	if (domain) {
-		if (domain->type != IOMMU_DOMAIN_IDENTITY) {
-			if (master->s2_cfg)
-				s2_cfg = master->s2_cfg;
-			else
-				s1_cfg = &master->s1_cfg;
-		}
+		if (master->has_stage1)
+			s1_cfg = &master->s1_cfg;
+		s2_cfg = master->s2_cfg;
 	}
 
 	if (val & STRTAB_STE_0_V) {
@@ -2367,9 +2358,9 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	list_del(&master->domain_head);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	master->domain = NULL;
 	master->ats_enabled = false;
 	master->s2_cfg = NULL;
+	master->has_stage1 = false;
 	/*
 	 * Note that this will end up calling arm_smmu_sync_cd() even though
 	 * we're about to destroy the entire STE anyways. This is ok because
@@ -2426,6 +2417,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	 * This isn't an issue because the STE hasn't been installed yet.
 	 */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		master->has_stage1 = true;
 		ret = arm_smmu_write_ctx_desc(master, 0, &smmu_domain->cd);
 		if (ret)
 			goto out_unlock;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 0b87c74bdf46e..d715794572b13 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -689,6 +689,7 @@ struct arm_smmu_master {
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
 	struct arm_smmu_s1_cfg		s1_cfg;
+	bool                            has_stage1;
 	struct arm_smmu_s2_cfg		*s2_cfg;
 	unsigned int			num_streams;
 	bool				ats_enabled;
-- 
2.40.1.521.gf1e218fcd8-goog

