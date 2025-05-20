Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001827A927
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768143; cv=none; b=hzFLNy5kSsqpKuVraGcRwrCrjWNf4xMLhchaWwq//K7N3cfAbz+wieZNMyQDBQCL1wuayqTmz7HapZlJf0vlnbIN/61VFdola8eyLYfLfAs0/NK3Ky3pAdyZH4czvSFuvDgTG4o8eGTGHS561fvA2vJ60b03lnfXd4dvntedu1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768143; c=relaxed/simple;
	bh=ZBvYKn5K11+lNsz4zT1zMYa5IeR/X4du0GnqkshS5cY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XWkhhQX79QtOs16h0rRe9XhXi8LUUZCtr43wLRwlkQDIPpx3HteqkWI8oAH9L4GFLvVKvN3znL5AimUdvvgCdnCj5yToo/wKs5ybO/L5FYBVm/mJWQjtGA1S0Vy7teZUtyqbTZeDEywK60UQ2IFV3GgysTz3cCVVRQPEfDkZmP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OevWc1ri; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OevWc1ri"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-479009c951cso12610211cf.1
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 12:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747768140; x=1748372940; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvaowTnmN7oLC96D2HQ8Iw/m6LXgQG1UkyHMoTmfSNI=;
        b=OevWc1riMBnCyoKaJY6SQNCF440E4wUf7Mii8ZifYJD2JbWpl9A3VyZSmgfKciy/qo
         DcuLHGAQjA8Yb977zrarOWFtDuLI1aGeHCaSup3rFHIuODmStIBO+TGts485WKvzVw1G
         WUUYae6GW3VbBC/EIT9FXF5OnaGL7XpXZMBezhipsiW+5rv+d3vi3rlvY/oqXREEIfDv
         mukoO9F55WlcSYF4rIz/xfJnOIbVnoVx+c5+XatYwFGvv37Ej0Zu3f5XTlleMTM+3ifp
         UFh7LxzTCy8wPkK5UqkakUZxbK7rC1WmmFnVUvBLlvcDwxKf5kSyV4wRzEDdMN7BULIG
         Yxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747768140; x=1748372940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvaowTnmN7oLC96D2HQ8Iw/m6LXgQG1UkyHMoTmfSNI=;
        b=ku/yrcYqLyg3tTZuMijPHtO5x/qJRoFEwy+BkK1zhfIQvPE1L8p6A8LMpqdjQgEoXg
         XfsM3Fz3S/fnGaXanHHMRs8M0Opo2W/rPOVR6XJDgtczrERUbSzCeguS27L9tl1FT04G
         s2wqhNpeoaJOI3378b2Hd3e5bM13/CYlwNtLKu3r7uujb178BPoOgSKH4FbJYqd07fxI
         z1lLAuVgjvo7ebORK6PLhppmYl1J0gXKSv2YpTpuEbejumR2NLKyufdqigTFp2p7iSkM
         2Xed9Qtw9qERghkh/2jNlCPW/QuOOfpjcVWfV4zImgGb9v6dpGEC3BdEMWPHbR8Ario3
         H3pQ==
X-Gm-Message-State: AOJu0Yy4vjTbLj/8wNOOqVKE78hhzv91q1ftrPUh5FKg8ovSsLacfvbg
	JQ1TR6J9XuEq1cF8PKcD0PR4RCWtrXp7zzbFeQ3514w10FDDLe/iZBbw
X-Gm-Gg: ASbGncuafrPnDFAVTRyk3mDgI5ZHDDVQEnPI9GFAotbkLiRnTfpuKNF2Px92z8q8Mzw
	lcuOt46t7MOZejoo6aYE1gNpEBXHlLUq9Ys3HDuProoWF2JMnhxz1J8EAvoAIC8ScoC36E/bt6u
	NV74fsBqxQBq6ByCgmSC6+x97JU7JdqwlOdYTf1Qaz7cOgeVVywHMAmVeH6AfmWq3n8+S2FNsKM
	bf6ODwb8pzMQcqtjGA6shMFrzK+8BNOUjMtCxbjFLiNgYkof9i9tcIvghnvc7Pu3cqq8C5pKsvj
	drblcol1Nq7fHXSczQd7ozhMg5oOytYkwA7GPlquU3IaQuXeokCoGGnodvh5YWtnWZ8nJPweB7y
	nZRpwoV9UGgrCYwoXTZqcmUPD6piULA==
X-Google-Smtp-Source: AGHT+IHrhoVKr8ZuMW3LLmVacxqlRwznTBlrPPx7593+XpI6zjzFhRF7/0TUgT772pugTudEsg+iFQ==
X-Received: by 2002:a05:622a:22a4:b0:494:b869:ac06 with SMTP id d75a77b69052e-494b869b287mr85977441cf.6.1747768140371;
        Tue, 20 May 2025 12:09:00 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae445b99sm76554051cf.48.2025.05.20.12.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:08:59 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 20 May 2025 15:08:54 -0400
Subject: [PATCH v8 1/7] iommu/arm-smmu-qcom: Enable threaded IRQ for Adreno
 SMMUv2/MMU500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-msm-gpu-fault-fixes-next-v8-1-fce6ee218787@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747768138; l=2173;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=ZBvYKn5K11+lNsz4zT1zMYa5IeR/X4du0GnqkshS5cY=;
 b=ViPeijvXoIUFv2QAC6sXPESomfVyzJ6s9UWCJTU2K3EndiqfiDH0VcJPIhmS25TOOhh6IVZsY
 tWgr3r9EDqOCOO+X64zLIEayNFmirrauIr4/BJjbDt38yQUW2T81wXA
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

The recommended flow for stall-on-fault in SMMUv2 is the following:

1. Resolve the fault.
2. Write to FSR to clear the fault bits.
3. Write RESUME to retry or fail the transaction.

MMU500 is designed with this sequence in mind. For example,
experimentally we have seen on MMU500 that writing RESUME does not clear
FSR.SS unless the original fault is cleared in FSR, so 2 must come
before 3. FSR.SS is allowed to signal a fault (and does on MMU500) so
that if we try to do 2 -> 1 -> 3 (while exiting from the fault handler
after 2) we can get duplicate faults without hacks to disable
interrupts.

However, resolving the fault typically requires lengthy operations that
can stall, like bringing in pages from disk. The only current user,
drm/msm, dumps GPU state before failing the transaction which indeed can
stall. Therefore, from now on we will require implementations that want
to use stall-on-fault to also enable threaded IRQs. Do that with the
Adreno MMU implementations.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 59d02687280e8d37b5e944619fcfe4ebd1bd6926..4d3b99babd3584ec971bef30cd533c35904fe7f5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -585,6 +585,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
 	.tlb_sync = qcom_smmu_tlb_sync,
+	.context_fault_needs_threaded_irq = true,
 };
 
 static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
@@ -594,6 +595,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
 	.tlb_sync = qcom_smmu_tlb_sync,
+	.context_fault_needs_threaded_irq = true,
 };
 
 static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,

-- 
2.47.1

