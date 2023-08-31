Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4211CB6
	for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 17:46:02 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-58f9db8bc1dso13769067b3.3
        for <iommu@lists.linux.dev>; Thu, 31 Aug 2023 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693503961; x=1694108761; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByI1wEibb2VTlOST1QE2nymSPLoO1tZHs3WuW7YknC4=;
        b=BsoG989MWLDaN1gRpsdRdVab5LyIpef2vltc4D+HQJNlsE1mFxMepJYkdgEsYewqzn
         3whOMWuzxW5x5nLR5QKJ32wRD/FY+LqSAQ3TKwgBjFbMERLtHiFAbctQQikZQnHlXbm6
         gDxyHdN/b8BRsH2QYWe9p3pIOYaMqNAJZmLbQAYQzyxnKUX4SAQVnB0ALtsYq4DP3s4M
         tSPakelnTmcICx9RNJvip8PuutecszvCzGce7OtjZ9N/dE4rEOt+dFqzyveu64xrTdiD
         UhxCQ2NVj77W0XdP2J55vL8OQXuzloJXC6HW9IUiwAiALQ+YBD+GJyhHHbucmNC4xV12
         NYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693503961; x=1694108761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByI1wEibb2VTlOST1QE2nymSPLoO1tZHs3WuW7YknC4=;
        b=TaKQ5rWxJ1NmJe2yGiUBQ2n8j1jsnH1uH2h2iwCT2WDobKFprgWk02hEpEqf41JnWn
         MY/mOgdYWrNmv4mC1ADfEJWZBuC/TGuqrmXqynqNGDMJXLCS+0/HiuS1SfWsptBGLkzP
         6AWBMoArKR4dHMS07w74Crg6D6kKA3u2Ra7dCMWQkURARuF4eEHde72W2DwGwUJrP5xL
         ROSHGyttloaE19RA2TuPlJb5ect9+qtp+qVqna76Qg7tGuxuu5HqIbIHigHm5tiX5asA
         5i95mkvSzysG1oA4rQ/I2m9Ns3FxMsYDPOW+H6FQ9tYH5WD6kPG2Svet12M9dyMvLJwB
         hh/A==
X-Gm-Message-State: AOJu0YzraXwhcvsCPoXCwozGVCwK8rDMeddB5jGMCf+lxGwjxeJprwWX
	G5DZWtAr0g6mIzXEMJuX6+67gsq2sHpnoj9Smd4omGz5N8o5KTxDli1noq2LoL3yh1G41HmJBnE
	XyvM0e6r6baDMqaH8vmNrueGoRhSZ02gy3Lu9+BtQYj4vSBgiIyjP9O7huWy+LoA=
X-Google-Smtp-Source: AGHT+IETeP/TvPNLQEuYy1USk5YI0K7POPLA/zLoU/1XNZBN0JFR3w9Gk0WHW9caWehCDRFFCCFE2F0gY1LX
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:1a0a:7338:4a5a:5f83])
 (user=mshavit job=sendgmr) by 2002:a81:eb0a:0:b0:576:8cb6:62a9 with SMTP id
 n10-20020a81eb0a000000b005768cb662a9mr2924ywm.6.1693503960746; Thu, 31 Aug
 2023 10:46:00 -0700 (PDT)
Date: Fri,  1 Sep 2023 01:44:32 +0800
In-Reply-To: <20230831174536.103472-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230831174536.103472-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230901014413.v7.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v7 3/9] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Mark Brown <broonie@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"

This is slighlty cleaner: arm_smmu_ctx_desc_cfg is initialized in a
single function instead of having pieces set ahead-of time by its caller.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5d1977027d2c4..5bb13fadb41ad 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1132,7 +1132,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	return 0;
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
+				    struct arm_smmu_master *master)
 {
 	int ret;
 	size_t l1size;
@@ -1140,6 +1141,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
+	cdcfg->s1cdmax = master->ssid_bits;
 	max_contexts = 1 << cdcfg->s1cdmax;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -2105,7 +2107,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2118,11 +2119,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cd_table->s1cdmax = master->ssid_bits;
-
 	smmu_domain->stall_enabled = master->stall_enabled;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
 
-- 
2.42.0.283.g2d96d420d3-goog

