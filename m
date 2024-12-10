Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BAC233D70
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849525; cv=none; b=lFLRHRzyxl9s3I9tTCRA3nvhj6L0iYoSbULS6z/ZwVUJ+IqdLqZy44ElEZxttvp8MWvgPq7BI4M8Vt5ibYGGEqRuu1me7pGTCN56bX6Z0h7qt6jzNq5ieFa6PFyTEmkPineO//VLdVENHsqY8FBSuaukSCkXpCY31i7uSSZLxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849525; c=relaxed/simple;
	bh=JBMkrQG/8cFEwbKJFanSCuDvcbSxAx5wFpFltTn+IAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AS7qXEY/uUnnKKmb7hzLOtc7JknJUCS029crA64bfb5k2o7O6SOl0wpwV6FWR02qB9njoRA2UnrPZyVrRky+y0W4EMZiN34e5Tv8DYiJwkc0P5Rl959SP7HZwCsD4Bu4AO/xcUr9EMmAyXHgGblZvYLdxhP2htZZjizWe0FZmwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcncKFE7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcncKFE7"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216728b1836so9175545ad.0
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 08:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733849522; x=1734454322; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qh7p2d7+E2GMmgZFCCSWmo87bNDM3/nkgcYOWm/PC60=;
        b=ZcncKFE7SCQdqm/q/9VFUy9Tf8MkEIZvXpuPyGdLPOm4yg/78dVH5xeHZkdV6hKHu1
         IlJcP41rUOIHv/uPzuv67Dsypf0MZXzZ+GGSvSUpWPkw7iq7RMxOHOUJlfV9P74j2q8B
         4vN+KKp6Iz5eZGqa/lQPmXVCO/XCL1AXZqEbhM5EMXaHxL4Xu0A1Df9YKOogQ1spY3Vj
         ToS/9kfCHXUysprQTzgNA1ogtpoAv4wBEVRQR2DSOlWUs1porOWFDe1U0WyVLVGiveVo
         ocCAK1Mty7K1htJQSsvuXCER8srf+IY1Zb5jZH1Gmj5lsZnUmqtbS6uxrUFd4rOEj5pl
         GzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733849522; x=1734454322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qh7p2d7+E2GMmgZFCCSWmo87bNDM3/nkgcYOWm/PC60=;
        b=Gihazwv7oi6BvVqcrnNUmU8bSIF1tbV4tBFoGzzCngPQXRClYv5LpTouepxlpLIEkr
         Y/hXbgwJBaNXvWEM9g76G4X75CrdiKaj6umqUNtTZR+v82+IsXxX1mQOdBUsj3FemBqh
         TxoQx/esyN25fGYCwS7PFGk6BtbzM9xrvPEpWUflVSqhBmg8BuYHFjWxGf+l6OCYFi1/
         2lvnn9fWdVQNGyn1s98Iwmc384D4r2nq7l292qB3o3pAhAv92VQTbOs+rY1Zva/D7u+k
         wcAtglC7kXoT0R090s8vsbqCdVj5bFW5BZQ6vDprmhMIk3FnSiz1UjCXGS5xhNweLSAf
         GzlA==
X-Gm-Message-State: AOJu0Ywz0RV2ElH2YhK5uCsyu/4w/3kSuFeD9DIYv3cMYM4d+rYQMeus
	G38huJpbjz6o9eRNMZ7v6W8inCUO/l3QenSaWbx+MoEiTHYU7MwrjwGZhw==
X-Gm-Gg: ASbGncu/E+i6GrUr5yIDadghtegq7q6yL/TZW2PBnndfj1FeIxYMLDFfRwnea9ZIbJ+
	qNVTuOKu7rCeETw9YdlXS1SIf5zmmK/qnHyYATgUB9uvPJlXR++BZl8aNpXk9Xu/Xmet7IUzhKQ
	AK572c/5dbUNgsYMpir7SHshwl0nawOVgVXuht0i/o4RpFy23dU7JIaXChueveaQuvMo8aLUlxO
	hch3M3C/2cQr9IFL44TU1pJgUGMZxibejucvO65Ll4txu/RAzDHZuAGljWoaA9j/nr48KMgMjzs
	U82P1baFOL27PLlcW7nxML76zCI/
X-Google-Smtp-Source: AGHT+IGyppZ/XUmktj28oKiZ+5yOlPQdJYESYN99eWYi54gnG85QRxp2tq+GL1giES6A+moTdOjNmQ==
X-Received: by 2002:a17:902:f684:b0:216:386e:dbc with SMTP id d9443c01a7336-216386e1127mr132673815ad.13.1733849522435;
        Tue, 10 Dec 2024 08:52:02 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21632c4fd4dsm55201575ad.232.2024.12.10.08.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:52:01 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Mostafa Saleh <smostafa@google.com>,
	Will Deacon <will@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 4/4] drm/msm: Extend gpu devcore dumps with pgtbl info
