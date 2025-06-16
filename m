Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487DBA42
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105933; cv=none; b=fGelLNX+QL2jX/lJG9OPrRz/15YIqBhCH2dSIbNcg/+YqzlxEPezfz3q+ij4tMemLUh3s9fql1w11SeZyF9YgbHN3OPw/D1MV1/9b559ryXaeszgRPbVy5XIwA6u9GdMdrlUOcwG1ioaHb3hQ70CXAdn+58PC8LthiZzFWgVQ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105933; c=relaxed/simple;
	bh=OvpIphP+QvyB1tmiyJddwNfp0yaqPPRhi5H6RcM+Zgk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qc0AqErY1uSxM6XTkWokPM3Q+64I56e279C4ufVsYn5wmVUKug+1SUOGzEvQmRvXwCD9tUIUc5s9lh3FPSxKP/1UNWm3JhusVBZgF/fCnQK5Ii9TcARgj6rduANEH36oZ/atsYhqDl566tWZaNE+7m66GP88LmYt6ylrAlADXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LqYNKXzj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LqYNKXzj"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b00e4358a34so3071235a12.0
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750105930; x=1750710730; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DJQ5LYhXy80jclBEe7vFc+4jTtDtRCz1gB+PcU69ULY=;
        b=LqYNKXzjKTsIuM63LDv+SuoWOVaxod7X4Z6QxcvVGFjp5o++4Xdu/Nu6iU069T2OQ8
         I51238i7d91cyzDZylSEJORd7IzD9UZ70O7vUO81D5R1jEgUHQxBlNF2ZnfoRTu4QcqA
         RNJNCWfGDwl75bofVZnExFRX2cfNBq10mKw3KqrKc6FEJQNRt/lQuFhk2WdSAiA8A9Mm
         FQo9cCVxOXgmLq9Diyp9FSBJ+vJ63E5IU4N9gAZy3LLzk6iZ9i0sdzPIpWDIX6d4gZak
         BZb1TU7ZQPaAC7dDjrgDjo+2P+X8w7g7e8gChIb86B77Yt7BD+bl15dXrH1t5xXuxhL8
         lE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750105930; x=1750710730;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJQ5LYhXy80jclBEe7vFc+4jTtDtRCz1gB+PcU69ULY=;
        b=ESiTAmh5LPWcMbkWRBfNFRKeJGZrc6NfbJO0EvUf2+SXCtUhEU1SxbiEUENeMlsgld
         oU933US8JqhQtxP4uE8AwsqJMvTRq1otmc3ca6w8h0ck1m9FkL9c0ee8BZigpWXbDtq8
         KCXEJqz2H3W3NweMugqpQnrCsWpfC/tvhsRKYE+2xMEVYJmJmqO75SNma/udt8iZn3Dy
         tEmiodVC8/LnRfrReihsRQJXQ5gt+6XHo9EipeqmMbkAz0DVuGlnDiCcV/H4CLTXQJKe
         EdSIUG20vaiyel2Jsq++oEjuE2gmwU7256wnvseBot/NYw7L6s/jSzwcLG8CHMpotvO1
         3srA==
X-Forwarded-Encrypted: i=1; AJvYcCW4H8qX6qGpYyggezrsYdCLdYJ77HryDLGWp9x+ABICWA5OWb3RLoCfIeur7bpOTyXg94k7DQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+5ZMOTPrxpK1p4/1L6paUudkqy4+d3HmmUAS7A9Do6zXQhRKv
	V4ghrQtM0RATzDLjoiuhRRScaYQVLOg90u8oFoaiUHBZSVm4qze93uOR8Mr53wzONB7tUaFjV1y
	SIQ==
X-Google-Smtp-Source: AGHT+IFpH/jmq3cPutaT+WuKR4tNfZQM7edVFqCO47/XLmIYHaLLs+7xvJCPaE0D0qmxvfOP+UafdHptbA==
X-Received: from pflr18.prod.google.com ([2002:aa7:9892:0:b0:746:270f:79c0])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e1a:b0:740:b372:be5
 with SMTP id d2e1a72fcca58-7489ce45fe5mr12758821b3a.9.1750105929914; Mon, 16
 Jun 2025 13:32:09 -0700 (PDT)
