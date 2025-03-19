Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09461E1DF4
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395451; cv=none; b=g7rY1UuHTrYCY62wyOPJ+QZvPjBtLiBQFvroHbFdCpNRq7hMpEDYR2v4mIWL4ea1D6bUoZyV5n0ZJZasGiXNsqTHr3ktBNcYGP9WvN1QUln+PiPYlhSUvS6SaqFXzJdTIGI9VpaM8HE8c051/n9INPGp9ZduU4UJPHCpNzPHqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395451; c=relaxed/simple;
	bh=/ySPkR/aTeuRK+/xkC1Wp/+XmiGAN99nf8Z+rdcy/nM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxFxVu6PkrZjyoWR/Plb+o8bAabVzE3sBkDI9KOwVSnXz24ZMgCii7tnh2P9pzgC7YV9hU7PcSVgYQlUhHcCjK7hY2J+Kk3/nyS1EcFehy8nYxxmDuHn4SKvzhAZmgh1lo8ZdN+Lwt66SgIwia0/sIYjgZ9xgXUUmSppnGClWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9g/NI/X; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9g/NI/X"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5528c98bdso28942985a.1
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742395448; x=1743000248; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AS2XW5pVq0bthsTGPB5Ou/UximnBEjkkBn7KlYu8Dbk=;
        b=S9g/NI/Xav1Hv+UYCz/yLo6ogNV6uEPIwJgKGJZJAInBTgUe+dEAhB670AXHh0hYy4
         ovDjW4b+5uFrtIRE562uCBx2TCTrDT0ngJFxHiM3dKn56KY3mIEk9DRpW9TQIjSu0bvm
         HqmUklnqutWGAfmzwQz9F4ZJJYm3Eq2ah0QzAQk1rPXs7w48IwI080gEr31dHNbC3IXH
         3AoxnZT6PVOMPXg9czcCd8J4gNq1hnEbFHkMQH86kjMCcL8RopPKV/5qWk5baivggtK1
         nlCObFlEFkHe2Jmifv9bvnXaz2PNFx2uiJ+3Vx4OgCaoNN6bxUe94PHp85XZCCzmeaZ4
         vjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395448; x=1743000248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AS2XW5pVq0bthsTGPB5Ou/UximnBEjkkBn7KlYu8Dbk=;
        b=QI13VAP3jGqRRP5JdU8kjnF9LoLxjO5XD/F5i028tzmk1ZFIPBztuqlieCAqR9/7F/
         fWvujZJV/iat3MTkhPZ76jsAvBx5/HreqEiw+bDpZk09goGL+mmM7si9cmtbJIE9ViE/
         EdMUrIDnjVy0CunHxKkdlRHOTiG7BCrc0GtAjt5rHavui9rOUwLSSovODz+au86AXAD6
         zYwWYtoLPOK06laMjsF5Dz726OAZ9UljMOXKaiLaEBnxKs0/aURpyOaO7ss+T+hG44q1
         t7AOzIFPNcF3gvpXJrmVP4XQjve3DUPrcCrHHbizvhB6tXT55lTTPOhyeSZj7HdIV/QY
         J6XQ==
X-Gm-Message-State: AOJu0YxZs8zHav+wTqLgguCjkJ9M5seZwv2NOqiKWfjjl61zGSbBa5L2
	8HSt/HcnOVnaXvcjfE7383LbiYxkQGS73Ixp4YdOXBEkEM80vY7s
X-Gm-Gg: ASbGncs59FbAHK3tPTbvaCG4YvqDi5SHI/pQOwr8wImw5XJqEIWkcgW1bVu4QwszP50
	BRgIydgwWTlEClnl53uKUbkw+ckVxstxwXysB+PcqVDgd8YEgEtyzclGoevRhWuHMHe0GazVHwE
	j6ajGBD3MtOKfcKy3l4GeLdtGA7nfnIJd8j2i8dXOg/9dFaP8ZgjQdW9Z8VfxVORaUvTVnjzq61
	ltIyshZ6igedn71jQJ9rkxgV5SYC8wNTeh/suN+HBvhIKPgOm6GOdaALhKwncwyX0nD03Wa+Kme
	G2d6sXDfmmD677LiPzDoL9gVPhUpbUTUgi8ORajHgfFhMyg4d/T53n8VNIpMUszqj6cM369QGts
	YOe0=