Date: Tue, 10 Dec 2024 08:51:22 -0800
Message-ID: <20241210165127.600817-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210165127.600817-1-robdclark@gmail.com>
References: <20241210165127.600817-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

In the case of iova fault triggered devcore dumps, include additional
debug information based on what we think is the current page tables,
including the TTBR0 value (which should match what we have in
adreno_smmu_fault_info unless things have gone horribly wrong), and
the pagetable entries traversed in the process of resolving the
faulting iova.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 ++++++++++
 drivers/gpu/drm/msm/msm_gpu.c           |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  8 ++++++++
 drivers/gpu/drm/msm/msm_iommu.c         | 22 ++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  3 ++-
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 076be0473eb5..f1d6e6665c30 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -868,6 +868,16 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 		drm_printf(p, "  - dir=%s\n", info->flags & IOMMU_FAULT_WRITE ? "WRITE" : "READ");
 		drm_printf(p, "  - type=%s\n", info->type);
 		drm_printf(p, "  - source=%s\n", info->block);
+
+		/* Information extracted from what we think are the current
+		 * pgtables.  Hopefully the TTBR0 matches what we've extracted
+		 * from the SMMU registers in smmu_info!
+		 */
+		drm_puts(p, "pgtable-fault-info:\n");
+		drm_printf(p, "  - ttbr0: %.16llx\n", (u64)info->pgtbl_ttbr0);
+		drm_printf(p, "  - asid: %d\n", info->asid);
+		drm_printf(p, "  - ptes: %.16llx %.16llx %.16llx %.16llx\n",
+			   info->ptes[0], info->ptes[1], info->ptes[2], info->ptes[3]);
 	}
 
 	drm_printf(p, "rbbm-status: 0x%08x\n", state->rbbm_status);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0d4a3744cfcb..82f204f3bb8f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -281,6 +281,15 @@ static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 	if (submit) {
 		int i;
 
+		if (state->fault_info.ttbr0) {
+			struct msm_gpu_fault_info *info = &state->fault_info;
+			struct msm_mmu *mmu = submit->aspace->mmu;
+
+			msm_iommu_pagetable_params(mmu, &info->pgtbl_ttbr0,
+						   &info->asid);
+			msm_iommu_pagetable_walk(mmu, info->iova, info->ptes);
+		}
+
 		state->bos = kcalloc(submit->nr_bos,
 			sizeof(struct msm_gpu_state_bo), GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 7cabc8480d7c..e25009150579 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -101,6 +101,14 @@ struct msm_gpu_fault_info {
 	int flags;
 	const char *type;
 	const char *block;
+
+	/* Information about what we think/expect is the current SMMU state,
+	 * for example expected_ttbr0 should match smmu_info.ttbr0 which
+	 * was read back from SMMU registers.
+	 */
+	phys_addr_t pgtbl_ttbr0;
+	u64 ptes[4];
+	int asid;
 };
 
 /**
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 2a94e82316f9..3e692818ba1f 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -195,6 +195,28 @@ struct iommu_domain_geometry *msm_iommu_get_geometry(struct msm_mmu *mmu)
 	return &iommu->domain->geometry;
 }
 
+int
+msm_iommu_pagetable_walk(struct msm_mmu *mmu, unsigned long iova, uint64_t ptes[4])
+{
+	struct msm_iommu_pagetable *pagetable;
+	struct arm_lpae_io_pgtable_walk_data wd = {};
+
+	if (mmu->type != MSM_MMU_IOMMU_PAGETABLE)
+		return -EINVAL;
+
+	pagetable = to_pagetable(mmu);
+
+	if (!pagetable->pgtbl_ops->pgtable_walk)
+		return -EINVAL;
+
+	pagetable->pgtbl_ops->pgtable_walk(pagetable->pgtbl_ops, iova, &wd);
+
+	for (int i = 0; i < ARRAY_SIZE(wd.ptes); i++)
+		ptes[i] = wd.ptes[i];
+
+	return 0;
+}
+
 static const struct msm_mmu_funcs pagetable_funcs = {
 		.map = msm_iommu_pagetable_map,
 		.unmap = msm_iommu_pagetable_unmap,
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index 88af4f490881..96e509bd96a6 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -53,7 +53,8 @@ static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
 struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent);
 
 int msm_iommu_pagetable_params(struct msm_mmu *mmu, phys_addr_t *ttbr,
-		int *asid);
+			       int *asid);
+int msm_iommu_pagetable_walk(struct msm_mmu *mmu, unsigned long iova, uint64_t ptes[4]);
 struct iommu_domain_geometry *msm_iommu_get_geometry(struct msm_mmu *mmu);
 
 #endif /* __MSM_MMU_H__ */
-- 
2.47.1

