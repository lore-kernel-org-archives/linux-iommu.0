Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1217944D
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 10:58:26 +0000 (UTC)
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-268476c3b2aso6561296a91.1
        for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 03:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701906; x=1693306706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gv8qs8tb5+ht3xEXCO2MlfdAXc51HHEhUztVM4QYf7k=;
        b=XxR0LNcd6ZMLLCXEsgVSgiM0m2dvGOpGJ0H2y2I3Ztbzt8plf5Zs/4VNYjeQOFpry+
         PH2HqrjjVyT6YxZ0ZowGRVgJRmlhAZziZAfr8pHS5GaUhXmpfF+xIN8sFcmU+VoQt6jf
         vg3KT/vuCq2HJIN/0b20FjE97XCf5ZOP7uVIA8O/OCVtNAP0HVbSntANTxWg/EcMcSxH
         R2UP3T6vuQvik0z9gG1HI/Zbn+2pPHPvZv+kPu+c7PlQhUh/60zo8gc/U/LQaRzF5NLz
         gJKIgjHkQfwHgvdR7MHN1Gw86BsVoxJ55knBkY5sEEGZdpPjIn/teqw7obJvPgVEFyXC
         Op7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701906; x=1693306706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gv8qs8tb5+ht3xEXCO2MlfdAXc51HHEhUztVM4QYf7k=;
        b=C6JxhF7Mshv3Ltdr0pHZpOifFF48iTKw045wtnsAvpQWU6phJeg35w3+P9JelFVFpS
         C6SNSfLrA2AOnjqSkcDzhpyDS38qgQ5EUTNaXIcifrrzZcze/wHeeIp0WzoChGHTUk1J
         DWyjgZSMr8sL8aQ4o0IY6vocFvdQ89GUSDAECyIw4Dsltmi7U8f/T2lUAiOaXOaLEeCE
         o+cFc9bO31HMx/t7hLZG7suanjbqOlchd0ES7FjP19W3+ZujMzR/KvsYbYIiAT6O+Gfo
         AhEZNIWlLUJlw54uBdSh4wHMJ7vdV2Ax1sLs5GlrEU4Rj0iPtAPSHrP3Ia1dd9nfdGZE
         AKdg==
X-Gm-Message-State: AOJu0YxcvZ965Hzy+8rXvgKaBERWhHJFX6RjfCtLHLe/uDTqFguopNsa
	QBwf7Hjw7+XyaUCttXs+k5I//f4wFlziCDHk2ivupz1jp3H9TofgwTUEIGY31lDCEflhXN2iLW6
	La60qtcVQEzeiO90/4qJWohkzEg5eFlHQ7R1MpzsQYSGQU+xZPutmSvISkKwgkYw=
X-Google-Smtp-Source: AGHT+IHY7P3AGtuprqqUV/dDekDb2kOfyGnlyTzMrT8+CEylyDp3RWzdk6ztQiyu+b0tkcWobWMgKFfrKVgj
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a17:90a:a58f:b0:268:38e3:34f0 with SMTP id
 b15-20020a17090aa58f00b0026838e334f0mr1756657pjq.2.1692701906060; Tue, 22 Aug
 2023 03:58:26 -0700 (PDT)
Date: Tue, 22 Aug 2023 18:57:05 +0800
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822185632.RFC.v2.9.I5d374dbc818b209e911ef5fbf43de6df0d7ac40b@changeid>
Subject: [RFC PATCH v2 9/9] iommu/arm-smmu-v3: allow multi-SMMU domain installs.
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

Remove the arm_smmu_domain->smmu handle now that a domain may be
attached to devices with different upstream SMMUs.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +--
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9f8b701771fc3..55c0b8aecfb0a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2564,13 +2564,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	mutex_lock(&smmu_domain->init_mutex);
 
-	if (!smmu_domain->smmu) {
-		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, smmu);
-		if (ret)
-			smmu_domain->smmu = NULL;
-	} else if (smmu_domain->smmu != smmu ||
-		   !arm_smmu_verify_domain_compatible(smmu, smmu_domain))
+	if (!smmu_domain->pgtbl_ops)
+		ret = arm_smmu_domain_finalise(&smmu_domain->domain, smmu);
+	else if (!arm_smmu_verify_domain_compatible(smmu, smmu_domain))
 		ret = -EINVAL;
 
 	mutex_unlock(&smmu_domain->init_mutex);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1661d3252bac5..fcf3845f4659c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -716,8 +716,7 @@ enum arm_smmu_domain_stage {
 };
 
 struct arm_smmu_domain {
-	struct arm_smmu_device		*smmu;
-	struct mutex			init_mutex; /* Protects smmu pointer */
+	struct mutex			init_mutex; /* Protects pgtbl_ops pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
 	atomic_t			nr_ats_masters;
-- 
2.42.0.rc1.204.g551eb34607-goog

