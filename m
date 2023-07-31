Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0201B11CBD
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 10:48:56 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-58440eb872aso58217027b3.3
        for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690800536; x=1691405336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LEwoPypxNg/0wwK9DSpnnqLrV8S3AoRDp+1fjKUE9c=;
        b=Zu64jTlkBdRIj9gwBHIkEJVYF6dZ4s91FVFh7yUrGiQNx/2i3SIoPyZB6p02M0O05+
         JkrVvisudZwOk1RmAK2Tyv4tzukWrLKNCbah+iRW+hxH/ExAyAs8Fp39H0BlmOgYGav7
         MHhAWUA99pdip43QxxiQbM5L0wEs3+ubr889qb7MgWXz2RyHiNAX+fEpEqDTTzuOoN5r
         p+HwJchlRe0WbydTE9EvRGjYFrPcvNmK5E3mr3WeLt5rMsKuQJ2XRQK7XFHd129+Z4ZE
         /a8Hiypp0fsAu5JwS773/ZODdwTlPSNmKLL2DEv65nfvXF4kXyHjcsuvmIaYEDqS6ZXI
         CC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800536; x=1691405336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LEwoPypxNg/0wwK9DSpnnqLrV8S3AoRDp+1fjKUE9c=;
        b=dCraZ+uwvizGppvuM+A4LHArhUTlzULfOXGi6vDHCzf9PHPay/PxSp5b5hPU8lJjL6
         KuaHde7CItNq17NJ6c82uedClfMJMZaWtuyRYxLkvsZ2oQ8uK9l29TTvKKgAxgGAufJx
         hKfiC0nqh/2NASXTqRjGAdwqzqQPefkDhCH5qRvVRPDjLPrrZJlsO+VLMyzWHWLjMcsr
         Af9YowGmZ51JihGtpvLQdZ90Y9dlAbKsy46RHceKLCThkOoiRau3nJx//SXyYsJTNNzk
         4ELvuATox/sMIefHm6FP0nziWYq+prZfixyaHoTSxq+0VzqEuBlJMQzU+VUs5dBNQ0ah
         5sGQ==
X-Gm-Message-State: ABy/qLbgdrGD22mhxxQORa1VRKzZMocDw8sUwLznXNyhjfiGffsatjg+
	sRaysEeCPccn1Qf/rdBfwQZe55iee+jajzGOIU3BKkpaP0t05eW6MS01sSLTiQi6jw7sxnm4djI
	yEvKnnnVt7MASo73Eo/Nd1umAPpgDodZdLGSLqnZo87HpT/5P1xOk9hAfXxbLvWg=
X-Google-Smtp-Source: APBJJlGFT8JRbNN2pllj+H+26z9eiMA1wqXAGjOqgKNZgKbHNZEnTJSje3k6Z2LOS2azPtan7cioZd2AbX0T
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:affc:ad1d:5cbb:3c6a])
 (user=mshavit job=sendgmr) by 2002:a81:b703:0:b0:584:41a6:6cd8 with SMTP id
 v3-20020a81b703000000b0058441a66cd8mr66785ywh.8.1690800535642; Mon, 31 Jul
 2023 03:48:55 -0700 (PDT)
Date: Mon, 31 Jul 2023 18:48:13 +0800
In-Reply-To: <20230731104833.800114-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230731104833.800114-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230731184817.v2.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v2 3/8] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	jean-philippe@linaro.org, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

This is slighlty cleaner: arm_smmu_ctx_desc_cfg is initialized in a
single function instead of having pieces set ahead-of time by its caller.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8cf4987dd9ec7..8a286e3838d70 100644
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
 
+	cdcfg->max_cds_bits = master->ssid_bits;
 	max_contexts = 1 << cdcfg->max_cds_bits;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -2107,7 +2109,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2120,11 +2121,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cdcfg->max_cds_bits = master->ssid_bits;
-
 	smmu_domain->stall_enabled = master->stall_enabled;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
 
-- 
2.41.0.585.gd2178a4bd4-goog

