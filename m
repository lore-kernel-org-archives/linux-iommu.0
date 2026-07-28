Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679504137A3
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272976; cv=none; b=oAefK4de3ymL1tNfrapU8vC2xRAw5E3PlkTNGTKZfy8ddgh2BvP5iihLGsUnVM6wnvCresV+h++GJ89M9mRP6gevZoUsHXIwoKKP5MIki4M5HmBxAj7NDAkPZmP9P2+/ZTxwtWgJouxjVCn1HGSQq8vXPFJzNnR8B7/w4bjBRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272976; c=relaxed/simple;
	bh=32kQ0N4rOkqdcXhqCGDY9YMzikK9IAx647JySMRSGV8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=piWUJCvlv4IpttyAt6dUPKHhBjeRkL9r4VRNcuJ2nAPaiLQC/muY7jgi4T9V3L328aQu6x2irIs5c/Fanqeh/s+oL1lSG5GOL9dJgOwWF1F9b/miy/XydHjRU5VVTyUzoqTkNXOWapDr/myJ7e87lQuxHxxrFRzOUKzg5QdaOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBTi16KZ; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBTi16KZ"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e024d2129so452687b3a.2
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785272974; x=1785877774; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CAdAYAObjlI2OlXyFTHPPp+bDQ+yzkEEVLhx/up3FzI=;
        b=HBTi16KZOtUaaRtpDUMStxgLq8dUo/W1NtvcCHkgPmFTRV4EnFhuk5pG8vqhozjW3X
         ItRwkpvEF9fzh38dTlaPF9p5DDczDZJBVSJMrpnu33RVoJQN8ZMkrbK5u3GhEJSnPRRZ
         h+xQMGX+7GrMzn4brUrMZTHZhNnVmFOMQ77AC8r6ifA4kVbVlFbzhKQZ4EHr4hkGqJ6Z
         T1i6UodhytTy0iMiEHCEyvOaK8lpMvWEUeohKbORovnwP0pyVA8YMa08CE6B9hKordvQ
         maN57Wj99GWK2vLt2wkXqRq4AvpTqOfxKEOXH1RJxYJ+Vjtw4QoGqoNzgVHfIyo4sO8V
         kbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272974; x=1785877774;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CAdAYAObjlI2OlXyFTHPPp+bDQ+yzkEEVLhx/up3FzI=;
        b=o7GpYZJD6BMZguxRjc7u6Lq0rMJkBaxnVmWJr3vGt6EuoUJYdv0+G7sUr34lAmTze9
         1HGOopPD3wensHditB6cwnPm8H0cHdG3Tf21eZl8mNzwPmEkqC28cCwQoa9tQ8Sjnjh2
         EtjgWvnb4LwUZ30p196e0Cc6a/KpyNqe938GWWs1SQoeUlQr3YgQhl1wTdZiKsCiui8V
         z6IHTKmUNZqDDeLNl7p3R26Zyehf+9qs78hTFgJh5tnrlji55huO5jrqNgfXeet2H2x6
         ZjV+1jrh37Q4d0DW0zQCwOtORrhVifHHoGeCuHMyIpW6kiUtKwtthwCCqU+cUeBOzxoB
         GGcQ==
X-Gm-Message-State: AOJu0YzmVLF5SsP8neo0u/bSQABNs0qCtvsQd3Eng+LmYTRB140TkKA/
	GOG3HJm1GULV07DEGhMzrRCqypcF8KbXz7hicplhMSmk70Y1z3mOextOYUeNnwVXfYx/X5C9lNt
	J0c6ecxm+xnQnMhT43aJhzU4gqv0Mob4BAXszKegUesjhN2RUp4ZOqvQ5bgYUEyNF3P3mhOMY1M
	atFHo0JhrybCbJdZmB/OtakmJr/ugIZQ==
X-Received: from pgmr31.prod.google.com ([2002:a63:205f:0:b0:c92:460e:4f73])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1396:b0:845:d284:9e11
 with SMTP id d2e1a72fcca58-84e93356ec3mr4281760b3a.56.1785272973393; Tue, 28
 Jul 2026 14:09:33 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:09:16 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728210928.1050849-1-praan@google.com>
Subject: [PATCH v9 00/12] iommu/arm-smmu-v3: Implement Runtime/System Sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Pranjal Shrivastava <praan@google.com>
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
The suspend operation follows a multi-stage quiesce sequence:
  a. Stop Traffic: Sets SMMUEN=0 and GBPA=Abort to halt new transactions.
  b. Gate CMDQ: Sets the CMDQ_PROD_STOP_FLAG to block new submissions.
  c. Command Flush: Waits for any in-flight "owner" threads to commit 
     their reserved indices to hardware.
  d. SW Quiesce: Waits for all concurrent threads to release the shared
     cmdq->lock, ensuring no CPUs are left polling CONS register.
  e. HW Drain: Polls the CMDQ until all committed commands are consumed.
  f. IRQ Quiesce: Disables hardware IRQs and waits for racing handlers to
     complete via synchronize_irq()

Entering the suspend sequence implies that the device has no active clients.
In v8, a surgical state-correction is added to runtime_suspend: if draining
fails, the software trackers (cons and owner_prod) are forced to align with
the masked producer index. This voids any stale commands for the next session
and prevents deadlocks or spurious executions upon resumption.

The resume operation clears the STOP_FLAG & performs a full device 
reset via arm_smmu_device_reset(), which re-initializes the HW using the
SW-copies maintained by the driver and clears all cached configurations.

3. Guarding Hardware Access and Elision
The driver ensures the SMMU is active before hardware access via 
arm_smmu_rpm_get() and arm_smmu_rpm_put() helpers. To maintain code
clarity, invalidation call-sites no longer perform manual elision checks;
instead, elision is authoritative within the CMDQ submission path.

The renamed helper, arm_smmu_is_active(), is preserved only for 
critical diagnostic (ATC), early-drop (Page Response), and gerror
short-circuits. For ATC invalidations, devlinks must guarantee the SMMU
is active if the endpoint is active, a WARN_ON_ONCE() catches inconsistencies.

4. Implementation-Specific Quiescing (Tegra VCMDQ)
Implementation-specific gating and draining are consolidated into
a unified quiesce_and_drain_queues callback. The tegra241-cmdqv driver
is updated to gate all active local virtual queues (VINTF0) before
draining.

5. Interrupt Re-config
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

[v9]
 - Replaced atomic_fetch_or_relaxed() with atomic_fetch_or() for
   correct ordering while asserting the STOP_FLAG
 - Moved arm_smmu_drain_queues() after the cmdq->lock wait loop in
   runtime_suspend() as per feedback in v8.
 - Refactored suspend sequence to use arm_smmu_disable_irqs() and
   synchronize_irq() for safe GERROR handling.
 - Fixed an off-by-one error in suspend polling timeouts.
 - Dropped arm_smmu_cmdq_can_elide() check from inv_range
 - Renamed arm_smmu_cmdq_can_elide() to arm_smmu_is_active().
 - Removed redundant bitwise masking from owner_prod reads.
 - Added comments to explain locking, gating and elision better.
 - Added comments to explain secondary cmdq draining and gating.
 - Rebased on arm/smmu/updates

[v8]
 - https://lore.kernel.org/all/20260601215909.3958732-1-praan@google.com/
 - Centralized elision logic: dropped redundant checks from invalidation
   call-sites; elision is now authoritative within the CMDQ layer.
 - Renamed elision helper to arm_smmu_cmdq_can_elide() and preserved it
   only for diagnostic/safety paths (ATC, GERROR, Page Response).
 - Consolidated implementation-specific gating and draining into a 
   unified quiesce_and_drain_queues callback.
 - Updated tegra241-cmdqv to gate virtual queues before draining,
   addressing non-deterministic timeouts from guest-side submissions.
 - Re-ordered probe sequence to enable pm_runtime only at the end, 
   aligning with SMMUv2 and simplifying error paths.
 - Refactored KUnit tests for better, addressed Nicolin's comments & added
   a multi-threaded kthread race test.
 - Refactored RPM helpers to use early-return patterns for improved clarity.
 - Collected R-bs from Nicolin.

[v7]
 - https://lore.kernel.org/all/20260527221407.1756491-1-praan@google.com/
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

Pranjal Shrivastava (11):
  iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
  iommu/arm-smmu-v3: Add a helper to drain cmd queues
  iommu/tegra241-cmdqv: Add a helper to drain VCMDQs
  iommu/arm-smmu-v3: Cache and restore MSI config
  iommu/arm-smmu-v3: Handle gerror during suspend
  iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to gate CMDQ submissions
  iommu/tegra241-cmdqv: Add a helper to quiesce VCMDQs
  iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops
  iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
  iommu/arm-smmu-v3: Invoke pm_runtime before hw access
  iommu/arm-smmu-v3: Add KUnit unit tests for Runtime PM

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  20 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 171 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 518 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  27 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  73 +++
 5 files changed, 780 insertions(+), 29 deletions(-)


base-commit: a86c36163c9722545d27e92bdad8418fdcaa8b1d
-- 
2.55.0.487.gaf234c4eb3-goog

