Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B13343893
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351154; cv=none; b=fpe5KOicZWQKXDII3VvI3BOJ6otFtAqW5uMtX7FT01T3/62IGxLJv9t7/vZvSktrMeUUGFXnp2XbWfjc3Qg5ka2si8nthd1rPG9v0dbWv6+JiZALBoKZlydFguaUXCGpfp11jPoXYVvNBHWUwdJejh9GHiEGLLJ5jrqwyPsNjgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351154; c=relaxed/simple;
	bh=SPN6EzypIMrz2ok8q1VOq93Kmuk/BRRHU1TEoYkx+Jw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hPQjh0dwK/HGgz6iB8UqWoSgItxh2o+lkwQd5rpCM3dho0cNRLbMCUhVQVCVTo5ELFg9FSivFR3sa1hm6B62bV8g4At8rPrBb6Rd7b/o2AaOQzzY4GKpupLO12aG+ijz5n6/D0ODjzAgNvCdWCSNO88DBgCaok36AAlip276U68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+TNRYVA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+TNRYVA"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8588f55654so1213805a12.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351152; x=1780955952; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CJfSPrWYPo7csu0Tl5vC8XaHGbKwh/8D77eWZzM/mbk=;
        b=q+TNRYVAlDLPcQMMj/S5QaD4xieNo+12BVE/MbwEtwAj/1RHEWGRyiwAhcY6CIH42O
         6VizTd6/Me9XllprHy1SN7zVRlxJrBOH3HXEjuLQeH016hBRXKPhz5NfCj7XWfaNEwm9
         7FPX96QYwr1USDTDeK37pYU5AQJ717iNznPjQwrk255cAWoyh8MmEcGxXu/cYsX4P+38
         TWK1aqlwPS1b9cL5ZkReFe63SlNu8ovHt8cD2TwT5zYjK/nhL5xdG9EyN7RPZdpZk0wD
         hW0wj+xM2lcrPjO0MWDb0SKbGeeVSxbDQNipKenhpnVIgkvIcG67lMvQKJTYku3m+Rax
         Us8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351152; x=1780955952;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJfSPrWYPo7csu0Tl5vC8XaHGbKwh/8D77eWZzM/mbk=;
        b=ZCyyOaHUo72fnH1mI5K4MdJwdTU3K4y/TQ+khyujaWcBAlkPYPqVR8cSWSDj7ckHd7
         ZThXNzF6zIv4WCeTw1ZSif63CslajUbuJ5iWNeH70yQLckKjcTPanREPqUHlR0e6PENK
         rR6uFs0AX08sUATLS8gqYe39Wg4Q8sax4zISE6Dig0kfBg2etkV9RxSbCWAF8DoaGu4O
         Lvg9xgsR0YMrasZnqhRzuSVAS8npNZsitNIszjoKV87Z/BJCVsHo6/1VrR9hL0m3yoTo
         A49xZxvtBWUYefTG48oLPp+vAmR813cV7C40YNfIhKkgLg3pEce5dML7Yd91iDo/zbhU
         /Leg==
X-Gm-Message-State: AOJu0Yzyoo/ioFu7dr2d+jwo+f97wgFjCzwgFYSa2qtWWb9n3ZWLhRUz
	d92b7DRqI97pupsEv1jred1W6ZGH/hCGlxobBfqp5s4LABM3gdN0n+AtU37yrK9P+Mob4AbycQ1
	ub/SGMoyJyI8S5t041fY4cZrXBSSrAE0QJP8FlY+hizfrSc5FcC0Kua1avYxyrS2rrUNnlBjMVB
	hzY2xh7A+qqZYwvtdtwwVkvqLGzSeeEg==
X-Received: from pfoc26.prod.google.com ([2002:aa7:881a:0:b0:83f:645f:b3e2])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b10:b0:842:66f3:c51c
 with SMTP id d2e1a72fcca58-84266f3d609mr2182499b3a.40.1780351151959; Mon, 01
 Jun 2026 14:59:11 -0700 (PDT)
Date: Mon,  1 Jun 2026 21:58:57 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260601215909.3958732-1-praan@google.com>
Subject: [PATCH v8 00/10] iommu/arm-smmu-v3: Implement Runtime/System Sleep ops
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

Entering the suspend sequence implies that the device has no active clients.
In v8, a surgical state-correction is added to runtime_suspend: if draining
fails, the software trackers (cons and owner_prod) are forced to align with
the masked producer index. This voids any stale commands for the next session
and prevents deadlocks or spurious executions upon resumption.

The "resume" operation clears the STOP_FLAG & performs a full device 
reset via arm_smmu_device_reset(), which re-initializes the HW using the
SW-copies maintained by the driver and clears all cached configurations.

3. Guarding Hardware Access and Elision
The driver ensures the SMMU is active before hardware access via 
arm_smmu_rpm_get() and arm_smmu_rpm_put() helpers. To maintain code
clarity, invalidation call-sites no longer perform manual elision checks;
instead, elision is authoritative within the CMDQ submission path.

The renamed helper, arm_smmu_cmdq_can_elide(), is preserved only for 
critical diagnostic (ATC), early-drop (Page Response), and performance
(massive Domain Range) short-circuits. For ATC invalidations, devlinks 
must guarantee the SMMU is active if the endpoint is active, a 
WARN_ON_ONCE() catches inconsistencies.

4. Implementation-Specific Quiescing (Tegra VCMDQ)
In v8, implementation-specific gating and draining are consolidated into
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

[v8]
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

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  10 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 169 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 435 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  27 ++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  57 +++
 5 files changed, 672 insertions(+), 26 deletions(-)

-- 
2.54.0.1013.g208068f2d8-goog

