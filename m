Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB02750FD
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763106; cv=none; b=Jgyl/SGQl44SZ043ZDkjFI5Uz0r1C5oV7BQoseSh9ecidl41soTfGo2ESbamj9eRvBvth6jtP88NzOBPEf9qCkueGMBMOTXm1b/v0WOIUXxYmU5TggUL5SWMM907tbEx/hLmw+/xoogDeWNLyLgfDQwitE7d4/aRjgrb6irmf/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763106; c=relaxed/simple;
	bh=RnNUWR8apEx6WPWRc8HjEOtdMZqQUWqHrofPXnVy62Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tVDSIIB9SRs4I0dRKLJaLYwHl6KvpmS2nWdjma132TC1EXM9jjkwYE0gWTHoOIGGL31buftwXUmo/opJ/jY9I54oqsctdiZKT65upZpRvUzkZVN2nwyRnzHfaLI3Cug4F79QxOvUSSMxbMQy7O4RIB2OEiF5OdzXt2aO7imjqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwqIXk8N; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwqIXk8N"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f2b58f0d09so8731806d6.3
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 10:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747763103; x=1748367903; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlMnByBJdLmm3G9/G0GQ/d4DyVfZJhKLZ7MqYnU+doc=;
        b=kwqIXk8NUGic8J+kSarbJvewfg/4ahRlA5BCszYot/32G+p9PBYpBcyoV4vfOb+3uc
         ZrT60/cAWt34x9oGuYBF7pg+3mb9wOFyuNreghlY8ciHcy5o+K/9MoDzTzPlMKHu6rn7
         fdWOou9tpfDOcGTE/L18I4ZcGq4mhSp/UCUJLC8joS+ZXLqfAY22j968EEuCwj1VF8mr
         HEnc279q63MIkpAoRwchH0UHS95dKyS/az8Jvumms+7ri0YjvhiEO3NeZ3FFJYhFEC+5
         /+KKjMWOoFldkSDTUrmrH50lw1/cwoesB9yb5tl2hTaQ0XCDk5xeQruXtGgbZLxMH/ze
         HSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747763103; x=1748367903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlMnByBJdLmm3G9/G0GQ/d4DyVfZJhKLZ7MqYnU+doc=;
        b=a26i8E7ik+Nvi96GXGFNKD5Lcm48Ynio0oo3IRdGqg7KPMJ/BldajoF5DjpmlaPHOg
         54Ms53CjboPZjPuo8T+Y4gXwpOoPOLOgSNYlXcEk8a9kGeZ0QBnZsjvVQrloh0jqBFO1
         VLPwxUC1S3vyKU9zeRHWZUm+P6O7jtjQuWED7RA/rAGzbXmgsZRGnsY29ratDNlhXC2i
         i4Mm94/RLpylQWEj82xjgkBw/rABobhjBch3sOiZ/Pg1GX8RtMLRANO5iHWSIJp0eisP
         YKgJK19EV//7IRI5MGK74GOAGT6/pg2oo36iNmdrV63EdfKTL3zvjRPTiiwz/KbaahEY
         KMlg==
X-Gm-Message-State: AOJu0YyvmnW3BwE/J87EfBt0HKHFMuaxKFVLgKZE/+WOCDrFieoLCBsu
	RVDV4TVJpxTFQoIY2gOh9jzWFRNJaMgAzYSivJx0nt+yKzHTuxWk07tsC+ou9Mne
X-Gm-Gg: ASbGncsXl0i+iPxcMX5AIjtOltHyXTfu2WQ832DijMkP89Jmrp+a0GQK/st5Bjx5tlV
	9EsFn+/9jtWcapzq7XGMC2mNachB7wHaMIfRbBipdyaw+pekSmQNwlIZl7+cQBAqlZKQXqR6lww
	dZMaBuzfAzwM9oMhB8XMeqPikJ7vXumxoZMKFeaXFsE//8frf7xxN1E6nW5dHeGFUHRwd04r4zG
	qBt1MzMPBzT8ogKwwifARS9MhAGMtQEv2OGoPLvJ9zwFTQM9GltWPCzAV6iVEATOGjEX2Lqqj6t
	+8oiTvkTJP7BGGluDtfeX3jsXottV9eb5hNy2m21v2i43Ocq0/hcL2UVslxl9x/cxgCWBmAhC0n
	QeVFoOXel4aJpdejv0DDmNnwY+GKKxQ==
X-Google-Smtp-Source: AGHT+IE97Zxos5az8cXO2o92+oaDSt/gpfACDdIypt80WhX1ZCXMDiAGP2cn+7N7wTHFzmRR7CT4jg==
X-Received: by 2002:ad4:5f8e:0:b0:6f2:b095:a79b with SMTP id 6a1803df08f44-6f8b0847d1cmr100255236d6.3.1747763103301;
        Tue, 20 May 2025 10:45:03 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b096ddb4sm74126586d6.78.2025.05.20.10.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:45:02 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 20 May 2025 13:44:52 -0400
Subject: [PATCH v7 3/7] iommu/arm-smmu-qcom: Make set_stall work when the
 device is on
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-msm-gpu-fault-fixes-next-v7-3-96cd1cc9ae05@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747763098; l=3453;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=RnNUWR8apEx6WPWRc8HjEOtdMZqQUWqHrofPXnVy62Q=;
 b=tD3WtT4vxh3vXzx33GeuNyl5hmvn+QJsiqPwD8bbM2tFraZ2f8cV83+Pw3p37JhvR3WUGpJVu
 Jc3NWPlszKkCay4kWpB4ilL1RekYJZqNSrPXTsclNz4Cevm67LPekiu
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

