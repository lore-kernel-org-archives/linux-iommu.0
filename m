Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0796B2853FD
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196035; cv=none; b=TnVOL9n8K630Uvf6Oc9b7KPao5A1sxYFRHP7qNdvA1gYtpFtsb7fkh88Y/8lOhH7vh8dlphazeQy+paQa263UqtelAurwQRsM12X5lrup0MaEpw4e6ToTF7GjL8DLSx2v+12gCVVJ3d+dEeMuhb9LFuvDmvkLgZbpq+WjgKitsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196035; c=relaxed/simple;
	bh=1VpNLxxhgHeouOWz0104bO08QM+FEUSpKwSEXBJqKVo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S2HFUS3Wr86upo0/ZY4tCzTTa2HDk433u3l+R2dYkfnRpvxiSQPjYc2GZh+sHLMI54B5Zfiznfo4Agd8pZF4zx3ClcpiMzklpVcYdpuryUePY8oYihx28XUuFBgkDzaKV5Jsl6kGHG2zoz4OcgRGyok/dEDDeTMCUsVUjAdMKt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pGGj4EKa; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGGj4EKa"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f3eaf4b9aso1301192b3a.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196033; x=1776800833; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BzbdvgHiaHAzLD3rmAoRxgb7YMfk4YkJzjC+w9qJt6s=;
        b=pGGj4EKa4fWVEXPCWcmtdXSqcjhiO71G731kPm/8ZASDvoUcNS1ukXVDFM+BWMuHz5
         MrVgf1r6QdYGt1kjzlnynSndyc4goYBqvK/ILcK5CtVSm3GpbCboubR1xUy8L5wU55rm
         R06UoLjufxoKLbFAA1sOJXmuyN4MoTwS0GV6D/MsMbm9RLxjW8rjmpBY1b1yYs9zuKkJ
         FdEOkhuAYfRIk8bVj6g6i5Ri7NHVRLMDmkdMdlUAfx2aPJH/NZV8WZUzSNU3yGg24HsN
         GnzPbLeLC2OpSmff8UHn0h/7ZjSq6uwwXIEtkdfIypRELGbM+GCgLqDDJA/4GsGUYC6P
         25BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196033; x=1776800833;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BzbdvgHiaHAzLD3rmAoRxgb7YMfk4YkJzjC+w9qJt6s=;
        b=oogwUa3d4hlg0ehcYBeD7N+f0GyRYcsnnUT0WFm1XAU/jS8/hxUr0HZ9N4Wj+gniDJ
         HWPP4GZiBh+8qhQPp3DNaNvIh5QxdMdyKQEq8dDLRHRLWCVGXZfzOSzwW1yJgYfCyUdP
         IIt7Cv5Y0Lf4b88AVsSi8t9i8nW9EMmOGBeRDenpOQU24Fj7JalgrNQyOYd4JM2wLzwL
         v2C0lWTUKcmYL+r6RzMA+q2J+/vtilbeE+SH++sQHmDckoL3M4kzMmP1oMDd0nRzbvbu
         yPFg1GLpchw6VjnGWlXZepBalFb5IXU7A7p45z/p7rOhJYhKZVKQCE7gJPXMDLnqcFJ/
         uTRg==
X-Gm-Message-State: AOJu0Yx0NFMUm0TXD+aH432/wdsos4MLTsg70Yp/Ks8iH1+7Ex+/V0u2
	2sehEYzYgSRR5sXrZbuO8xmUyW4gJliaDTj9KOYPjniO87VL2X+j3swRJhodNZ7FEHLKvymk/lc
	CgartWK6XumBJffJus1kJ2BUpx1iCIiZdG49A++Oc+7aodNol1F24FLwvUkYAGaChu0ruNRgHLv
	jk2chzwFWFK6k6JuBTCqOOJJblPt0Idg==
X-Received: from pfll4.prod.google.com ([2002:a05:6a00:1584:b0:827:45df:8f74])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a211:b0:82f:2b0:2809
 with SMTP id d2e1a72fcca58-82f0c25e4f4mr19037522b3a.1.1776196032843; Tue, 14
 Apr 2026 12:47:12 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:46:52 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414194702.1229094-1-praan@google.com>
Subject: [PATCH v6 00/10] iommu/arm-smmu-v3: Implement Runtime/System Sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Pranjal Shrivastava <praan@google.com>
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
around a software gate embedded in the command queue.

1. CMDQ Gate (CMDQ_PROD_STOP_FLAG)
To safely manage runtime PM without regressing performance on high core
count servers or systems not opting for runtime power management, 
this series introduces a CMDQ_PROD_STOP_FLAG (bit 30) in the command 
queue's producer index. The flag acts as a Point of Commitment in the
cmpxchg loop of arm_smmu_cmdq_issue_cmdlist(), ensuring no new indices 
are reserved once suspension begins.

2. Suspend / Resume Flow
The "suspend" operation follows a multi-stage quiesce sequence:
  a. Stop Traffic: Sets SMMUEN=0 and GBPA=Abort to halt new transactions.
  b. Gate CMDQ: Sets the CMDQ_PROD_STOP_FLAG to block new submissions.
  c. Command Flush: Waits for any in-flight "owner" threads to commit 
     their reserved indices to hardware.
  d. HW Drain: Polls the CMDQ until all committed commands are consumed.
  e. SW Quiesce: Waits for all concurrent threads to release the shared
     cmdq->lock, ensuring no CPUs are left polling CONS register.

Entering the suspend sequence implies that the device has no active clients
Any racing command submissions or failure to quiesce at this stage indicates
a bug in the Runtime PM or device link dependencies. Such races should not
happen in practice, which justifies the non-failing nature of the suspend
sequence in favor of memory safety.

The "resume" operation clears the STOP_FLAG & performs a full device 
reset via arm_smmu_device_reset(), which re-initializes the HW using the
SW-copies maintained by the driver and clears all cached configurations.

3. Guarding Hardware Access and Elision
The driver ensures the SMMU is active before hardware access via 
arm_smmu_rpm_get() and arm_smmu_rpm_put() helpers. An 
arm_smmu_rpm_get_if_active() helper is introduced to elide TLB, CFG, and 
ATC invalidations if the SMMU is suspended. For ATC invalidations, 
device links must guarantee the SMMU is active if the endpoint is active; 
a WARN_ON_ONCE() catches inconsistencies. Elision is safe because 
hardware reset on resume invalidates caches, and PCIe device links handle 
power dependencies for ATC.

4. Interrupt Re-config
a. Wired irqs: The series refactors arm_smmu_setup_irqs to allow 
separate installation of handlers, aiding in correct re-initialization.

b. MSIs: The series caches the msi_msg and restores it during resume 
via a new arm_smmu_resume_msis() helper.

c. GERROR: Late-breaking global errors are captured and handled 
immediately after SMMU disablement during suspend to ensure no diagnostic 
information is lost.

Scalability and Performance
===========================
A key design goal of this series is to ensure that high-performance systems 
(typically servers) that do not enable runtime PM are not penalized. By 
embedding a stop flag in the command queue's producer index and designing 
RPM helpers to perform only read-only checks when RPM is disabled, command
submission on these systems incurs negligible overhead. Power-managed 
systems only utilize runtime PM atomics as necessary, ensuring that 
scalability is maintained across all hardware classes.

Call for review
Any insights/comments on the proposed changes are appreciated,
especially regarding the synchronization & elision logic.

[v6]
 - Replaced the atomic nr_cmdq_users counter with CMDQ_PROD_STOP_FLAG
   to eliminate atomic overhead on high-core count servers.
 - Implemented a 5-step quiesce sequence in runtime_suspend including
   pipeline flushes and software completion barriers.
 - Introduced arm_smmu_rpm_get_if_active() to elide TLB/CFG/ATC 
   invalidations when the SMMU is suspended.
 - Added WARN_ON_ONCE() in invalidation paths to detect inconsistent
   power states for active endpoints.
 - Refined batch submission in __arm_smmu_domain_inv_range() to ensure
   clean state when dropping batches.
 - Refactored GERROR handling for better integration with suspend.
 - Added Suggested-by tags for Daniel Mentz.

[v5]
 - https://lore.kernel.org/all/20260126151157.3418145-1-praan@google.com/
 - Refactored GERROR handling into a helper function and invoked it during
   runtime suspend after disabling the SMMU to capture any late-breaking
   gerrors as suggested by Jason.
 - Updated `arm_smmu_page_response` to be power-state aware and drop
   page faults received while suspended.
 - Included a patch from Ashish to correctly restore PROD and CONS
   indices for tegra241-cmdqv after a hardware reset.
 - Collected Reviewed-bys from Mostafa and Nicolin.

[v4]
 - https://lore.kernel.org/all/20251117191433.3360130-1-praan@google.com/
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

Ashish Mhetre (1):
  iommu/tegra241-cmdqv: Restore PROD and CONS after resume

Pranjal Shrivastava (9):
  iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
  iommu/arm-smmu-v3: Add a helper to drain cmd queues
  iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
  iommu/arm-smmu-v3: Cache and restore MSI config
  iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to gate CMDQ submissions
  iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops
  iommu/arm-smmu-v3: Handle gerror during suspend
  iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
  iommu/arm-smmu-v3: Invoke pm_runtime before hw access

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  18 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 449 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  18 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  29 ++
 4 files changed, 485 insertions(+), 29 deletions(-)

-- 
2.54.0.rc0.605.g598a273b03-goog

