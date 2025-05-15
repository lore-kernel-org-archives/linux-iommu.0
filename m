Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D9298CC0
	for <iommu@lists.linux.dev>; Thu, 15 May 2025 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339184; cv=none; b=G9hps0wBMDF/fTXVaVVRLJP5hiR7Pt2IUjgrVX5sL6TIz4D0WtliOqKZpFKv3vQ8Gzzuc2hoQF1cbeRMUsH+MnhEXoKFD47UCWO8jaILyQ9cxzsPCVEa6RlNHbOUqJW70Kbr0ZjHUZuKcYVbY0gpiZtYcWZ05tOo2JcJh3yel8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339184; c=relaxed/simple;
	bh=NuuNOSzcg6T6eP7lLDMW2wQqpv+M7MyGEuNFao145fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJjMLmJmiqkwnCQZOwqUFYCL/hYTa1aTP5Go3XeDpkSE7GTQO06ptofu4nNuo7kppsFr8p0AEo00il7EbtfXAd0fABgeCY+9rMxAzsDH6JqKurTT1t/eXQs9CKn5bRL/x4T0+TSKqmbxws0/dM9XCVUn2FXuDEzJUFtYV4mNmtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM8wD66N; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM8wD66N"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c548db0aa0so21740985a.0
        for <iommu@lists.linux.dev>; Thu, 15 May 2025 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747339181; x=1747943981; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRX2mmgMKg0kWmEalfWfPxyKsLjxoohp0lPvLbYN2U4=;
        b=YM8wD66N1wnkK5nLBQUQEDWnP9FPpgldD+4r163w5wKmyZ7BCTBTjVRH26QZsh5FD7
         BZQlY0ovMFwyoNaREhQiUdWSW5y51iuQfrMymI4ZMHmrYJzmy6zgnOM3WL/gWVXWpv7O
         eGcnmaV65pyHTYtO0x1F3qup/Wf8J/aOf8JUsN5F6gTRDdCMa4hCtRtSh6MAq22ZX/Yk
         IXMErUdu76iLOqpJF1mYdDy3GvChR/nJmaEyCChxjiDrhesJiPoajsNys43eeRosEQr6
         9AzgztUGiyzHRo8ycMaT2AFokrjqAiRd/U6Vr+HR2LZ6L5hZGS0+NU0ZicbVQvoX6YRk
         qvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747339181; x=1747943981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRX2mmgMKg0kWmEalfWfPxyKsLjxoohp0lPvLbYN2U4=;
        b=i9M4rzB8QxJDQlG72g4r3gNSp5Sd9z6NGsTR2Dz4vYvR5qE09d/xfiY+SEvK+N7Fh0
         o5YYFXe0qa9JoPErtQIzfr5u13fCqCx5aKQhNP157rlVoe/8tFT473q/DhmbaQbyfq/k
         3w5IyFyjNOWK/mXqCqd1eGjmbOpxObpGjwlxIbw8xyxc8fSMaTfQSWcn6XTpNXdPtJ59
         I5b7cf0ibyYuwTnjUA1MWc+drsksrcCJjVoCO6kG2lzNV9aTy8LiLH459DEjIn2wA+L+
         N8AH/hmyHNIk3UUS7R1J6UZ179zzlu+8dLDP3VKhyXPOKt50W7hks3t4GqTcO1fuaWfv
         49fA==
X-Gm-Message-State: AOJu0YxqBIuiMk3nwL8dJ+9XygdIw/ZlOOw2CH7C89TRsf5KGw5GesU6
	KCm+e7eo6v5HLLKn0P2U2mNqk0bKd9J0UGSpz6VT35/THKGzCZPWt8i81hJrbvw6
X-Gm-Gg: ASbGnctIJ4vvOpzf7J6UFKphb9aRwqbhRvt46SrrE+L1WAw39cw0WYnuTaYsr++aZY+
	gx6rrNFHHz7uZNdes16bJtCtGb14Xu5duXnqkbmbirU9WZl6t0SWbEdbWrywuv2ZWhKxohdWM0+
	qwIkVWNEi5k0CiAx6DBtKa993nrGQr6hSpMTZYKHKMxvn4qDYEFl+eYGlCt6GfiyAXDovdNe3Y8
	cA++dWneGWW4DkobUN+BdoXrtvDKNJCdpiZlg8Ab3QwFeu8ZZuOm+MWZyk1RKZVee9sV8ieZpb4
	ocSfkQ5u1dXcPjF1eaBx6yf9gITCudO0eJeWKxP+ChCscMqm8KfbSLeHV1X4Whl58K3i5qiF8OW
	snoCHUAzPt4sbtIvgtmo=
