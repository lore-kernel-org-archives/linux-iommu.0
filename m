Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA5155A5D
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272987; cv=none; b=qE4iGMUNzBSY23pEKzfGbWilzLAncfH9f2w6GMeM2HwBIPQyaTkQJQo3WbpL3/l+zubJhPIwvl2XgAmvSNFO83s7IgNVMeGW6BuprdhZUOf7SBCRd/43x2LdykQwNvNVfiscrVJURrNhi2TopI0gKwHAw0IU9rJd/a8cAYA0IO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272987; c=relaxed/simple;
	bh=6SPxGTWRQlxwnRxJyJ553Lqxtydpct0uRwY9IoEaSt0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Llc3DNGfDmt9xeO/KiZZweroyPzMWs+A5x71JKDQ/oQ/KC9M64GZZqj4ed8t8ZoRgfrUeDUWlFozBruWbyCCdGd9ItcBuzgjyvV3Ls1eT2uI5TsKya6TE3F+l10XBmQ1/DGWCOeNZwLX/moWZagaZXv5cQmHhi+Fk2MHBWGy7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lSNMJlue; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lSNMJlue"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfa4e4684bso7537085ad.2
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785272986; x=1785877786; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XsPlyt/0X4oEp+lyWoaCkrwCBr2oTFOrLePbBqMkWfc=;
        b=lSNMJlueYTBDjT+YB3+nh/4EE6OIdhweAv+TnObSMXs7vfJzS9OX/0hLKLk9wVfKqc
         F+MZ1CO0AKNcv1K3oISFTSrhMFrOTiNpigL3AsPA2+P9Mo+7Rnl8DkVbmkqG9Okzonmx
         qm7f3P7FWBISppxzzQ/uuQNZi2/eJ663Vx8/yGQw7X7L1CmdFoSGCNiD0l8reot+JljN
         zf952Fd+275RWwk3QnDYYDY2v9NrN8jaM89W05K/2TSCvosSOHP/TLXkOBGbQjnVTs2Y
         4qKDuV/RCSvNldDp8pGfTTETOCwmJDtKVOyheL54zPf/+eT/M9G9cZS4aWPca+1nst2M
         SMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272986; x=1785877786;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsPlyt/0X4oEp+lyWoaCkrwCBr2oTFOrLePbBqMkWfc=;
        b=rYsTExe4RtZv0IJzUjET5vrpqWMoX81+G7UcC6iewO1WBdsbJupWUSBUXR/T3v1fFI
         rzQh+v4j5sLHQFEtBxIHIfzKYZwev6uO0dnft6QIvNw3KcxIvHXJArHHlM9lZWcWTy1Z
         RQ8sfwctZPzXKPM9vyiITaR3tjMGz36GX1eDmF86VSHHbjiJP0/X6ygCcgepPxqKaZXJ
         3xYAfMtjX17Pn/4ZRNObaIhrhG9Xu0G3U2LXKUByjEO5gVkN5I0Ls62jT47io7Yw+59k
         Vf6xzuzQVqXmo7B8Rk+FDFIX6vqtzkUD97FFeIcFbvvCcPUi3Gc25kA2N9V6/WUwxnkE
         N4Tg==
X-Gm-Message-State: AOJu0YztbXHdioLGQBBIePC09WdtWWg77FYzvQEfSKI89O4yflw9JQP4
	yHP8OIdfaBA5gr7lAbRUd773tpD3Vuv5j6a2S7HSE3+jtU2O4PWyAO7F4nNlGv/O7Jn8essis8V
	hSCzHzfgBz1Bvp+00VvbgzNJSAK1SUmmP4vwQsonzJ366g9916nqpz4SaaYZi6rbGeAToTBO/k1
	E/K5BPIpGZ0o38WnZd95HTaEd3njDLGA==
X-Received: from plsr21.prod.google.com ([2002:a17:902:be15:b0:2ca:be81:b451])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:166e:b0:2ce:fa3a:45f7
 with SMTP id d9443c01a7336-2d015d1eb47mr42785845ad.16.1785272985765; Tue, 28
 Jul 2026 14:09:45 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:09:21 +0000
In-Reply-To: <20260728210928.1050849-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260728210928.1050849-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728210928.1050849-6-praan@google.com>
Subject: [PATCH v9 05/12] iommu/arm-smmu-v3: Cache and restore MSI config
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Pranjal Shrivastava <praan@google.com>
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
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 96ca4a024cdd..03b80ab0a59b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4710,6 +4710,9 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
 
+	/* Cache the msi_msg for resume */
+	desc->msg = *msg;
+
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
 
@@ -4718,6 +4721,40 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
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
2.55.0.487.gaf234c4eb3-goog

