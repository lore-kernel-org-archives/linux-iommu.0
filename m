Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414B747D
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 16:33:49 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5840614b13cso981517b3.0
        for <iommu@lists.linux.dev>; Wed, 02 Aug 2023 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690994029; x=1691598829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGhWSbzc4cZej0FeJJbc3VXFTtBzmMATq60yYbQRCzk=;
        b=Wfmjss+UWmZsCytY4z2zpjHfRx8D5zoF9UEpfx4Rmioi27engfbfmtGjsJKQWBcyVf
         QS5jrHEj985TIIPJU2Mfx45hFU3uZrL0e52dgYK7tVtA9xaCfnfD2ihgwvbDsnbWO4Ag
         So0UGVMoWSVnDk+FESZFRihVwOytovkaGPzW4T8N0gSCoM2jXawxIf3LpwlN5Khp+pah
         yjcreTw1ONoQ8cMSKG2QPznIeGjCQIWll17RNVuYyACk1GcDPSczUDF/RDsO9l6A46K0
         0Lcty3jmaLU2xZl9Y76nI9/56Xbhl0emopedb/DqA/C06TZARGBtPULdRn5u2XTvcmw/
         kOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994029; x=1691598829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGhWSbzc4cZej0FeJJbc3VXFTtBzmMATq60yYbQRCzk=;
        b=ew9jVG+FNM7zAnw8Wwpglf29LwyNBUVYLxcMGEFIZs6QT4BSnrYFScbToFaUk2qkXR
         F34aVvEJ9jSQObWZQnac2odMVRDPoP/Lzqr0jtcyVQOlGXQhE2PnUegz7e8QaDC+1X0D
         1CTvbe36zYeSZEL0nRhiCq8L4J4CJv3TeHdDl3ItvN/igrMgCn01l3RQGOZurnkt1XrU
         /jqkZUXIYuLxxmIEP1P7vFRNH7GlVPBGl7btK5kdHiwWEPhj89XUtUL0VApo2nEX6xQY
         4sX2mA7M5Pu993JzpSCBiWkfenV7EsdCTtuOliZxzV4VSu6LBoB2LwvQaX+Huh5MtazC
         0YHQ==
X-Gm-Message-State: ABy/qLY0pr6fWP++BWPRcWJIFUDUL6Y2tze4lj7B3SnchA4iSP6M9nWL
	gj/m+Ju5XvCFhme5ikDhmo3hWHrRuXpliHL6fHE7f7wFuuW8SnBAmU+YwvrIeiz7urFxUW7cRxj
	j5iAZ4XWU+LGVdc6MKWweH20NkGiqeO7/zLvo4/UYo0jWgrF7ikzUEktdy5+dgtM=
X-Google-Smtp-Source: APBJJlFrdCMuLTcNvB4PEmrjrdw1E2K0mx6VOTk63TBd4jAAKLgWBwBxXteZbNG1vw2PQrNREyOTvEazvG+L
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a81:ad5b:0:b0:56c:e9fe:3cb4 with SMTP id
 l27-20020a81ad5b000000b0056ce9fe3cb4mr227897ywk.1.1690994028873; Wed, 02 Aug
 2023 09:33:48 -0700 (PDT)
Date: Thu,  3 Aug 2023 00:32:31 +0800
In-Reply-To: <20230802163328.2623773-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803003234.v4.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v4 3/8] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	jean-philippe@linaro.org, Michael Shavit <mshavit@google.com>
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
index ded613aedbb0..fe4b19c3b8de 100644
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

