Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5938281372
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107445; cv=none; b=Qb1+qVvQuQVix3fPEd0TiuwpIpz9bQzwloria5R8trHTJIrvoFQLdxXZMvlDyCZUbvS5CXq7AbA99JZ3ntJnv68fXtdmeybvxRD6nRdgZjaNb2nUFtjLtp1yIe49CicTxnNwnif9RXhsdkPlZzl2/uDdKPc/fDmC/PqaUdPKYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107445; c=relaxed/simple;
	bh=wzb+Csa73ZgNo4khyGvM8YgSCeUmNILS584s12qUf78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UIc4X3h4NDjUBwW4jdB+V++mvzLv3vYwS3V3XJSDo14E2xu3Z0mcD+ggqRwRHYOJR1fJLyrtUTNDIIPg0inJyI7c36zbakkMyNOTlrTaaxSKW4t/Ee4Wby7vwKkRCwJtYDRCpZOYnKseYoU0LUsuOyeCp64eZFSPPANbFBZdC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z71XwNCs; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z71XwNCs"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c3bfb37844so11604485a.1
        for <iommu@lists.linux.dev>; Tue, 04 Mar 2025 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741107443; x=1741712243; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8S9dBjNxZ5kSWclYX8MM4Du3QFxwWnxkd8aNT+KTuk=;
        b=Z71XwNCs/BxFjuM0OvptQt+NIhmAS156KXtXY253KCOBautcryUVGOwVY4KFR5DwHy
         dJwKyAJKTmYzXl+sqwq2/jlGiWYLbXkuqrhCPpsumyf6f03GsPYLSDyTCXv9hrB2jLuz
         wG6pZUfJJmCtAtfOt2PZ2HoF+PL2kU5qzDA3aJ9nSbQImnYtR3wh6//9JTjyMc7humn0
         GaGcZQgB0rDsX9CWNqXZD7GWP5bAS7xcS1WSCTd2hNa2Htf/QMemcvOWdwxZEBQHFd/z
         5C5pSi4LHj/o0/pDjSXbss9M+QygKF4Fs1wLj4i720RH2UbtV5gkRg5Pvzadh8g7sCQp
         5ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107443; x=1741712243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8S9dBjNxZ5kSWclYX8MM4Du3QFxwWnxkd8aNT+KTuk=;
        b=PxnF2OyF1Kl701cB6p8gzvtv2L+tYwuptd9DwaNnFdF3mnfUGgzwgdecJkQ2S7NNPU
         HlP6A8dwb5eGNgZ4ZtHcKkerdExECWvrvakq6sgMlTEtpI9VSvSd7JROcZKHnbUKbk6E
         GetYO910JrGwO9g+PPGQ/E6R4P4aXTfOC8KYwOF4ODXY2jaPzrrHbqou4VdayQyLQCHA
         S5TOvtKrZ5XL598K2JSly+7zWfU4CFUimstyRt7uLd+PRo3TGHHOTDMKxCVL7fWcQxl8
         a2o1rW4SKnIeOiYfcA2pFYqtFWtbTDxksv9DH8a3WqqaiHxjPS8ppFUG5Vm0PXLW8Xn2
         g8Ng==
X-Gm-Message-State: AOJu0YwYv2zltraK31ixbqtG7JdvQ40KPZKgfuYVxwF2bXX6qy1xwmN7
	O7xY3+NdEbm2sCEcF7oZzrh+Mnu4Sq6JvGecx6NuyGRBP1gEeIet
X-Gm-Gg: ASbGnctLPIGH5EQuGMQc0pG5htANDD2w5IjSuPRPHmTzmLqhOo3YqQbJ01cRS+F4bnt
	GhDSyKPby25Eoj6DCQGjC+qEwNuY9O0vmTQD/p+WHS96mv/78LQyOZay+j44G2zgEPjq6I3kMAy
	POe1H72PyvOjV+c75fPnteW7oUCG2sgw8keLoc63VQs/EI3ysS2qFxmr6L9IZaj1JZv4sgHjlIJ
	9HeejdJKDHnkX9Sw1DfM095S/DHdD85Mk5fMRHFmCIhwy3ksyDL9gIryipUBjIZORe4VZk8jsjQ
	PcZ/ztXEpfBn+tKoV5rz2CPxprFGwyq1NmIj4EA8Yf/9ADwkRHmWrtUzIdgnP5F8BJERqNpaJrw
	Gmk4=
X-Google-Smtp-Source: AGHT+IH8E2+NNMucN2iWnEvCfvVSv1/1e2v1p1j23JiywBOdc8vK1VN/pksuByNIEL9Gc/4zzxsiYQ==
X-Received: by 2002:a05:620a:1721:b0:7c3:d3a0:578d with SMTP id af79cd13be357-7c3d3a05813mr103204585a.14.1741107442690;
        Tue, 04 Mar 2025 08:57:22 -0800 (PST)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec3b6sm68915966d6.125.2025.03.04.08.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:57:22 -0800 (PST)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 04 Mar 2025 11:56:48 -0500