X-Google-Smtp-Source: AGHT+IEUBVxNH3Lj7tUjS4Mop+GMxjYMq/idGTGfkbzDE/H+cThDC2WmGJXmJn8+8iyby/rSDnLTuw==
X-Received: by 2002:a05:620a:2907:b0:7c5:606e:763 with SMTP id af79cd13be357-7c5a83dac18mr168535685a.6.1742395448390;
        Wed, 19 Mar 2025 07:44:08 -0700 (PDT)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c5201fsm868587485a.23.2025.03.19.07.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:44:07 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Wed, 19 Mar 2025 10:44:00 -0400
Subject: [PATCH v5 1/5] iommu/arm-smmu: Save additional information on
 context fault
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-msm-gpu-fault-fixes-next-v5-1-97561209dd8c@gmail.com>
References: <20250319-msm-gpu-fault-fixes-next-v5-0-97561209dd8c@gmail.com>
In-Reply-To: <20250319-msm-gpu-fault-fixes-next-v5-0-97561209dd8c@gmail.com>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org, 
 Connor Abbott <cwabbott0@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742395446; l=6457;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=/ySPkR/aTeuRK+/xkC1Wp/+XmiGAN99nf8Z+rdcy/nM=;
 b=pW8dnSeUfSbbfScY5Vu7vapW0rnsWlSENK31M8LwJ9ZeP96qlfErtrGGKpYyBtWsx1mMigWyp
 vKyhFyEZW4TCrO317brQ3fcTSH96lKmKEef17al8GUGD6CWZfeVLay9
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

This will be used by drm/msm for GPU page faults, replacing the manual
register reading it does.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c |  6 ++--
 drivers/iommu/arm/arm-smmu/arm-smmu.c            | 35 ++++++++++++++----------
 drivers/iommu/arm/arm-smmu/arm-smmu.h            |  7 +++--
 3 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
index 548783f3f8e89fd978367afa65c473002f66e2e7..5bf1aa4aa941962710f1f14260e133d560aee86f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
@@ -393,14 +393,14 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 				      DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
-	arm_smmu_read_context_fault_info(smmu, idx, &cfi);
+	arm_smmu_read_context_fault_info(smmu_domain, &cfi);
 
 	if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
 		return IRQ_NONE;
 
 	if (list_empty(&tbu_list)) {
 		ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
-					 cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+					 cfi.fsynr0 & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 
 		if (ret == -ENOSYS)
 			arm_smmu_print_context_fault_info(smmu, idx, &cfi);
@@ -412,7 +412,7 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 	phys_soft = ops->iova_to_phys(ops, cfi.iova);
 
 	tmp = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
-				 cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+				 cfi.fsynr0 & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 	if (!tmp || tmp == -EBUSY) {
 		ret = IRQ_HANDLED;
 		resume = ARM_SMMU_RESUME_TERMINATE;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index ade4684c14c9b2724a71e2457288dbfaf7562c83..a02078eb968b81a35c1c086ed7007ea2a453ef94 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -405,13 +405,20 @@ static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
 };
 
 
-void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int idx,
+void arm_smmu_read_context_fault_info(struct arm_smmu_domain *smmu_domain,
 				      struct arm_smmu_context_fault_info *cfi)
 {
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	int idx = smmu_domain->cfg.cbndx;
+
 	cfi->iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
+	cfi->ttbr0 = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_TTBR0);
 	cfi->fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
-	cfi->fsynr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
+	cfi->fsynr0 = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
+	cfi->fsynr1 = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR1);
 	cfi->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+		cfi->contextidr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_CONTEXTIDR);
 }
 
 void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,
