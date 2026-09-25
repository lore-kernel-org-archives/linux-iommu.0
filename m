Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D4F2BD00C
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 01:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790298795; cv=none; b=K+P31p6Q1pIz9mJ4m9gijo5UXDYM99c24RyNHkcNRD+NzoQ/Lu4gZQspGGjEmeracRJiigMP25cFAvAJZZ1QI+HJRTSG6b2ajzassWQZZmHvV6N4c8gazTDwA93fN3us82wXqyJ7PyHsw7pn+/iBAgOE4PuVKvvY3cLAA9TqWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790298795; c=relaxed/simple;
	bh=ydHVmHAKNkaOnIlJSUsYXWaXXQdhyvqp4w2fbF0dsdM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dpDIxEh7DFvig4bNqeSLucqaOhGHP0aRMv4BYwnF4k4XuQEucrQr9flPEvJdsVWxdhzl7ILXurX1f0fYEe+GrWfYuw/pZn5aFj9FxiXDys7h8WM+m/A0pagxE9atPWr1u1h+124ZnU9NhbGnVR+T6fWhAbAR7pscYc6igM8QtJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDydb+9N; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDydb+9N"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc52c77089bso382145a12.3
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 18:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790298792; x=1790903592; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tsGiZAY40ILBDkcC5GrUE+7G9t9ArWuC4UK+LzuL0LU=;
        b=oDydb+9Nm5dnwFyJC4iBM/lhhvgwhrcTeS4u7wcNpQZhmqtmnOVoUOel/RDLOE7kfc
         rPuUu7gbXZtPJGKnJ1NBfaBxTVVMIYt4hK7+pqzCFTMMsubkfGLWWewxOYnsyLdxQgpd
         sXvW3WfeBtwRACJd+j01hXpT0yngQFMOLOFl4EFioR0+BMHZ3QDAiT6SS/Ky41mFmFQh
         TJikMMDfC7wys6wFt4FLpQ2u+Z2/DqL46SZfzPfvvpjFLkMZ94TXeiLlwZWf7P+3Zfpe
         C3XI4ivzWkacDTNNkwMED80r5lPTDm95VQMDzff4DiKKn146uhDOdfJFQcM1EYxLmzmz
         g+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790298792; x=1790903592;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsGiZAY40ILBDkcC5GrUE+7G9t9ArWuC4UK+LzuL0LU=;
        b=2ZF5v+/cUmmpJ920mREI5gDGcHfndD1400/FlX0WKAgCdEqNybjnlk4UVXUTAm+uVi
         mefUptuoHR1PWRuw2HTklpyX+dBRG+0w1AVXsTOXHs0oyzZkr1kXAcbRfQZQHoxkkY8z
         eJWybEDjH5nTBTxugSjFCpIcfQQF9VAfMMpuWteiY40Bf/woQPJDY0rUSB+CCP6VWALX
         +W352HWP/Yb9E0hDRbesiB3e52oWO9dC6ci1oZcTGvASCEQ6hfTWG0jKc14I/hjbArSV
         au3A0W0wl0EFJU3R29nfEXyYPO+emG4ukaNEFCADwBYv/IKPSB2O2hcmedCDAXXoXt2f
         kYdA==
X-Forwarded-Encrypted: i=1; AKwUvBzy1ATWvxYJ3IzzEg4WpuFKGn0jwi+rzq8cbV18vni2WyCZ6QPA6yxJHxB2XqJvt6U6MartYA==@lists.linux.dev
X-Gm-Message-State: AFuF++liNevYbzuvO5n3sYFUNyylatrbgI2Kv3yLEnnT15AfHaOA4vnX
	MI6mQGkdB+vRfbwwdS/5KbSSw+j5R0sPTWVeRrzABO6T468uIkxJJFrBjU6sY0LLLa9EZcsta/G
	offV05Fu5uP3oEA==
X-Received: from pgbfq7.prod.google.com ([2002:a05:6a02:2987:b0:cc4:b1e4:46a3])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4329:b0:3d2:5eb3:596 with SMTP id adf61e73a8af0-3de0e73d6cfmr3866075637.16.1790298791917;
 Thu, 24 Sep 2026 18:13:11 -0700 (PDT)
Date: Fri, 25 Sep 2026 01:13:04 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925011308.3381953-1-skhawaja@google.com>
Subject: [RFC PATCH 0/3] iommu/arm-smmu-v3: Add support for hitless replace of
 CD entries
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series adds support for replacing IOMMU domains with S1 page
tables hitlessly, that is without disrupting the ongoing DMAs. This is
one of the dependencies of the Liveupdate IOMMU support for Arm SMMUv3.

