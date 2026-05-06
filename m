Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6D480DF0
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079972; cv=none; b=ZH4VStL8pdG5E6VaU9OiWa1u6xAPRohlhCqAjoDYVF/aHElj6ZTdhYl4a3jGxl4tDu59AI30DXn6bDETbLh3oJKN3ImsLvGokEQbaqCiJIKWMk9DcXrj4PYNcKRO/j6MPOGQPn/a7CTyXASyoQ1m61shI39/m8WlGQ6CL2v/PE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079972; c=relaxed/simple;
	bh=QFXa6YRuzF4t4fYVJg/6kH/sPOukM5S6trX2NukRuU4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CY9Y5MrF6Qe1hvR19zGdmixf0QN7aiYu9KNNWWHBAOcp7tUHWa5HA7yvaK6lcW5GEFXu5fH6dI8RWXlv+efUAoKrVODGVsoG+LnKIH5vHvO/myWUCPDdrpVFctRUYCeSz8DKoYy8wQAHLGsq4Z9SwXHcF93PkGG/t2nM+bD9794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=c4k41bCU; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="c4k41bCU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1778079971; x=1809615971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pJ+mAEF4gTcPP0yuCSSDawXZa9YmtM/8CnfSXl8auwE=;
  b=c4k41bCU/0Y2+4SXGFyKJpO2XvKznIjHpHlW40SZ9lGNYXC+Rzr5mgc7
   wR+V2sR4Or+j3aIPD+hX506e3YO5d0msQHXD/ae2NIvj7FkXDsDVYm06Y
   16ocBy9jMVZvPUGXYaNlDLZfD8iZW0iDXBk5jAhKhCKgvkaf861fCth8n
   PBcOLqGofekn9ZO8A95iUEN5Fw2Mpim6MFWpBZsa/UMgAJZ91KpCnV/U4
   81lFx4M3qeJoH/WSkBJ3r7AFbEhSZieeHYkibL9grmYgF0ETZ6r0bAGls
   F2aRy76nAh7fXvKkO8UGVF6pbEQhqRfVhCqNWSiHeFRkjbX/Y0Fn3BFls
   Q==;
X-CSE-ConnectionGUID: dt5nDv35SXyZ1iFPxgXUFg==
X-CSE-MsgGUID: Zd0vJ0ZHQEm13B6RV4d+Ew==
X-IronPort-AV: E=Sophos;i="6.23,219,1770595200"; 
   d="scan'208";a="18889457"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 15:06:08 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:9321]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.224:2525] with esmtp (Farcaster)
 id 2731fe09-c9e6-4f50-91f1-2a35684e3a18; Wed, 6 May 2026 15:06:08 +0000 (UTC)
X-Farcaster-Flow-ID: 2731fe09-c9e6-4f50-91f1-2a35684e3a18
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 6 May 2026 15:06:07 +0000
Received: from dev-dsk-yigitogu-1a-d17f6574.eu-west-1.amazon.com
 (172.19.100.7) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 6 May 2026
 15:06:05 +0000
From: Yigit Oguz <yigitogu@amazon.de>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<suravee.suthikulpanit@amd.com>
CC: <jgg@ziepe.ca>, <nicolinc@nvidia.com>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Yigit Oguz" <yigitogu@amazon.de>
Subject: [PATCH 0/3] iommu: Add PCI vendor:device ID to IOMMU fault logs
Date: Wed, 6 May 2026 15:05:36 +0000
Message-ID: <20260506150541.60467-1-yigitogu@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

IOMMU fault and event logs currently identify devices using only their
PCI segment/bus/device/function (SSSS:BB:DD.F). While mapping a single
BDF to a device type is straightforward, doing so at scale across many
hosts and thousands of fault events requires additional tooling and
manual cross-referencing. Including the vendor:device ID directly in
the log line makes each event self-contained and immediately actionable
without any post-processing.

This series adds vendor:device ID (VVVV:DDDD) to IOMMU event logs for
ARM SMMUv3, Intel VT-d and AMD IOMMU.

Before:
  arm-smmu-v3 arm-smmu-v3.0.auto: event: F_TRANSLATION client: 0000:2b:11.6
    sid: 0x158e ssid: 0x0 iova: 0x280000000000 ipa: 0x0
  DMAR: [DMA Write NO_PASID] Request device [86:00.0] fault addr 0xe0000000
    [fault reason 0x05] PTE Write access is not set
  AMD-Vi: Event logged [IO_PAGE_FAULT device=0000:41:00.0 domain=0x000a
    address=0xe0000000 flags=0x0020]

After:
  arm-smmu-v3 arm-smmu-v3.0.auto: event: F_TRANSLATION client: 0000:2b:11.6 [8086:1533]
    sid: 0x158e ssid: 0x0 iova: 0x280000000000 ipa: 0x0
  DMAR: [DMA Write NO_PASID] Request device [0000:86:00.0 8086:1533] fault addr 0xe0000000
    [fault reason 0x05] PTE Write access is not set
  AMD-Vi: Event logged [IO_PAGE_FAULT device=0000:41:00.0 8086:1533 domain=0x000a
    address=0xe0000000 flags=0x0020]

Patch 1 adds vendor:device ID to ARM SMMUv3 translation fault logs.
Patch 2 adds PCI segment and vendor:device ID to Intel VT-d DMAR
        fault logs.
Patch 3 adds a devid_str helper and vendor:device ID to all AMD IOMMU
        event log paths.

Testing:
Build-tested against mainline Linux (torvalds/master).

Runtime-tested on a custom downstream branch on ARM SMMUv3, Intel VT-d and
AMD IOMMU hosts. Translation faults were induced in a virtualized setup
by removing DMA mappings for an in-use region, causing the assigned device's
subsequent DMA transactions to hit unmapped IOVAs and produce
translation fault events. The resulting log lines were verified to
contain the PCI vendor:device ID on all three platforms.

Lilit Janpoladyan (1):
  iommu/arm-smmu-v3: Print PCI vendor:device ID in SMMU translation
    fault logs

Yigit Oguz (2):
  iommu/vt-d: Add PCI segment and vendor:device ID to DMAR fault logs
  iommu/amd: Add vendor:device ID to AMD IOMMU event logs

 drivers/iommu/amd/iommu.c                   | 94 +++++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 ++++++-
 drivers/iommu/intel/dmar.c                  | 33 +++++---
 3 files changed, 104 insertions(+), 52 deletions(-)

-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

