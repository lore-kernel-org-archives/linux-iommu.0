Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E48A16631C
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850846; cv=none; b=FMzScTQ4RhD74ylMLLT5x/KgagblUNkFq+uEvhM46pcPoEv3DqvVqmz0wTyn3pJLi2vS0a7tAjtLUtIXbIwauPATDclu4zAZIPbWPWv0EBnib2oR1dC+lfRKu9jOgKI5Vmc+GWfvRLPV1irzQVr72G9DWNCW1c5D/Dd1el0ut3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850846; c=relaxed/simple;
	bh=Ed24/mqCCvvZCgetl/hcdKlIeTHtnGeaSZ9ctzirepc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT8sLkHakpkTw5rhaOJRLQHOnlBrcFZyOkaEqJbuhzjCy7VDNi8MlyPl7e5arN6/zwiVmMDUDlKwwtyoL8F8Eaxo3Oos2aBMsuj/jZCcaZ3k/XGtfDx+mW7ea1RqF6Tv/YnqnJSL7vCMuPUpjwPQfExka+X1EUoB+5oUY5ZTbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC6edrce; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC6edrce"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fa78306796so17787065ad.3
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719850844; x=1720455644; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foX87Q35xBXng5Wl1QSeaFlNvKSPs7buApce6Aj2ce8=;
        b=kC6edrceGkgKSbl+RGxMRJxnDMpjZx6U5gs7nUBfozhj+FII+RFqbBTZlTPK8a6Bth
         L84K6jqMEopzGF9ZBiuSq0KhVSMyUWGDDagNalrXRPpx2MFQTg1P0i9uv0bIcqOckLaS
         9016+iMS8Vk14eZ1Gw9o4Mc+7ukfjItzC7GKRhoI68e7sDVadsE8rEuY05XSB/mu9uaJ
         zEtCY9UJFojUF9LCJGKNGqN2SUWCEfqF7bhNO2UecG5+OCEdAdwxdq2gctAX+C+95kpc
         nbsnxm/RMjpDrpuIV042Rh8beXzOVGR8MuXfc/XD8KEHr3OESinDN8Dm1VmXppXchIoN
         wk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850844; x=1720455644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foX87Q35xBXng5Wl1QSeaFlNvKSPs7buApce6Aj2ce8=;
        b=shU3fenHJxJD5/o/uGtgp2ZNPi4p9V3VbJlR+EZKStQ8GmSUh9oOAQEzjds/QXF30y
         27x89IhmzV6+l+I144fZniUFRKIG7LWNe8+N61zGAG7lMPvhP5GQwNURPqWMTDt9Hxlx
         hxw5t2Jcdw2vgTdn/Ey+PmQ1c3KCYZbKFbnYprXO34MWVJeYWRaKpECbGh5mpFS+5BQ6
         Mi8aUpCSZKsoUJc5N1AZrJUBWijSqAo9NbwDal6Tl3oZ0HNIWfpSf9oJDCWA3j/sjWV+
         xuy18zmg8lFQNj9RHzue9KMS1o5niCVhhKANOJBAi/l7zia9ci40tsd6M/e+TIukfFvQ
         lhOQ==
X-Gm-Message-State: AOJu0YwtoIk3qn6axrxrG1ehrlmTqlP4Y+Tn8yoLcRhfq9i9qsES+rA/
	tzObCmorH9WmHMBq+0mn75F+HT4pQEvpbu0tNhhgwXEmGCvVBPXeiHEwbw==
X-Google-Smtp-Source: AGHT+IGezuz9KcsCDkHHf6nqDerEGKPZp9rv7QW8gBS87OnSnt1vrKQewvteVEA7LabRrLMcMNIbBg==
X-Received: by 2002:a17:902:ecce:b0:1f9:b16d:f97c with SMTP id d9443c01a7336-1fadbcf4391mr43164895ad.66.1719850843877;
        Mon, 01 Jul 2024 09:20:43 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535cc8sm66487225ad.122.2024.07.01.09.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:20:43 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Rob Clark <robdclark@chromium.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robdclark@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-tegra@vger.kernel.org (open list:TEGRA IOMMU DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/3] iommu/arm-smmu: Add CB prefix to register bitfields
Date: Mon,  1 Jul 2024 09:20:10 -0700
Message-ID: <20240701162025.375134-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701162025.375134-1-robdclark@gmail.com>
References: <20240701162025.375134-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

