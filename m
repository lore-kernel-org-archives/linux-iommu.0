Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAEE3BC68E
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597292; cv=none; b=gMXswxcq4ENnp/cCc3lsP7s3A1TJVBNc/HBHk5Edinwh69G4XtTYOwdV8AXjJA81AKD7Ndq1z3JVEE7Ale/slkt5nczaAQJb8UHEQqw7U4l8Q3iShKhOgFHSg/3aHw1PlyKfBeZvpaQBohcw9Zg5GI8fIqCUSCI+0a1/cobY3FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597292; c=relaxed/simple;
	bh=w57WWqbuVg1C46CefALqiJ2Pvgfc2qJJo+gvJ+wT4u0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g76v3QZyA7qnD4fLQAWV5yoUAL2rj+xol6nLa/FTMUsE6gsKCkVf5bxsnmONeqe5Y//MQQGUfYj6HNOQEagQcI88jPvyapVVE19h7gYwB70I6a1NJSYWzkeINKA65esR3jTQd21SkkOr6gvdYhm/XA/P3vasyKx8BvmGEWn+txQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQKuHDkG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQKuHDkG"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b828c8so177694a91.2
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780597289; x=1781202089; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIiNR1cRpyTRt2RrDtP+DBDRqvojsy7fBnMse0sQxKI=;
        b=IQKuHDkGBEIYG+H95UILm5/3SzFdNYidVEuWV/g2fUuyzsMDVwHWouhY3kDjTfJ+Od
         Lvd1ntCCNSyPFdEJyYnMZWjNZhaVGeM8a/iEQfCCa8j2y1wCU98rqZX0AcLM/QvdQXHA
         1m9/Lk7XV0gljOYeNZzK0EZ1EgzgEaJTlRX93TI82My1lgEuIUtwTE52vqDuaY/mcgWe
         y9DvZEpPZ1SvW9lhTS94hjzzmqpZ8eM07NuienTpd9KiJwwsG6OJWA949aUVz6OtKOVO
         6KSS3tH5ULONJ4y0Tr1EPPgQDLXCFkdbO5DTj2OolQtPDv9yBcsGkOCV7F86KYJlxtG3
         HRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597289; x=1781202089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIiNR1cRpyTRt2RrDtP+DBDRqvojsy7fBnMse0sQxKI=;
        b=kq2QMYRAdb/BhvViDdd4NK8zn6EIfeshIDpg4bVYbYM5ts/3j7JQwORkZrZukpREbW
         5iyWb5tCGX9NVV5sI4r9UAZGBnX2ZWH8NXUyfhWErWV4ij5y8G/EKoa4rwleKIxZwcuJ
         YNNgTPLFSqLENKKwzQJY2NO9YCNZ/mRDOYesSxFnzVX3f5qLsqbNgihHLWebMUkUBYbR
         XrPmiqJDlsid/6EQLJ7RiXvdvMaTnZ0YSc0q4umXeqejBsECudLNsHawTlfDO+aB2cMY
         m/PKVwMn+QpudYvW3O3OVv7z2NviO+sCzj6C2+fH7xpbQc+YF7Gn5iv/OkArgtQXX7Lk
         JBTg==
X-Gm-Message-State: AOJu0Yyij3JJuHXKbyukWQoioRkD6eVyW9lVGRh7ti7r6HmbYadCNDyv
	zCvLeUWp6C89tMgISxI2kgjOWABVCoF01V0tLl2zDJV7RLzKV8X2P9+CwMKAiGYC5ZKpuO93Q5I
	/qPuhee99gNnudkQxcbc2SB15mkELIalNCP3M8WYpb0Ymq+/5f3gS/ZBgGvN9ZETdaZJgvWN4YD
	RCIwt1Rbj8CS2P7CtOyPS/4tOHI/ABsA==
X-Received: from pjez16.prod.google.com ([2002:a17:90a:150:b0:36b:be09:e0f7])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1ccd:b0:368:a297:bd38
 with SMTP id 98e67ed59e1d1-370eedfff8dmr139009a91.7.1780597289305; Thu, 04
 Jun 2026 11:21:29 -0700 (PDT)
Date: Thu,  4 Jun 2026 18:21:16 +0000
In-Reply-To: <20260604182116.3179005-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260604182116.3179005-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604182116.3179005-5-praan@google.com>
Subject: [PATCH v8 4/4] iommu/vt-d: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the Intel VT-d driver to handle ATS configuration and enablement
more strictly. Specifically, update the device probe to fail if
pci_prepare_ats() returns an error. This ensures that any ATS-capable
master reaching the attach phase is guaranteed to have a valid config.

Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
fails. Since earlier checks in the probe phase preclude config-related
failures, any failure during hardware enablement is considered a kernel
bug.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 849d06dfe1ae..f39451323553 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -876,8 +876,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
 	if (!pci_ats_page_aligned(pdev))
 		return;
 
-	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
-		info->ats_enabled = 1;
+	/*
+	 * pci_enable_ats() should not fail here because earlier checks
+	 * have already verified support and configuration.
+	 */
+	if (WARN_ON(pci_enable_ats(pdev, VTD_PAGE_SHIFT)))
+		return;
+
+	info->ats_enabled = 1;
 }
 
 static void iommu_disable_pci_ats(struct device_domain_info *info)
@@ -3292,7 +3298,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	dev_iommu_priv_set(dev, info);
 	if (pdev && pci_ats_supported(pdev)) {
-		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
+		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
+		if (ret)
+			goto free;
+
 		ret = device_rbtree_insert(iommu, info);
 		if (ret)
 			goto free;
-- 
2.54.0.1032.g2f8565e1d1-goog

