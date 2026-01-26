Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB9330D35
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440334; cv=none; b=HuSL9TDn6Ir2QT1Xakc/zHLAeGXqzw1PnimOJzJByHk/BNIUclWkPgT01cFtKkKS0BBzIPcd4OPVudjDEbTneH8JlOZAcx45klWOKRTUC2eavI4qqomdZl7Yh7Ktr8jlZluGWcT673bYdpVRNITzrQ0k3pGEgFb5t9Pwxo3xv98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440334; c=relaxed/simple;
	bh=pn27hWKrlNa4RMewJ7h6LxWDb6sy7Db52tglsYuWiGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lmwmxN5EwqosVNlV0LyfdYC8ysgLqrRmcrRRsk2rzbdYXMce8MYJwNakMKEtczLSBqkw9ZjccJys1rhk6091tgKqiyaviY4kgHOWvbF1OFzSBOZuQAIfTcYE/iYq53UIZf1HtAIacvARC8BqnEdT21u1cuVhe++DDGeCqNfraks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NIOD3nRD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NIOD3nRD"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a755a780caso34044165ad.0
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 07:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769440333; x=1770045133; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JhKohPT6D3gFYW6K2gBRSlrf4PslOzw6zA6ZRec0/EA=;
        b=NIOD3nRDOkuC3MOGWP/7RsXpXJnMbrN8AKxGkVfxXsfatnSEmE+8LX/4V3ar+K6voX
         r44sgOuy7g6HhMIR1NEYBp4v5un/wOEIuubbhEesyxMvDaD1uMXxHF+hxl9vT4HdyhNc
         yfEjk9/4adoAdec4dYSxAP+7F+1VGjum2xJn2wMAc+cKFezVbF+y7DS2damZDcvPo7hE
         mQSALX/3OUGLRR7VMW6w87lwUA6K0LMYG2q1L9+GYqmOFouQ2trsbNJLfQLCzQvHA0jt
         HbO1ltZG1RT79VCZHmLIEsZdthJgjRMFEsKxfD4UL2lOccdNCvlQKnfMB5OiI60pkg4M
         U7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769440333; x=1770045133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JhKohPT6D3gFYW6K2gBRSlrf4PslOzw6zA6ZRec0/EA=;
        b=IjXffB3CTc+J8ylk1SFZTyCXDYPBgV/kbX2N3NzRfRHjyBkqS7+5Rj7LYuJ6B26QLj
         MwiRbNs8HbEAaPx8U4GMVuKD/+7s0sVV2ujUK4gU5DTJxUc//VwwvhYCAYd9j9e6xAiZ
         QrdtH1MO3xtlrgQs34oI+QQmpgTP8LV4tt+YUv/+cyFpUAd5Qf8126RK2aKtYSdE6BJT
         MMU40BQmASIRyM8klZEfzYrIn3oB9fWrmLQDVXSePoZOqh8clxGwksbmikqRvARFR8zG
         W+nA0k8qPHy4PWtzJayjyq5qInNPI4Z2HE6elhNdL7oPjIrDZn8JpnC6U5+7T2bpdlw4
         Bjbg==
X-Gm-Message-State: AOJu0YxaylehaFwlwlId+L1GNUXa2p9IqvkGyuBiXS6cXW7MikEO3b7r
	IHvRfGwWhsZKO2OBCifWxg3dAY5rMFGgOvFe8yE37taMS/dmcqTSOL4cqcQ1H+4NZyXHr+5JtIB
	lQwCIfc/3UtoG6sR53J9QfBY6VhcGATKe0hE40ikSR+HH8gy2SclGWA3LRASvwYqbdAn6MI1Mz8
	32pTu6CMKbizSSrYTT82YzH4AJAJLIQQ==
X-Received: from pjblx17.prod.google.com ([2002:a17:90b:4b11:b0:352:c7c9:def2])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:246:b0:2a7:a87a:423
 with SMTP id d9443c01a7336-2a845567106mr36486305ad.19.1769440332606; Mon, 26
 Jan 2026 07:12:12 -0800 (PST)
Date: Mon, 26 Jan 2026 15:11:52 +0000
In-Reply-To: <20260126151157.3418145-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126151157.3418145-6-praan@google.com>
Subject: [PATCH v5 05/10] iommu/arm-smmu-v3: Cache and restore MSI config
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
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

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d9003f5f40b6..91edcd8922a7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4047,6 +4047,9 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
 
+	/* Cache the msi_msg for resume */
+	desc->msg = *msg;
+
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
 
@@ -4055,6 +4058,40 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
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
2.52.0.457.g6b5491de43-goog

