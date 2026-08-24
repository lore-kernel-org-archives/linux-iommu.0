Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E901A01BE
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574237; cv=none; b=e5m+u0aDTQ4tVlJEouP0tixnd00StxkWOfnHv7Dt2n6HLkn19oJCVVH2YTbVAyq6EAsn4OIXYJDvpoIBSkABJE8psehC1J/qVchw9rQjWSm33EzHiKWL7yGyV4T2AxCQiOaz216SkkJVUT0fOKjOAiEMDxlhoo8PAvCZMfMB2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574237; c=relaxed/simple;
	bh=QQ+BuMhlGjap9G/8niHShlE1MGJ4y7C/XEXcy/s8Xx0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l3pR61Lmm0/IgaUfjL1lMV+QgpEuglgLsh5DMWUMhml7XvsbYFTJckVoCJvC3P+M+1/1MxbGwYulwZJw2LsCz/4zgrOdGluJJ131/4BZLrfaSWZ45uVFqGE+XCRJg2/1my5YPrWzlL8sScpyI+0xlyUZO6jc+XxWzg3HklaQ5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GgsgYe/4; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GgsgYe/4"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c89704da8c7so5064304a12.0
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787574236; x=1788179036; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tUcMgUMCUzyieEAsi81dwAASFx0SSottK9MrWICMjZA=;
        b=GgsgYe/4jNMsXJhjP7Uiz9/CEEHubqwXUG7KOsOEbnq2ssRI4cgFTAjv/JaNNjgOK7
         XoJvNVuIbtprQ4zJHpUe8onOi1WHv9AI+xfEpWjkb3i1nnCvDMVgNk04auk8VjJG3h65
         z4nPRTdzJmhiAsQWUOzWdUlPnzv13QYT2FPjWvTpzxseKKiJ6H+JgrlbdL70TRjGab/7
         PXm8ROEF7Y9oNAVwcsDtN2aSlijisqw1IujlaQ4+Lh2P/HzXlhYrFjMiOQeHt3rdMu42
         pUiqNw+W3Ie7V7LONfLRxy2N+Vt15Ss/a0g9BjVBwjRCGRNxaHhttru4PRdKPHBQhUed
         l8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574236; x=1788179036;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tUcMgUMCUzyieEAsi81dwAASFx0SSottK9MrWICMjZA=;
        b=HMz913wTg9qT34fiaRAi0Yfv3vxBtLyja+t4WVH1OD6qV+EmtUKX5dFNIn3hTiuqrg
         0LIy1tl3bXQJXVrV5vQDE1jT6mz+2n5N3SJaHK9PK98yHwp6V68vZkSDlHzd1HvqA24D
         HXkhcY5TJsJidIH8rF7jqlgvAWCF7qNOw17hVHQ6FfC2lT9fWfoPROsDXX9GXlwCUYez
         9qUzkD1q04p9atdK+0BtVX3CSQEqJmnluLvB5/azEPEOfeoA/VKV7GZWa+b5DqsVC0Cg
         /xZLsSh6D7K4Wri56YyKMC2E25PdS0BCKmuajid132USj0gVP6ABHO3BhGvGXDkYMIrv
         HLVg==
X-Gm-Message-State: AFuF++l5CuQAtQeilscQUtDmR3Vn2ePZ5vrzIztqjwjunKh4kxxrzgk6
	suL6cw8s7KS7Y9v8GFpLzx2ooQS9hO279cvk/+u24Wv1tMYhK1GclytZzNHPEV4bYcx5PEk/cw+
	F6ur1yNHXu6H+RljkZrHB80XJEqnuGhc84SwzEc4wYfxbZ6yGkJre0+J8gDTcHs6n+CgMnzYqbB
	cE1UpeTCHysWNVYEXogilnJ5l2EQDWvQ==
X-Received: from pfbfr20.prod.google.com ([2002:a05:6a00:8114:b0:845:b9e9:fcd1])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a110:b0:3c3:bbe6:95c9
 with SMTP id adf61e73a8af0-3cd301795c8mr46911339637.16.1787574235313; Mon, 24
 Aug 2026 05:23:55 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:23:42 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824122347.1588592-1-praan@google.com>
Subject: [PATCH v3 0/5] iommu/amd: Refactors for ATS robustness
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

This series forms the second half of the subsystem-wide ATS robustness
updates. The first part (focusing on the core subsystem, Intel, and ARM
SMMUv3) has already been merged upstream [1]. This half addresses the
AMD IOMMU driver and standardizes the PCI ATS API.

In v2, the series has been significantly restructured based on feedback
on v1. 

[v3]
 - Collected Reviewed-by tags from Vasant.
 - Added a comment explaining why devices without DMA translation support
   are not ignored (to preserve interrupt remapping) per Vasant's feedback.
 - Renamed iommu_disable_device_dma() to iommu_disable_device() to accurately
   reflect that it disables both DMA and interrupt remapping.

[v2]
 - https://lore.kernel.org/all/20260814015647.3370124-1-praan@google.com/
 - Patch 1 Refctors the probe path, isolating capabilities into 
   iommu_init_device_caps().
 - Patch 2 renames iommu_ignore_device() to iommu_disable_device_dma().
   Following Jason's suggestion, it invalidates the hardware DTE by
   clearing the Valid bit (lower 128 bits) followed by the upper
   128 bits.  
 - Patch 3 splits the probe error paths to ensure that devices with
   config failures (like PD_MODE_NONE or ATS mismatches) can preserve
   their rlookup_table entries, successfully keeping IRQ remapping 
   functional for bypassed devices.
 - Patch 4 implements the "Fail Hard" pattern for ATS in the AMD driver,
   failing the probe and throwing a WARN_ON() upon ATS configuration or
   enablement failures.
 - Patch 5 enforces the checking of pci_ats_supported() prior to calling
   pci_prepare_ats() across the entire kernel PCI subsystem.

[v1]
 - https://lore.kernel.org/all/20260601134204.2150602-1-praan@google.com/

Thanks,
Praan

[1] https://lore.kernel.org/all/20260615235037.259909-1-praan@google.com/

Pranjal Shrivastava (5):
  iommu/amd: Refactor device probe and capability initialization
  iommu/amd: Fix DTE clearing and rename iommu_ignore_device()
  iommu/amd: Split probe error paths to preserve IRQ remapping
  iommu/amd: Fail probe on ATS configuration failure
  PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()

 drivers/iommu/amd/iommu.c | 199 +++++++++++++++++++++++---------------
 drivers/pci/ats.c         |   6 +-
 2 files changed, 126 insertions(+), 79 deletions(-)

-- 
2.55.0.766.g2966f0265a-goog

