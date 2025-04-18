Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49CE20C037
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745019301; cv=none; b=gkjBiX/lc/fR991qu5bhLSgNCm8oOUrpOGgGVru045OFAeVJzZUw6q/LmpbHs/Q4z7qhg7To4tEX4Jq/NxBB2/uWVVKN/7xQNDfnb5StkHQzyH9wpocFMdIjEhVmjCbl1jWdbb2D/caypBbOo+vdAed4irwdzmDpkUsAXgXjacE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745019301; c=relaxed/simple;
	bh=k5Zn2JEOggLhm+zHQE5cyVt9V9sPp9bJ9ZCS0rPWj7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ThCsCXax3z4yZZhyrryMUFFIDTwe8IbOB+Hi8KHKa41FFHptihehACXaXGzLDH23GkBi7DvkYK8bcu8HrUGm5y674oKkC/gMUBK2ojCee2d1IazJQYOSrF91UYI9iQZhyV1WPb0m0yxwdWEJKov+J8szEi8VkryX/+DPsbhjB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hptpoBRB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hptpoBRB"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225505d1ca5so21310025ad.2
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 16:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745019299; x=1745624099; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7263scwdntC5xYCoNA/BCVFflH2+9Rqr/AMxWa5H0M=;
        b=hptpoBRBKWlnwRVzXDcqY3BL7lZvjHJZj26yuoN4RpGM7p2SWoflGEiCWm5ms7G2Gn
         WyxAPlmwK1y5IC9IC1SvRMovbTBDi0JPos7lVJ78yxHpRNEbtdk2438Lvr5Gpi1sTv76
         Bo4txTsZyAdc8fKwctJO3LxL50NVP6ymuSjOwEqJmjEiU/DlhELpE3r8K2yi0vtc886M
         U7JYyYUuLSOSDejtuhgXrcYkhs6mXFHnjsMBQYZP9I7Xo4g/8oYrFvyL5PRWC0Vo9rsN
         UufiExQ/qV+QVEJcpOUm+P9xUxgd7VZqs/oC7M367ffGvN2asKluuOG/pOZOdYAbd9K1
         nQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745019299; x=1745624099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7263scwdntC5xYCoNA/BCVFflH2+9Rqr/AMxWa5H0M=;
        b=sRmkqD6zp6a3ClrPMoPbPuJO7+d+my23ixD4PnBqDYX1xeXfAeturIF4RJsnjY6yEh
         lYuwaEIUE19Bg1Wz1BxDlV7bUtURLxkvRvssIllG721s7lLJiDyiYLk1L8bLcH9yj5J9
         GWmUxZAkJ09BrssB0hNvVvDx24tiiTVYEOpJqDDW0u0jYY6XhEFw+CTn5iCHWMh35iFT
         3yUv79X146KfobzpaZ/uCWcyFZueo4yTP3TCZcdFll7rpU0s7s7OgwZyr+C2gYTWmVKY
         FUZhmjgZ5laudkT6RJpAuF/oTLOHnrItsXh5g7LS3ih+tCBPqQ0mvxXuHM+xY/ySEcQf
         gcog==
X-Forwarded-Encrypted: i=1; AJvYcCWBTQN6UGVyzO4hO9AAG4NydYkXZuveWqOYvliZVUYoS6n0+jmrD5PWI++E9efaX3CUDm7/zw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yysdeee/ekQaL1rRtKsBAVfHx/45bi7cfaB8b2G5yHVeDj7zqqg
	KryLJZUoX3kwJklszIbm/lEWA5ndfzNKIVirET/idb6ClS7h6pjUPmSlnbdnyDwaN1wliZbPdQ=
	=
X-Google-Smtp-Source: AGHT+IGHoBOvdLHaVc0syIuawQTRco7RScAhslFPa2hZEUklrXtwYxdTE+2Tfs9jce+r5rVL93hGUEwqHg==
X-Received: from pldm5.prod.google.com ([2002:a17:902:db85:b0:227:e9e8:7153])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:98f:b0:221:7eae:163b
 with SMTP id d9443c01a7336-22c53627298mr62884305ad.46.1745019299111; Fri, 18
 Apr 2025 16:34:59 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:34:03 +0000
In-Reply-To: <20250418233409.3926715-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418233409.3926715-5-praan@google.com>
Subject: [RFC PATCH v2 04/10] iommu/arm-smmu-v3: Cache and restore MSI config
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 +++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7f70e0f4f158..7990865059e4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3968,6 +3968,9 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
 
+	/* Cache the msi_msg for resume */
+	desc->msg = *msg;
+
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
 
@@ -3976,6 +3979,44 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
 }
 
+static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
+{
+	struct msi_desc *desc;
+	struct msi_msg msg;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
+		return;
+
+	if (!smmu->dev->msi.domain)
+		return;
+
+	desc = irq_get_msi_desc(smmu->evtq.q.irq);
+	if (desc) {
+		get_cached_msi_msg(smmu->evtq.q.irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	} else {
+		dev_err(smmu->dev, "Failed to resume evtq msi");
+	}
+
+	desc = irq_get_msi_desc(smmu->gerr_irq);
+	if (desc) {
+		get_cached_msi_msg(smmu->gerr_irq, &msg);
+		arm_smmu_write_msi_msg(desc, &msg);
+	} else {
+		dev_err(smmu->dev, "Failed to resume gerror msi");
+	}
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+		desc = irq_get_msi_desc(smmu->priq.q.irq);
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
2.49.0.805.g082f7c87e0-goog

