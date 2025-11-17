Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472C32E135
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406893; cv=none; b=OBGpSpoeh49cLXwPyrLizeuTUy9SScXm351vPx5DNPMGap6p6D5KmfsY7xMequFGRJGMf7vV2ib3qXlSq2VV3bjKeCVgPDi+JrG6/URCCkzTDu93PqJTqfKujnm0FVe+p/eBJEko+hZX5s8uH+jnYMXXktDFfaPd0jFI3gxU/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406893; c=relaxed/simple;
	bh=oDfBUmVw9evXwpom/vZbyIzesKFWZwG5tLFcAEnbmZE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NAjzIDqw33vYX8gfkL7t7wH+v/ovW6MlfS5wAaVK757TvtrhAJfUIZXc9TLXu1H2JT2MZTkBPQJHKOzbd8ADmMQ410fgaZn3GlOfx7lrDEv9P6+M5AEJicWwjh1pe+jjhA/v9i9rjaJYxkPqnR2lV7GDiCWpDKCzj65m0aNIAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlfMnVka; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlfMnVka"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34176460924so4567208a91.3
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 11:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763406891; x=1764011691; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jSflE4BxYgz/vwt2s+QgBlV+FOHHoCRFFbgdkZalb6E=;
        b=VlfMnVkalYZhIB5Mi7/Tzd7Pjqkn93R09uFq16767h8bYfMoLQCkUrtQ9NlxL5rW/R
         hCqBInclCxHHsIoK/13VCRqIXpXYUNMR4hpb5NCY5H/v5bkNuO89HAkMRbilmiYHYnEa
         eYeX8efRBudjDMlG9mHS6snc8iDUfD9SvbxN2pmecHk0aVJf5chDCGTT1mna1lBD3mxb
         9NQUcqb+z9JO8536bFsX65gLwuYtfSPVwkcwvhc3RQbI8uKjcNG/31OLqxNjSvfPiq+O
         /J2H5bnNGuXP9OsLjxnVXhxhoYBv/qYRT9DrCta6xI9Fnmcp9CLB8rZXUV+6AD+n3etQ
         D+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406891; x=1764011691;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSflE4BxYgz/vwt2s+QgBlV+FOHHoCRFFbgdkZalb6E=;
        b=hHigkg2j+nowO6TqIjC/YVmmm1cmrhCXFIhoeCyM+EsJYaN9GjNOrPxRzG8DmQsdWI
         ln0KsLyWA/Dri4UvqVWdx/VDmMY9gax83aMDdfemgUapgY1D5rDBjaU/ROpOnSxbgLk7
         /3pyZqJhZEfZj99LWk6dJWtAj19idLA8sxr3D5WCtZYKuv0IeX8M41B8Y2ZKL5KZORR0
         AtVaBkA8eHum0D++wfi/1kEhksjjiW5vdQeD5UGqTjfzIggdjc+rWcMRAUFYDsGnqJ7e
         eiHu+WUMBSsdWZyWDc8B5Zan5hnVfNSuwWV3s0dUCHK83rLDo/s+MGIs0+zxNTnvnYC+
         ltuQ==
X-Gm-Message-State: AOJu0YxfN9mMV12YhkRYCRnnjdZIMiViET0zr5mNQJel/kPrBOUOT28s
	By4c29KVC1bZos3wAMYzbU+LuikrWiQxikgwSpVuUjPWRbhn87tamzlNjpp/JJt9v71EbAPnspo
	qM54sDZ1JXVj6pxle3ifWKS2luTqNrFA1yivr83mLoGo2DomtwvZ5LHSn4fPByh10V6+eHp19Jr
	vy+1iTQSYGgetAjRrc1SCuTtUa0/mAdw==
X-Google-Smtp-Source: AGHT+IGiHlkDc70eEyTUVuNLFcHLLhpHD7h+bpiZo08RLxh5zwYoq6D6kjgKAVlLrAt3+5DhojazPHe8gA==
X-Received: from pjbbr14.prod.google.com ([2002:a17:90b:f0e:b0:33b:52d6:e13e])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:280d:b0:341:2141:df76
 with SMTP id 98e67ed59e1d1-343f9e9fee6mr13978460a91.13.1763406891201; Mon, 17
 Nov 2025 11:14:51 -0800 (PST)
