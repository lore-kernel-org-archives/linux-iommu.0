Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609F7C433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 11:56:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFCC3239EE
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 11:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCC3239EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 446F086A85;
	Fri, 22 Jan 2021 11:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wgp8jFrKRJK4; Fri, 22 Jan 2021 11:56:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3CB0386A5B;
	Fri, 22 Jan 2021 11:56:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2877DC08A1;
	Fri, 22 Jan 2021 11:56:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18CF9C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 11:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E77F021514
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 11:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KnI3E2q8uiwZ for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 11:56:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by silver.osuosl.org (Postfix) with ESMTPS id 0377C2DE22
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 11:56:31 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id b5so4806114wrr.10
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 03:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=owZkjSFOA0fuCp5k3fuGX+G2Hp6YSx1juCTT9XbA4kE=;
 b=Yfotiij4PbT44jIwb874ov94q9TaJDIr5uPZmkTQVPdRZWtdCst/v6l+xeo4jnWBMu
 MlaCnH3+Gxgv079JfZb4MTr/GSo8Yb9GWJYxYabZzRq52FufOyZVmHwxraQ/KzVJ92lb
 BtuQ/4V+F0ZHuIlCOhmXQGEvbOZyseb/36c95qb0YJ6y1KeUIKROkvjCPixnXwpQqx4k
 XTx2C6Z8u+pi8+F6APbGGv8P6Q2D+kfR50/YNse42JxmWoVZqPDnR5zq5I8Ei6fFB6Tt
 ZA5MiHUhwp1eHSEglPQgJIcmJ13JceHsZtcZ1y6nJnnvnG+hHOHBwirNFms2VxXD/BHt
 IwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=owZkjSFOA0fuCp5k3fuGX+G2Hp6YSx1juCTT9XbA4kE=;
 b=DgMeQgKFwYRwERkjjl8UBgYlmp8g5W912/iyxCDIlnrGuU1NpEbmfVMezN2tKZOwGJ
 NulTONZSd1QcZgTmzgecE1OQdeaSyGxYPoYmvOWR5B/3isiGcbxecQAmh0dbY3EAPLdU
 sdv+QA1NddMJpMDZ3hN0VctDEA3y1dV/kXIYEAoOR2gctEOYPbF5FgyRfYMBmeJ7B3x9
 aaBT1F0m6xOXN9aLM/JHFaxWEDdvFIOqDVM6uGvuWR1rYD6tEESXSkiU8vebOVhHMQDd
 FMkdJXIW0iY+v9y7y/BvuCab9ANlWQr6tt6BxC+y6VwqCpOmoK1GruAWK++N6BVt6QmO
 1Hqw==
X-Gm-Message-State: AOAM533CxRC1ixuJMhAt/w6n/D28zw/JDJvBlVm5xVnt9rbZz8mYBa/w
 ox7Yv/uN4DN/zh66OQkHxvCaVg==
X-Google-Smtp-Source: ABdhPJxmWG1lTuXpvqqZl1ip4r8FU//sAdGE7mIr6uOeJ1+qwBEyt54qF3kDGQgJMOB/K5vmESCGbg==
X-Received: by 2002:adf:fd10:: with SMTP id e16mr3952999wrr.376.1611316589591; 
 Fri, 22 Jan 2021 03:56:29 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s25sm13293901wrs.49.2021.01.22.03.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 03:56:29 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Subject: [PATCH 2/3] iommu/arm-smmu-v3: Make BTM optional for SVA
Date: Fri, 22 Jan 2021 12:52:57 +0100
Message-Id: <20210122115257.2502526-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210122115257.2502526-1-jean-philippe@linaro.org>
References: <20210122115257.2502526-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, vivek.gautam@arm.com,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When BTM isn't supported by the SMMU, send invalidations on the
command queue.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  3 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 14 +++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 14 ++++++++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index a6536c2b32d0..652d03ad8ae6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -743,6 +743,9 @@ extern struct arm_smmu_ctx_desc quiet_cd;
 int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
+void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
+				 size_t granule, bool leaf,
+				 struct arm_smmu_domain *smmu_domain);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 642ce2c225b5..ad8cf62a8f83 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -16,6 +16,7 @@ struct arm_smmu_mmu_notifier {
 	struct mmu_notifier		mn;
 	struct arm_smmu_ctx_desc	*cd;
 	bool				cleared;
+	bool				tlb_inv_command;
 	refcount_t			refs;
 	struct list_head		list;
 	struct arm_smmu_domain		*domain;
@@ -182,9 +183,13 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 					 unsigned long start, unsigned long end)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
+	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	size_t size = end - start + 1;
 
-	arm_smmu_atc_inv_domain(smmu_mn->domain, mm->pasid, start,
-				end - start + 1);
+	if (smmu_mn->tlb_inv_command)
+		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
+					    PAGE_SIZE, false, smmu_domain);
+	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -253,6 +258,9 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 	smmu_mn->domain = smmu_domain;
 	smmu_mn->mn.ops = &arm_smmu_mmu_notifier_ops;
 
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
+		smmu_mn->tlb_inv_command = true;
+
 	ret = mmu_notifier_register(&smmu_mn->mn, mm);
 	if (ret) {
 		kfree(smmu_mn);
@@ -404,7 +412,7 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 	unsigned long reg, fld;
 	unsigned long oas;
 	unsigned long asid_bits;
-	u32 feat_mask = ARM_SMMU_FEAT_BTM | ARM_SMMU_FEAT_COHERENCY;
+	u32 feat_mask = ARM_SMMU_FEAT_COHERENCY;
 
 	if (vabits_actual == 52)
 		feat_mask |= ARM_SMMU_FEAT_VAX;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a27b074d5c0c..db545834493b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2018,6 +2018,20 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 	arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
 }
 
+void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
+				 size_t granule, bool leaf,
+				 struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode	= CMDQ_OP_TLBI_NH_VA,
+		.tlbi = {
+			.asid	= asid,
+			.leaf	= leaf,
+		},
+	};
+	arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
+}
+
 static void arm_smmu_tlb_inv_page_nosync(struct iommu_iotlb_gather *gather,
 					 unsigned long iova, size_t granule,
 					 void *cookie)
-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
