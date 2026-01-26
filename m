Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59538252900
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440324; cv=none; b=r9gGfmrXXc91rsyLCJyrOqufq6tCMlAk6bjwPwLRbJ+6N5u8gA3xuz/4gFpmFVJmbhsOaTvanfojUnPcmY7GXNPaofY78zmfWUBKwphwOr5cWZBy4HET3/g9m7mhYfFnRzlYwWwfakDjOmjEtNrwlQoqO9lRwkeAlAkRyUt4eUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440324; c=relaxed/simple;
	bh=aC8vGR4idp61Vjo1itXdN1B4Z8IgZh5JU1X2FMRWiGQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LhtNF4oTUGKVaMQVOa2aqmBJ6sy2pXZxisepb+IT/nWwziZ7DxMQFEyj1GHyZgYkyhCddFZZa5yEPSCgVXCgqtkxZFmccAZd2XSHMSNJOELuDwsgAj23QGHBiY6oXqFrvlLAtJON34aZZHZN4INmq9HcAuMZN+XuyetVGYwfyjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DAsuYHFG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAsuYHFG"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bce224720d8so2562528a12.1
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 07:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769440323; x=1770045123; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fKWXOYDJMDZd4E282EkXCZPleEOgWva/5KVxxk/+aD4=;
        b=DAsuYHFGRkU74Nt2ZemKqeBam17H58etzIR6+Jck42k7TVUxgrSlFF80J6D4aQPvTo
         v8HED0TfakrIb3DPyz9fCnYh9HKHWNzNUyezJetvcxGL2x4VFrX2UMoH2jrGAC0/6duQ
         Gs2TQn5edR0w5xwcefHd+1cgPZ1eqHdM+eWqpf49bQSOSrNOKIb//cMnhuYpgd5cB+td
         Q24SIT/DrkToq9JiG89ubamioiFm5/wiqQt4f2MOk9yBvRVn2D3EvOmYqQsgcPXpvDFi
         COy3MgqYBFsBsVmlpUFBxiME4+Jrv9vfJ4aM7FfoKs1ma58uBz/dyJcqbhncLRIwMGaM
         ukeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769440323; x=1770045123;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKWXOYDJMDZd4E282EkXCZPleEOgWva/5KVxxk/+aD4=;
        b=ooqml2sOtagWd1DyK02CdOY5gwYXuLyUOBFm0ihHfug+h2VK81V8fldZA/wqX2+1wa
         qyNp+Os5ixafor2rVBWcj7Qp/eVCQa+dWb3KZjIUgA3/7l8mKlcguW4Kcb+YErn0T9lk
         k418/2C7sycp81QiADEIMS+ZV9OVMDNzDwcX0rCNC2L+RwE7gARz9tuNwShsGZCkOwaz
         6O8Cf6lJzspRuaBol+y7KiT0ckbxsuVyw0w+IS06DiXW5jf2VqbkQvri/FpOXli95/5e
         o77mvNDAEtCpXuhdcoJhxEWrGIYz61/CygzSCLqc/dIokctIn4VFvFPt0p8bAbJXeqwv
         xOhA==
X-Gm-Message-State: AOJu0YyoZ/vDo8KRGkFCYCMQscl+TTo0iE1buJ5KJ+foKX+P/nKa1MVJ
	eaQ8US5NG8UwenOLYhFqmU+HyKz2bMdtfJeaZ7oCR0eVP/q3vFUGcAG8FD7iKv0idtJf3EX9/jf
	r89sO8gbEqbVBZmlD9SnBFbRUKj13dKyr1AcpkdLVFomRgH9MGFRYpaLQHoJftgqG/uGHZtYHyg
	tswa1GRM1nS8lPH99ITDm5eTfjoqhJ5Q==
X-Received: from pjlm13.prod.google.com ([2002:a17:90a:7f8d:b0:34c:2f52:23aa])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e70b:b0:34a:b4a2:f0bf
 with SMTP id 98e67ed59e1d1-353c40fa5famr3841672a91.16.1769440322492; Mon, 26
 Jan 2026 07:12:02 -0800 (PST)
Date: Mon, 26 Jan 2026 15:11:47 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126151157.3418145-1-praan@google.com>
Subject: [PATCH v5 00/10] iommu/arm-smmu-v3: Implement Runtime/System Sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
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
re-configures the *_IRQ_CFGn registers by writing back the cached msi_msg.

Call for review
Any insights/comments on the proposed changes are appreciated,
especially in areas related to locking, atomic contexts, and potential
optimizations.

Note: The series isn't tested with MSIs and is weakly tested for PCIe
clients. The same holds true for tegra241_cmdv changes. Any help in
reviewing and testing these parts is much appreciated.

[v5]
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
  iommu/arm-smmu-v3: Add a usage counter for cmdq
  iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops
  iommu/arm-smmu-v3: Handle gerror during suspend
  iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
  iommu/arm-smmu-v3: Invoke pm_runtime before hw access

 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  10 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 429 ++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  13 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  29 ++
 4 files changed, 445 insertions(+), 36 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog

