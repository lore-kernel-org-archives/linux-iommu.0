Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167BD27AC30
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768145; cv=none; b=ortyFW2ODDXM9t8lo8P1Y9DmqenuShmmi0v/SIPM5myB2cACBNzjZwwWwy3XcjvP8f7I8r7XnuqN4YOJJYLgBZMf4fOmDZH8cqbO7I1me6hyaaaEDM10xAXYMDw65EwmhrVfpGnIcneBpJ9o9VIb3vAj1yuGVWHslGubH7vGHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768145; c=relaxed/simple;
	bh=RnNUWR8apEx6WPWRc8HjEOtdMZqQUWqHrofPXnVy62Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MWd99MrBsqDlJA/x6Ve12BzfW50fI1w+0nKKEi2K3K9oi02hYqsZYFyU4JvW+q8lBjh+PZksLSCJSKiU5b6JyZG3ovi5xArAO3uq4YLicVyc6mDSxDv9P6n4p6ms2UxyQ1R5tOIBEuRiRF0xXv0zI9ExbRQPpJ/YSQkTRCBb5us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdtUVZ8N; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdtUVZ8N"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f8af95ce87so8988296d6.3
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 12:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747768143; x=1748372943; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlMnByBJdLmm3G9/G0GQ/d4DyVfZJhKLZ7MqYnU+doc=;
        b=GdtUVZ8N49yUifKjfVD/oMx2rRkBNBhhm1cxnFDc8xwf+eLqTlXfIKacgDdg7rLDfj
         83+zppXxtb1oEBD8LllLD+qImu482oZSGJo6yKF2qGiJpGY1CYV38y/nnHxvA0hy/n88
         f7ZSLmEuYTRJ/a3PDOlqdwvgmsLZinp1Sg2pk0VLtXUGVuvaXIbpo1+DswxsOOspNF+z
         796K/wlSN3vVLB3xh5u+ChXaK7NP+FMbldNZWJkAoO7/XfeEjZzArCUjgTAotqFHIINN
         c1rPClxvB6t6twcJ6TI8VYxcDv3R4j6rPvuqLbAAyAyIxzfXHdp0HekySpf2Wp9Na5Bg
         5LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747768143; x=1748372943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlMnByBJdLmm3G9/G0GQ/d4DyVfZJhKLZ7MqYnU+doc=;
        b=sq+ryjmoD3zZazmBYkpCTjZcdcxat9GCts2vmCU1FlVPJq12OUkGiC3loRFs3823H5
         hTTHC31bqTuksdk6ydhnZGXzZRhtjcGPEquSAbpdynFVW8pEu4qTIIUcynLypO224vLb
         EV65xKze1CafBEMsuYaK+477JIYllgrNd87yD5/cSaDUNdfvUQc2fclPKUhmaR1mxv8E
         di58hCCR7L3cihUIO9+5evQ38Pey94pshg/CZjAKLXjCvNqeeZ56LhNNY/+Fjf2KWbqz
         lke6pg/E+caYbPlx5SFSeVQP5ETXbWIb6+ZbaipTKu7Dsa4aAa7BkYI3tYSvFWkCRe2v
         VgYQ==
X-Gm-Message-State: AOJu0YyrRIlUZJp78N+yECGI9/2WbEZfUF7/iP2kkEFgYj315zV9zz5U
	oEmGsEY4ATtOCeUnD8xAnoDLD5m1MqDEX58fRrQlDuWxtbegztdtykBx
X-Gm-Gg: ASbGnctTbMGHOvvPiDbRi2RY2oVp+iZ5cv/hHeZ/mo7Z65KzMtg7o/W+3DXsyWU62g9
	gH+JwnWF80cL+QYYbHkVk7WL+H758xmq0DtceLlvmyfDiCiq+ZlRrdN1Dsj+6v50vIICt63MkxF
	MuNM4E8pXKPVywhpuBeMgzWPmUG9IMzUfxI59Zz1eBNoeguzraHRWUJUT+mLm0/FgdJW+nCs8VQ
	Iap87/aZ58oZ/n2evST8XSgAAUvFi7oyAfYdJUP0S+Mriy/WYvyyyR0eZM1HsHK6JE92VD5gdGy
	YNpyaf+1IfNIajn9EdXA5m6HSieLf1s2kdXBtmDW8vVl/2aqH/et/j66KvdO8rt2dPFGYx/wGHr
	WdQE7AgRvWnJBoyb2HdU=
X-Google-Smtp-Source: AGHT+IGIrgJ2dmANNY3EjX9kZvxGmi8VdnrE3uOp5o3gsUKwQp+d16sgiHehsoeADCEn10ddqVWxMg==
X-Received: by 2002:a05:622a:587:b0:48b:6eeb:f98e with SMTP id d75a77b69052e-494ae330988mr104811741cf.2.1747768142906;
        Tue, 20 May 2025 12:09:02 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae445b99sm76554051cf.48.2025.05.20.12.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:09:02 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 20 May 2025 15:08:56 -0400
Subject: [PATCH v8 3/7] iommu/arm-smmu-qcom: Make set_stall work when the
 device is on
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-msm-gpu-fault-fixes-next-v8-3-fce6ee218787@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747768138; l=3453;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=RnNUWR8apEx6WPWRc8HjEOtdMZqQUWqHrofPXnVy62Q=;
 b=Gva2s5Z7Ds/ygUrvduDeZ/TWE6RzxCRXnJg0Zhx6Z4wRmr7VRKNIHU/2xJaO+oPPC4dZhG1Tb
 GdN7Dm+NI2yANHk93Y3MujPoXjVnGL92q+a8IWtX3FmhfkHr+wCKih3
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
index c84730d33a30c013a37e603d10319fb83203eaa5..f7430c131c21f40308df36fe25fe75d31558c817 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -112,12 +112,39 @@ static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
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
 
 static void qcom_adreno_smmu_set_prr_bit(const void *cookie, bool set)
diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index abec23c7744f49bea70f3352da9385304ed3702e..d83c9175828f792f1f43bcc8056102a43d822c96 100644
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
  * @set_prr_bit:   [optional] Configure the GPU's Partially Resident

-- 
2.47.1

