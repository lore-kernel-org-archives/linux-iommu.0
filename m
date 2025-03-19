Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDE31E25ED
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395454; cv=none; b=JFvYGZiilyY1lzWCEPe/6UbiV7RWFkU5tMFGDusYwHaBnuf98H+prBTb2Qcus4OeQWZyReTSsPNn07sVV6qzd9wydJL5I7pD3lelG/b6cQroXOdMvwoJZt3e6Q3W/B31fP2UUShsDRNDUh4ghetv1/8UD3Um+4zako0M2sanGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395454; c=relaxed/simple;
	bh=dyr7GkrtgLsig+n5TUngdYzO6eV3oK7bTiLJtUDHAnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bdJkZk3+I0nq097Zb8OqpB1OoZ6hNlYYMxSslpPYvF3Ih9p5j8vAfDTt85BDZcdtgXFexJGNXMRlHcUv4Z1Op8DLz5OWxEnVO5y0P3bfrDkz6LDxy5ijSgGiLtbb+TNk3U0v5PxWYm5V9J62VabTQmRkfaM/MZePfRMoc0DYB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHdIJfdf; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHdIJfdf"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c553948a30so20391485a.2
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 07:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742395452; x=1743000252; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPN0fQB0H/8KK70kj8NlZTzNxC/Qn5H/Tut0vpbeXbg=;
        b=YHdIJfdfO5R8jOly0jbA/20WQ+A6dJstpRHLJwMCK1cs2V/QxVKXpIEMR/yUpsA56u
         pOnMVPGl1xdIYU2DiEUYo32/GmL0LSjJXDBjkTr/NppI4JqphvoU+eagWyPnu7niEuTM
         dhtYbHLqKi2+Hknee8C56Fe8SFl+ET3ppWNmY2xaDkqVhRS2eIot2tL2VAjGwu0qZWLq
         Shpxf8KqMOWMJHiWMy25HE1DEjwQy+OAbedylpm/OVnGV8ypj6jMpimgmhPaqn/488qT
         O4+ukdiPfFqQ40tCjmH1uE0N4JtaTdI6VDhHQaxpnru+7VQv7AeydxSy8HsjrqR1DVcM
         X59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395452; x=1743000252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPN0fQB0H/8KK70kj8NlZTzNxC/Qn5H/Tut0vpbeXbg=;
        b=gtGp5ZMG1yB8eY0LCW3fRrUiD9sxiICipOeTbDtBoH1IPhgw8o539Tzjim4t4culQn
         zjSrr4LPPUDcNzYWE1Oqksoo3hAR0jm/Qki5OVvE1W/qXsKXJiyc0dd+wi3PMt7QYQbD
         u/3qsjrDCQppe/cRmyeYJo8iJE0scEjA/N1ZhhBdbcMijSaDFv1VlVGg9cwuYSee110p
         tLue+TQZlf0dIQDe9d7s1X8O+ohQrBpcIAl1HNjmw3QreUVziJ3FpCw86fgH7vgKAPU/
         dYIReg8F7HwXQ3IdCPYOOeD+9jeLEFKXDmUmmFVcHVWwQ0nkAI+ekQKio8dGj/p2WBRg
         H3+A==
X-Gm-Message-State: AOJu0YwdgqjgSOwoKKiReyhqiG8l1S9TPzh7ZeMhcYedS1LsKsdiGdwj
	je+G+ZLVGXWIrjTpH3hSHQcHraJwZN1+VgMDmfk+ThE5LwANw1De
X-Gm-Gg: ASbGncu0fzCewDkqGU7kOPHoVm4CMhGU8yR4xiaHGNkdKkV5Kk0NYrgc29los4w+Sjs
	h2whPDACcTx2h+Gl8SuwIbmbSocge6dHT4JYBKl2UKS5ZDj9CBnupufynFSvvCMBC/0EF66LjyO
	VeE1wcAkA4uQ0RyPSiQuDI+exw4UzRxEI6Gcr0u6UOjEU4mLsb3+wMlB9WF+9K5HkMhOj2Q4QDv
	iNaHn7ZXYf9Ir2Nrq7PuPsP23dB4qFUxI3Cy5T6MvsREUz1SBIdwhsr8/U2m4t7m4xPxMrWk4cH
	9IE1th1yMgvbuD3kMzlIDdhHBf7cZy254aWMrtEMIcPOcOxaaBHWJkNyQLK+bToVhOxESSGKJTx
	oM2k=
X-Google-Smtp-Source: AGHT+IEpDQ6Iq7EL34BOyUpZMWjHvcPvh/lkrIFcpZHlUwWtyFmoiBx6pZ8T713YT9KI50QLqxMdOA==
X-Received: by 2002:a05:620a:25cb:b0:7c3:e399:3289 with SMTP id af79cd13be357-7c5a83d609amr122312985a.4.1742395451490;
        Wed, 19 Mar 2025 07:44:11 -0700 (PDT)
Received: from [192.168.1.99] (ool-4355b0da.dyn.optonline.net. [67.85.176.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c5201fsm868587485a.23.2025.03.19.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:44:11 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Wed, 19 Mar 2025 10:44:03 -0400
Subject: [PATCH v5 4/5] iommu/arm-smmu-qcom: Make set_stall work when the
 device is on
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-msm-gpu-fault-fixes-next-v5-4-97561209dd8c@gmail.com>
References: <20250319-msm-gpu-fault-fixes-next-v5-0-97561209dd8c@gmail.com>
In-Reply-To: <20250319-msm-gpu-fault-fixes-next-v5-0-97561209dd8c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742395446; l=2356;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=dyr7GkrtgLsig+n5TUngdYzO6eV3oK7bTiLJtUDHAnM=;
 b=RKN5nvvDGIxbm5UBumrBYsNQjDxpkr0KCnP1Iaw92xOCRP/yvUGsivMyDJOaRMEhdhlM/3hlS
 Gw3WyY2nTiICpPLJZ1sNNIRZU6cstKEpnuXrASFBZYibV9DoVEO/0gX
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
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index a428e53add08d451fb2152e3ab80e0fba936e214..f6bb405573be0ed480a2587a5a780dd711b8d2aa 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -77,12 +77,39 @@ static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
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
 
 static void qcom_adreno_smmu_resume_translation(const void *cookie, bool terminate)

-- 
2.47.1

