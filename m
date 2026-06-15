Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3635F197
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567452; cv=none; b=BQTOblC8xi8yrh38vL9RbcHvA1IDbrCRyApzLCP0SX76KuPDUIkA6fut6+euKTrkSzSd8mpi0BN4y3RXCvaLh+nCzIN5VjRVvMjcNlP/Aas5Hj1BTDiUjL2/g+jNqSVH+Pt6AZ78xrG1Izc7/XKEdxjqtFTyxCxk+dq3huLv/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567452; c=relaxed/simple;
	bh=v4l5BP6mSyjUVIp0jSkZQ5FNJamGyYJzyXE/hmgYprs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TvmPhiVT/c7BTKSMXRhf+Yit7FUHqoMQfJ4CfOQLMvxszKVSmxrQTdH8f8RL/SY+6kWUydPknwkW5BzbUNM9N+ggg7/u+8iJ0iicLqvRT0h0i8FDfdk3uTb7l6nn3NIr8PnjYG8qQvdUSIiZhhHR/2MswsHGRgyqSJLRnAsDv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jO2AlsZ9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jO2AlsZ9"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8422b544a4bso2685845b3a.3
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 16:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781567448; x=1782172248; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghCN2ryt2ezJV5YU5b84fUdE6lXkqtPvhPQAH6Ew2wA=;
        b=jO2AlsZ9OSZdYUvMKLZJscEXsP1HjTpgh4O7sCQAX3l1umKkaXK0lfeGiaJpjfxE4M
         lyCsJtvJ3m17pxGwEzDwdCD0NRsz15SLhbXxfUKSI0GyQS+q/fU/jQRmJkQ7APgueGjM
         PjONiIWOJukMtvT//ACS3x5SwsGNqomKbWxqeN8z5I7UFVWmzUi0cmbWdgAs8cTA8ZE+
         zjMvgM8XWZiQgWTbzEXqHAR0+g6hQW+70qRTL2XmypVmmg1gntxCO5LIUHIG3YVF/tAz
         15WaTBFzhp0awto7BLtQtJtHyjPrXbcdjb4AO+BoknpCH5WUIfTwKiEb1m5+kp5KnAcO
         wykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781567448; x=1782172248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghCN2ryt2ezJV5YU5b84fUdE6lXkqtPvhPQAH6Ew2wA=;
        b=rT6eo3zCRh6Q+Ne//wvGmaF7U1/l33G5HflHwcDG2DZh0yotFX/LSI4VLWpOplCRwn
         BpZTH4lDSrTyzF0VCsNJgaP+3b8rPmiEQh7GokIAl7MhZZf07TZ4GqyqTEPnpcz+9qls
         XqgL9eZVD8NiFnQKHOs9ApONDmvWpjAziDpopOc7wlTyM+s2H6qTEXOio+MesnghvJwk
         i2MQ49+rxZXOrhMIRk9ZvIf59oV1JH3h1JmmiZrZo2u5hb5uwsgZ15xRCGbY5okjm/ov
         emZYp+9vgcxSuwjelIj9TFCrz4SGZpym7VId8Jimh5VoLhE9/fr4EUDBu1Y2vQYV1bjl
         +HRQ==
X-Gm-Message-State: AOJu0Yw+WmHNjA/0Xs3XL7Q1E04ywkDDBZlBuW98ahEGcM68iw4v5w8B
	cM9tEO3rCMgvrcx1Y+x9xtPTWIP9y0x4nmXjgQZQLJtEkeaoSfkyFXnUa3QqiaxwA6YuwtYoq55
	r0/H48dmUbC2P4PgeRMwc8nv2KnPcE538niK2v7eXppujQewkwAykH85VdJYH19UjGC2EXEbLdp
	V31bKTu2PuQcgRjp7CbYdsiOX5uQdyGA==
X-Received: from pfbha13.prod.google.com ([2002:a05:6a00:850d:b0:83f:682:48d5])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d01:b0:842:708f:39be
 with SMTP id d2e1a72fcca58-8451530d5bamr987400b3a.5.1781567447898; Mon, 15
 Jun 2026 16:50:47 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:50:36 +0000
In-Reply-To: <20260615235037.259909-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260615235037.259909-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615235037.259909-4-praan@google.com>
Subject: [PATCH v9 3/4] iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in a
WARN(). Since probe-time checks now preclude configuration errors
any failure during hardware enablement is considered a kernel bug.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..57b750ebcd3d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2956,8 +2956,13 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
 	 */
 	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
-	if (pci_enable_ats(pdev, stu))
-		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
+
+	 /*
+	  * Since pci_prepare_ats() has already verified the HW capability
+	  * and programmed the STE, pci_enable_ats() should not fail here.
+	  */
+	WARN(pci_enable_ats(pdev, stu),
+	     "%s: Failed to enable ATS (STU %zu)\n", dev_name(master->dev), stu);
 }
 
 static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
-- 
2.54.0.1136.gdb2ca164c4-goog

