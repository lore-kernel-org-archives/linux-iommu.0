Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5C29B775
	for <iommu@lists.linux.dev>; Thu, 15 May 2025 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339188; cv=none; b=G+b47zENUAmfa5f5LC8lVp3rIhxVjrgSaKTssBxfHM1TqVnGlI10AsJvWfrxIRhB4Y55KcHXaOKZqvavX7FnNpl5/+FZATnxryhA09BMNmC7EXJxybCRtdnH+CzvKMiGci3tuZK21LiYPVI6pZuhnN+vmT9rPimbaWfq4gc8ydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339188; c=relaxed/simple;
	bh=aRsZmjoGo/cSFHXwutiwXX9pdz9qjGh+q+3C5UDfQvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sQ/b46+8PR+BoHiZHFeJxTRQNdDu80FXSMULGPeToMje/OCc8tBWfbtC1K0pWaU5KtopG1bFg/is42NrmXBS3uoQWB4PQAN/dIF/rkE5s0MDJq83lQn+ilJ95uASiMzXsA0WAdEU8m9/JGHKiuwNCf+g0U9jXbs8PGSByKqqhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuEfamcA; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuEfamcA"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5528c98bdso16730285a.1
        for <iommu@lists.linux.dev>; Thu, 15 May 2025 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747339185; x=1747943985; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9GO00zbxnFbKyoYKR1MGg1EYQGaCXyOc2lNqTvdH6I=;
        b=iuEfamcAD0K0x2j3bAvkpgvH0WRJzI25k4pvzH3t31EzKzROZd9z32bqB+8eohY+Dw
         UU1rIFOO7ej/c0ztjX3Uv7QPyEGgxZ556JZGFis2iufurqxfMi/06kJxedeMpNaKaeSt
         CxmSYtYxFYyMBmhV90ImqWQZN7sm39egl6yT8a8+d36gdnPQv+T/35gTnz7XFiyemNAl
         jQX2X9mpWTQkfZ4KHQwtucRVlVcyJLmnHzu/CJmxoVoAnSWMp/sEpaO7Sn2IFpKtq9M4
         POLmQXMXQeueYbCA0kEotk9GD+5uETCJh12wY+o9mFD/kINhYF6k2TpipF4uXwoLYOju
         LoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747339185; x=1747943985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9GO00zbxnFbKyoYKR1MGg1EYQGaCXyOc2lNqTvdH6I=;
        b=f8E7N6NI/P5OQSQPPmmQCMVjh3ZQegNcXFkMOwcFZ5zN6kKJSp0xv64T36cAMx85Kt
         CdVkGGDqKNF2vbmsIJw5QcCctGEV/YEwMAA7WB46bVRh2c3LZ5K/eimYLgEZ/WNAlWPh
         Zf4mP4dLC/FgUWhwPfhsries7PMm+sailDfDiO+Nct/gDWMg+nqK3l/ZYnXW1wHpRhxP
         6bG2PpGrlPuxnGf9Kgbq4KruQHN3V/e98YTomYhk9E9bUFP4WDRLdI8KnpHIXg1Iv1tJ
         f4IXG3YopkjN6TMhkjV5TS/gqwWzbcBN6mkxjkFEoZCjzipUOUfMzX+8C66xQWXsIO5C
         X9KA==
X-Gm-Message-State: AOJu0Yy3pUqSTmzRXeCjXPXOcay97qfnK9XLtIoJJoHFW4TrLahVM7al
	zt9tZr1kc+cW89CEziEb5csRzI31c8CgHrkSYsQTjcATChe/wl7hNY4v
X-Gm-Gg: ASbGncsT8HO/GKWxIaPEbUaFv5SkXJTMWxyGmTr2V1YmV3Zuth6yRi6cy6SdX23EDNH
	0wFN7skNnCmVHIM2uDptQJDlh8HeiB3VhH2wl31M9qGyOp8dXRki7CNZS3QQnkD5gR+R2YGTy4m
	dJlEMLjwQEKokM+gncCvuOvg2O1O485iUl6CGBgdJ0qks8frYRCzuANpogxrYmGVUiwRxSwzx3E
	N46SMy4fdOAWmuhGUVHpmSQWt4X0/xRnGFcofciemOletMW3haA4FbIyKYpPh6FJhShcKmviX1R
	/8KykDt2SxJyfc2BLvQQyPve1SFedZ0+4MI3PMiv6ysR+ueYYN3m5mHzSxYYpdXoCwgeSK6l3Sa
	pL/w7Q7mrL/+hjJSRE+U=
X-Google-Smtp-Source: AGHT+IG6CqnqToKilBZg3d95WbqLz8tctrzr994PFqGigAXmx649QoHO+YFYQoHsNTC0rhdZ3luaSQ==
X-Received: by 2002:a05:620a:2803:b0:7c3:d1b9:e667 with SMTP id af79cd13be357-7cd4671faaemr58332985a.5.1747339185205;
        Thu, 15 May 2025 12:59:45 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae4fd80bsm1957231cf.56.2025.05.15.12.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:59:44 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Thu, 15 May 2025 15:58:49 -0400
Subject: [PATCH v6 7/7] iommu/smmu-arm-qcom: Delete resume_translation()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-msm-gpu-fault-fixes-next-v6-7-4fe2a583a878@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339176; l=1531;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=aRsZmjoGo/cSFHXwutiwXX9pdz9qjGh+q+3C5UDfQvg=;
 b=+pdVVw82/z0eIgzgC6o+AzTuVq7FlJ1dneFaBpTdAtknFxz/eSWyUdXaQGcHd4MoAd4oA8kti
 e6nMCOZKmtuBM8tRS1ISKqELZJCTLF3R76A1EnTAP8F/VIbPZJpnnUk
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

Unused since "drm/msm: Delete resume_translation()".

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 include/linux/adreno-smmu-priv.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index 8ed94fb39e6ec6a3d8e6fabe61ff142682f1764c..80bb36e09f07901fd73c522ec077b0b3211adc50 100644
--- a/include/linux/adreno-smmu-priv.h
+++ b/include/linux/adreno-smmu-priv.h
@@ -46,9 +46,8 @@ struct adreno_smmu_fault_info {
  * @get_fault_info: Called by the GPU fault handler to get information about
  *                  the fault
  * @set_stall:     Configure whether stall on fault (CFCFG) is enabled. If
- *                 stalling on fault is enabled, the GPU driver must call
- *                 resume_translation()
- * @resume_translation: Resume translation after a fault
+ *                 stalling on fault is enabled, the GPU driver should return
+ *                 -EAGAIN from the fault handler if retrying is required.
  *
  *
  * The GPU driver (drm/msm) and adreno-smmu work together for controlling
@@ -66,7 +65,6 @@ struct adreno_smmu_priv {
     int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
     void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
     void (*set_stall)(const void *cookie, bool enabled);
-    void (*resume_translation)(const void *cookie, bool terminate);
 };
 
 #endif /* __ADRENO_SMMU_PRIV_H */

-- 
2.47.1

