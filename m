Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130D04DC89
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 18:39:07 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d10792c7582so4823646276.3
        for <iommu@lists.linux.dev>; Tue, 01 Aug 2023 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915147; x=1691519947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdJVm/jEcegurWxMLywzO5qAAqQ1pj5h79mr3KehF7s=;
        b=NCjX8nBOwUi8F1xZKBH5x+e7op40D9d9or1UJ/31nnn43FhUjQgVVJnswghBgPH1jv
         Vb5c98cc5UHCgZfr0fhdhXh+jTMOZgNRYOjMr0tgu2RUW8ug9WbdgF6VsvdQ3dKlwgaC
         VwhFQryNfghDSzHRgr7rSEJh91xhYKLlQnD2CYFgHITXk/2R2nZMCoihOwYovDp/23Mq
         4vxtjNToG+SabGbYBpNuPetkIJVTsfnfEDEeBlyDKsXL+8t6T11TKQRii0ULQHZETF9O
         KfiLHg3wtwPMxPJtE+aVu5A4aqedoLqXQ5gahHT3xZ5ivNG9lvzGS+A5oVZ7jarfczt6
         MMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915147; x=1691519947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdJVm/jEcegurWxMLywzO5qAAqQ1pj5h79mr3KehF7s=;
        b=kjM/yPJRrD7KDSGQZGrus9/T2wDRc1NrpqXEGRY8D50g0ZxNPT+BjbzMOC7DorZjZw
         r0q2iTdq3dez4LLpXvpbhcfQysHJf4Oj9Sf2Duo7zHVQkzIzulOiwdPVoRUJZwvB8lT8
         CN59KmyzFnxglXSmBm//FCTtUlKiMDHfwEavp+tBmgDDTB7pprFxHpTfgSpmWcFNZ0JW
         q8L+x5WcAWjcR6CPevP5ZoALKn9YuLphL3JTvrr7KnU5uG+2MSmNBZQXF2aUh676d7ku
         tfOlIw47I7cAnXNee1FOuoD3w+yX+qY7o8ljgpDmzR8FdrwsvT99386u1ztrfc5haQfv
         sjIA==
X-Gm-Message-State: ABy/qLb/rcuAZkykbtOLagDAVkg1vtxqKxpSlvA3O0NQs6CEGYWphs/7
	ln1XwsOKep7qvpxqxdspls8GBnYM2US/+DNBs27dfRyM0ob0O5cdeHjKtScffc9XXo1HmZqDxVg
	KY84MgIU6dYlF/87lRcGGncb91GUq1GaGk7EHvPUHd4zUM0QiWW+fNhn4vvR0I6c=
X-Google-Smtp-Source: APBJJlHCy/eD1nfcypDGAcoiCb+YNa0Afat43VBJmS6hV3eCZMQEtRQ92r8y5gfPrjhq8h5mdGvrfXC8oJ22
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a54:d53d:50e4:b5b8])
 (user=mshavit job=sendgmr) by 2002:a25:86cb:0:b0:d13:856b:c10a with SMTP id
 y11-20020a2586cb000000b00d13856bc10amr93266ybm.3.1690915146152; Tue, 01 Aug
 2023 11:39:06 -0700 (PDT)
Date: Wed,  2 Aug 2023 02:35:20 +0800
In-Reply-To: <20230801183845.4026101-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230801183845.4026101-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802023524.v3.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v3 3/8] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"

This is slighlty cleaner: arm_smmu_ctx_desc_cfg is initialized in a
single function instead of having pieces set ahead-of time by its caller.

Signed-off-by: Michael Shavit <mshavit@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ded613aedbb04..fe4b19c3b8dee 100644
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
-	struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2120,11 +2121,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cd_table->max_cds_bits = master->ssid_bits;
-
 	smmu_domain->stall_enabled = master->stall_enabled;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
 
-- 
2.41.0.585.gd2178a4bd4-goog

