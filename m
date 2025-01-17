Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15EA1A9B2A
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139665; cv=none; b=UHyc8iMbmnI8k3Lg19SXbaQ1JGZvKpeK36WIzyt1mgqYCjyUH4BNJQf3Oyl8Ak4Q8r+9/kBmTL7gSOEcgiQ9/gTyoql7zbMmdibXqKdEDbDPCByaBf76Par+GttNAS8/U+hc2tRZgGtD6zzK10cnMbTld5hnIftwZZrKbS6FvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139665; c=relaxed/simple;
	bh=JyOLVh0gEkcPnnA/qjt0Kfj3pqe9UFDopPZk8F1e/x0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KeJWtp2mRQ+CpsGVqXH65js/oqs6zsRgRwrS1YCW9tl2ASRcsbjjuXF+Om3NMmPktNvH252NMzRA2Nx5H0ZDu+CnpzyRnMzLB3ID/q55JJt0+3QOvnIx2Qpe14NGJNPOp/+Ksll8vACJsUC2qLCvYX9I7UsFrmy2gqp73dtCzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf1U1iJ1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf1U1iJ1"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d89b21bc27so3184026d6.1
        for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 10:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737139661; x=1737744461; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7cXS8jZh32k3xn1O/NOhZ8hhmDw8Y92QQ/WTT5FTNxU=;
        b=gf1U1iJ1jagq0/bc36x/vRxgII8yytqJbNw0d9gHXzpzGdAavkrdEhZ4cD7fHeQNnU
         53GL83LMe3PHJ4yVIYX40vtJHitZSD2B1Svxi30DKlii2T3TTL4I5GwgA2oHG5yQBoen
         xvLRfyfbtA00o9Pt497WsG3Ka9/JVqnsQIE+GoYeahpfhrMcwx4aZoUpN1Gyn83RLjYW
         LBf/eXSyzVmz7xQOKEhKkvtEZCkM55RpPFueiNtpjHrnD12O3zjfzXWGLEyDqzgtiMk6
         2FOTFcHfCt7oT3pZMtCaxLD+piK2OfPM6J9lsUioA8h1C09Z4Cm2f8pcgy+SuPOquOeY
         t/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737139661; x=1737744461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cXS8jZh32k3xn1O/NOhZ8hhmDw8Y92QQ/WTT5FTNxU=;
        b=DVYe0spd/fhDFWSc8R8npjsxfVMsb+8S0vjaoEMzidAfhPCDhyQNNH+OMShKprMxwa
         5Q0tON90/7eCUNbR1BwYZnRlEmrnLK6i6tWG1E/bZtXHOt9tG575G9q08fuMX6VG6ii9
         vsPgssfcGmKYSoACYE5cV1hB7Be0mhZarAeAUE+vJChFBTfAqhX//jtpi1YgTUD1K1ES
         rqkD5/xJ51TFt2/Pbr86HtLwY+ZNnZx9CsD+IofM17ia1iNkP4fA4UdctvcNo/jdIfNN
         WflTC1k1QgYveRodZ7XLgZTZct4G1cxeSteRJISmL6Qh1eN1LkZk1NpV8akcHruhUV/m
         VLmA==
X-Gm-Message-State: AOJu0YxmwPsv9xajdCvXOrIrXY7iHCDeSLocyBvUmKRDNyL9ZFbQG4n3
	HFdF1bVHMEuWQtRiPrtpUKoazkaWWdqVA4K14JJ5PeI+UigFaPAg
X-Gm-Gg: ASbGncuXUfY12LbnV1JBbAHBeUgWeG8rHL/TEmXzdTyLKxzXjnfCn8TfPpQqJ6V3NyB
	dUIinFvDNCNkw27jgV/94WRFzPCfbhs+NSGu9QhHAfV/K8C6c/4OtHj/PKQeEXDZG/Qyhp2fHkw
	fohaSRaFfxNQg5AMvuRq3XKilsK/AI3IhB0pnieTGb+Fxcd1wsVEeezjcX1CQvs1ze9mleuWtul
	ES8BRAqAc4P8+PNqdsV6jo0bf7bcpLvnTppZsZeZ0O9t6ZV/auEKns6TSRqr1IWDJqKQqtJ5zgF
	q4V3GPRqFr0b5a8=
X-Google-Smtp-Source: AGHT+IFkED0JQTC0Xpd5G1Q8mAnhBtwFYNMO1jthK556QYFx0lYcOPWbJ2YYI/wogCp8QUtnRASS4Q==
X-Received: by 2002:a05:6214:528b:b0:6d8:7d84:a514 with SMTP id 6a1803df08f44-6e1b2175b9dmr23314216d6.5.1737139659256;
        Fri, 17 Jan 2025 10:47:39 -0800 (PST)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcd3859sm13992176d6.74.2025.01.17.10.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 10:47:38 -0800 (PST)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Fri, 17 Jan 2025 13:47:08 -0500
Subject: [PATCH 2/3] iommu/arm-smmu-qcom: Make set_stall work when the
 device is on
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-msm-gpu-fault-fixes-next-v1-2-bc9b332b5d0b@gmail.com>
References: <20250117-msm-gpu-fault-fixes-next-v1-0-bc9b332b5d0b@gmail.com>
In-Reply-To: <20250117-msm-gpu-fault-fixes-next-v1-0-bc9b332b5d0b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737139656; l=2114;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=JyOLVh0gEkcPnnA/qjt0Kfj3pqe9UFDopPZk8F1e/x0=;
 b=Z8mukskVxG/5911ObuOE8aZjxBMyoMMxQL49HUEn1UzKTTkKUCl1YqM1Kdm1q24jL47h7A9xL
 sQTHHPy79i0CWIRIUNZjb06P1taEZ4QbjZs13mX8cjDTJoodH+OmmrC
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

Up until now we have only called the set_stall callback during
initialization when the device is off. But we will soon start calling it
to temporarily disable stall-on-fault when the device is on, so handle
that by checking if the device is on and writing SCTLR.

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 31 +++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index ee2fdf7e79a6d04bc2700e454253c96b573c5569..54be27f7b49d78b7542fd714d6aade2b23c65fc0 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -112,12 +112,37 @@ static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
 {
 	struct arm_smmu_domain *smmu_domain = (void *)cookie;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu_domain->smmu);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	u32 mask = BIT(cfg->cbndx);
+	bool stall_changed = !!(qsmmu->stall_enabled & mask) != enabled;
 
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
+		u32 reg = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR);
+
+		if (enabled)
+			reg |= ARM_SMMU_SCTLR_CFCFG;
+		else
+			reg &= ~ARM_SMMU_SCTLR_CFCFG;
+
+		arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_SCTLR, reg);
+
+		/*
+		 * If doing this in the context fault handler, make sure the
+		 * update lands before we acknowledge the fault.
+		 */
+		wmb();
+
+		pm_runtime_put_autosuspend(smmu->dev);
+	}
 }
 
 static void qcom_adreno_smmu_resume_translation(const void *cookie, bool terminate)

-- 
2.47.1

