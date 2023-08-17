Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B726D14AA6
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 18:21:46 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-cf4cb742715so157820276.2
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 11:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296505; x=1692901305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBooMpaGlkQ+FKKABWmvIlNH9aUPRTcSS6CTCMQ9kRM=;
        b=IU2UOZ1QAkZfOcMGg5vcsJJHh9ZQj9hhxtEDAYymf3rWNhFaqWW+6INaMkoyKxt/oE
         Kaqvuj+X/pxgIK2TiTFUz0WzsHSgyKWS2ZHyj2Hj43tq7Hr69oibRlmjOv8YImpM7OIV
         9u3bHZgKiIQbgOPeaKpTQ+kaemWaVvBB3iWU+3PEWGmyQY6v+wO7PHV/kAo4zw+G1ugz
         mhFC+iuG27Yd3uMkvWXhaPZhcM8v7uoVO4GDfIWF9C6ZmyyycifTgv9BjPqaUlTr8GVS
         r6LVXt1zs+RHdu5RadGCtpslOLsMzFZd/mXaGR/d8Zfs3hVW2VKBl03OxCrI41Dupwpr
         gSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296505; x=1692901305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBooMpaGlkQ+FKKABWmvIlNH9aUPRTcSS6CTCMQ9kRM=;
        b=NumB/aY0Cg6/TnwrO0g4zx1/q1dXPDgRBXaaDuxlaHJKaQSuug9FUMaANY5JGzGP6o
         kPKKxjvU+hgUVdtKTHzSZrnh/cE9plzuK8iECC4HHqofezkSAgke2l1P/4ylL30DEZaL
         +7tl/PYV/aFAOJ0IsVJJY59cu9Z1zkIS1UO8Id8iYxZvUvG1qus3ad7Z94OZB+U5Qtr2
         12NEkyHOuAQYBpDZk0L3g5lio02VZF/VtKPFtzbRccz/I2rnFLjHPnLYNAYaFEFqTBnx
         Go5sgxlpp7IAjY3i/BL3Jseepv27ma3fHpfyCTe9RUML6qt4vLxFtl8NJBJwOB8ohFb5
         v9SQ==
X-Gm-Message-State: AOJu0Yw2+SrVFOQRty9Fj0QysmzjRO/kcDA0BCTvVWsM15TgrSqwUKHe
	LTSpbDvCyuyTYb3bD8k8sH+CxLljo2LriZ1AJ7n2w7FYnZfB678H5rqKNlgX6cyHQ71CHC8Ragi
	P+aFj+MCqa3FWzD5yCs9+vDXRt30vHz4kZHXd3gjQbamxmXmUAdahgCA14HlXaCA=
X-Google-Smtp-Source: AGHT+IEqqWWy632gyVQWnMmINQsSMRfInztWWbMpGG+vOabJBtHCJeGHnGFeZG2cljxVwoXwgg50KcnBmYwN
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a25:494:0:b0:d12:d6e4:a08d with SMTP id
 142-20020a250494000000b00d12d6e4a08dmr4183ybe.7.1692296505437; Thu, 17 Aug
 2023 11:21:45 -0700 (PDT)
Date: Fri, 18 Aug 2023 02:16:30 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.8.I5d374dbc818b209e911ef5fbf43de6df0d7ac40b@changeid>
Subject: [RFC PATCH v1 8/8] iommu/arm-smmu-v3: allow multi-SMMU domain installs
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com, tina.zhang@intel.com, 
	jean-philippe@linaro.org, robin.murphy@arm.com, 
	Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove the arm_smmu_domain->smmu handle now that a domain may be
attached to devices with different upstream SMMUs.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 +--
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c9f89f4f47721..08594612a81a8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2587,13 +2587,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	mutex_lock(&smmu_domain->init_mutex);
 
-	if (!smmu_domain->smmu) {
-		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, smmu);
-		if (ret)
-			smmu_domain->smmu = NULL;
-	} else if (smmu_domain->smmu != smmu)
-		ret = -EINVAL;
+	if (!smmu_domain->pgtbl_ops)
+		ret = arm_smmu_domain_finalise(&smmu_domain->domain, smmu);
 
 	mutex_unlock(&smmu_domain->init_mutex);
 	if (ret)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 143b287be2f8b..342fa6ef837ab 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -726,8 +726,7 @@ enum arm_smmu_domain_stage {
 };
 
 struct arm_smmu_domain {
-	struct arm_smmu_device		*smmu;
-	struct mutex			init_mutex; /* Protects smmu pointer */
+	struct mutex			init_mutex; /* Protects pgtbl_ops pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
 	struct io_pgtable_cfg		pgtbl_cfg;
-- 
2.42.0.rc1.204.g551eb34607-goog