For consistency, add the "CB" prefix to the bitfield defines for context
registers.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c  |  2 +-
 .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  | 18 +++----
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  8 +--
 drivers/iommu/arm/arm-smmu/arm-smmu.h         | 50 +++++++++----------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  4 +-
 5 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 957d988b6d83..4b2994b6126d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -200,7 +200,7 @@ static irqreturn_t nvidia_smmu_context_fault_bank(int irq,
 	void __iomem *cb_base = nvidia_smmu_page(smmu, inst, smmu->numpage + idx);
 
 	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
-	if (!(fsr & ARM_SMMU_FSR_FAULT))
+	if (!(fsr & ARM_SMMU_CB_FSR_FAULT))
 		return IRQ_NONE;
 
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
index 552199cbd9e2..e4ee78fb6a66 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
@@ -141,7 +141,7 @@ static int qcom_tbu_halt(struct qcom_tbu *tbu, struct arm_smmu_domain *smmu_doma
 	writel_relaxed(val, tbu->base + DEBUG_SID_HALT_REG);
 
 	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
-	if ((fsr & ARM_SMMU_FSR_FAULT) && (fsr & ARM_SMMU_FSR_SS)) {
+	if ((fsr & ARM_SMMU_CB_FSR_FAULT) && (fsr & ARM_SMMU_CB_FSR_SS)) {
 		u32 sctlr_orig, sctlr;
 
 		/*
@@ -298,7 +298,7 @@ static phys_addr_t qcom_iova_to_phys(struct arm_smmu_domain *smmu_domain,
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, sctlr);
 
 	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
-	if (fsr & ARM_SMMU_FSR_FAULT) {
+	if (fsr & ARM_SMMU_CB_FSR_FAULT) {
 		/* Clear pending interrupts */
 		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
 
@@ -306,7 +306,7 @@ static phys_addr_t qcom_iova_to_phys(struct arm_smmu_domain *smmu_domain,
 		 * TBU halt takes care of resuming any stalled transcation.
 		 * Kept it here for completeness sake.
 		 */
-		if (fsr & ARM_SMMU_FSR_SS)
+		if (fsr & ARM_SMMU_CB_FSR_SS)
 			arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
 					  ARM_SMMU_RESUME_TERMINATE);
 	}
@@ -320,11 +320,11 @@ static phys_addr_t qcom_iova_to_phys(struct arm_smmu_domain *smmu_domain,
 			phys = qcom_tbu_trigger_atos(smmu_domain, tbu, iova, sid);
 
 			fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
-			if (fsr & ARM_SMMU_FSR_FAULT) {
+			if (fsr & ARM_SMMU_CB_FSR_FAULT) {
 				/* Clear pending interrupts */
 				arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
 
-				if (fsr & ARM_SMMU_FSR_SS)
+				if (fsr & ARM_SMMU_CB_FSR_SS)
 					arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME,
 							  ARM_SMMU_RESUME_TERMINATE);
 			}
@@ -394,7 +394,7 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 				      DEFAULT_RATELIMIT_BURST);
 
 	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
-	if (!(fsr & ARM_SMMU_FSR_FAULT))
+	if (!(fsr & ARM_SMMU_CB_FSR_FAULT))
 		return IRQ_NONE;
 
 	fsynr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
@@ -403,7 +403,7 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 
 	if (list_empty(&tbu_list)) {
 		ret = report_iommu_fault(&smmu_domain->domain, NULL, iova,
-					 fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+					 fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 
 		if (ret == -ENOSYS)
 			dev_err_ratelimited(smmu->dev,
@@ -417,7 +417,7 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 	phys_soft = ops->iova_to_phys(ops, iova);
 
 	tmp = report_iommu_fault(&smmu_domain->domain, NULL, iova,
-				 fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+				 fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 	if (!tmp || tmp == -EBUSY) {
 		dev_dbg(smmu->dev,
 			"Context fault handled by client: iova=0x%08lx, fsr=0x%x, fsynr=0x%x, cb=%d\n",
@@ -481,7 +481,7 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
 
 		/* Retry or terminate any stalled transactions */
-		if (fsr & ARM_SMMU_FSR_SS)
+		if (fsr & ARM_SMMU_CB_FSR_SS)
 			arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_RESUME, resume);
 	}
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 87c81f75cf84..23cf91ac409b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -415,7 +415,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	int ret;
 
 	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
-	if (!(fsr & ARM_SMMU_FSR_FAULT))
+	if (!(fsr & ARM_SMMU_CB_FSR_FAULT))
 		return IRQ_NONE;
 
 	fsynr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
@@ -423,7 +423,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
 
 	ret = report_iommu_fault(&smmu_domain->domain, NULL, iova,
-		fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+		fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 
 	if (ret == -ENOSYS)
 		dev_err_ratelimited(smmu->dev,
@@ -1306,7 +1306,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_ATS1PR, va);
 
 	reg = arm_smmu_page(smmu, ARM_SMMU_CB(smmu, idx)) + ARM_SMMU_CB_ATSR;
-	if (readl_poll_timeout_atomic(reg, tmp, !(tmp & ARM_SMMU_ATSR_ACTIVE),
+	if (readl_poll_timeout_atomic(reg, tmp, !(tmp & ARM_SMMU_CB_ATSR_ACTIVE),
 				      5, 50)) {
 		spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
 		dev_err(dev,
@@ -1642,7 +1642,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Make sure all context banks are disabled and clear CB_FSR  */
 	for (i = 0; i < smmu->num_context_banks; ++i) {
 		arm_smmu_write_context_bank(smmu, i);
-		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
+		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_CB_FSR_FAULT);
 	}
 
 	/* Invalidate the TLB, just in case */
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 4765c6945c34..b04a00126a12 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -196,34 +196,34 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_CB_PAR_F		BIT(0)
 
 #define ARM_SMMU_CB_FSR			0x58
-#define ARM_SMMU_FSR_MULTI		BIT(31)
-#define ARM_SMMU_FSR_SS			BIT(30)
-#define ARM_SMMU_FSR_UUT		BIT(8)
-#define ARM_SMMU_FSR_ASF		BIT(7)
-#define ARM_SMMU_FSR_TLBLKF		BIT(6)
-#define ARM_SMMU_FSR_TLBMCF		BIT(5)
-#define ARM_SMMU_FSR_EF			BIT(4)
-#define ARM_SMMU_FSR_PF			BIT(3)
-#define ARM_SMMU_FSR_AFF		BIT(2)
-#define ARM_SMMU_FSR_TF			BIT(1)
-
-#define ARM_SMMU_FSR_IGN		(ARM_SMMU_FSR_AFF |		\
-					 ARM_SMMU_FSR_ASF |		\
-					 ARM_SMMU_FSR_TLBMCF |		\
-					 ARM_SMMU_FSR_TLBLKF)
-
-#define ARM_SMMU_FSR_FAULT		(ARM_SMMU_FSR_MULTI |		\
-					 ARM_SMMU_FSR_SS |		\
-					 ARM_SMMU_FSR_UUT |		\
-					 ARM_SMMU_FSR_EF |		\
-					 ARM_SMMU_FSR_PF |		\
-					 ARM_SMMU_FSR_TF |		\
-					 ARM_SMMU_FSR_IGN)
+#define ARM_SMMU_CB_FSR_MULTI		BIT(31)
+#define ARM_SMMU_CB_FSR_SS		BIT(30)
+#define ARM_SMMU_CB_FSR_UUT		BIT(8)
+#define ARM_SMMU_CB_FSR_ASF		BIT(7)
+#define ARM_SMMU_CB_FSR_TLBLKF		BIT(6)
+#define ARM_SMMU_CB_FSR_TLBMCF		BIT(5)
+#define ARM_SMMU_CB_FSR_EF		BIT(4)
+#define ARM_SMMU_CB_FSR_PF		BIT(3)
+#define ARM_SMMU_CB_FSR_AFF		BIT(2)
+#define ARM_SMMU_CB_FSR_TF		BIT(1)
+
+#define ARM_SMMU_CB_FSR_IGN		(ARM_SMMU_CB_FSR_AFF |		\
+					 ARM_SMMU_CB_FSR_ASF |		\
+					 ARM_SMMU_CB_FSR_TLBMCF |	\
+					 ARM_SMMU_CB_FSR_TLBLKF)
+
+#define ARM_SMMU_CB_FSR_FAULT		(ARM_SMMU_CB_FSR_MULTI |	\
+					 ARM_SMMU_CB_FSR_SS |		\
+					 ARM_SMMU_CB_FSR_UUT |		\
+					 ARM_SMMU_CB_FSR_EF |		\
+					 ARM_SMMU_CB_FSR_PF |		\
+					 ARM_SMMU_CB_FSR_TF |		\
+					 ARM_SMMU_CB_FSR_IGN)
 
 #define ARM_SMMU_CB_FAR			0x60
 
 #define ARM_SMMU_CB_FSYNR0		0x68
-#define ARM_SMMU_FSYNR0_WNR		BIT(4)
+#define ARM_SMMU_CB_FSYNR0_WNR		BIT(4)
 
 #define ARM_SMMU_CB_FSYNR1		0x6c
 
@@ -237,7 +237,7 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_CB_ATS1PR		0x800
 
 #define ARM_SMMU_CB_ATSR		0x8f0
-#define ARM_SMMU_ATSR_ACTIVE		BIT(0)
+#define ARM_SMMU_CB_ATSR_ACTIVE		BIT(0)
 
 #define ARM_SMMU_RESUME_TERMINATE	BIT(0)
 
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index e079bb7a993e..b98a7a598b89 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -194,7 +194,7 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
 
 	fsr = iommu_readl(ctx, ARM_SMMU_CB_FSR);
 
-	if (!(fsr & ARM_SMMU_FSR_FAULT))
+	if (!(fsr & ARM_SMMU_CB_FSR_FAULT))
 		return IRQ_NONE;
 
 	fsynr = iommu_readl(ctx, ARM_SMMU_CB_FSYNR0);
@@ -274,7 +274,7 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 		/* Clear context bank fault address fault status registers */
 		iommu_writel(ctx, ARM_SMMU_CB_FAR, 0);
-		iommu_writel(ctx, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
+		iommu_writel(ctx, ARM_SMMU_CB_FSR, ARM_SMMU_CB_FSR_FAULT);
 
 		/* TTBRs */
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
-- 
2.45.2

