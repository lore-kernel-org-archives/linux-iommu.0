Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2291E50B
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763109; cv=none; b=q//GBmv+8TmuMUd7kGvlb46wfKpR2RzIWVICYG5qRRQKry6IOFGpNWDYpIIfKHqNNuz/8zXFlW7+GUKb4XjzKhaheWEdwxRz2E7T4mJwXgckedla+gMfPqgVCDEQG/qEP8G6IUgOnt91i0sCTSq+kA/dML8dUmaTVytp8R/r3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763109; c=relaxed/simple;
	bh=IRNUvyOjaxw/F2ca+hPqiQkWq4EHwHVBbpQuon23Uj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fkcUctJrpewCi8z65OS3FToCujdDZexIP9SBNWL35En8gr0+eyuTG3fcrhW8DO0L554fVh+KVPgMlCfmr373kvQKURMANcvJWvNeMnnpfVvqSAwMkIXMn/1t3QdJNj7f3XOw3RDIESiGKXh0M3JdHgly2nHi7PihD9t5N7ISrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy9UR5jo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy9UR5jo"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f8be631832so6956946d6.3
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 10:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747763106; x=1748367906; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cADqZ1V/EGiLXKG6qQOYNjFrT4sU1TPLVJeXzQQLmA0=;
        b=Yy9UR5jotuhgkIZh4k9Yg0Y1bbYr7jMmjwEZoD7hrgLL+ApebzzXwvWT2EbaU3MTCQ
         WgsUpcm7zwwWnCm6QJflyRKZaKpfIFjHG3cfbhnw+7nE2xR1qNIcGOV2XR0WGH+JSWLa
         X1KpLkhRuY1G1T5V7x+hGnCJAhtkWy4O8f28tNBMevQI9ZAJXYnoU+Fhp+jxB4oAY1rs
         w31GST1hq5jS3NhoP3pWldfPZkMPyFdMxcq+W/lCigUjIw7MSwFy/QHSOaUygPev2Z0G
         n7sCMoUQRZo4L9OmMehdDqtHAxl9wmc3+mTPLCJZ7GFakYXkn8/BLQN7QQDcwM15kNN0
         +BTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747763106; x=1748367906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cADqZ1V/EGiLXKG6qQOYNjFrT4sU1TPLVJeXzQQLmA0=;
        b=YwFN9hg/RY/EAZfE2xX6/xz/8oAQdgWHhUUUqP2cs5JZ2w2CTiLLh9kre6+6/miZU4
         x9Zg3pQTRuFgLvCs60M+nfYcrXRv8UAQC4cUZGNqaYmaY1harkYKashCtYsiCAUs6ZjR
         7jCZXme3LfTg+pC10Bx5xgBrAkHN+TRjuBx/KITL3px0NgecpgY1JkEWihsiC1SrKRgT
         Rl8uMYmvZIzcimYya0TxKMPaN9qn0zzFl6PC2K9wlRAs+KszDQnXC5QlAUfH2kcUMMNh
         F7PJTThSkSiu+l5vVIFfcTSOgF8Wji9d97/S6BSMCGVLTAMk7HbyL5dDLBQWQLGrTbYd
         LO/A==
X-Gm-Message-State: AOJu0Yw7nXozyO4qhR+63rOoF9rSNnm48yjACb3fCFk4x0/ZMth1FEkW
	D+NfFYabYXzc1ZqHhGKDcmQp0tHLVWsLUiHvCVgOX6mFYuoxKYolqLkX
X-Gm-Gg: ASbGncswBz9TjmHORs0HgDrpw52QIdlN7tDSN/caovZckZsylmGHUg1huTfgh76rqYi
	v6nb1iNkwxbnpO+XaanMYerd77qYYLsKvo1xRAtBJLKz6D6MaH/pEwCYUZOOuowVnbJt7qFr6WI
	xkICrHSHc2FGMKd0DibIIlZ7gz7TqE6+h5HMS8nXTnRoqB8ajP/hI+irPnzZ+7TNauSzV7AugRJ
	4T9RTlkf6qHOviaEci1nMnKhrR5SLgxtFTobXaqGD64OQYiiG081OGqOAS2lSNofKTcSprF5a4d
	Mbd41uaNhKVL0gUVYGvlWZOCAxQj4vmIa9dmPiDBkueS6IsOKQ4kXp71r8juCTbQszMe5KTuA2c
	YwuCIxjS7Oh/ePQIYRKE=
