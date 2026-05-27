Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574A3C4B64
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920055; cv=none; b=BPJtssUWEtFGJI8DgQ37BKJIVLOsJB2tnN2Ut2qYlztg/ZrtuQy8ifey35vo1dMo90FUdgr/+U0a7u495ySwaOSS+OSjWYMCEzBCegJjlhtD0+3RkImHtFo6Hnmygr65SFRrzULECpXKgoqA/YgEH+uo9ErAFPO7b2VYdGNDF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920055; c=relaxed/simple;
	bh=htyFig9wMwo0lwcQqSEUdaHHDYuVIMhHkl0s70IlR9w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eGhW6ek4sSrDt2QdC3lubz5hSkLojTvYaatLunphx/5hZ40JrnpVKapd3SFkJ2bB3mcrFSDKthOaCiqSMrjBgs7RXWmmfO262alo65mrvUOlrQfAugsKwPsYt/dkTYmpLpiBMswfETzAwfALRi6d3L5pYtCQLI64gjc4MOg6Z64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+z782Gl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+z782Gl"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf0607b5f5so1574855ad.0
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 15:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920052; x=1780524852; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V19fwt3YsG4bFoecIfuC0pYkusNGWcQTO//+HSSI3ng=;
        b=N+z782GlsrKBP3CEHX6ddpUQwdm6uMjW0hfjvfyBWQ91J19Nz62ubk++W4b6cK9ggo
         rBQ/6BhxbBDVvlRPiugk4pXlmS+7ea+r0mXZiAc+mM9x2ZG+jiUOjh9zVxLiISK3JPiJ
         eAXsfNiucXPHX6CWNgyIaFYnGS8D0Vh+i5rdtfejpLswkdNMkEi6LZq7H7ibZsZcgKfz
         XqfQQBKqognDutUwdP1mgf66jZuUotHWolMlrIu2Y7PTGMaKJf/Dv4UaRAQGY/9R+E2U
         +bC5u4ohJW8hQFwfdEO6v30ps7HBACTPyfLiv3SB0jNXCw50tp148kmKKrkihKRVKfRn
         x2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920052; x=1780524852;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V19fwt3YsG4bFoecIfuC0pYkusNGWcQTO//+HSSI3ng=;
        b=eqfqqIIHnDF6KR1bP/cZcpZG2MhO2pe+Y+JAfqv/tOTipb+qhrvLgbtlckOdpCXbvy
         V1QcrZgfs9KBX0xHVVb1FPULhwnHHiq8N+6fYTwzNp0gqkNH/tATL0Fi8vC5jUIMDKH6
         OQXFsf8fG0i0plQd1hp4D3NSiKTVdRBBFmG5MEiJuUEQLqeeL9EiEewpgpap9rPE42aC
         Mi+3GtdTpyW6FXwsmXL2MlkCN1QB6CNh+JU6ojjS0PXI/DmWpSwyZ+rRGvEGN7XhK6Wq
         hiwBrC5V28qytzscPe/fTLEjMuc8C/varu7OQLRrElA4sk8SjmnCblcLERoxCabaa25a
         9vJQ==
X-Gm-Message-State: AOJu0Yy+cSyfC5Xs3V/ps7QOxvHA5MkDxwJYoQRXVL+oiJFM/W4Ryto2
	Ze1bNvTpWSjzgCE7HMnkgo5n9r5iFY3tSLVN2yZ8WTFAn4k5/Wt57d8MO5X7sHs6onDq8UuFsI6
	OJdp9m61/8AEc8pJ5cW4EuEgrd/rLyX5ZQtr8FM50cB3zC8Uogx7Qgieub+Q5RDt+z3TjMgA7EQ
	idvJMLdsPxzzTFnJ5H4TkYC0TZJgIwSw==
X-Received: from plhe2.prod.google.com ([2002:a17:903:1c2:b0:2ae:5d79:a153])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b2c:b0:2b0:60db:7927
 with SMTP id d9443c01a7336-2beb06bc19cmr275487085ad.28.1779920051683; Wed, 27
 May 2026 15:14:11 -0700 (PDT)
Date: Wed, 27 May 2026 22:13:56 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527221407.1756491-1-praan@google.com>
Subject: [PATCH v7 00/11] iommu/arm-smmu-v3: Implement Runtime/System Sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

As arm-smmu-v3 rapidly finds its way into SoCs designed for hand-held
devices, power management capabilities, similar to its predecessors, are
crucial for these applications. This series introduces power management
support for the arm-smmu-v3 driver.

Design
======
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
Any racing command submissions or failure to quiesce at this stage indicate
a bug in the Runtime PM or device link dependencies. Such races should not
happen in practice, which justifies the non-failing nature of the suspend
sequence in favor of memory safety.

The "resume" operation clears the STOP_FLAG & performs a full device 
reset via arm_smmu_device_reset(), which re-initializes the HW using the
SW-copies maintained by the driver and clears all cached configurations.

3. Guarding Hardware Access and Elision
The driver ensures the SMMU is active before hardware access via 
arm_smmu_rpm_get() and arm_smmu_rpm_put() helpers. Commands are elided
if the SMMU is suspended by observing the CMDQ_PROD_STOP_FLAG 
(via arm_smmu_can_elide()). For ATC invalidations, devlinks must 
guarantee the SMMU is active if the endpoint is active, a 
WARN_ON_ONCE() catches inconsistencies. Elision is safe because
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
===============
Any insights/comments on the proposed changes are appreciated,
especially regarding the synchronization & elision logic.

[v7]
 - Rebased on the latest arm/smmu/updates branch (which has the removal of
   struct arm_smmu_cmdq_ent merged)
 - Converted manual cmpxchg loops in suspend/resume to use atomics
 - Re-worked to elide invalidations solely based on the CMDQ_PROD_STOP_FLAG
   via arm_smmu_can_elide(), dropping any need for pm_runtime_get_if_active
 - Added an smp_mb() fence in the reset sequence to ensure that the SMMU 
   acquires all RAM updates made by newly un-gated threads before SMMUEN=1
 - Implemented bitwise masking for the PROD register to prevent software 
   metadata (STOP_FLAG) bits from being written to physical hardware.
 - Introduced a KUnit test suite to verify the CMDQ gating algorithm

[v6]
 - https://lore.kernel.org/all/20260414194702.1229094-1-praan@google.com/
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

Pranjal Shrivastava (10):
  iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
  iommu/arm-smmu-v3: Add a helper to drain cmd queues
  iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
  iommu/arm-smmu-v3: Cache and restore MSI config
  iommu/arm-smmu-v3: Handle gerror during suspend
  iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to gate CMDQ submissions
  iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops
  iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
  iommu/arm-smmu-v3: Invoke pm_runtime before hw access
  iommu/arm-smmu-v3: Add KUnit unit tests for Runtime PM

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  15 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 150 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 445 ++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  27 ++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  29 ++
 5 files changed, 636 insertions(+), 30 deletions(-)

-- 
2.54.0.794.g4f17f83d09-goog