S1 domains are programmed by CD entries in the CD table. During a new
domain attach these are updated using arm_smmu_write_cd_entry(). Since
ASID and TTB0 are in different 64-bit words, arm_smmu_write_cd_entry()
considers it a non-hitless update and sets V=0. This means such an
update is disruptive and would generate translation faults if there are
ongoing DMAs.

Replace the CD entries by using an unused temporary ASID in the
following sequence to allow hitless replacement of CD entry,

- Update the CD entry with temporary ASID.
- Update the CD entry with the target TTB0.
- Invalidate the temporary ASID.
- Update the CD entry with target ASID.
- Invalidate and release the temporary ASID.

The series adds a vfio selftest that triggers a continuous DMA and does
the hwpt replace while the DMA is ongoing. Since domain replacement is a
race with the translation requests, the test does it multiple times to
capture the small window where IOMMU faults can occur.

Without this change we can observe the SMMU faults in the kernel logs
and with it the SMMU faults do not occur.

This is only tested on qemu with the emulated SMMUv3 and an out of tree
NVMe vfio selftest driver, not on real hardware. Following are not
covered and can be done later,

- S2 domains have the same problem, S2VMID is in STE qword 2 and S2TTB is
  in qword 3. These need the same handling with a temporary VMID.
- ATS is not tested, the test environment runs with pci=noats.

Testing:

Without Fix:

  TAP version 13
  1..2
  # Starting 2 tests from 2 test cases.
  #  RUN           vfio_iommufd_replace_hwpt_test.domain_replace.memcpy ...
  [   33.267749] vfio-pci 0000:00:0a.0: enabling device (0000 -> 0002)
  [   33.270709] vfio-pci 0000:00:0a.0: resetting
  [   33.385682] vfio-pci 0000:00:0a.0: reset done
  [   37.128021] arm-smmu-v3 9050000.smmuv3: event 0x0a received:
  [   37.131885] arm-smmu-v3 9050000.smmuv3:      0x000000500000000a
  [   37.134585] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
  [   37.136961] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
  [   37.139631] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
  [   37.142188] arm-smmu-v3 9050000.smmuv3: event: C_BAD_CD client: 0000:00:0a.0 sid: 0x50 ssid: 0x0

  ...
  ...

With Fix:

  TAP version 13
  1..2
  # Starting 2 tests from 2 test cases.
  #  RUN           vfio_iommufd_replace_hwpt_test.domain_replace.memcpy ...
  [   33.418253] vfio-pci 0000:00:0a.0: enabling device (0000 -> 0002)
  [   33.421218] vfio-pci 0000:00:0a.0: resetting
  [   33.539750] vfio-pci 0000:00:0a.0: reset done
  #            OK  vfio_iommufd_replace_hwpt_test.domain_replace.memcpy
  ok 1 vfio_iommufd_replace_hwpt_test.domain_replace.memcpy
  #  RUN           vfio_iommufd_replace_hwpt_test.noreplace.memcpy ...
  [   88.416453] vfio-pci 0000:00:0a.0: resetting
  [   88.531989] vfio-pci 0000:00:0a.0: reset done
  #            OK  vfio_iommufd_replace_hwpt_test.noreplace.memcpy
  ok 2 vfio_iommufd_replace_hwpt_test.noreplace.memcpy

Looking forward to your feedback on this.

Dependencies:
The patch series includes a patch from the vfio selftest multi iommu
series as it is required for the hwpt_replace vfio selftest. It is part
of this series since the original code doesn't apply cleanly on the
base.
https://lore.kernel.org/all/20260505221518.619123-1-skhawaja@google.com/

Related Work:
Liveupdate IOMMU patch series:
https://lore.kernel.org/all/20260921004834.2601285-1-skhawaja@google.com/
Liveupdate IOMMU feature patchset breakdown:
https://docs.google.com/document/d/1enDn-uPE9U77U-xHEnzn6HHGKiePSAtMIP8EDU3NO0M

Samiullah Khawaja (3):
  vfio: selftests: Add support of creating iommus from iommufd
  vfio: selftests: Add iommufd hwpt replace test
  iommu/arm-smmu-v3: Add support for hitless replace of S1 domains

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  66 ++++++-
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/lib/include/libvfio/iommu.h          |   2 +
 .../lib/include/libvfio/vfio_pci_device.h     |   2 +
 tools/testing/selftests/vfio/lib/iommu.c      |  60 +++++-
 .../selftests/vfio/lib/vfio_pci_device.c      |  25 ++-
 .../vfio/vfio_iommufd_hwpt_replace_test.c     | 171 ++++++++++++++++++
 7 files changed, 316 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_hwpt_replace_test.c


base-commit: 3d7783543c2646af69ad65825e810060494bea21
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