X-Google-Smtp-Source: AGHT+IFDWp8u+QjgmXSWCzrAKUKVyvuRDbgutIyJGTYJ63yX5WXLYpLuZEG+9WHmxaOHRSYMoJ0INw==
X-Received: by 2002:a05:622a:1306:b0:474:e664:691b with SMTP id d75a77b69052e-494ae37764emr4557401cf.8.1747339180611;
        Thu, 15 May 2025 12:59:40 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae4fd80bsm1957231cf.56.2025.05.15.12.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:59:40 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Thu, 15 May 2025 15:58:45 -0400
Subject: [PATCH v6 3/7] iommu/arm-smmu-qcom: Make set_stall work when the
 device is on
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-msm-gpu-fault-fixes-next-v6-3-4fe2a583a878@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339176; l=3349;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=NuuNOSzcg6T6eP7lLDMW2wQqpv+M7MyGEuNFao145fo=;
 b=G8f7cSFchFa6Ol5NZmbPn25aQKQkCTssSAZn+8lrwlFIh1x96h6u6Eq2OveCkRVCprigujkFM
 gF8bATUpx0qDSrjfTkYolsLQIxjAjr3aU2RLL0cOv0MsHcy5zrhpUHQ
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

Up until now we have only called the set_stall callback during
initialization when the device is off. But we will soon start calling it
to temporarily disable stall-on-fault when the device is on, so handle
that by checking if the device is on and writing SCTLR.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 33 +++++++++++++++++++++++++++---
 include/linux/adreno-smmu-priv.h           |  6 +++---
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d71404ad90376b2c258d67e07ec380674961a429..98927be42bd1af25dcc3f667cb75d250a320c447 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -78,12 +78,39 @@ static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
 {
 	struct arm_smmu_domain *smmu_domain = (void *)cookie;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu_domain->smmu);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	u32 mask = BIT(cfg->cbndx);
+	bool stall_changed = !!(qsmmu->stall_enabled & mask) != enabled;
+	unsigned long flags;
 
 	if (enabled)
-		qsmmu->stall_enabled |= BIT(cfg->cbndx);
+		qsmmu->stall_enabled |= mask;
 	else
-		qsmmu->stall_enabled &= ~BIT(cfg->cbndx);
+		qsmmu->stall_enabled &= ~mask;
+
+	/*
+	 * If the device is on and we changed the setting, update the register.
+	 * The spec pseudocode says that CFCFG is resampled after a fault, and
+	 * we believe that no implementations cache it in the TLB, so it should
+	 * be safe to change it without a TLB invalidation.
+	 */
+	if (stall_changed && pm_runtime_get_if_active(smmu->dev) > 0) {
+		spin_lock_irqsave(&smmu_domain->cb_lock, flags);
+
+		u32 reg = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR);
+
+		if (enabled)
+			reg |= ARM_SMMU_SCTLR_CFCFG;
+		else
+			reg &= ~ARM_SMMU_SCTLR_CFCFG;
+
+		arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR, reg);
+
+		spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
+
+		pm_runtime_put_autosuspend(smmu->dev);
+	}
 }
 
 #define QCOM_ADRENO_SMMU_GPU_SID 0
diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index c637e0997f6d8eedcc42a03a9d303700f62f8cf2..8ed94fb39e6ec6a3d8e6fabe61ff142682f1764c 100644
--- a/include/linux/adreno-smmu-priv.h
+++ b/include/linux/adreno-smmu-priv.h
@@ -45,9 +45,9 @@ struct adreno_smmu_fault_info {
  *                 TTBR0 translation is enabled with the specified cfg
  * @get_fault_info: Called by the GPU fault handler to get information about
  *                  the fault
- * @set_stall:     Configure whether stall on fault (CFCFG) is enabled.  Call
- *                 before set_ttbr0_cfg().  If stalling on fault is enabled,
- *                 the GPU driver must call resume_translation()
+ * @set_stall:     Configure whether stall on fault (CFCFG) is enabled. If
+ *                 stalling on fault is enabled, the GPU driver must call
+ *                 resume_translation()
  * @resume_translation: Resume translation after a fault
  *
  *

-- 
2.47.1

