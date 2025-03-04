Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D4281372
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107447; cv=none; b=eU81jXKHl0nmZ1KajkdmINO3XOrsjXosaJNOxq1IJpL/GUaH24PN/CosT66j7bOHRJ+EwJfico0f42zObDbx7k0P6wrtgF8tZqRj6cgMoLXdSCFmSQ6SI7/h20zPqPJCCmtGCnllk9e/GC4dRL9fhuVYf8BL66YpEJO9kM3ebSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107447; c=relaxed/simple;
	bh=Me/D1+KhPPoLdXUQArYzWEOMKf4DNFEbfunwhGA1eSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Po1utRA+xg8tUgJGXeTZKE/eafrLPKT2hcdxkX8SUM4l+g27Vq8us24nikaarIEoIBGF+Cq05ANiVrV0i0eTqJ4q6ZVT3zJXPi6ctQ04wwbChscw9MKbA6gPahKIUEy75+xDVoIQDFx5vRfEXtgtT2BWi9m4iNWZP1N+A5pxjsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrV1HT6C; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrV1HT6C"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8969029aeso8820296d6.3
        for <iommu@lists.linux.dev>; Tue, 04 Mar 2025 08:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741107445; x=1741712245; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4O0NBwVlwoR/WweI6jxIBAubbEuQBPU/tNgYLJ99BM=;
        b=RrV1HT6CDiBhPOXQKlCEJVpXOpkrRIscKVyitsV/RaeFuHXTSXljVbE87aZYeBL7ZK
         V5VSH+OTbx9/QytuFCbhAS7uBbAvepgJAhxJ6k0SU2sNMtKot6ap7Adtys3IyA/1kqtN
         zLY06xFOj8xilaReOq5P6HJJ4IAZoU5dILtnCKAFzY09rBt4PibP3PMn8ZKhIciD6QrB
         JZju8EP+7ZcbpeXcygZ1/ojlkAEvwNpyur9LKgsJ6wY0qJWzhOgRTE8j3SB0ew1cAeF0
         FwMlqtea6mWkLeLIQYUhyxzI8LsWlsXQSEZzX/DG0fdLTZaSfaXqpgRZmGsQX3PVKYmM
         cAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107445; x=1741712245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4O0NBwVlwoR/WweI6jxIBAubbEuQBPU/tNgYLJ99BM=;
        b=k83swrg7/xSOwumP4PAWXZ+On7H0O5crH35niyxrrSYRGxn+cdHiryta+JUxt2BplY
         iXRUwumJUgrzc1E7l644O1vBXLdrdcV566Sgcw5SLl1IkAxEXmi7l08U0wyRs3ONmjAC
         /DikIMxa/Vu171ut4ydKdkM6w6I/8aQGvRvjbPRF8YuEQAxe+dEg1ASLHlbrm+hwR2va
         0lmEibwt4jG+aZaLjyR59HKRK+V2WsSW3Oy/nZaa+cjXEvXlSYFGT+kGUogyZjwtgcd8
         SNeQj6E5rWjFQ/38LRt1R5F44ogspj0FAJRHQ4u0mkL5/tf5aQO6HijdL0CbjnvghA0f
         N1FQ==
X-Gm-Message-State: AOJu0YwGnETQvtyNwvM7ky/WHANJBFhuJIDZDmQqNv0N4KAWJGMZFnii
	HOTyEvbj/Oa9kFnkRLmnde0jxe+1oM0Uu50pxfwGU8FtiddH5LRx
X-Gm-Gg: ASbGncu17nJ3+rk88DxfVIjJarY8ts+MjuxfIV/p6I9fe+drkswetLO1uEMj3lb2EbX
	f5ueDJcBJkFX8yuax9Gh/Xbm+rB5nhfzTFzEwGrfEoWxKpnkb4RvnqDYZBkzUj+R+kBq2+6V10T
	d5Vf0LbgT+kS5klVUqdEf9I+qMyp6JuaG9nfDU8qTc8opTgbn+Gg0vPUXUPE7tvw+T/0RyNfNbC
	iYG9GayzjFGGSkfJpBFM44Mt63PNml1/80CWH3ivFLAKLt9y+RBfG2DkJI84i6K/f4uVAWPt80n
	ThcKspasMop9z1I8uDS1+KGOSySMpu/qRzyvtFAGhi7WNOaekUtT6aHlP6PZtRLKrzBCMcfJrf/
	9RpM=
X-Google-Smtp-Source: AGHT+IFmTBw/x9z2AhNxbshhDZU2/MsdlMTKQxvGcWNlN4YbSO4kS6CeUKvMP93Gc8bji+QnPDvufA==
X-Received: by 2002:a05:620a:444a:b0:7c3:c406:ec10 with SMTP id af79cd13be357-7c3cd6830d9mr199306785a.14.1741107444924;
        Tue, 04 Mar 2025 08:57:24 -0800 (PST)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec3b6sm68915966d6.125.2025.03.04.08.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:57:24 -0800 (PST)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 04 Mar 2025 11:56:50 -0500
Subject: [PATCH v4 4/5] iommu/arm-smmu-qcom: Make set_stall work when the
 device is on
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-msm-gpu-fault-fixes-next-v4-4-be14be37f4c3@gmail.com>
References: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
In-Reply-To: <20250304-msm-gpu-fault-fixes-next-v4-0-be14be37f4c3@gmail.com>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org, 
 Connor Abbott <cwabbott0@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741107439; l=2106;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=Me/D1+KhPPoLdXUQArYzWEOMKf4DNFEbfunwhGA1eSQ=;
 b=DcKFFyeJYU3dr7n7hyZuWkoVwCLwEf5oGUfH1stJNBPTrVCxsAWbmfPuZC7lLD7dJuFdZgFWN
 OMJ3w0DnCjKD1p7njjA8uCVBeD9sfqthO9aIDeLec9/kH02MUzU55kr
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

Up until now we have only called the set_stall callback during
initialization when the device is off. But we will soon start calling it
to temporarily disable stall-on-fault when the device is on, so handle
that by checking if the device is on and writing SCTLR.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index a428e53add08d451fb2152e3ab80e0fba936e214..d34a0d917013bb3d5a24b3ce72f48e3b38474da2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -77,12 +77,36 @@ static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
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
 
 static void qcom_adreno_smmu_resume_translation(const void *cookie, bool terminate)

-- 
2.47.1

