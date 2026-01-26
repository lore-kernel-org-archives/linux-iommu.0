Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096433B6CC
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440342; cv=none; b=pQ81/eMFsswuyXiZXgfwiEw7ob/hQLkFI1vfuEmIW2jFJ/KV7ECtIQlLd3b1JDm36VBY8XsxLNZPasEYpOs+IGY+wpNCQVYVTLkegQYFNGGexAbuKwxb/D+vZCcrUkYdDLA0Uugj8we7B1R1fZasf6fa1rnGbS2bni83VPH/oH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440342; c=relaxed/simple;
	bh=md7tN995OKUmQPuu/CDylIYO6Gx2uix2sVsCm6/qWCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=grQfCaEf6P8ue+BrPpTL6m+ZB8jVVErnZjA42AvCQEblqAe1BHWACkIKNtmL9JpR4SQ3mx1ND1rM0yjm5ObF9gqghHfJvmWt3PExJAx/v/RDa9zXZ03QnfWOkPlTR9d2rLTjG/5NC3TACg38Hrjmo4A7nytsoqggdjsT5GAwMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qo6xvbiE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qo6xvbiE"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34ac819b2f2so4050763a91.0
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769440340; x=1770045140; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5O2APTy7OkzFnnsUuG3lkfKPnAJvqbOHUIhbuHe9/Q=;
        b=Qo6xvbiEqX6fQF2nyNn6I+mcymSRBXetHIKS7WrJJCwahN80SfXA02AdYxUif0jWVa
         KLVwnVkUH/5q1a/jLT+y6lj47o5Fdr8Duk3NcJktVdNgSPTqmlyfrcaPJi7/AKU1BlAy
         MumYGWjvt5kAGwKzDkACq8XxCb6+thHRtvgjBn+IQXXSyRxRECE4nbIaGUCStgJKe+UK
         APc/mgbk/RA7J2uxETNkSTgs5c97+TB7WRB5nJNUC7ecU8LNh4ffhWMYj3redsPQP6wa
         A8t8r3ITNv6BMClHhYv+UhuCSlx7x4TNmcXNZBk/zd6+lyy1JQtdvRu0LNSZDfF83xxi
         2E0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769440340; x=1770045140;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5O2APTy7OkzFnnsUuG3lkfKPnAJvqbOHUIhbuHe9/Q=;
        b=ogTG659PGchyMpiT6uqzDf2jpzP4d1Horeabcrc0qYw1O6KIa+bFcOU7drT5bpYbDi
         xWur8XGv1w/wUM/2tskVRNN64X3na9D9Kihgp5jfEz1YuG2s//i9ZoccRhVj19xZSnfu
         p31whrWEFQh54mS5279I+VsSGTuLglf4Ztq1Fnve3thqqbVTpRHukuSsww9ZXT3rH4ae
         XLw0b4UCMcVO5CZT2jYbVp0e/SBWUe25i5kBpcDbyQ2MFB67H4vCVL0mOLRsK4I55TVA
         o8mZIihbCH6kFRP2Hn+RtyZ1C89xMlFGonHufcDfzfUqyaub/x+RLn/BjJ0EFjYxPNxj
         BS4Q==
X-Gm-Message-State: AOJu0Yw0N54mVuStruR9Rww8xpdbhrW11gKo38QJYoqVpumySSbdxQFX
	JXBb7CU1ddFKFYjXr3gH1P1+PxFt6fKXviO0KkqgjVNu/gH0u7Y+dSNjNr+pRcRfYz3WD9kCiy1
	Sqq8ODQxbxAeuH6Qqf9FsZrofPrTegBvIEYJ7QPIKBwCliOSE7JbhmWvjOav9M6kMrvdV8+HFn4
	cQxk6Q3TSPvTgEfCiseu4aLYdCqVibMg==
X-Received: from pjbtb5.prod.google.com ([2002:a17:90b:53c5:b0:34c:d9a0:3bf6])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3848:b0:349:3fe6:ab8b
 with SMTP id 98e67ed59e1d1-353c41accb2mr4109172a91.36.1769440340300; Mon, 26
 Jan 2026 07:12:20 -0800 (PST)
Date: Mon, 26 Jan 2026 15:11:56 +0000
In-Reply-To: <20260126151157.3418145-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126151157.3418145-10-praan@google.com>
Subject: [PATCH v5 09/10] iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
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
index 22782025d0f0..9931dde41239 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3752,6 +3752,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		pci_prepare_ats(to_pci_dev(dev), stu);
 	}
 
+	device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -5079,11 +5082,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
@@ -5095,6 +5105,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 err_free_sysfs:
 	iommu_device_sysfs_remove(&smmu->iommu);
+err_rpm_disable:
+	pm_runtime_disable(dev);
 err_disable:
 	arm_smmu_device_disable(smmu);
 err_free_iopf:
-- 
2.52.0.457.g6b5491de43-goog

