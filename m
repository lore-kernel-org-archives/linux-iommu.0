Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E5BA42
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105958; cv=none; b=QMBK3AJdDl5w4LWv7D/M+fJpBh23N7W6Zxyajjb979tQy2NaCdLvgjAM/raKiqfz/tD9sinYiqJEJ0pPOkQbaSiN1OoIysr3LgGc0hRKCn3RTUL7PMZCNXzapH1y6Vkc8HGg3vvVBcRpfeL1yg4nj382aymeVs2mmVi3pMtWNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105958; c=relaxed/simple;
	bh=v2fL/bgBUWa8bIPuwJ2/+SFpxONm8Ejv1+bMaiT9E/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vz28sf8jt0hLd+l3VPi7SQv7Awuk7RiDF2GWZpiZGn8SE0Bi0FS81stuuAZFg8dEwFSfuPFsfGqt+JtlQYIxBd24rtWwc/dpyY1CFXe3UCJnyGBH3XS2e32eUAgyQAmlPzeSP4SNBe37D6RK3Fnak6dEUPlknPCnHLthx2Z8o+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2W5+BCg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2W5+BCg"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748b4034b42so2293986b3a.3
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750105956; x=1750710756; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai92FprFBO61iaqy5GjwpYIUQQcsfszAdIiu/we2Ci4=;
        b=T2W5+BCgYxjCdMXEc8PltCG8gIM3yWo1/iGoihqQNQUacNBhQcBNtHcEBcvJQ9X6BH
         j0QW9OpiiwPwyLUslfClc/EawDYlxjJ8sZ1T2E1c1FF5WgN/EMKf/eqPOi9ouJDwgFjs
         b14zuLiwg2X6OODeUIb3BUkFEEdjfBKOaG2fiIYXLsA1gfYgV/uuf/bL6FYjLKgDhYzT
         GqNPrQahM1LoBclNmrDwUL0s/W6h5JwcC66oIBssYiOVPuAGtet1fplOH9t/6OeUguRx
         lniAHpSDXxS0yb3TGOVI15SsBJvgqIunlZ/kD8ZaTKxqu03dlftJqJUICFSoedOW306W
         uRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750105956; x=1750710756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai92FprFBO61iaqy5GjwpYIUQQcsfszAdIiu/we2Ci4=;
        b=o/SaMND16bWAQkn1+n0hj6fIqxGRfUoW7DWif2jFV2mVHbn94luTDqDzUEm/BgVPMh
         Th5h22Bxs42KCQDdk8wRaeTDTi4rs+uh/IBrbxzoL0Ty5KMW+9x8kT+gI1A3R86ulOIO
         +6/xNGvmkiphOwUCCdJ1eN3V3STmhtgLUjgwT8GutecLIO3ljN/ovTxH796yaQ89oOGc
         w9tCFQ5mYFj9dmYk9YGuBP3lk1qQ0CTIKuJN4wsYoGpeH8y1YHJ6j17OkqRmYzyOPhI8
         AMMigFFohRkvgM/E3Jp3c6n0PuF0liP0sFfyCuwlcM4KOX93/8zQVOHyTg/NMRiJl3BM
         vtlw==
X-Forwarded-Encrypted: i=1; AJvYcCUKt4i3y6hH3K13/YgCtNVxkIRqHfhf4XgKHQTVGvfnLRWJBihcVPDNW/j9AqYhaIIsq0Z1Lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfLaSsMrDs781Ho0qfHf7FSPNsl9ygoXcH0w6Bi4vJH6ZwgYQl
	Ki4GxrLT2s536Rfg9djaoZz1Yfd6wssP103/1I1KmDoQ8jRABS0xk6C8f+qj3FT34F2dvsg6bxz
	Hrw==
X-Google-Smtp-Source: AGHT+IFpl2ibqUnoU5ng70gY2sexCjYuNfEpC0QLgOvtkq+E7TeC9BBLNVjcgZXQXVFrdiBFnYE1IlpNog==
X-Received: from pfbhd18.prod.google.com ([2002:a05:6a00:6592:b0:747:adac:b0dd])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e10:b0:72d:9cbc:730d
 with SMTP id d2e1a72fcca58-7489cffbf39mr13515519b3a.11.1750105956115; Mon, 16
 Jun 2025 13:32:36 -0700 (PDT)
Date: Mon, 16 Jun 2025 20:31:45 +0000
In-Reply-To: <20250616203149.2649118-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250616203149.2649118-5-praan@google.com>
Subject: [RFC PATCH v3 4/8] iommu/arm-smmu-v3: Cache and restore MSI config
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
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
get_cached_msi_msg & re-config the registers via arm_smmu_write_msi_msg

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 45 +++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9ce00c959034..4699d3294d3e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3962,6 +3962,9 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
 
+	/* Cache the msi_msg for resume */
+	desc->msg = *msg;
+
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
 
@@ -3970,6 +3973,48 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
 }
 
+static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
+{
+	unsigned int irq;
+	struct msi_desc *desc;
+	struct msi_msg msg;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
+		return;
+
+	if (!smmu->dev->msi.domain)
+		return;
+
+	irq = smmu->evtq.q.irq;
+	desc = irq ? irq_get_msi_desc(irq) : NULL;
+	if (desc) {
+		get_cached_msi_msg(irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	} else {
+		dev_err(smmu->dev, "Failed to resume evtq msi");
+	}
+
+	irq = smmu->gerr_irq;
+	desc = irq ? irq_get_msi_desc(irq) : NULL;
+	if (desc) {
+		get_cached_msi_msg(irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	} else {
+		dev_err(smmu->dev, "Failed to resume gerror msi");
+	}
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+		irq = smmu->priq.q.irq;
+		desc = irq ? irq_get_msi_desc(irq) : NULL;
+		if (desc) {
+			get_cached_msi_msg(smmu->priq.q.irq, &msg);
+			arm_smmu_write_msi_msg(desc, &msg);
+		} else {
+			dev_err(smmu->dev, "Failed to resume priq msi");
+		}
+	}
+}
+
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
 	int ret, nvec = ARM_SMMU_MAX_MSIS;
-- 
2.50.0.rc2.692.g299adb8693-goog