Date: Mon, 16 Jun 2025 20:31:41 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250616203149.2649118-1-praan@google.com>
Subject: [RFC PATCH v3 0/8] iommu/arm-smmu-v3: Implement Runtime/System Sleep ops
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
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
The idea for the "suspend" op is to wait till the cmd queues are flushed
before disabling the SMMU through CR0. Note that waiting for the other 
queues like the event queue and PRI queue is not required in this
version as by design their bottom-halves hold a pm reference ensuring
that if the suspend callback is invoked, both the queues have been
drained. In order to avoid mis-use or spurious transactions 
(b/w SMMU disable -> power-down), the GBPA register is configured to
abort all transactions.

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

3. Eliding TLBIs and CFGIs
The existing pm_runtime helpers like pm_runtime_get_if_active() and
pm_runtime_get_if_in_use(), are too strict for certain use cases. They
fail if the device is in a transient state like RPM_SUSPENDING, which
can lead to drivers making incorrect assumptions about the dev's state.

These helpers don't suffice for cases where one wishes to elide HW TLB
invalidations if the device is powered off. As discussed in the previous
versions, it is wasteful to wake up the SMMU just to issue a TLBI since
we anyway clear the TLBs and Config cache on resume. The existing APIs
like pm_runtime_get_if_active or pm_runtime_get_if_in_use fail to help
us acheive this. Consider the following sequence of operations:

a. The SMMU is in `RPM_SUSPENDING` state
b. The SMMU driver calls pm_runtime_get_if_active/in_use
c. Depending on these API, the driver elides a HW clean-up op like:

if (pm_runtime_get_if_in_active(dev))
	invalidate_tlb(dev);
else
	// Skip flush, assuming device will fully suspend

d. Now, a client wakes up, causing the SMMU's state to bounce from
   RPM_SUSPENDING to RPM_ACTIVE without invoking any rpm callbacks
   preventing the resume callback from clearing all TLBs.

e. The SMMU continues operate with stale TLB entries.

In order to avoid the above situation, this series introduces a new
helper function, pm_runtime_get_if_not_suspended(), The new APU, 
pm_runtime_get_if_not_suspended() increments the device's runtime 
PM reference only if it's rpm state is NOT RPM_SUSPENDED and it cancels
any pending autosuspend timers. This allows us to reliably clear TLBs or
Config cache if the SMMU is NOT suspended, ensuring correct operation.

4. Invoking runtime_pm_get/put
Given that most of the configuration done by arm-smmu-v3 is stored in
memory, the idea in this version of the series is to elide all TLBIs and
CFGIs if the SMMU is suspended and only go ahead with ATC invalidations.

Thus, for most calls, the SMMU driver would make the required changes to
the in-memory data structures, but elide all TLBIs, CFGIs and prefetches
This is done by introducing another runtime PM helper based on the newly
introduced pm_runtime_get_if_not_suspended.

Only places where the driver does a pm_runtime_resume_and_get is where
touching the HW is unavoidable and important commands like ATC_INV and
other commands resuming stalled transactions.

Future Work / Potential Improvements
Ensuring a pm reference is held for user-space controlled IOMMUs.
As per a discussion with Will off-list, it was decided to remove the
additional code for tracking user-owned IOMMUs / insecure attachments
from the driver.

Call for review
Any insights/comments on the proposed changes are appreciated,
especially in areas related to locking, atomic contexts, early resume, 
PCIe-related considerations etc. or any other potential optimizations.

Note: The series isn't tested with MSIs and weakly tested for PCIe
clients. The same holds true for tegra241_cmdv changes. Any help in
reviewing and testing these parts is much appreciated.

Changelog:

[v3]
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
  pm: runtime: Introduce pm_runtime_get_if_not_suspended()
  iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops
  iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
  iommu/arm-smmu-v3: Invoke pm_runtime before hw access

 drivers/base/power/runtime.c                  |  41 ++
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  11 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 378 ++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   9 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    |  27 ++
 include/linux/pm_runtime.h                    |   5 +
 6 files changed, 438 insertions(+), 33 deletions(-)

-- 
2.50.0.rc2.692.g299adb8693-goog

