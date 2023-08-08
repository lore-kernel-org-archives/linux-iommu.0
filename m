Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A921401A
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 17:15:14 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d074da73c3eso5389863276.3
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514914; x=1692119714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fCG4B237jlLOlgd06dSBd3YRjuMxdikxPYPDrhwm5iw=;
        b=7C2lcn96rDD8uHyYxwlOuYSB6tJWNGn1sDDVV0eISte0YEVmg+BB/EDclewqkCypbk
         2E3O+JjH3MYoC1zBEtoh/02QmkV6yQQFDvTnr9J4deVfvAEp9HmNeUDl+xW4mpSrilTp
         2KIKs4IuGI2PysYkT1VrX1CLcb867IXsTdWuRy3scxRSjClA0vnfy5RO6Ad4Hw13GqqY
         bYkn67krN9aZhvErOVy84FixBNa4MIgTE1INV5kka2mZvqb3XeI88boYcRuHJY8RUlcZ
         UiWlVjXZZHErhjO5rKlZXVM7ZjsUbObp0I+yvvFC67IcAOhS5qBjNzYBSnR4L5CF6MxX
         VLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514914; x=1692119714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCG4B237jlLOlgd06dSBd3YRjuMxdikxPYPDrhwm5iw=;
        b=GkQtQNmbL2um8A/Koz5ksftHj0wYXOgV2ynWDqbGLnOtiLjmdCsO7Q9wFmSH+jhp1n
         agSSq2CLAno226fX1CWQWe71ZCAXwllTYht3xOVvQr4+5lGDfyw7IluCr0LEbjRU/rSJ
         lR0U5Cew60GlK3knhuTxJBrnefxc4k4OFefdrRCcw/jGHf3gHW1O72c2NaorP0thbo/2
         vY2nwlURB3h4UGHorR15kGCxkSJTODG1ielXow+MimVR3kBJiMALDUyMTErlg3x22djQ
         eaVNpN5K8bxMLuOvcyRyrPQetbmlUOtgd7zyAK+bpWmZgfqtk9wk0UBkWGd+Nf7pmP0u
         Q56A==
X-Gm-Message-State: AOJu0Yzq0PrQQBy4z3zpHtenhrwbhT53mANHCepSVbbppxxziSIGtEa0
	hSW542vuHN9hnMIi/dfLCvoEhe6wOkRt4SV25ltl2gJ+wg5ipxghNQw7KSlwacHtaND/ttR0FME
	/IZGjFfUu1PeTJhp03W9HD/r9ebt5+h6npbUh/oej1xxpxFuZ4/c1K+INWA1YiKo=
X-Google-Smtp-Source: AGHT+IFGeT5c0NHUdPNrkQ55mUsPESfCUtj6//PDUdYu98m/zuJKM1UFdBQT/UoJ6wlhteXfP+Mk5ZXZe9Gw
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:986a:71d7:3b1e:ac1d])
 (user=mshavit job=sendgmr) by 2002:a05:6902:690:b0:d46:45a1:b775 with SMTP id
 i16-20020a056902069000b00d4645a1b775mr3143ybt.3.1691514913790; Tue, 08 Aug
 2023 10:15:13 -0700 (PDT)
Date: Wed,  9 Aug 2023 01:12:00 +0800
In-Reply-To: <20230808171446.2187795-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809011204.v5.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
Subject: [PATCH v5 4/9] iommu/arm-smmu-v3: move stall_enabled to the cd table
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	jean-philippe@linaro.org, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

A domain can be attached to multiple masters with different
master->stall_enabled values. The stall bit of a CD entry should follow
master->stall_enabled and has an inverse relationship with the
STE.S1STALLD bit.

The stall_enabled bit does not depend on any property of the domain, so
move it out of the arm_smmu_domain struct.  Move it to the CD table
struct so that it can fully describe how CD entries should be written to
it.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v5:
- Reword commit

Changes in v2:
- Use a bitfield instead of a bool for stall_enabled

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fe4b19c3b8dee..c01023404c26c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1114,7 +1114,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
 
-		if (smmu_domain->stall_enabled)
+		if (smmu_domain->cd_table.stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
 
@@ -1141,6 +1141,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
+	cdcfg->stall_enabled = master->stall_enabled;
 	cdcfg->max_cds_bits = master->ssid_bits;
 	max_contexts = 1 << cdcfg->max_cds_bits;
 
@@ -2121,8 +2122,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	smmu_domain->stall_enabled = master->stall_enabled;
-
 	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
@@ -2461,7 +2460,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   smmu_domain->stall_enabled != master->stall_enabled) {
+		   smmu_domain->cd_table.stall_enabled !=
+			   master->stall_enabled) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 35a93e8858872..05b1f0ee60808 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -597,6 +597,8 @@ struct arm_smmu_ctx_desc_cfg {
 	unsigned int			num_l1_ents;
 	/* log2 of the maximum number of CDs supported by this table */
 	u8				max_cds_bits;
+	/* Whether CD entries in this table have the stall bit set. */
+	u8				stall_enabled:1;
 };
 
 struct arm_smmu_s2_cfg {
@@ -714,7 +716,6 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
-	bool				stall_enabled;
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
-- 
2.41.0.640.ga95def55d0-goog

