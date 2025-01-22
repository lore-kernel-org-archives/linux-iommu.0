Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25FB1607AC
	for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576073; cv=none; b=Cek8umxVKJSlb98Brn8oP6DJaH3DD6UYJvUg6dMkEp6BA2vkvgvBjK1yF3SSE83lRwYVOaGuEEFOW71o04jifK7tz5bjuX1stNzzTt7vBqs2PTrUpOe68ogJqZ7sT4DfZ5rmhhqz/Q7kC3lXgC/VYKH0uI/2LhFl+YLam9mkrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576073; c=relaxed/simple;
	bh=4obbXrvjN1YYsEVfq8apmOVUt5dXPe6TwBqzW1FSgs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sseTBk2cF8cuSZC/NEVxzMlaSooO2juvf784pUqL0XyHVsbu9SiWrvXd6/2EjKQ+HTr8BGcwad0bXXBA+vBWWfcQy7b8Iq71cNiAdHtpxZn8dnNchjLQi/OcTzJN8D3V8qIFnz+8g7nSA75nWx1GQfBdeF3FUrgwn3UeQ4T1WPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAFIA6GW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAFIA6GW"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b858357124so1338485a.1
        for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 12:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737576070; x=1738180870; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=clItPhIQuRHdt/X/5Yn3hkPoRrPZ3x4kk0mvqKl7Y8o=;
        b=DAFIA6GWp0sPmIqEerzsDC5yN+ywzM996XOdOePp1qKjfV9dlSEFpHK5IsgIZ+GTay
         gANyvMoGuaVdpxrVG4EtbXHYaeK94tJe3dC3Ghey9fEcClqPyb/cYJ+n8gfYKzintRIB
         8AQzUt/ADZYQLY77fMA7JX/rOKJ/4evrIifwuF3oWo6ZSFcElDXnDGedYptLPhjTcq3n
         f1AwBLXu+1+mziFVfhpuXmZ/F/GMTCJ34iorgF+NHw7lnJ1AMxoKbt3NzcCaTEHkNxZC
         7Bs3UBEhpe753qCJUo77becbvIUMKZfft8Rx+LLXzbyNJ8rwPyTrX3Xf1zubIFnzuEGk
         4RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737576070; x=1738180870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clItPhIQuRHdt/X/5Yn3hkPoRrPZ3x4kk0mvqKl7Y8o=;
        b=nynmZzlPL1cBGfhEAbF6iDH46SGk/ovaasEloE64w+XwdzEij072MVoaYzBn5AH0kH
         YlOlzOcRu3/C56c03sQxQoW6BAAdS7UgmTLHRnfKjJbrh83P26gm0L8k1WaaY24w4PzA
         NWZcnD9eppTXGbkrn1iUt1GQR3guPZt3nJQH35EsyBQLvrUe8GVS9yvz2qJbLdvKBEMZ
         roo/j93Q91jS3vQJEk6ZkHS6D3xAduo80co2wdYuhTsvPmdgIoOpMfWEQcx9hXHy/pLF
         Rx0bMk9uR/J/30SOX5bCHWwwGi83ZB6PmBEHPhxZuOztEP3z4guok9XhhfK+Ub/9zqMb
         udrw==
X-Gm-Message-State: AOJu0YxoIP9CuR56u5SIp1gGSdFNGOdgE7UqtBsT43TZddbFxS2ZtWJ3
	WfoSoDgsAhRlvImCEIgMBnKsF7inA+YFsxlXcycdFgRfnjdh5n6G
X-Gm-Gg: ASbGnctKxl0nqe1W0LUiwoQ4XDbWkpvVbhkX5A3tRuKmzjXbnxVsUo1Ef7YnGAfJjmN
	UBkCrOtjG0jiwiN6Cjox7wg0Lfz8plrq1f1pGdsGh0NA5lpqFmZKy86z0Ct+YQ2KICyV7/dcg/o
	CTYzrAWezW+JFmdr7syMYf+HgKIjP7VRSXWw1ArY+sDcsXYEsrFjDj2NEhOrjR11dKjYBxlhzqB
	SXJUudb2n9xC0nykFd3wP1KiYvFyDMpwZhJCsNUch/GCaXTJaRTWld7XK0j0vScUxr7L32TYTyB
	68npb+s/0ufdxP9dgsMpK4KKymbe
X-Google-Smtp-Source: AGHT+IFbsQgN+OYWoJ8tGUrhqTk3b6gEBJi7yaE4oLpHOAjzYS5P1remXjUXmLoR8liW70biIpVbJQ==
X-Received: by 2002:a05:620a:1911:b0:7be:3cf2:5b46 with SMTP id af79cd13be357-7be6320bc70mr1391147185a.8.1737576070653;
        Wed, 22 Jan 2025 12:01:10 -0800 (PST)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be6147e30asm694606385a.31.2025.01.22.12.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 12:01:10 -0800 (PST)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Wed, 22 Jan 2025 15:00:59 -0500
Subject: [PATCH v3 2/3] iommu/arm-smmu-qcom: Make set_stall work when the
 device is on
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-msm-gpu-fault-fixes-next-v3-2-0afa00158521@gmail.com>
References: <20250122-msm-gpu-fault-fixes-next-v3-0-0afa00158521@gmail.com>
In-Reply-To: <20250122-msm-gpu-fault-fixes-next-v3-0-0afa00158521@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737576067; l=2108;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=4obbXrvjN1YYsEVfq8apmOVUt5dXPe6TwBqzW1FSgs0=;
 b=UtLt9Gxw8iQpbRsxeRyHyMb7Pm7ArBDOREehdF+WX9yPMugQJ3Icy/92gYrtsug8VrkLc1is8
 CiXL67DhVUCAGFOPZCD8bglUB3zCsRgXLnoLC4DgfCG1QTviaTVY5MT
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
index 7d86e9972094eb4d304b24259f4ed9a4820cabc7..6693d8f8e3ae4e970ca9d7f549321ab4f59e8b32 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -112,12 +112,36 @@ static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
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

