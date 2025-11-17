Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7792D336EC4
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406917; cv=none; b=T5pvi1uBnEaG+hPP4ehf8dO2ThB2fYLK0m5mrhIETLDP68XfgIRgLF/lOQP/EEidaEK+UToOVs87yZPsPGR/F5v8a888XYV68LyVuz4rpKHSW/pe70qniCnCDPNOJBPOD2m/OeMiV32HDj5Z9FI4GizNxQ+8DUobu1aRe/ODOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406917; c=relaxed/simple;
	bh=qALyXrP9vmcOOEymeCE9sNz8J6Bray4Ej2AieYmrA30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WWTBsaCerSb2RiOb0ScCnJoAlMHD4XUdL+n+UnArG580AhOE+V17goUJCdjBa4PygnOZRuwWiCkMqT3hUTtylkX33q8Sm0sf2Akb+9EbR2umxVZjOmB9kemyqjBHyiyQKCqFIMwPLdvJFQ1znLF6yzZ8x+kDUEcnnWH+DAPPCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQ/uW57m; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQ/uW57m"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-343daf0f38aso5389891a91.3
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 11:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763406915; x=1764011715; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qqXq8HSKbTRWgHtXO7CqV6DNx8mjlXb1MJ/IQ9Y4WOI=;
        b=GQ/uW57mZbQY906OVNBlsxJJR3SOVuWHm2eyDngRKdjLabLnUbuMmD098QhWN0XDd3
         lIbIBkbGKnHdMMgnEEObhgR+1zZUDSp1h/wbKGDjkgmtjwfPI8z56rDHNqTWAgfWz/yr
         R2MXmmgqd4Z7EzO9LssuzOASJ4qJ7Zptsp/Xo5q+5HfDMDhVMNh4yjy0F7RC/UG/X0c/
         Y+Iljs6p2gwOv7LI2GkLtA83y4dJIQTzkOWm0u5WdtavxPrM7+p9Eil25b39Bz9jbv0t
         wCtBnhm4q3w4MJ7eRpMjKrZ2M8y1wDWuBWsLbH2hDevl++jcqdUeYIRGvb8858aezFSE
         RViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406915; x=1764011715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqXq8HSKbTRWgHtXO7CqV6DNx8mjlXb1MJ/IQ9Y4WOI=;
        b=fbq+F7zBsOZqil9sEc4TDmS8ff1yabEEobuFO7mcWVk3Pu32IkQwhf3u8qhDnzj6Lz
         wDdZB47p0pyNeK9LqNzLQx2VwCw6u+EQvErmUfCWg7KY3Cri8abPZeFTwsjowYNcyROV
         O36XWZ0l7Eq7sI4/eE7sl7bcSATXa0Z7e0l3YvcwEPl9fPYki5xrmw7U1obPpc0uTsf0
         xZ4k1aG+NP/jZGc5vWv2EfrlhA8pjTY3doMb16l79ckX9y36ZOac3DDeTiKXd9gsPUL+
         zNPUIZ83Pa1mzYmmpP0Jmi4tWu6jaNNQ9g89M/TDTrD/hS31yUfBmvaL54gIyudeLb5H
         tgyg==
X-Gm-Message-State: AOJu0Yy0PZYatcSH1RzQPIHvUtNs1TAzyPIV8lvIBlvT9dKxWR20tEVt
	nihbsGdrogsN4BSSDm0tZuindkJt07uwXll8cOrqNtmnaeru6N6OAaMX4zedivuRFEdB8KBH+pr
	C8gY+xRXct+g2E/HzBtQoPMXxmAa097LmXFADd8V7KVxNljRVkC4bowrTejd41Z0lWPVcCGQ3F2
	TvC0p7xvUenP+dHe2UDBKEOD6pMFVCwA==
X-Google-Smtp-Source: AGHT+IHCNeHJxHgNPw6nyMLmMivAczqsfhRAQuNfsgHTb1FBXczwL9SJIFFXM76NLs2Suz3mxYrgC7cA4A==
X-Received: from pjo19.prod.google.com ([2002:a17:90b:5673:b0:341:a9d7:3d07])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4985:b0:32b:9774:d340
 with SMTP id 98e67ed59e1d1-343fa7607cdmr15014623a91.33.1763406914502; Mon, 17
 Nov 2025 11:15:14 -0800 (PST)
Date: Mon, 17 Nov 2025 19:14:32 +0000
In-Reply-To: <20251117191433.3360130-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251117191433.3360130-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117191433.3360130-8-praan@google.com>
Subject: [PATCH v4 7/8] iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable PM runtime for SMMUs having a power-domain during smmu probe.
Add a devlink between the clients and SMMU device. The absence of a
power domain effectively disables runtime power management.

Reviewed-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 44875c526183..49a3a46994b1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3685,6 +3685,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		pci_prepare_ats(to_pci_dev(dev), stu);
 	}
 
+	device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -4992,11 +4995,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable;
 
+	if (dev->pm_domain) {
+		pm_runtime_set_active(dev);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_set_autosuspend_delay(dev, RPM_AUTOSUSPEND_DELAY_MS);
+		pm_runtime_enable(dev);
+	}
+
 	/* And we're up. Go go go! */
 	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
 				     "smmu3.%pa", &ioaddr);
 	if (ret)
-		goto err_disable;
+		goto err_rpm_disable;
 
 	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (ret) {
@@ -5008,6 +5018,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 err_free_sysfs:
 	iommu_device_sysfs_remove(&smmu->iommu);
+err_rpm_disable:
+	pm_runtime_disable(dev);
 err_disable:
 	arm_smmu_device_disable(smmu);
 err_free_iopf:
-- 
2.52.0.rc1.455.g30608eb744-goog

