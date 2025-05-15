Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5C296FCB
	for <iommu@lists.linux.dev>; Thu, 15 May 2025 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339186; cv=none; b=uVnas3A4BTZkh4jdU/xc166qlHCH1MVoYAPVkxHZUqZPo1Pey7MOcM5LqtMge1NxDGG6NXvJCPXY8+4ZLwa/4TfxnqXDZnuhV2UTBaht9Fofc8O9Kt7LsNpQgPxi1Fvv1uADqVHtzQ3syjQs9V+PkyK100ZYXANsNFr9GZ01gks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339186; c=relaxed/simple;
	bh=Qq5k1GBVvpOoe3vbf7lHYuU1s8ow91pqey8KnhArgxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EiB9sbv+/RTAj3ytw3lcHFMOkFxYZ/84CLxFIOHPSXTXMRlBXXLJkgT6Tz2axD0R/rA38hQ53wiE8AQkVCAc034FgHqGP+9GYMTN5M4i5CZRy9MnevuvFi0TJWHEwXxabgBaOggFhlt6Ith5HsC1JLv14tjuP0wQ/th+VNhDpoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZlgq0hE; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZlgq0hE"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f542e5984fso2294566d6.3
        for <iommu@lists.linux.dev>; Thu, 15 May 2025 12:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747339183; x=1747943983; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXRAlEAkp/v2H222njYW3lOGT6rTudruLVTCXUshl+c=;
        b=TZlgq0hEd8OmOdOviE+KLSshGRCpr6GUyB5SNPfgOga+gsWQ3hOn3awe6J3J+A2d3I
         ImfO6GIOvP/zb2bUlD/ehNyJMwpQ9ViMb7r+pBAzqn7HfSMEJCpkiD5I5aeyY4ds35yg
         Mbuj9MvxT3XO87DVBBdnv+vPlY24VbaMp0rcvIVNISz5Ay369npZzBBP3QPVZ6R2WWHl
         ehTPYZmOJInmZV2ELwkgRlu8MFZY4ikWDzYhuEcpfAVnFIv+E6Pfcndu8RaPc5mMKaEO
         yefiFzCsSTL6Fab8lSqQOxNefDoZ/JZBatTf6/+pUW0CtYBhBX9vHfqPtT2KFsP4UDMb
         fnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747339183; x=1747943983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXRAlEAkp/v2H222njYW3lOGT6rTudruLVTCXUshl+c=;
        b=eFks+7RfMLP5oj7VXTXPc92/1eeRkPqE+LWt4pwb/d0cKTtLHPTia2OJ3yZB6dWrRt
         N8GYy1G82y3wI3vVL4rroy4JxTuwc8/sjcPwQvRkhsOhSOINZ+z3WhgQhtjS7gtS9Kni
         3WlPYC254q18DJp3glsS5apxuTaeH/M6TXloNQLe4EYNWcmjX25gXiBglUq8YEKW3KMX
         +AF15OuAC0j86YGyHAR0oUtS2oYnHxB+defjD7SRPUb5BcIEvf2ksOMwR0+W+3kxBagz
         B8YLWYR3WqDqpO12pOo+xaKA3DQH5dh65W5ke7bnPXWUN2RSRysYpgr/wvsMGcjs9plh
         21Hw==
X-Gm-Message-State: AOJu0YxC62k+r/z5JSbvtAbp/Nw6jGOeWVGYjvOI/UDZoNODuSizO/B+
	bCWz6JoGLfjEwGfX/qvJD3iku+FRXPWuJMDGJTmAlWlHIXZsBRsWkl2/
X-Gm-Gg: ASbGncuiPzINPvdwACCPOQxhZoNJz1m+hLUSk79KtNhzevIkXT4oWgXk5Rw5B3Ctu17
	ztRpXgCqLqMnaM1snbm10cJOw1SGEZXbo8hSOg+7ZNXbbqTRkwfFxFS7HEsXf7kMqaOdMT6ZQWR
	nR8QUjfEoV1XpoPTlh41zfWJGxju2Of6SmXluIUcjnEzTaAHC++IBuKBldZyZyBwFxqayqW2cjm
	Ux3sVBHuIxFuzdHinnNIp9VupiWTNXF79YFBSdGsjHHUh2JDGDT1cvsIJ6u1U0CMWQpB5FciNGY
	X9E+EyzpcWv+Ba3JCU00sqKM3zgbj4VUgy1dd+jCaJjM8PFAhiwDK3Yat0SJe7wQIjvVTh/L9du
	thgrP+F6zQ8xiCGAjSM8=
X-Google-Smtp-Source: AGHT+IHON1Ci4ArRCi8J9fIgnvSIH3M28UzX9E4XnN9n89/XqiNa63YZ+YYjbAguQ3rvFJAVU38Aqg==
X-Received: by 2002:a05:622a:19aa:b0:473:884e:dcff with SMTP id d75a77b69052e-494ae4539b1mr3915141cf.13.1747339183019;
        Thu, 15 May 2025 12:59:43 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae4fd80bsm1957231cf.56.2025.05.15.12.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:59:42 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Thu, 15 May 2025 15:58:47 -0400
Subject: [PATCH v6 5/7] drm/msm: Delete resume_translation()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-msm-gpu-fault-fixes-next-v6-5-4fe2a583a878@gmail.com>
References: <20250515-msm-gpu-fault-fixes-next-v6-0-4fe2a583a878@gmail.com>
In-Reply-To: <20250515-msm-gpu-fault-fixes-next-v6-0-4fe2a583a878@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339176; l=3253;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=Qq5k1GBVvpOoe3vbf7lHYuU1s8ow91pqey8KnhArgxI=;
 b=/yM3pG9E+DokL/lrL3Cl3ogv2uxixtq/MENaQRhh9mJ7nye6cSJOdpS0NZNuJb+oTQewG5E6D
 ++dtz6vH3kzBvtRX4KSQtz77NW08TMP7QhhfQ5z4KlxpGJRz/i6wi0U
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
index 2a94e82316f95c5f9dcc37ef0a4664a29e3492b2..c6fed9bcb0021a5ad25d8487db1cc05869668c3e 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -323,7 +323,6 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 		unsigned long iova, int flags, void *arg)
 {
 	struct msm_iommu *iommu = arg;
-	struct msm_mmu *mmu = &iommu->base;
 	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(iommu->base.dev);
 	struct adreno_smmu_fault_info info, *ptr = NULL;
 
@@ -337,20 +336,9 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 
 	pr_warn_ratelimited("*** fault: iova=%16lx, flags=%d\n", iova, flags);
 
-	if (mmu->funcs->resume_translation)
-		mmu->funcs->resume_translation(mmu);
-
 	return 0;
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
@@ -398,7 +386,6 @@ static const struct msm_mmu_funcs funcs = {
 		.map = msm_iommu_map,
 		.unmap = msm_iommu_unmap,
 		.destroy = msm_iommu_destroy,
-		.resume_translation = msm_iommu_resume_translation,
 };
 
 struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index 88af4f490881f2a6789ae2d03e1c02d10046331a..f118de637b1b35acba76a92c2cca1de9b2fad5a0 100644
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