X-Google-Smtp-Source: AGHT+IF/kqZXAuJjPUcZYWB5r6Qr7iOAsFvxKah/Zq78HNCB/e2Q26OWxJdFiR2AvAYDpvo1c5xq6w==
X-Received: by 2002:ad4:5941:0:b0:6f4:c603:588c with SMTP id 6a1803df08f44-6f8b087eb22mr85100926d6.7.1747763105993;
        Tue, 20 May 2025 10:45:05 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b096ddb4sm74126586d6.78.2025.05.20.10.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:45:05 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 20 May 2025 13:44:54 -0400
Subject: [PATCH v7 5/7] drm/msm: Delete resume_translation()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-msm-gpu-fault-fixes-next-v7-5-96cd1cc9ae05@gmail.com>
References: <20250520-msm-gpu-fault-fixes-next-v7-0-96cd1cc9ae05@gmail.com>
In-Reply-To: <20250520-msm-gpu-fault-fixes-next-v7-0-96cd1cc9ae05@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747763098; l=3387;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=IRNUvyOjaxw/F2ca+hPqiQkWq4EHwHVBbpQuon23Uj4=;
 b=bb1ikhMcSzxMlK/2NMm33STv5kLCmibVErhj4n18dSnT3mDibLINSPR9ac7QKmBAKJFyLjFcr
 bATA0iAywjqCx5qFhoAISP9lr/FgSu8Zo+BxW+MrAxNgLZ4CwVNSho3
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

Unused since the previous commit.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a2xx_gpummu.c |  5 -----
 drivers/gpu/drm/msm/msm_iommu.c          | 13 -------------
 drivers/gpu/drm/msm/msm_mmu.h            |  1 -
 3 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpummu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpummu.c
index 39641551eeb66d1441810c9691708ef448192578..4280f71e472a4130a62ba74e936870905ca260bb 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpummu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpummu.c
@@ -71,10 +71,6 @@ static int a2xx_gpummu_unmap(struct msm_mmu *mmu, uint64_t iova, size_t len)
 	return 0;
 }
 
-static void a2xx_gpummu_resume_translation(struct msm_mmu *mmu)
-{
-}
-
 static void a2xx_gpummu_destroy(struct msm_mmu *mmu)
 {
 	struct a2xx_gpummu *gpummu = to_a2xx_gpummu(mmu);
@@ -90,7 +86,6 @@ static const struct msm_mmu_funcs funcs = {
 		.map = a2xx_gpummu_map,
 		.unmap = a2xx_gpummu_unmap,
 		.destroy = a2xx_gpummu_destroy,
-		.resume_translation = a2xx_gpummu_resume_translation,
 };
 
 struct msm_mmu *a2xx_gpummu_new(struct device *dev, struct msm_gpu *gpu)
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index fd73dcd3f30e75878364cb28dd26475c2ff80a85..aae885d048d0d2fd617d7b2a16833da25f5e84cc 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -345,7 +345,6 @@ static int msm_gpu_fault_handler(struct iommu_domain *domain, struct device *dev
 		unsigned long iova, int flags, void *arg)
 {
 	struct msm_iommu *iommu = arg;
-	struct msm_mmu *mmu = &iommu->base;
 	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(iommu->base.dev);
 	struct adreno_smmu_fault_info info, *ptr = NULL;
 
@@ -359,9 +358,6 @@ static int msm_gpu_fault_handler(struct iommu_domain *domain, struct device *dev
 
 	pr_warn_ratelimited("*** fault: iova=%16lx, flags=%d\n", iova, flags);
 
-	if (mmu->funcs->resume_translation)
-		mmu->funcs->resume_translation(mmu);
-
 	return 0;
 }
 
@@ -376,14 +372,6 @@ static int msm_disp_fault_handler(struct iommu_domain *domain, struct device *de
 	return -ENOSYS;
 }
 
-static void msm_iommu_resume_translation(struct msm_mmu *mmu)
-{
-	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(mmu->dev);
-
-	if (adreno_smmu->resume_translation)
-		adreno_smmu->resume_translation(adreno_smmu->cookie, true);
-}
-
 static void msm_iommu_detach(struct msm_mmu *mmu)
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
@@ -431,7 +419,6 @@ static const struct msm_mmu_funcs funcs = {
 		.map = msm_iommu_map,
 		.unmap = msm_iommu_unmap,
 		.destroy = msm_iommu_destroy,
-		.resume_translation = msm_iommu_resume_translation,
 };
 
 struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index daf91529e02b6c491d624e9de686173eeef86a9b..c3d17aae88b0a57b3c7d1df3351b39ec39bca60a 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -15,7 +15,6 @@ struct msm_mmu_funcs {
 			size_t len, int prot);
 	int (*unmap)(struct msm_mmu *mmu, uint64_t iova, size_t len);
 	void (*destroy)(struct msm_mmu *mmu);
-	void (*resume_translation)(struct msm_mmu *mmu);
 };
 
 enum msm_mmu_type {

-- 
2.47.1

