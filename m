Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF18BE1
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 10:06:50 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id o12so57403631edb.9
        for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679393209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vobwVwu5vqkiJyoBOOEqCTxQqrEPYGoYHd5CB27XYWo=;
        b=T5Z+6j/4fPCtg4TqEi+GQjaIUa7VbmzwSp0zC5rWcIkcRjVEisq/QayMPPmE4/uioN
         884UiciCL+BgE7r3ssF0CGfXOlGVNESlj3AeP9EApbPk7C79pkSj5ptCpGKCsxnU2nnU
         mYfs07u/WegROBK9fxzTONW9GiowEX5FgGCKmfmvG51+mmiV1omsKvWO5WtqM+t7s13T
         cOqkzRozgulnMbbfDGtj3ZVGENh5UKSTRI7lBehYkrGqeCL6/QBJWQJvHGbwbmNdAUIc
         D6lcUytgIrhh/Wj33re3Q3wLuW+kRHpJ1NBqeO+u+IEEo1AfQIeFPtHRJWdDngeFw0oE
         bN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679393209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vobwVwu5vqkiJyoBOOEqCTxQqrEPYGoYHd5CB27XYWo=;
        b=eStTS427CVQGEPktPTUbQA9F7A50mLo4eJzH20Rh2TQsFPuyfyObDia2a3m7CfG7fy
         OJAcfE+TgLZmTsd7HK8rI31j7aFh2Yi+Uz33urnMOYAtzUNcKyF/n7t3VFHwPRyabKr0
         yDDGi9ytKb5awjYvclq5lwcL7jec9ULA7svGY/k+j9aAXwMWX2MP9Ude5iw8nv9oeygK
         2ZSjnx0UKt0BAdGmwCeMwqx9RfSzWbS8qct5ukBZHBjvKklh/3mYd04t3CXHrreumcRz
         US2JyUzWX9gjtPucQ5cB7rJZAiWRbi3N+lsH78nSZ3CS+U0Uw7PkAaaFpes8AszBREmY
         8ZBg==
X-Gm-Message-State: AO0yUKV3yF0W3A6Vz6eeld6/9d8o7xcI0ZdtYAXyEwUjH+WBJxszTFg0
	dmlKm5CRk/oiV1UTksKdpueSHw==
X-Google-Smtp-Source: AK7set+u3zDaizghMsvZtv651O10go/bFAsoEBHI8hxxpIo8D9WUCa6sPS18tBoxKb9KZdSgG6Z6SA==
X-Received: by 2002:a05:6402:b3c:b0:4fa:315a:cb59 with SMTP id bo28-20020a0564020b3c00b004fa315acb59mr2412600edb.12.1679393208865;
        Tue, 21 Mar 2023 03:06:48 -0700 (PDT)
Received: from localhost.localdomain (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id s2-20020a056402520200b004bbb691a334sm6006505edd.2.2023.03.21.03.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:06:48 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] iommu/arm-smmu-v3: Explain why ATS stays disabled with bypass
Date: Tue, 21 Mar 2023 10:06:00 +0000
Message-Id: <20230321100559.341981-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SMMU does not support enabling ATS for a bypass stream. Add a comment.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
As promised here:
https://lore.kernel.org/linux-iommu/Y9z3UG+wEBn4i3G2@myrica/
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f2425b0f0cd6..a8410c132f1e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2447,6 +2447,13 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	master->domain = smmu_domain;
 
+	/*
+	 * The SMMU does not support enabling ATS with bypass. When the STE is
+	 * in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests and
+	 * Translated transactions are denied as though ATS is disabled for the
+	 * stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
+	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
+	 */
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
-- 
2.39.2

