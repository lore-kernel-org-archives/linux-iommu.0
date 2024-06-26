Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BEC194AC1
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434448; cv=none; b=kGi7msVhm5LEeB3HfbeCZd9L3odid9XF12topiQw21l7M1PNGMSys4zAu2qlHFacC38QASYmkpc4+o6JwpywDnIAehr5qzeBQ58t+gIZk3tg9Olus66zBH2kfAZzM//T8PggvByshvshDxnxvim6HPZC51dIZaReO9VfcfmKsoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434448; c=relaxed/simple;
	bh=R1J6u0WL/5rijyfbWPCld6jkHM5mRIc5qDfbPUKjx6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+UEHDHt2k4vruWVnpMgAKJ9brT221vPmfMl/+8QFhR1ezpQ45F0ezkEY2VjQBo8CwKpZyzDzOigiN8Qcm6q7i1yZbyJApyJwHcY07gg3l2Rhy2fhU0tVLzNJG9ggM96CEN0DB+MFtAe8mSGjJp69BQeT51yrgnW1f+LU7z3Cf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j81f3s1K; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j81f3s1K"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-70df2135426so4660850a12.2
        for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719434446; x=1720039246; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaTg9/B23waOI9zVmutPgK2+FneQd1nJivbxDxQ8kVQ=;
        b=j81f3s1KjKzSB0I6DkLzhRfuROeE/AzrqzOn/F7MijgTdLOdUHfdHSnEAbn47Q1cxW
         qyPOQM23qtl6L31kQojxq4bPz1LtcqrD644hjjXfxqk0W/Tbwnjj9fmtpgDLIy0EgFYv
         Q1HQMYBTHG4dX+dCLWGSchL9u6R4qeZzzT6mCVwiZgGjlK8txU+XyhfChCnjDeF35wrg
         vAyPijpwVpno/dEYVW17z1cxhmVcc//Zuk7Xlqag/i1PdCg8RB31v/3q/S87YhX86ep8
         iQscMYSZxj77xlhD86ToHejx73hnSuDfx6K0mt7S08BbD9EVunLdBRGMsyX2J0Th7lOl
         63Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434446; x=1720039246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaTg9/B23waOI9zVmutPgK2+FneQd1nJivbxDxQ8kVQ=;
        b=mv4mcqfQ2dxQgezG0/UY8iC0EINfykZAim+AlflBVLTtS5+fwH8vUCRpmYjblaDAc8
         uzTth51AMi94wmriAsgyZu8y3/cubc5ZRy/A/zw0kullp7kpfbvN/oq43a5VNajgZXME
         /3gipKYFRAXH8SDmnsn8uNpcMuOCK8GqIqtJ69vWjrieXmjnj+d37E+RF5eqaKCJ/Ul2
         zj4S8zr73wl4GYDU5k3Pm6Y8LkiBl/XFUk2NKx/d7z7kFuy7WZJ5fXAkkzVZixEQFzEg
         nwjXCSE4xWsfMLCoB5oDdHEFllI8tFPCqPVUT//5A+OD7U3GX4QIjwGn8+cbYkPNOqCT
         M4wA==
X-Gm-Message-State: AOJu0Yzx3Nbhi9md1YkDf4Bipa6VMQGpnrRA6w0jTsWpx/hyM/c5NfhC
	PHxA4eYcbZD1lL+ViVKdoersKmJlqv7kwPmJdxJpcZinZTvq5B6w3S4hjQ==
X-Google-Smtp-Source: AGHT+IF1OWXRmVAc7P/t2mo7Vtey9dDgaSNQaluXlN5oULC7q6DlJRy1fKAenx9cbqHNm6YYfgPHbA==
X-Received: by 2002:a05:6a20:214a:b0:1be:c5f5:589 with SMTP id adf61e73a8af0-1bec5f50ae7mr1535396637.55.1719434445944;
        Wed, 26 Jun 2024 13:40:45 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa1f39695bsm75150625ad.278.2024.06.26.13.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 13:40:45 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	freedreno@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm Adreno GPUs),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/2] drm/msm: Extend gpu devcore dumps with pgtbl info
Date: Wed, 26 Jun 2024 13:40:27 -0700
Message-ID: <20240626204033.255813-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626204033.255813-1-robdclark@gmail.com>
References: <20240626204033.255813-1-robdclark@gmail.com>
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
 drivers/gpu/drm/msm/msm_iommu.c         | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_mmu.h           |  3 ++-
 5 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 99661af8d941..422dae873b6b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -861,6 +861,16 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
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
index 3666b42b4ecd..bf2f8b2a7ccc 100644
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
index 1f02bb9956be..82e838ba8c80 100644
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
index d5512037c38b..a235b0d0afb5 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -195,6 +195,31 @@ struct iommu_domain_geometry *msm_iommu_get_geometry(struct msm_mmu *mmu)
 	return &iommu->domain->geometry;
 }
 
+int
+msm_iommu_pagetable_walk(struct msm_mmu *mmu, unsigned long iova, uint64_t ptes[4])
+{
+	struct msm_iommu_pagetable *pagetable;
+	struct io_pgtable_walk_data wd = {};
+	int ret;
+
+	if (mmu->type != MSM_MMU_IOMMU_PAGETABLE)
+		return -EINVAL;
+
+	pagetable = to_pagetable(mmu);
+
+	if (!pagetable->pgtbl_ops->pgtable_walk)
+		return -EINVAL;
+
+	ret = pagetable->pgtbl_ops->pgtable_walk(pagetable->pgtbl_ops, iova, &wd);
+	if (ret)
+		return ret;
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
2.45.2

