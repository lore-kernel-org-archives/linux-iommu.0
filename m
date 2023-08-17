Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB114AA6
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 18:21:33 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d6ac5db336eso166199276.2
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296492; x=1692901292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZP10bOrqJHL85lu3Z2lUx2alTLUFh+2Q6vzg89i9Wk=;
        b=3SMQXfpShml6d9+BtmaqOK2GzQznRL6kyxmNNpDAk0CT1TqSZj14kVaCyjAuoY8Ax4
         pUoE56xlNXNLOnXa9v2+/+DYWOtsfnIr1hiKC74FNdVVnrb/NQyojV5sLfI+Ffxg4ETV
         vRSA3YuSgWM7b0p3cR9XpwMtJEcS8nvF/1VpsdGANQjIZqUBDhgQWlHzpa5J75wKpO6Y
         qdqiK+/eWkHNqYp5fC/ATsxKWHE1j8rC+FNhpi4zsemW9RbIgorSVC8P/o7+Ur7AF02N
         zRfO9DP/B96rozUkWWcJhzFNNMBQW9IcwC+Rw1SZXEmJsB/7TtigLri8zQzxJjqpHC+L
         PQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296492; x=1692901292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZP10bOrqJHL85lu3Z2lUx2alTLUFh+2Q6vzg89i9Wk=;
        b=CHqKlxAQSurHTG2F+HlGmL0kHx20JDeoHujpVIOClCrXeGCQ51fJVekn929NzVXxoE
         CKjalcfsDsEhtbh1w90GBwpTp13S56it/BDEUnGvRkiY1ZhVT7IyobqPLuX1Dfhjz2Kc
         fn1V+1tTgpmvzBd/R5LdQWPql3asDnD88jVOxH6NXmLEyOQuxDl44Ya54sMl+YiAg/o3
         136bq/IjgeVgRto0bOnWMW33Ehu1a6f+kCva6KhkjF65PEs5OcrGaEKFus+BFy+KTh/V
         iNsYaV7YRyPViR5FD+JxntreXF40bvWZeF0F31MrgWuVrMtjDxNUNk1FdXB7dwnDLSk6
         GLWg==
X-Gm-Message-State: AOJu0YyImkeTKMHo8eZxRbcSa279ABIPYhsfi76ENpLn3iD2nxLGCCDR
	axF4XbgXs0MP+4dmIBlhVTCkgbTtOU3zuUgfD8zN5Kj2H3ExSOViMeS6Vkui4RplgqL7Fik8YCQ
	jRUhRMeyf0693a4N5tQSywVc2IaaTtMURXmSIRDTe8LmetsnyC7nlOnliCdMYm7M=
X-Google-Smtp-Source: AGHT+IGbdbNVPcRg1sbArh45fkt6h+fxSGJJucKE8ciso+2BfxjvcUKG1RiUX+bGIUHNJJUh65fH4VC/apu1
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a05:6902:144e:b0:d44:585f:dfa8 with SMTP
 id a14-20020a056902144e00b00d44585fdfa8mr5677ybv.0.1692296492062; Thu, 17 Aug
 2023 11:21:32 -0700 (PDT)
Date: Fri, 18 Aug 2023 02:16:27 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.5.Ia591869e7a4b88af16a57e09c92df21599d3312c@changeid>
Subject: [RFC PATCH v1 5/8] iommu/arm-smmu-v3: Add arm_smmu_device as a
 parameter to domain_finalise
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com, tina.zhang@intel.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove the usage of arm_smmu_domain->smmu in arm_smmu_domain_finalise to
prepare for the commit where a domain can be attached to multiple
masters.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c0943cf3c09ca..208fec5fba462 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2132,11 +2132,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_device *smmu,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
 	u32 asid;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2169,10 +2169,10 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_device *smmu,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr;
 
@@ -2227,15 +2227,16 @@ static int arm_smmu_prepare_pgtbl_cfg(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain,
+				    struct arm_smmu_device *smmu)
 {
 	int ret;
 	enum io_pgtable_fmt fmt;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
+				 struct arm_smmu_device *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct io_pgtable_cfg *pgtbl_cfg = &smmu_domain->pgtbl_cfg;
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
@@ -2275,7 +2276,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg->ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, smmu, pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2585,7 +2586,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain);
+		ret = arm_smmu_domain_finalise(domain, smmu);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu)
-- 
2.42.0.rc1.204.g551eb34607-goog

