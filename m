Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065E47CA62
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131540; cv=none; b=MDWpYflxl3fclN0Xzgv2BatWHfWNdmVLP5X7zy+K50XJR+VIDLV7oyqCvsz7+80vj6PLHWZo1+peIpuMa0aCx2R5SPawD7hZoKDc3Dvje4iCmNJIwBbynI1haGZOQ7tYQVGwJCW+QvhOadaBP0QZYyc0HEbF4dndGJE/f2fuL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131540; c=relaxed/simple;
	bh=CuyMTV2toefKFBu22fflUqCz/Qh7DGVjuBXqnSnFCQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sXHWKgIGsZUk1VA60Xs9oxaWKznw7d3hvT1UbFJ7ueYPvWr5+05tePA679TfufGIEnSFRIP1V1uK1rgjZogb8JYtKTJ/J57PzKiairIQaodpDsDe2UcP+rlM9ErriofCKJZwKjDk10VGurI+HETfS8KrXwL/TpdF9znjj45FarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=BxtHeBRZ; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="BxtHeBRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789131522; x=1820667522;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zyLeE2j4JM9qN3t73F4gnb9yLZClmnJFub7Nlabs4hs=;
  b=BxtHeBRZl92ROaRVFAitbHxgaCE9OeP/3xuHKN9KLjNxqRihKEK2hNCm
   en5We7ul22MMZej1Wjg2/JnUc1G5DKUFvXBWUn+ulRfTESQdmzJnBKfEM
   ewEXBC7jjIyxMo6oldot2HXO+S+3SzWz3RWDq4REgVov/R8hr2t+K1VrS
   PomGirAxGgkpaJmtdTPp3mviAylPmQvBdUYm/NDmrEZngRkT5z6/rKCjj
   RD2aCa2ZXCOpHM6Y1u2PAPYrvrd1ynyXY4XWbFB0p0Z+o+T/wD01AGb46
   fe0+E3VSs5Tm4VnqFQ4AGwPq4zTNmxraEx3/ZhCtfPsiScy4NNriLOQi+
   A==;
X-CSE-ConnectionGUID: Bo5p7fyHTp2YUvV/ByIykA==
X-CSE-MsgGUID: xQfQhnVIQpO07KtGrIrJtw==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="27926022"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:58:38 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:15362]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 9bdc87fd-5149-4492-992c-52ea92ac8b52; Fri, 11 Sep 2026 12:58:38 +0000 (UTC)
X-Farcaster-Flow-ID: 9bdc87fd-5149-4492-992c-52ea92ac8b52
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:58:37 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:58:36 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 0/3] iommu: Reduce iommu_probe_device_lock contention
Date: Fri, 11 Sep 2026 14:58:31 +0200
Message-ID: <20260911-vfopt-s2-v1-0-fff3db7e01c2@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

iommu_probe_device_lock is a file-scope mutex held across
__iommu_probe_device(): every device's IOMMU probe serializes against
every other. With "PCI/IOV: Initialize virtual functions in
parallel" [1] fanning an SR-IOV enable across CPUs, it collects 94.7%
of all lock wait. Patch 1 gathers per-member sysfs publication into one
all-or-nothing helper (no functional change); patches 2-3 move that
publication and first-device default-domain setup into per-group
finalisation after the global unlock, under group->mutex, mirroring the
removal path and bus_iommu_probe().

Lock statistics and SR-IOV init time for 4x PF (NVMe, 255 VFs each), on
the reproducer from the parallel VF initialization cover letter [1]:

  lock_stat:
  Lock                     wait: Before     After   contentions: Before   After
  iommu_probe_device_lock      25507 ms  10471 ms                  1143     841
  &root->kernfs_rwsem            942 ms   1834 ms                 93208  116316
  &vfio.group_lock               425 ms   3614 ms                   497     736

  avg wait per acquisition  6.3 ms -> 2.6 ms (4080 acq., both arms)

  Stage                 SR-IOV init time:
  S0 (baseline)         3027 ms
  S1                     999 ms
  S2 (this series)       995 ms

Reproducer disclaimer:
I lean primarily on lock_stat numbers to defend the improvements. In
the reproducer, this lock's residual hold dominates the window and
masks the later series' wall-time gains, more in [1].

This is relief, not removal: the lock still has the highest wait
time in the profile after this series. Wait per acquisition drops
from 6.3 ms to 2.6 ms, which is what makes the smaller
serialization points behind it measurable for the later series.

RFC on the direction: The comment in __iommu_probe_device() expects
the lock to narrow to device_lock() once the ACPI/OF replay calls
are cleaned up. I could not make that work for the whole section:
group formation in ops->device_group() is a cross-device decision a
per-device lock cannot order. This series instead moves the work
that needs no global ordering out of the section. Is that an
acceptable step, or is there a scoping or removal plan this should
wait for?

A second question: I have measured where 90% of the residual hold goes:
get_pci_alias_group() walks every PCI device in the system to find
same-bus DMA aliases. It runs once per device probed, so once per VF,
under this lock, and the VFs keep growing the list it walks. A prototype
that skips the walk when no device has a dma_alias_mask and this device
has no pci_real_dma_dev() override cuts this lock's hold time by about
90%, for the same acquisitions and the same groups. I am not proposing
it here, as I do not have the time to get it right this cycle. How can
we optimize this preferably in O(1) time?

The lock_stat and timing figures come from the public reproducer. The
full series has also been tested on current datacenter server hardware
with thousands of VFs.

[1] https://lore.kernel.org/r/20260911-vfopt-s1-v1-0-693271dc0226@amazon.de

Pavol Sakac (3):
  iommu: split sysfs link publication out of iommu_group_alloc_device()
  iommu: create device sysfs links outside iommu_probe_device_lock
  iommu: set up the default domain outside iommu_probe_device_lock

 drivers/iommu/iommu.c | 197 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 160 insertions(+), 37 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.47.3

