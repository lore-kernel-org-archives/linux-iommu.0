Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19320C037
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745019272; cv=none; b=Sdy7csjzWUqNgejwsJr5jCgewnXW83KnbvAnJ7slockQJLnCm+SNTuu9tfFIr8eO396TR8I5xLQTRoaGLW6B8YjEjlkV7YHmGzg21uauT4/WT9WRr9DVCYqC1jRziJKq24T3VLM+/uO3LrQoxrZhuXiDHhIJkNty1HojE6LgqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745019272; c=relaxed/simple;
	bh=2240GIW9v5e1I5/AnbEYaE9o2WuXiVldcOIVmJWJQuE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X8z+qo2iFP8+zTLIgOd+MTWq85R/nT6BJus6/AN2kY503n2juvw01mk5Oh6bKQpm1sxKa/VIbOBXt0PpNzeJH0pS7YS3VeVUR980DdkC0PM7g+C0Q1BQTEQv9SusIdyb7/+3gHC2kYZ1Vw8AKkvOzGQr3ZSPAfeld2xLT76praQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/xAmY2o; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/xAmY2o"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227ea16b03dso29948205ad.3
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745019269; x=1745624069; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B6d+AR7/5tbLL0ns2hTnYkqCziCUUbwmHjN1CmD/u8Q=;
        b=d/xAmY2oTFuVSxWBVExNhj+0gvwDKkj5rbVh0zkIkA4Uts9+roH0Xmq1HZ2f0Fghgc
         UvNm6YGOrde65zGeMJI5nNaoUbWtFniu5tJZ5p1oDt8g7YbdhB91GVum+GhawHWsG0rq
         vy0T3JCWgut+bWOGgsrqF/ePd9IJNp6VuQiIU6zfjxhu0kKFDX8l+z8yN0FvPnXMd3bL
         rFYBrMCvkl9PATN/2/dn2kIWAYxCfxSI/ZpLNHjWPELRV89Wm8k2Y3d4TAtGN/OUS4Uj
         YpbmoNxi1o9yWC/g+TUZgIDSCTP7Ce7aFBqOtlc4RUJ+0/XEVDD+bUkAQUKh5buPuiUq
         +ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745019269; x=1745624069;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6d+AR7/5tbLL0ns2hTnYkqCziCUUbwmHjN1CmD/u8Q=;
        b=YQrA2GqB4pKBOO9MYXrsFIutp1wHAiLgtlnA/jqgobwE8HtcrF16QvTius5Lmjuz1V
         IrSso8oWAxIErmxoZ25ixyFNeowQwExkfTUQ+yMq8e9oors6q/Cmw1V8XFey/gCyLlt+
         F5GTU3xBXmMhdy3w9kT7VfxE8C1C4IfGjRf8x7WclZYDEsddkOUpx+zMB5YA1NqxsM1Y
         ICmUNu2e0I2CB+erIw4s+v1/J/jBlxQlR0UJrwhCPS5RijPIcIWDEIQ10eXIweWN2Uw3
         pYONKxx8/FocKMq4XGxO7W/rzI9O5dV/jkJQozda8DpKCb/ddEYtUpNc5BbKCi5OMFwU
         Inbw==
X-Forwarded-Encrypted: i=1; AJvYcCWuY+FauBRx+cGdTBs07dE496ajJMTgt1V3UTBM8/7gLTIDXl7hxcYTIoMGbRMYjbFoKPeqfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcyFGCBVFvZzc2L/6t72X9QGcb3KTzkA1eSt18RmOeMQ/ObCH/
	0nVhUe3jaoz8AxhPPwd1f/YGXasEpHv4nEpBzFGggFJvrmfuHLtv2G30KfraYZ5o3UwiX5h9rw=
	=
X-Google-Smtp-Source: AGHT+IHK/9XWMv41VbcNdyk5GMY0rk4UquCDO5UDPfmoGKpa71e2Xxw00FR144r94tbjvJZipm6/SzwwJw==
X-Received: from pfbgj12.prod.google.com ([2002:a05:6a00:840c:b0:736:56a2:99ac])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:17ce:b0:216:2bd7:1c4a
 with SMTP id d9443c01a7336-22c535a998fmr58961425ad.26.1745019269606; Fri, 18
 Apr 2025 16:34:29 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:33:59 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418233409.3926715-1-praan@google.com>
Subject: [RFC PATCH v2 00/10] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

As arm-smmu-v3 rapidly finds its way into SoCs designed for hand-held
devices, power management capabilities, similar to its predecessors, are
crucial for these applications. This series introduces power management
support for the arm-smmu-v3 driver.

Design
=======
The arm-smmu-v3 primarily operates with in-memory data structures
through HW registers pointing to these data structures in some fashion.
The proposed design tries to make use of this fact for implementing the
suspend and resume ops.

