Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24A3CAE73
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920067; cv=none; b=qROhFtp1eXUe30Mppldmqt51ajXOuukEcCPU1+qRtTceFtV5+D6Wv2gl7hsCoaGCHa/iCph5+vcyAV7uRoazWel9NtDfmIwyKY5QDJGSatbdhI4YpXf3YQ3+WeAsYy2BD+K+60Co01s+yC4CoUUnb6LwageWTvMAcHSL7wxV8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920067; c=relaxed/simple;
	bh=tqzlfY2gP+OfsrwO4tJNez/zWqdmcR++WYjib0DuV0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eOm7GleCqDZuCqMKCz0Bx8ChPYhULHJ1W2BEodUs9ZdstD32L+iQjaLcEyuozlCC+NX4ORPAxyHzd+2I/hZhpdv8Louf4LG56oRQ1zNkX74DOroQNDGuEEWqXjkbkGDlkhIEZuUHB6swmnwDOqIfoPeg1zG2Q6+e2p6PxqJB98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NpX55NzH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NpX55NzH"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3662990c03fso9530660a91.0
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 15:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920064; x=1780524864; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DsoenszedeSjTu5gG8Ot5kkuypT3biJ+H2calxCYQ+I=;
        b=NpX55NzHFyuwlnP3UVGnGzdWpORcq+y1C/au03r7T3gXbHsfOOHwKo+WbqBfRkawoj
         VoplZ+/Q1XdALbFak4m+fIcYGz+KvFNIs0rKLwjG3ZK05u9jaEsXX/BtJgxtt/EhARGL
         GolLidfyhctPp2VyEjvQZbbCmGutf9TVEfA88hDEWcMx9JkSxqnsv98Ae40HeHvc9bby
         CeYLjWbCwQxKewEdX0sTgbQMGEDTg3YGHTLj+30Fp99ggw2jOpshQmTzBaJCh/AP8UoR
         NefAERO/FxeSwFph0oABLMp90pWK19OuJxxzkW1G1RnivM4fWQAtpWIUnoTKl42emuYH
         eYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920064; x=1780524864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DsoenszedeSjTu5gG8Ot5kkuypT3biJ+H2calxCYQ+I=;
        b=AY5+6/oPTTQmyRHpGz9X3XqX/YP4qV11E/L4UWpcx0HGk8CVLO8S3XcOVZhCoKn1sL
         HFSteQ66D4lciDQ4hiXtzdvBcmR7RkI0WsgU4hdQztKOfeXEQixxpwOSJUV4mdI2gnhz
         3o49mnlSe/2NqKlo2k0jVFuko2Vx3jWTRqpluUXEM234sp8168nCzqG6L2E3wwo6Nbqs
         rwMXlVFwONZErKq0UssLakmlN+hTjzgv9WKqvI96Pra8tD/9szOMV7PaH4lJ6fY8mJ3O
         woCL2n2IYemxiGyl0bAQn5/lIRb3BMdBOHKm3MN98i/uR2dwGuQbK5SU6J5h8WeJXpaA
         mP+w==
X-Gm-Message-State: AOJu0YzPc4qJ2e357IYJfv9x9CUz8TOaWOoutTzm1wfwTScHoV4ln4OW
	fvrvouO2SpxqK55QQvhDtb+E1X5/4IsCMCNXK7ctWaUFm3l7C+EFVuzOrlDyAmWsExhATdFO1AL
	q+zIW5pDYO2L+YdLB8G2ezvo34t7Ga+5fzPyYcFpFMX70YjUvK6WCvunzW8zzAjYBdPdCM3Nou+
	Vn3Z1rmuFA2JXb/+iRz8uCn4bsD8UTvQ==
X-Received: from plda12.prod.google.com ([2002:a17:902:ee8c:b0:2bd:4b8c:fd31])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f709:b0:2bc:dca9:f0ed
 with SMTP id d9443c01a7336-2beb087b062mr204197725ad.15.1779920064134; Wed, 27
 May 2026 15:14:24 -0700 (PDT)
Date: Wed, 27 May 2026 22:14:01 +0000
In-Reply-To: <20260527221407.1756491-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260527221407.1756491-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527221407.1756491-6-praan@google.com>
Subject: [PATCH v7 05/11] iommu/arm-smmu-v3: Cache and restore MSI config
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
2.54.0.794.g4f17f83d09-goog

