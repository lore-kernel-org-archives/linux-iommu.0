Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26749FC01
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 13:19:46 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-57320c10635so86660977b3.3
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692191986; x=1692796786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9Qph3ozTnmUe4nSAzwJ4ofPLTPQz2snZpAAblUqODc=;
        b=R4aC6QgSvBo5QxowfhE38idPGf8q1hmGNW7BOOO2y9MSVXUZIQTyuhffKF2houAS4r
         nUMeQ2VFsF0catXVantKv9p/BktAZvhr+hIswTLuSC6FM/GCxTg2PCY7qIu1ucZqxxd4
         nYTDE7V83WHpIVj7mf8n2TF80GcZWO0x8VkG6SIae/kL+daqLlE4BUkQSq9HMozOzJtb
         AgXS6dtO4E+BdRfaMTl3INjXth8Oki1oHZPUm6D7J4ykZJXYU/bYIrX/QMDDrqqVBAb6
         Q4eaFtyGTPFDnCTS8x5vn/Tt3bR6/SuUJBNRx3rCgIgXmtx1e89CHww0GMBEuCKkpywL
         kXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692191986; x=1692796786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9Qph3ozTnmUe4nSAzwJ4ofPLTPQz2snZpAAblUqODc=;
        b=DDUR71ftAsyd215Qem0+C2DlY+KLNs6K7dHzE8UqKJzfw6YY9VOWRq2zVmpC4RDi2m
         Uvp8Wb1q9jROqknFbb29ZbEvZKIT2c1XgTDJRO5Mm25EDuhYXswwhPZEFyvBmE8ZJQWI
         lboo0Vmf7pmnZOBrvWyIXhST5LWMofOl9F7Ax2dNE6IhsFPUbzPZTQcKkc9xbqHubwst
         gscXE1znkuUP+cQLkdFKb+uxcdHtxUOadJE2RfQ0UuKUq4pBQHOeXN6ZJVMJCG/Jj0KY
         QXYXuZcrZsE5vjAOQ64uIdRkFKDVgnUndwSoUXOzzOmpA2GPorAAoxQZZDU3508aoclR
         Rh+A==
X-Gm-Message-State: AOJu0Ywn7Wn5xnH03l9VQX+UBTb/wO4dH94anuv+ZiMtD6yYygkOMopl
	LgYqVGBEb0DpTDEQtdcdBE4wVNkGuy8pz2aVInOrl1Cnv7h+kgy9flhG4kgr+IAwdxtns+3KWJa
	H+ncRfYINwkxGE0MfMsKkbmqRXrFA7UKvpTfqdpxhViPpTWYAyOrWvHf3peCJNpQ=
X-Google-Smtp-Source: AGHT+IEQkGlhcowEepsZcDP4dk0vcyGvPOlRQmzOByosSK0aD9YS7+DG0MWabh67GUnpxb/n1LaxVC3xXZlM
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:ae98:2006:2abd:3434])
 (user=mshavit job=sendgmr) by 2002:a81:ae1d:0:b0:583:5471:1717 with SMTP id
 m29-20020a81ae1d000000b0058354711717mr25272ywh.10.1692191985709; Wed, 16 Aug
 2023 06:19:45 -0700 (PDT)
Date: Wed, 16 Aug 2023 21:18:43 +0800
In-Reply-To: <20230816131925.2521220-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816211849.v6.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v6 03/10] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org, 
	jgg@nvidia.com, nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
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
2.41.0.694.ge786442a9b-goog

