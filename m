Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B403164B7
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406909; cv=none; b=jsqveR+VKf6ASpu+WU5cIctyxgwP2ZH+YXu1Igbk10kfJnKfzd1to2tfYOlHmiKhzZeY01EDLzpyUD3qtAHRH3Bvl1w8dCchPr/GUP7JLank9ZyfgrqZ8yllneWKTMRt8CtRS9LarFsPBsL/wh0gf4erTydd6qJ8dAxJw88xj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406909; c=relaxed/simple;
	bh=3rzLoUGxsLfQq8KTNdboFLk2Qt3/6lH9x/ROvCznGd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TuAxWU28+hgmJsUaHuu1UgfBdgmJzGe67QwjU1LHqzK9cxdDlVnnY7/5hwFBDchlm9WZEMQf6WSVw5ecUGn0h+FGTKuMT1bjsL/rgntlyJ+6ArF/eBeBp1mpQHT0LOcXmHAUKaTYrrQBhtPP823LKjuL1YH1iNOiJeIo4uq/rwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2MBvQa1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2MBvQa1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7ae3e3e0d06so3839904b3a.0
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 11:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763406907; x=1764011707; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w5L0Y/5kCciTNkHzSZoXZFS5vfgWO7YluWBbYI/FAcE=;
        b=X2MBvQa1uZp24MryWhgm1UFsZqUGGAi+x4mz7VGJIZETVgEB6znX1BbLJQMk3wqb4h
         e1nI/3TG4CWN0YRqYKdME1p1y/X9i7+/RVxoaVaB35VgSHidrf7pifhtBqvSHTP0KaSF
         15li+eL32PrFauiLeaxRJCP5o0Ap4DY/flurY5s48D2HjJm9IMv9/HQf17T6ZHgcaJnb
         oQZAB/15d5F4zkgyNYhXR7m3y8K6luqReJW+CzFVAoTm+z14q3JMoSNnehEXr0mktmZs
         10jq8qmtLtQ3yx4PA/+koNBqovjhy/Wh3K8YruPGOxyzZXeMWKpUJ6KZsK3az4Wb9oGP
         kHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406907; x=1764011707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5L0Y/5kCciTNkHzSZoXZFS5vfgWO7YluWBbYI/FAcE=;
        b=kYK2I4SInrjfd3R06SVtAZu7TOjNedh/qSj6VJa4U7bXu0qiZO+LVuoKOfM98IA/Tz
         qp4sapMCvFDDz8Vzr1f9PuYfT5stQNEj+w5Y4NA8gAQcVdj8BHULz51x739bG6GIxyIG
         Xrvzbdoji706l3aI59lF3pmHUPOm+KXE5beWxXxGE2jnztkPNQeUeZLDKQhxkEPSZjfK
         qXM+ec6JUC5p5Mniio05kfeSAdmLIxWFU/DiT6ydIvmsUqSc30UtibF0UOj7KG1ax1oL
         UgE7MTkY++bf9pXO/G8zF/rLkNbAj67KPJOqMyPZgDaQp7reokNk6YliBZJXXVWVmkyj
         yFAw==
X-Gm-Message-State: AOJu0YzKdvfvulKw0OAZJu9Bpc9VrXlfdKHcuUwe/TghaW4CLLzuDCKk
	NxYCuNivoKogxC1IhXTQDGLkLCrY0ig7XI/qxMRB2TkeKy4J0i5Txh+KxduLcZbZgoFGtBc3OeQ
	MrhsYg6KtKNtGdwtXP0QvgBUUnfZAe2bg7CaHWXvriF+ugrTgO6ktJJyBL/yyRJ7tMP/YfJNBh6
	SvAZDC3wwdQifgk2xb6sU6YTaeFAjZDA==
X-Google-Smtp-Source: AGHT+IGuSDUPft2q+xxa4K/ShaiyU41OLh7SwaKquGy6nIKv7WpLgU3+XAeVAiX85iC6uxwdzMsB9NX6DQ==
X-Received: from pfbg21.prod.google.com ([2002:a05:6a00:ae15:b0:7b9:78a6:f727])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:9067:0:b0:7aa:93d5:820f
 with SMTP id d2e1a72fcca58-7ba3cd5ce33mr15085867b3a.30.1763406906458; Mon, 17
 Nov 2025 11:15:06 -0800 (PST)
Date: Mon, 17 Nov 2025 19:14:29 +0000
In-Reply-To: <20251117191433.3360130-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251117191433.3360130-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117191433.3360130-5-praan@google.com>
Subject: [PATCH v4 4/8] iommu/arm-smmu-v3: Cache and restore MSI config
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
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
index 31041ce93e03..1d6c60bee7dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3988,6 +3988,9 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
 
+	/* Cache the msi_msg for resume */
+	desc->msg = *msg;
+
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
 
@@ -3996,6 +3999,40 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
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
2.52.0.rc1.455.g30608eb744-goog

