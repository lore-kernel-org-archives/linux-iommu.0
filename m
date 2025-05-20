Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEDC280306
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763104; cv=none; b=k3ijnrHccORP/T9wk9N/EcNeGBrHj06GcT9Qk8nv/tPJQ0Kou+IidAoG1UDjwk20IrCodyCznjm4PatpRsw6J3n6dli/R737+mz0NHIvZQAVp6pWmJST3piQMhYa7HEhCtn4105PBG5QyizO7E1ss4qBLK9fNSWS7xMhH/klMOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763104; c=relaxed/simple;
	bh=ZBvYKn5K11+lNsz4zT1zMYa5IeR/X4du0GnqkshS5cY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sc15UBhAh7Bnej5l5MRvb2oSKKcg5jX0gLzmkP4l2t41rYh5I3dMdW2M3nmdGbr3V9ryDvfrO7mKVzJwrF8bxvI1PIHQr2mPFql8XU+JDuFYll/0udv175iyDHZY9j73UqUtSFDkia2r2jpRKqwt3PR3/LaV/WOciervx5ZQoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVMa8uLl; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVMa8uLl"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6eeceb05894so7984126d6.0
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747763101; x=1748367901; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lvaowTnmN7oLC96D2HQ8Iw/m6LXgQG1UkyHMoTmfSNI=;
        b=CVMa8uLlpFL75YTs6uKKZ4Aguz2dD8fez2SSyr3M2jON5wKrXWN9GxiImUGnct56cP
         VDrykycQaFWTOWXAm5t08xtP3Olrlkwh/ubHTypItamTl8Rzou6N3utke+MatxVxvu+t
         p8yueSVLV0u7IpCCBg9Gj+xkUitxkMyNof/faE7Spo0VDc7HCJm1Q9RRhGIcCfetiQXQ
         qBOenjVFuwSjwECU9E624g30tFI9/sCAl3b5vdMZZdzkKyMuAQWP3Dc3Z7SGWNaddWE7
         liQuIX5fs5W2Yv7EpYuQv0M2otLETgc1o6G/+maX8YHAYWzZbJkmYo8D+V/x3dAqTDuY
         Oe3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747763101; x=1748367901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvaowTnmN7oLC96D2HQ8Iw/m6LXgQG1UkyHMoTmfSNI=;
        b=YxYVi2Ld6s1gJ9gPww71SZlbv9mAe8CqyNeP5RgwArxE0W4vyQKBUnLwyI8dtOtvMk
         wmx2oIALZ4tOXulMhrlQQQ8TTVDCoflWYVn7iLEIIT5ag6JMgrwOqcKP+QQ71EQxDSQe
         3E6HvgFt/H9xO0BTwsjHhs45mgaD2Oh3r+PRbBt+l84LOn+3RbAn6wnAOxC9aH3LXXxm
         bD6jSKI6liVcV5BXaEnzWFJnasD+B/yvucIphT/pA78iCHIZnyVn6RyITM8gRhsNgt6D
         3lZdNd9a3RXMFGdZZ1c0WGyLJrLB6v4kBu//yHHjKCALqaqd/LVjNR2r7XQ964F79U6T
         wvJA==
X-Gm-Message-State: AOJu0YwpZ7RWJcLB2c2v+Mng5ixIpZvX7jS4zQAolfYf0dsPY7bow1cY
	P9tO6tABCA2LugpNyozvl0AQ58qwXaQfH+ubjAJPilsaOa9EpiDbbOxC
X-Gm-Gg: ASbGncsjSmLDsPLrqPNThMeoPEG4z5ib4WRs1Qlub2qQSZ5uKLIJu8VnzGFietcNoHc
	92wRGi7sdQpAkeEHTeoKRIhnvVg0T+004nYdo77oCwUyn2PHeYPXn+R2Jgi+ZPL2k85/jQ4jiaA
	eg2bKWhXfjdl9mL3cEqjqePinEmyfq/iTrhYszvZNKwP5Y7Fx9VcYJyt5lRczPEiyg8RjUDZ+RG
	QUmeWs3eUQW1zYFMkqeHhlRxJ+SvudDgO4U8Zri/b/SWGd4PSey3v4nPPZZ8Vuv729Qa8StGmA1
	KhgQsCExNN8gCur8rzfK3r1CHOE3o3nJgFkiyR/hRTUzvgSA3OORdB4QygFFEIfGNXhfqh/4PZY
	uWabQN7RnLESWHtFrL6s=
X-Google-Smtp-Source: AGHT+IGqCzG1SvNWszzrmmzUY2oSx7dYJcoW7SuKzN1obqGThnOW42g+lUzHl4o0PdCvhz4+UPzvxA==
X-Received: by 2002:a05:6214:29c7:b0:6f8:e361:78aa with SMTP id 6a1803df08f44-6f8e3617c79mr23828486d6.8.1747763101074;
        Tue, 20 May 2025 10:45:01 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b096ddb4sm74126586d6.78.2025.05.20.10.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:45:00 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 20 May 2025 13:44:50 -0400
Subject: [PATCH v7 1/7] iommu/arm-smmu-qcom: Enable threaded IRQ for Adreno
 SMMUv2/MMU500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-msm-gpu-fault-fixes-next-v7-1-96cd1cc9ae05@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747763098; l=2173;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=ZBvYKn5K11+lNsz4zT1zMYa5IeR/X4du0GnqkshS5cY=;
 b=JmZsTt+6O7fNx0yDUqUsXkrhtOsb8qvW7BpJuQ7B23u1tzp4qHdYnvwbwbDnWJiZvcItArAbQ
 1T514ek8rm7BoPLevyDE8Ux2jAjR0ELikP8fAA06vsIo8AQ7PBSk64A
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