@@ -419,7 +426,7 @@ void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,
 {
 	dev_err(smmu->dev,
 		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
-		cfi->fsr, cfi->iova, cfi->fsynr, cfi->cbfrsynra, idx);
+		cfi->fsr, cfi->iova, cfi->fsynr0, cfi->cbfrsynra, idx);
 
 	dev_err(smmu->dev, "FSR    = %08x [%s%sFormat=%u%s%s%s%s%s%s%s%s], SID=0x%x\n",
 		cfi->fsr,
@@ -437,15 +444,15 @@ void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,
 		cfi->cbfrsynra);
 
 	dev_err(smmu->dev, "FSYNR0 = %08x [S1CBNDX=%u%s%s%s%s%s%s PLVL=%u]\n",
-		cfi->fsynr,
-		(u32)FIELD_GET(ARM_SMMU_CB_FSYNR0_S1CBNDX, cfi->fsynr),
-		(cfi->fsynr & ARM_SMMU_CB_FSYNR0_AFR) ? " AFR" : "",
-		(cfi->fsynr & ARM_SMMU_CB_FSYNR0_PTWF) ? " PTWF" : "",
-		(cfi->fsynr & ARM_SMMU_CB_FSYNR0_NSATTR) ? " NSATTR" : "",
-		(cfi->fsynr & ARM_SMMU_CB_FSYNR0_IND) ? " IND" : "",
-		(cfi->fsynr & ARM_SMMU_CB_FSYNR0_PNU) ? " PNU" : "",
-		(cfi->fsynr & ARM_SMMU_CB_FSYNR0_WNR) ? " WNR" : "",
-		(u32)FIELD_GET(ARM_SMMU_CB_FSYNR0_PLVL, cfi->fsynr));
+		cfi->fsynr0,
+		(u32)FIELD_GET(ARM_SMMU_CB_FSYNR0_S1CBNDX, cfi->fsynr0),
+		(cfi->fsynr0 & ARM_SMMU_CB_FSYNR0_AFR) ? " AFR" : "",
+		(cfi->fsynr0 & ARM_SMMU_CB_FSYNR0_PTWF) ? " PTWF" : "",
+		(cfi->fsynr0 & ARM_SMMU_CB_FSYNR0_NSATTR) ? " NSATTR" : "",
+		(cfi->fsynr0 & ARM_SMMU_CB_FSYNR0_IND) ? " IND" : "",
+		(cfi->fsynr0 & ARM_SMMU_CB_FSYNR0_PNU) ? " PNU" : "",
+		(cfi->fsynr0 & ARM_SMMU_CB_FSYNR0_WNR) ? " WNR" : "",
+		(u32)FIELD_GET(ARM_SMMU_CB_FSYNR0_PLVL, cfi->fsynr0));
 }
 
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
@@ -458,13 +465,13 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	int idx = smmu_domain->cfg.cbndx;
 	int ret;
 
-	arm_smmu_read_context_fault_info(smmu, idx, &cfi);
+	arm_smmu_read_context_fault_info(smmu_domain, &cfi);
 
 	if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
 		return IRQ_NONE;
 
 	ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
-		cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+		cfi.fsynr0 & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 
 	if (ret == -ENOSYS && __ratelimit(&rs))
 		arm_smmu_print_context_fault_info(smmu, idx, &cfi);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index e2aeb511ae903302e3c15d2cf5f22e2a26ac2346..ef6915a0d9f62b0a1734a3ee57ea422615036094 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -543,12 +543,15 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu);
 
 struct arm_smmu_context_fault_info {
 	unsigned long iova;
+	u64 ttbr0;
 	u32 fsr;
-	u32 fsynr;
+	u32 fsynr0;
+	u32 fsynr1;
 	u32 cbfrsynra;
+	u32 contextidr;
 };
 
-void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int idx,
+void arm_smmu_read_context_fault_info(struct arm_smmu_domain *smmu_domain,
 				      struct arm_smmu_context_fault_info *cfi);
 
 void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,

-- 
2.47.1