Subject: [PATCH v4 2/5] iommu/arm-smmu-qcom: Don't read fault registers
 directly
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-msm-gpu-fault-fixes-next-v4-2-be14be37f4c3@gmail.com>
References: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
In-Reply-To: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org, 
 Connor Abbott <cwabbott0@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741107439; l=5819;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=wzb+Csa73ZgNo4khyGvM8YgSCeUmNILS584s12qUf78=;
 b=h8YQvcJJIa8Q4NcAJtFPmlRqE4hYKd2Xj6cZY31JoaG29+/XgnzrAdUOk7ztfKNMoB2iXBQyP
 oqAOUu9lBlwBs7aw4xmzLre3EIEDVUKGbqxEWsi5g+cX8DcYXM7eTlW
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

In some cases drm/msm has to resume a stalled transaction directly in
its fault handler. Experimentally this doesn't work on SMMU500 if the
fault hasn't already been acknowledged by clearing FSR. Rather than
trying to clear FSR in msm's fault handler and implementing a
tricky handshake to avoid accidentally clearing FSR twice, we want to
clear FSR before calling the fault handlers, but this means that the
contents of registers can change underneath us in the fault handler and
msm currently uses a private function to read the register contents for
its own purposes in its fault handler, such as using the
implementation-defined FSYNR1 to determine which block caused the fault.
Fix this by making msm use the register values already read by arm-smmu
itself before clearing FSR rather than messing around with reading
registers directly.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 19 +++++++++----------
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 14 +++++++-------
 drivers/iommu/arm/arm-smmu/arm-smmu.h      | 21 +++++++++++----------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 6372f3e25c4bc24cb52f9233095170e8aa510a53..186d6ad4fd1c990398df4dec53f4d58ada9e658c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -62,16 +62,15 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
 		struct adreno_smmu_fault_info *info)
 {
 	struct arm_smmu_domain *smmu_domain = (void *)cookie;
-	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-
-	info->fsr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSR);
-	info->fsynr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR0);
-	info->fsynr1 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR1);
-	info->far = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_FAR);
-	info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
-	info->ttbr0 = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
-	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
+	struct arm_smmu_context_fault_info *cfi = &smmu_domain->cfi;
+
+	info->fsr = cfi->fsr;
+	info->fsynr0 = cfi->fsynr0;
+	info->fsynr1 = cfi->fsynr1;
+	info->far = cfi->iova;
+	info->cbfrsynra = cfi->cbfrsynra;
+	info->ttbr0 = cfi->ttbr0;
+	info->contextidr = cfi->contextidr;
 }
 
 static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index a9213e0f1579d1e3be0bfba75eea1d5de23117de..498b96e95cb4fdb67c246ef13de1eb8f40d68f7d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -453,26 +453,26 @@ void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,
 
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
-	struct arm_smmu_context_fault_info cfi;
 	struct arm_smmu_domain *smmu_domain = dev;
+	struct arm_smmu_context_fault_info *cfi = &smmu_domain->cfi;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 	int idx = smmu_domain->cfg.cbndx;
 	int ret;
 
-	arm_smmu_read_context_fault_info(smmu, idx, &cfi);
+	arm_smmu_read_context_fault_info(smmu, idx, cfi);
 
-	if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
+	if (!(cfi->fsr & ARM_SMMU_CB_FSR_FAULT))
 		return IRQ_NONE;
 
-	ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
-		cfi.fsynr0 & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+	ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi->iova,
+		cfi->fsynr0 & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 
 	if (ret == -ENOSYS && __ratelimit(&rs))
-		arm_smmu_print_context_fault_info(smmu, idx, &cfi);
+		arm_smmu_print_context_fault_info(smmu, idx, cfi);
 
-	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, cfi.fsr);
+	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, cfi->fsr);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index d3bc77dcd4d40f25bc70f3289616fb866649b022..411d807e0a7033833716635efb3968a0bd3ff237 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -373,6 +373,16 @@ enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_NESTED,
 };
 
+struct arm_smmu_context_fault_info {
+	unsigned long iova;
+	u64 ttbr0;
+	u32 fsr;
+	u32 fsynr0;
+	u32 fsynr1;
+	u32 cbfrsynra;
+	u32 contextidr;
+};
+
 struct arm_smmu_domain {
 	struct arm_smmu_device		*smmu;
 	struct io_pgtable_ops		*pgtbl_ops;
@@ -380,6 +390,7 @@ struct arm_smmu_domain {
 	const struct iommu_flush_ops	*flush_ops;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
+	struct arm_smmu_context_fault_info cfi;
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
@@ -541,16 +552,6 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
 void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
 int arm_mmu500_reset(struct arm_smmu_device *smmu);
 
-struct arm_smmu_context_fault_info {
-	unsigned long iova;
-	u64 ttbr0;
-	u32 fsr;
-	u32 fsynr0;
-	u32 fsynr1;
-	u32 cbfrsynra;
-	u32 contextidr;
-};
-
 void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int idx,
 				      struct arm_smmu_context_fault_info *cfi);
 

-- 
2.47.1

