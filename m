Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3520E281344
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768150; cv=none; b=bs4lJw7RJUyZMpLLlBPsFECDInayAfXSD/F6lOqyFfzVGzSfFvOPjucSzulY3D4jTvRl+aV1Sl5PB9kKOrIRNnA4NXSdZ8sm5WwFNdsSEGRXfNfbIerXDdAJEHp0ldSZAJSSdSgBwRZbKICogNSNuzdbYA3ExOk3Kq18Hfp1YZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768150; c=relaxed/simple;
	bh=IRNUvyOjaxw/F2ca+hPqiQkWq4EHwHVBbpQuon23Uj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LiGYycMmO6jlP0XWFQNcElPFv0Tw03rBJ6yk0se381Bel72q9ERuvLeg1O+IY9Iige3ItT1VWqe7XBZvLj/Ya0ouJfMZ506NADdtWR2ZYK+LXYOTw5CcRfjTBLf3oZkhtLa9H8pm4faC16L+w5+IuhXkBW+FdvKQ2ht3WndjD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8g47IGE; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8g47IGE"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47675dc7c79so3046131cf.1
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747768146; x=1748372946; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cADqZ1V/EGiLXKG6qQOYNjFrT4sU1TPLVJeXzQQLmA0=;
        b=i8g47IGEg+a5ny6TKDfnlmqA0ssNucQrqCtNoqU7uhuovhwYXl2WxnlvHOpjm3PD0g
         ddQzKZbX0rvDYlDoeqfdwU+S2VE3DeV/1zt3NVNU3qHwaA08ggJcoOYlxR0kMV5Gbe+2
         VaeFqQEnSujQFoytpgW8sG57MvZqOeqvhUpnK25YnC3AMad/Oxau9JtLpxjSKy/tJcPV
         CUm9x1DKkgWXWCSwfSTOuiRD5jCUCImi+vxNKvOpZaB7l46oHlAmJngoZ/GSkhft7HL5
         qnXxmp8AmjCjRoUBD04iu/IDTsp1/Kz9prTzJrfBMeCkO1xIu0Niuk91stB1K/9+uo+f
         zxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747768146; x=1748372946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cADqZ1V/EGiLXKG6qQOYNjFrT4sU1TPLVJeXzQQLmA0=;
        b=AtAXtah738EbYr2CH+Q2qyknXMU8dqlSDO/I/7W6mmkyVJw2ud7zyx6ujtsgG24JOo
         cmXKMCdGBxma70peSCwtWKEmSSUGwrm6HnKiZ76J2Rs1Ul6O9DNahaEKevf4PuWk29XU
         QrePXwmL2Ehq8BK9ByxIWb+NsmJZNdLkg5CDSHaih+2lZwKGE5femZMDcwf1s1yCCir7
         l9PDFfEnqRSk+Wu5pTRLSGIdcl3nOz5E6YBb3Wmjg+JzHWGYeqRC7eqeQNOSaK6VRK7O
         61/lYQQnJJH6L/c+PA8tn3Hruc+TjvAu2e5XIDxZ8jqSmBaEfOuuj8MWO/x6HNOQkCuy
         gfKg==
X-Gm-Message-State: AOJu0YxHyIDLP6Pm6p8ASFNOmx1W7v/w7faskHaLrVu/q2oskLb/LVvq
	kiOcLUcwNO4EkWzpKGw4bn71bQZLEr26zv+vFqj4yvx3pVRf2fgNGv1n
X-Gm-Gg: ASbGncv7c6Ro57IBHWaBYqDZFe9HgRm7ofPR8YLEhqvhIbvciYtxjBZru2NAt3Z8cId
	Ykw1/pHCBDO4AbODzgjUaU3RrdtsT+ecYA1x+KY89MIaNQU7U8lhcAsclrn3puqAwgtKoII8hZF
	YwnO3pJKNlUZYmpKSgBhEpLktDgK+uX//UddxdmJQiT5jb6L7C1Fh89OFz0VFd2NP1vWNbDwAxq
	UzfegDwbzQikY4vPRF5nxY9xiokFgaXADFMdXOVm4NcBdrRUCP2L0v3GbGGfysTCjDC5eINynRO
	w23i8PWo05If/OeLdn+Z5/tESp+r6wfkeXgk2RzMbb0E2YMxsDCGgzBD1l7YoJ9MD2pIBwuhlNI
	OQfr2iLHWQjhjBCzD9TI=
X-Google-Smtp-Source: AGHT+IH/sySa48mHF1j+xGqwAb4OUN56/osDwaowVOBbvnddvZtTNPPLhnoNhpJNu3NLmENNp9KeEA==
X-Received: by 2002:a05:622a:295:b0:474:e213:7480 with SMTP id d75a77b69052e-494ae4557f3mr113963491cf.15.1747768145897;
        Tue, 20 May 2025 12:09:05 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae445b99sm76554051cf.48.2025.05.20.12.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:09:05 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 20 May 2025 15:08:58 -0400
Subject: [PATCH v8 5/7] drm/msm: Delete resume_translation()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-msm-gpu-fault-fixes-next-v8-5-fce6ee218787@gmail.com>
References: <20250520-msm-gpu-fault-fixes-next-v8-0-fce6ee218787@gmail.com>
In-Reply-To: <20250520-msm-gpu-fault-fixes-next-v8-0-fce6ee218787@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747768138; l=3387;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=IRNUvyOjaxw/F2ca+hPqiQkWq4EHwHVBbpQuon23Uj4=;
 b=5d0rxfRs5HCrkUIw2Arap8ZqFIuAGJ4FzZ6nBN1RaYGc2iwrZQL0YnVpt1p+/vjsJdBWdGDLK
 wKpde4hDDxRAJWeKAxM6zuLjWRz2y2+sHM1RYmSEmKQLnJbDbCP4lc7
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