1. Suspend / Resume
The idea for the "suspend" op is to wait till all the queues are flushed
before disabling the SMMU through CR0. In order to avoid mis-use or
spurious transactions (b/w SMMU disable -> power-down), the GBPA register
is configured to abort all transactions.

The resume operation uses the `arm_smmu_device_reset` function which
re-initializes the HW using the SW-copies maintained by the driver. For
example, prod/cons for queues, base addresses for queues & tables. The
arm_smmu_device_reset also clears the TLBs and config caches.

2. Interrupt Re-config
a. Wired irqs: The series refactors the `arm_smmu_setup_irqs` to be
able to enable/disable irqs and install their handlers separately to
help with the re-initialization of the interrupts correctly.

b. MSIs: The series relies on caching the msi_msg and retrieving it
through a newly introduced helper `arm_smmu_resume_msis()` which
re-configures the *_IRQ_CFGn registers via writing back cached msi_msgs.

3. Handling user-space attachments
This version of the series relies on the user-space paths invoking the
iommu_*_claim_dma_owner API. The existing IOMMU API 
iommu_group_dma_owner_claimed() checks if DMA ownership for a group has
been claimed. However, it does NOT distinguish between kernel clients 
and user-space clients. This version of the series introduce a new helper
iommu_group_dma_owner_user() which allows the callers to specifically
determine if a iommu_group is owned by the user-space.

The function checks the group->owner field which is exclusively managed
by the iommu_group_claim_dma_owner() OR iommu_device_claim_dma_owner(),
instead of relying on the iommu_group->owner_cnt. Both the
*_claim_dma_owner APIs are ONLY called by vfio and iommufd at the moment
indicating user-space's DMA ownership for the said iommu_group.

Based on this new API, the arm-smmu-v3 driver tracks all the non-trusted
attachments in a list and keeps deferring suspend till the list of
non-trusted devices is empty, i.e. no non-trusted attachment exists.

SVA: The binding driver would either be in user-space or kernel-space.
For the latter, devlinks would suffice and for the former, we won't
suspend until all user-space attachments are removed.

4. Invoking runtime_pm_get/put
Given that most of the configuration done by arm-smmu-v3 is stored in
memory, the idea in this version of the series is to elide all TLBIs and
CFGIs if the SMMU is suspended and only go ahead with ATC invalidations.

Thus, for most calls, the SMMU driver would make the required changes to
the in-memory data structures, but elide all TLBIs, CFGIs and prefetches
This is done by introducing another runtime PM helper based on
pm_runtime_get_if_active.

Only places where the driver does a pm_runtime_resume_and_get is where
touching the HW is unavoidable and important commands like ATC_INV and
other commands resuming stalled transactions.

Future Work / Potential Improvements
Draining queues could be slightly optimized based on the feature-set
supported by the smmu, for e.g. if STALL isn't supported or ATS is
disabled, we could avoid draining evtq and priq respectivey.

Additionally, for tracking insecure attachments, an rbtee/hashtable
could be used to improve search times, subject to finding a way to
generate IDs / keys for pointers.

Call for review
Any insights/comments on the proposed changes are appreciated,
especially in areas related to locking, atomic contexts, early resume, 
PCIe-related considerations etc. or any other potential optimizations.

Note: The series isn't tested with MSIs and weakly tested for PCIe
clients. The same holds true for tegra241_cmdv changes. Any help in
reviewing and testing these parts is appreciated.

Changelog:

[v2]
 - Introduced `arm_smmu_rpm_get_if_active` for eliding TLBIs & CFGIs
 - Updated the rpm helper invocation strategy.
 - Drained all queues in suspend callback (including tegra241-cmdv)
 - Cache and restore msi_msg instead of free-ing realloc-ing on resume
 - Added support to identify and track user-space attachments
 - Fixed the setup_irqs as per Nicolin & Mostafa's suggestions
 - Used force_runtime_suspend/resume instead as per Mostafa's suggestion.
 - Added "Reviewed-by" line from Mostafa on an unchanged patch

[v1]
 - https://lore.kernel.org/all/20250319004254.2547950-1-praan@google.com/

Pranjal Shrivastava (10):
  iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
  iommu/arm-smmu-v3: Add a helper to drain all queues
  iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
  iommu/arm-smmu-v3: Cache and restore MSI config
  iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops
  iommu: Add a helper to check for user ownership
  iommu/arm-smmu-v3: Track masters with user-owned groups
  iommu/arm-smmu-v3: Avoid suspend when user owns DMA
  iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
  iommu/arm-smmu-v3: Invoke pm_runtime before hw access

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  11 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 468 ++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  19 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  28 ++
 drivers/iommu/iommu.c                         |  19 +
 include/linux/iommu.h                         |   1 +
 6 files changed, 513 insertions(+), 33 deletions(-)

-- 
2.49.0.805.g082f7c87e0-goog

