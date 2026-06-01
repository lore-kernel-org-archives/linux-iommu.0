Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543136AB5A
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351165; cv=none; b=oeI67wNRMf91jmQmm8XfrXwoq74os+mGDFxo62vPiyKvdCOYtO8VEUr8iOlN2Tk1mPRNeepkkOoeWazSeIPMH7h1YjCiwps50VZtgL8c8ukuoHVK+1rDIx2xp1pHaWWinLfxdAnNrDckEt+FX0tL3QxTdiBlprcCAt9Cdf7+PLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351165; c=relaxed/simple;
	bh=CmAndAezwJtSHEONNjggGPWTXGddlw75ap2/uAABAhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j/s+DDiq3EegMyoZygvDFIbjUAWUlhdwOvM7F+BKS6zx8k3RfaM9Ss9iuvZYn5bI4xQY1YN+GPt7LODLoT1Uvn3CZFB6vuxMUSsayNOCam3jMSXAKUT9jCGlQGHDNromWDlIcxOVh//F8Ebz/CItUSA9tuKddIbIpkV9cu+1AzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p45d+eYA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p45d+eYA"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2cde332so942324a12.3
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 14:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351163; x=1780955963; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rcpp3JbrlJR2Sgfo7gqP6/7JvCiYyDzydlgBu8YMP0M=;
        b=p45d+eYADrkehVpFiznHYdLz3Ks1fOjLLWTvwo2UEPevIb91TaqjkNc5AMyOBkvK3C
         gc4djlDzjm994L4RmuHRe0NtW8TjoEv+Uf316xqy7VVzW53LjraC8WpmkoRMGNnG74ja
         qCqdEDhbbaQhVl7w1U8s6sgHONRoiLiAHj43Xk2+jmjYzxl6CkoMiQrAJtHa90pjfQRh
         hSDqmMeMbUgsVf/mz8KH8+swSjoDb+SYzchacS7wOfOOMydzOmXg7X1Zt8pdi1JL9SDb
         8qLaxnGyMMCasvWHghIsNXV7PJgVRtFliQ8NQ2UePEcfWlZrR3v5VmwgKb1/eFEZYryY
         rgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351163; x=1780955963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rcpp3JbrlJR2Sgfo7gqP6/7JvCiYyDzydlgBu8YMP0M=;
        b=C/AEIvnBYdT0IDn9z0rCDM3VpM0/qb3cmLQSxacFPg6hSk+pnkgP3NKWxgjvs9ajrC
         LGnIcLeFoJkdjJvVX7V+jFngp3A7+QssuAGG5pU0x3upgDZStPyM1KSn0ny8SsfXXDIl
         wqz565jqvdD4iB+Es7KjpyYWJj6cRi9+xUrVe6xQu2yfEiwltqX/7fHT+ayoNlu9o9Bq
         86c0KUqUD/a02tyqtuGsQa+aF2rwtbMQV/nSL1E0nojduyRwpc76TC8TYGzwSNCAVbXO
         0kZz8F/4SDww0VbSa0tms/vA8iPaS2S9fOiSEQndlsxp5xEdKQKUhyeqgZyCAwuAtJm4
         gZ0g==
X-Gm-Message-State: AOJu0Yw/M77Q47JXD7NHJsD0L2LNsEmbv1TTth3TPyLvq9vyGYSgvH5+
	RHiIRvbI0MF9Iaki3IfujlyhxAFjbYYe33atQFI8RuLWCDOc/9gY31HCwTJqJ39JELber+FhKrP
	3s4Hn6MCsL9VmwMSI2/OiKXb5II3UOA9uvMm+uQgKN993IEks8af741sTRe3yqktJzIa4DyrjUa
	qbBRDk4mceAE/TreUaz/TSA5nNhd2wng==
X-Received: from pgar15.prod.google.com ([2002:a05:6a02:2e8f:b0:c85:b93a:f6e0])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d83:b0:3b4:71a9:cda5
 with SMTP id adf61e73a8af0-3b471a9d336mr3295111637.48.1780351162605; Mon, 01
 Jun 2026 14:59:22 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:59:02 +0000
In-Reply-To: <20260601215909.3958732-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601215909.3958732-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601215909.3958732-6-praan@google.com>
Subject: [PATCH v8 05/12] iommu/arm-smmu-v3: Cache and restore MSI config
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The SMMU's MSI configuration registers (*_IRQ_CFGn) containing target
address, data and memory attributes lose their state when the SMMU is
powered down. We'll need to cache and restore their contents to ensure
that MSIs work after the system resumes.

To address this, cache the original `msi_msg` within the `msi_desc`
when the configuration is first written by `arm_smmu_write_msi_msg`.
This primarily includes the target address and data since the memory
attributes are fixed.

Introduce a new helper `arm_smmu_resume_msis` which will later be called
during the driver's resume callback. The helper would retrieve the
cached MSI message for each relevant interrupt (evtq, gerr, priq) via
get_cached_msi_msg & re-config the registers via arm_smmu_write_msi_msg.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8682be5060ed..93cee32f6c99 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4551,6 +4551,9 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
 
+	/* Cache the msi_msg for resume */
+	desc->msg = *msg;
+
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
 
@@ -4559,6 +4562,40 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
 }
 
+static void arm_smmu_resume_msi(struct arm_smmu_device *smmu,
+				unsigned int irq, const char *name)
+{
+	struct msi_desc *desc;
+	struct msi_msg msg;
+
+	if (!irq)
+		return;
+
+	desc = irq_get_msi_desc(irq);
+	if (!desc) {
+		dev_err(smmu->dev, "Failed to resume msi: %s", name);
+		return;
+	}
+
+	get_cached_msi_msg(irq, &msg);
+	arm_smmu_write_msi_msg(desc, &msg);
+}
+
+static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
+{
+	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
+		return;
+
+	if (!dev_get_msi_domain(smmu->dev))
+		return;
+
+	arm_smmu_resume_msi(smmu, smmu->gerr_irq, "gerror");
+	arm_smmu_resume_msi(smmu, smmu->evtq.q.irq, "evtq");
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		arm_smmu_resume_msi(smmu, smmu->priq.q.irq, "priq");
+}
+
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
 	int ret, nvec = ARM_SMMU_MAX_MSIS;
-- 
2.54.0.1013.g208068f2d8-goog

