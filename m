Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E56101D4
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 13:21:12 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-597f461adc5so27930037b3.1
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 06:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784071; x=1695388871; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUPSRV1Y2NOennFdL40BVpulBOE2JdAWnJXz+eg2+lg=;
        b=p/zSGpVdt/UdG8dW836ECxswaxDy2Qc3inSNS7DZn7oLKB5ulkhYHMHZO5lp0zJEF9
         aKwaVLD/ePatIWK7CtPxC6LU7FscAzY9c5ypI9iAugj/dEoeOg19WXCNicBWxRkEu+UH
         eeDfYLfU80LAHZt87HJzThoG2Ex0894mK0S0LY8yqxjHNUACMvgXXljQpP5k6xvmzWqf
         gk27uzvGdXtzFYeipwCrS23WZkT9M8zXgs/5luZqK0ELyp9Qwl7OBNhxk1C31MD2JEaa
         heezfkYIYgk0Rnd9Su4tYdMnQn6rQKdPFjroay9c4KX18nhhw2jwnrknWpAP1j7OkFtw
         6QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784071; x=1695388871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUPSRV1Y2NOennFdL40BVpulBOE2JdAWnJXz+eg2+lg=;
        b=NOwJg2hPHv3t9fB9EsuR2ZL7tOYJ3AMYdxJ5Jud5GwA1YwFou+ggIiKBRa3GJkIxX1
         pEps6J7KH9PnsKIj7Z1ZKVBiQgSzb8QUqZICbzAv+5MNb6wqPs8Ki3gsRjKEfva2fkRM
         or7SIMl9AwQKomPyVmn6uK0eoOp76LM+p8fcFZQTNu0UaRCGXOFuHan6iq9Y8JaLLoAy
         5yegayZuYt3Cf6KpxYJx36oSLC7eJgjNkkX+2WPg7lG8I0/POKhN83+/ZROsaehtGVxU
         QoPQqkoVbvFhhcnMhLmLB16PMKs/2jPw0tvJW1B44YRRL6PC/ZP2ZUeZ1WjQRO94cj0x
         EBIQ==
X-Gm-Message-State: AOJu0Yyl6rgKYoanxJKsZc5KPINb9UFdYQJNTgubXbeVSeC54IL5fxUD
	09I/VWLPFg26LS7M+nQqHc3HBB4cS0ECrPYE88IQGmA6Cx03d6UmoAgGjf4E8s+MBfHuSDglZR0
	kgcUMbBIfR8jt5ICaknKvcpnb1onldJW0KrHKT+VNHCA2pFZE/uTG0SgThMpkiaw=
X-Google-Smtp-Source: AGHT+IE80sO205KDJEKcNpKH17hvdhH3ildl+E6LHEuDB+h1xgVjg474K5hdxY3HF3T1uQfxYdpv6g4XFWRm
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:47bc:d53f:1c50:a3f2])
 (user=mshavit job=sendgmr) by 2002:a81:ae49:0:b0:59b:ec33:ec70 with SMTP id
 g9-20020a81ae49000000b0059bec33ec70mr39843ywk.6.1694784071028; Fri, 15 Sep
 2023 06:21:11 -0700 (PDT)
Date: Fri, 15 Sep 2023 21:17:34 +0800
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230915132051.2646055-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915211705.v8.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
Subject: [PATCH v8 3/9] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org, 
	robin.murphy@arm.com, will@kernel.org, Michael Shavit <mshavit@google.com>, 
	Alistair Popple <apopple@nvidia.com>, Dawei Li <set_pte_at@outlook.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Tomas Krcka <krckatom@amazon.de>
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
index 1ccff6d87edf7..a9649eaeed8dc 100644
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
@@ -2087,7 +2089,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2100,11 +2101,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
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
2.42.0.459.ge4e396fd5e-goog

