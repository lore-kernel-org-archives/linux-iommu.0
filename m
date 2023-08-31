Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0211CB6
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 17:46:05 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-58c9d29588aso14793267b3.0
        for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693503965; x=1694108765; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+w3KBHikFTGwIimaQYuBypMhrw19N7uERmLhmvMz58=;
        b=tAPAQvYTpMJig0Pz4F3ja7bmkv9mtLzyXGlsgTuc0RkOyFGSubzvvBbWsFI/UffoEB
         G9BZw5yKSb8AaKKaVK/hwyqsvRKmKh8pFB/s+qoDQ4vq4Ac0/90LgpdMT6WUj/96Zj/N
         wZ9RZbMF70Z5ZxB0QU22m6aaRiQpuxkY9DZLJ1UEXNsKFCYkDUyYX7RV6UEpMEGt5hkc
         ccN1lobRta9INp64k2rRHtOz51H3C5q9kFdaMd0JBaFInODtTR7mETkcLdxjXXNi7MLc
         DyXrQrIfxxTUoPmKa2Y+HgXnLmbUikV02y8RlCZGnfVhn0NnwI2dKMzUQUbL6U3a03qp
         mi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503965; x=1694108765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+w3KBHikFTGwIimaQYuBypMhrw19N7uERmLhmvMz58=;
        b=g7k+Yk9nMxaU4I/JHV0eUBKQgMnYnewqx74XdA7CM/dvwhWIWzRsIy30rBQMDcVqWP
         1gHKqtv7BkelrBMxxUAv/gzyBKTDzeV4xLBKC76k8jUnrjEunvTHPn7zARK+fsZfltOW
         BQV7b6n+U6hZ1tD3ULI8UduyovX9DHEiF9uzax18SSF3jAVVI2w/xKzrfAm2xBXOLG0H
         aZuV9wy+e6eE2NTlX8qRmgyXnflcGjOVH77RlXaHJPKIp7MSh5Q1XrzPtwpaV/uoDj5h
         A1ULy+qSHfpXEPKVJt858RACSq4yYrC/Bxxx2eIP0oB40r3ox8LO2kOXUqBLBKNM3rqC
         AudA==
X-Gm-Message-State: AOJu0YzfOJG67mORczJ3GwB/J00qhOFa89TY0/8Gss+iO70zE7e59fJ1
	IuJTHGSS+T4lYepfuAfGAdrS7VSezK/1ruJUw9TUo3LdDvoDcQBjb/JFuydTSrnnzyCWZCBFz4P
	qqfxZJXCIIdg2WO5QtILQ+yCNAsbyD5A2399c8kV5xJEKne9QXXnXjnVZrEM3LOo=
X-Google-Smtp-Source: AGHT+IFAWVZV2caLtc+pnQCsFawM0vj56icg1pDwBPCBAR0uE5NsLxwemjROnxuZAPffh9wiN1C0yPtzEIKV
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:1a0a:7338:4a5a:5f83])
 (user=mshavit job=sendgmr) by 2002:a81:b61f:0:b0:56f:f62b:7a11 with SMTP id
 u31-20020a81b61f000000b0056ff62b7a11mr2293ywh.8.1693503964944; Thu, 31 Aug
 2023 10:46:04 -0700 (PDT)
Date: Fri,  1 Sep 2023 01:44:33 +0800
In-Reply-To: <20230831174536.103472-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230831174536.103472-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230901014413.v7.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
Subject: [PATCH v7 4/9] iommu/arm-smmu-v3: move stall_enabled to the cd table
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>
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

(no changes since v5)

Changes in v5:
- Reword commit

Changes in v2:
- Use a bitfield instead of a bool for stall_enabled

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5bb13fadb41ad..44df7c0926802 100644
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
 	cdcfg->s1cdmax = master->ssid_bits;
 	max_contexts = 1 << cdcfg->s1cdmax;
 
@@ -2119,8 +2120,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	smmu_domain->stall_enabled = master->stall_enabled;
-
 	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
@@ -2459,7 +2458,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
index 5f0e7468db5f3..007758df57610 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -598,6 +598,8 @@ struct arm_smmu_ctx_desc_cfg {
 	u8				s1fmt;
 	/* log2 of the maximum number of CDs supported by this table */
 	u8				s1cdmax;
+	/* Whether CD entries in this table have the stall bit set. */
+	u8				stall_enabled:1;
 };
 
 struct arm_smmu_s2_cfg {
@@ -715,7 +717,6 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
-	bool				stall_enabled;
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
-- 
2.42.0.283.g2d96d420d3-goog