Date: Mon, 17 Nov 2025 19:14:25 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117191433.3360130-1-praan@google.com>
Subject: [RFC PATCH v4 0/8] iommu/arm-smmu-v3: Implement Runtime/System Sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

As arm-smmu-v3 rapidly finds its way into SoCs designed for hand-held
devices, power management capabilities, similar to its predecessors, are
crucial for these applications. This series introduces power management
support for the arm-smmu-v3 driver.

Design
=======
The arm-smmu-v3 primarily operates with in-memory data structures
through HW registers pointing to these data structures. The proposed design
makes use of this fact for implementing suspend and resume ops, centered
around a driver-specific biased usage counter.

1. Biased Usage Counter
To safely manage runtime PM state, this series introduces an atomic
`nr_cmdq_users` counter. This counter is "biased" by being initialized to
1, representing an "idle but active" state.

The suspend callback waits for this counter to be exactly 1 and then
atomically transitions it to 0, signifying a "suspended" state. Any
other value indicates that the command queue is in use, and the suspend
operation is aborted.

Code paths that submit commands to the hardware (the "fast path") use
`atomic_inc_not_zero()` to acquire a reference. This operation only
succeeds if the counter is not zero (i.e., not suspended), effectively
gating hardware access. The reference is dropped using
`atomic_dec_return_release()` after the hardware interaction is
complete.

2. Suspend / Resume Flow
The "suspend" op now polls for a short period (100us) for the usage
counter to become 1. Once successful, it configures the GBPA register
to abort new transactions and disables the SMMU, EVTQ, and PRIQ, leaving
only the CMDQ enabled to drain any in-flight commands.

The "resume" operation uses the `arm_smmu_device_reset` function, which
re-initializes the HW using the SW-copies maintained by the driver
(e.g., prod/cons pointers, queue base addresses) and clears all cached
configurations.

3. Guarding Hardware Access
Instead of eliding operations, the driver now ensures the SMMU is active
before any hardware access. This is managed by `arm_smmu_rpm_get()` and
`arm_smmu_rpm_put()` helpers, which wrap the standard runtime PM calls. 
These wrappers are now used throughout the driver in interrupt handlers,
TLB invalidation paths, and any other function that touches hardware
registers. This ensures that operations are implicitly queued until the
device resumes.

4. Interrupt Re-config
a. Wired irqs: The series refactors the `arm_smmu_setup_irqs` to be
able to enable/disable irqs and install their handlers separately to
help with the re-initialization of the interrupts correctly.

b. MSIs: The series relies on caching the `msi_msg` and retrieving it
through a newly introduced helper `arm_smmu_resume_msis()` which
re-configures the *_IRQ_CFGn registers by writing back the cached `msi_msg`.

Call for review
Any insights/comments on the proposed changes are appreciated,
especially in areas related to locking, atomic contexts, and potential
optimizations.

Note: The series isn't tested with MSIs and is weakly tested for PCIe
clients. The same holds true for tegra241_cmdv changes. Any help in
reviewing and testing these parts is much appreciated.

[v4]
 - Dropped the `pm_runtime_get_if_not_suspended()` API in favor of a
   simpler, driver-specific biased counter (`nr_cmdq_users`) to manage
   runtime PM state.
 - Reworked the suspend callback to poll on the biased counter before
   disabling the SMMU.
 - Addressed comments for the MSI refactor.

[v3]
 - https://lore.kernel.org/all/20250616203149.2649118-1-praan@google.com/
 - Introduced `pm_runtime_get_if_not_suspended` API to avoid races due
   to bouncing RPM states while eliding TLBIs as pointed out by Daniel.
 - Addressed Nicolin's comments regarding msi_resume and CMDQV flush
 - Addressed Daniel's comments about CMDQ locking and draining
 - Addressed issues related to draining the evtq and priq
 - Dropped the code to identify and track user-space attachments

[v2]
 - https://lore.kernel.org/all/20250418233409.3926715-1-praan@google.com/
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


Pranjal Shrivastava (8):
  iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
  iommu/arm-smmu-v3: Add a helper to drain cmd queues
  iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
  iommu/arm-smmu-v3: Cache and restore MSI config
  iommu/arm-smmu-v3: Add a usage counter for cmdq
  iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops
  iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
  iommu/arm-smmu-v3: Invoke pm_runtime before hw access

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  10 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 411 ++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  13 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  27 ++
 4 files changed, 417 insertions(+), 44 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog

