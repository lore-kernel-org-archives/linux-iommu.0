Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A64944D
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 10:58:09 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-58419550c3aso64371267b3.0
        for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701888; x=1693306688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPo4bS6bgF3iXXZFHRw7dDnws1JAiCkzNYGL3i11bCA=;
        b=G9KK9ylHQI5OWSDfOp+7cRr1Fivor9iPR8DIjXzyjBh044lMNgN1fqnAOfydp6Hhmw
         kTncI4gWfYaJubVdTrkAK0lAzqIYbcwLYJ5Jn2LBO5EhgPMsU4Nj3H91PzOJRXPr52+T
         5Sj2nysxAoFLiMLc/n9zevqR+3/RYVauTWETV9FWRAeIR2qwnyrVqB5wh43B1GqPl9iP
         tX+ACphS8chVFv5ZnZ4LkuoVuivQmIySAmW4ghHjXZASRC88TJX5az/jegGpffuSHq7r
         SU6o4J2Lm2nYNPs4qh5fN+XOhBbDWZko7TGPrVTj3I81cYkD9E5v4+LK5AR8RHvS3wgn
         AORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701888; x=1693306688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPo4bS6bgF3iXXZFHRw7dDnws1JAiCkzNYGL3i11bCA=;
        b=Rd2uRJ6hlXcwdwnzrxFpLA7+BtEgs4wWg/uXaRvsZxlbnpwRBgliPs5daLe8uF878g
         mMV5XbdsU0lcrsc9mn722P0QALw4S3tMtpq2vxXNQfAVk612lOdVZV+hCitJgDqyF9Rn
         jlHjwTees5Oayp7RKeDIn8UUFySFb4uhx2He55oP6v6utyMXiaXYXUrPdlX56dWoxWz6
         pfEBOZXDCKzsLICCIorIzLsQjoHXjmvGMGYk0yBnnDsQI0FF2ql8dNphHcbd4Sj1ydJO
         KkO6G4ASuN3tZJN5JF1XCHAbvzhHehb6NPS9Kf0nrVAGmfUIZi+WhS1TUS/qCNhPaKdw
         RQgQ==
X-Gm-Message-State: AOJu0YyUWGZpsQfaC88bGjQi8wE3VJVn0CVc3T+pXWq+/jRBp/awz+Fx
	LQIKiWLjopwPMRmQDaP6OZk5mgt2oSQDxBdod0fd8H+dJhJr4llpcVMPwMkYkK1+44KWd1hsPGw
	E7ms6ZaK4As+KCf0G7wPSSjRCquYIZ1OdsgA2ludo2Rnqc+l7rGmLUizDmhtm1Qc=
X-Google-Smtp-Source: AGHT+IGycL7gl1G8U6+jtg4VRe9A9eG9SI5H/YWMDuChD5JZkIw+01izdKdnZi/mhqaqG1fmzSy3xGc6ZnnE
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a05:690c:368b:b0:589:dbc8:3d11 with SMTP
 id fu11-20020a05690c368b00b00589dbc83d11mr97018ywb.9.1692701888099; Tue, 22
 Aug 2023 03:58:08 -0700 (PDT)
Date: Tue, 22 Aug 2023 18:57:01 +0800
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822185632.RFC.v2.5.If0dc099688d13ce9e661a1e4a1339030f243ff39@changeid>
Subject: [RFC PATCH v2 5/9] iommu/arm-smmu-v3: Alloc vmid from global pool
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

Consistent with how ASIDs are allocated, allocate VMIds from a global
pool instead of a per-SMMU pool. This allows the domain to be attached
onto multiple SMMUs.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
As discussed in v1 RFC, an alternative would be to support assigning a
different VMID/ASID to a domain for each SMMU that it is installed to.
This is more flexible but will require more work to achieve.

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1d072fd38a2d6..9adc2cedd487b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -73,6 +73,7 @@ struct arm_smmu_option_prop {
 
 DEFINE_XARRAY_ALLOC1(arm_smmu_asid_xa);
 DEFINE_MUTEX(arm_smmu_asid_lock);
+DEFINE_IDA(arm_smmu_vmid_ida);
 
 /*
  * Special value used by SVA when a process dies, to quiesce a CD without
@@ -2130,7 +2131,6 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 static void arm_smmu_domain_free(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
@@ -2143,7 +2143,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 		if (cfg->vmid)
-			ida_free(&smmu->vmid_map, cfg->vmid);
+			ida_free(&arm_smmu_vmid_ida, cfg->vmid);
 	}
 
 	kfree(smmu_domain);
@@ -2195,7 +2195,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr;
 
 	/* Reserve VMID 0 for stage-2 bypass STEs */
-	vmid = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
+	vmid = ida_alloc_range(&arm_smmu_vmid_ida, 1, (1 << smmu->vmid_bits) - 1,
 			       GFP_KERNEL);
 	if (vmid < 0)
 		return vmid;
@@ -3169,9 +3169,6 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 	reg  = smmu->strtab_cfg.strtab_dma & STRTAB_BASE_ADDR_MASK;
 	reg |= STRTAB_BASE_RA;
 	smmu->strtab_cfg.strtab_base = reg;
-
-	ida_init(&smmu->vmid_map);
-
 	return 0;
 }
 
@@ -3995,7 +3992,6 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
 	iopf_queue_free(smmu->evtq.iopf);
-	ida_destroy(&smmu->vmid_map);
 }
 
 static void arm_smmu_device_shutdown(struct platform_device *pdev)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index b0cf9c33e6bcd..1661d3252bac5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -670,7 +670,6 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_MAX_VMIDS		(1 << 16)
 	unsigned int			vmid_bits;
-	struct ida			vmid_map;
 
 	unsigned int			ssid_bits;
 	unsigned int			sid_bits;
-- 
2.42.0.rc1.204.g551eb34607-goog

