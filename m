Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E0A1E480
	for <iommu@lists.linux.dev>; Thu, 15 May 2025 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339181; cv=none; b=OlF23GbMHkL7+isarhaZRlI9F69WMbEZIa7AKm64qWwPmBzvmMUcCteFG2lcH3n/R+AoUSOB/ot1BXM9x48UwNz/d7uMheXfuGG9Up+sZBob2QXQMx9G4+cMyLVNpPzypdaFPp6H+/4f147Wd8s4nvzImy1qA6fOvn3DKLGF8fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339181; c=relaxed/simple;
	bh=DPKRVjaqGjt+UvV8ZZCM0hAEA0xW5F7yYBkPh+fJ4X4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fz60bjrSle6twrVe+XyIqyM7G80Ty2nvyY4Fx3c4XNTtD4SR1N3fS71zRiYvGvRn+s1K72FiPCOEMwR22EHD5988+EhsbUKqVAhe8pIAlzB9h34cMr/CGUU/94qlLPlxc1wwAuf+YYompLtEhgF2Vp1RSBHKnYUnjCxTuLUdczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncIUigJN; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncIUigJN"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f8b0f7c42dso404706d6.2
        for <iommu@lists.linux.dev>; Thu, 15 May 2025 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747339178; x=1747943978; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWJZCHLwo4+rNxVq1K/n30vdDm3CIQkELPwI2pLPS/o=;
        b=ncIUigJNapVdrOL94WLZ9Nk0QXcM5JaLpKk1+9HG15CQZAfnIDVpMV8084dXGORYZB
         RfGJs9sC9cD/dgfb+uew6/Ker0gV3kFBM1/Xr5+S5z8YceK5w2F1M7bLh5rhAkEPBlGs
         yt/qrHzNFdNOf0ivf7MtjzHo4UkvTupT6PI7Pdz42ynEFo4mj23pR9ii2h2ZHCMPpTol
         uwQy0m9PPsCrk59+1jEivgyGXDAmyKIh3TRSWzAgJRoXFnw/G0+Zpa0ftUSAeaCMOPKD
         nOcQTeLfPCkSvJZvS1YzvX4LyodeJLOfk3KO/sDowkj1VjxQ6IDxim8dEO7lgCJCD1/e
         odEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747339178; x=1747943978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWJZCHLwo4+rNxVq1K/n30vdDm3CIQkELPwI2pLPS/o=;
        b=kc4DJMAXYMRCkTT8lxnM3vD9S6O3eAMf+aLefEOI1VBlHzVogeX6Rai4Hy7Up0MT6e
         0Cmu9zFFuIXvTnHyPitotc058RDneznYlYJea4MVR9+egD8CWJ8mmvaQu4uWWzzfTFY7
         C6Rba5s0HTFwLlYPn3sKopKnr2j4YqpfsKx2lvGWfIpIzBmZaiA7pQ+vfn3mOyIGD6Xa
         hIxZfyK+pEZTDatTfvKECrWragafKYA5oJJPPCBRYp6blICeDkyrJKkD2iXL3UZTXhCh
         030Q/xfc6RfjQ6MaYbWvm6acXViHYT8TKV9RsIywVYeHgUHCqL+bPZqxEDFL4YNx30IX
         bbJQ==
X-Gm-Message-State: AOJu0Yz8b2r+Nj5ox5RRsJ7Lzd62kCst5deLgWa5UkM/UhOmNyc2jwMa
	bNHz33yjT7wZVTrmv/h8wyjNT/JsJ0nvfRlWT8v5oXzDkp2Cant/EGkZ
X-Gm-Gg: ASbGncvUCz9eN62ILugLUy6PjxHs5DqwQSGq40mWn0ThN8oqI6t76wPlFn8bPK1mC+d
	caspbiJEtZqfv1HsMg6ejgQe2iHW+o/8ACWBzZJu/7tgcgGShDCUQCypqwDCL1PSFINYub2JcPY
	EF3VWWGSVYmLvGTwR4/ppGt9T924JWmF9UGLj9IbncOd37XJFKj3mcrZiQ2IS9z1n6jwx/h03xc
	pJy2Ye0PzNiLmumJu+mROK2Ute42chMRo44gUqE0O5KLHaUfUItzyf76xQhNBpGojwQYEYrVxSh
	NORGb9QKZVmdzz9uFZ/z4VBWWfzbqwZIDs188KgWVZ8prrjpxyrb5K++B79do5GaDtL143xOY3L
	bTI4XOlNMkufONo0b6tk=
X-Google-Smtp-Source: AGHT+IH82TQ9c8cVYqaXjsAhzpScTuQetKQyv8EkyvQLwXx7nU7GdytaDPOdEesc7oYyyCkeN49+/Q==
X-Received: by 2002:ac8:5951:0:b0:475:876:ac3d with SMTP id d75a77b69052e-494ae41e3a4mr3460681cf.13.1747339178066;
        Thu, 15 May 2025 12:59:38 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae4fd80bsm1957231cf.56.2025.05.15.12.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:59:37 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Thu, 15 May 2025 15:58:43 -0400
Subject: [PATCH v6 1/7] iommu/arm-smmu-qcom: Enable threaded IRQ for Adreno
 SMMUv2/MMU500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-msm-gpu-fault-fixes-next-v6-1-4fe2a583a878@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339176; l=2173;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=DPKRVjaqGjt+UvV8ZZCM0hAEA0xW5F7yYBkPh+fJ4X4=;
 b=62Z0w3hpPUoa4KOiyVuNO04DfGNn3v70J7ZnmSCozzrwREkvpBQansvHOQaEZoUFL+zftDl/L
 uXXn7xCS28bAYrzU5iTGeMySBdN12STsv+/vLopzuc9rlGmgu1VXpvp
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
index 6372f3e25c4bc24cb52f9233095170e8aa510a53..2b21b7208bc7b439d69e36ca678acd2eacbd5b85 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -468,6 +468,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
 	.tlb_sync = qcom_smmu_tlb_sync,
+	.context_fault_needs_threaded_irq = true,
 };
 
 static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
@@ -477,6 +478,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
 	.tlb_sync = qcom_smmu_tlb_sync,
+	.context_fault_needs_threaded_irq = true,
 };
 
 static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,

-- 
2.47.1

