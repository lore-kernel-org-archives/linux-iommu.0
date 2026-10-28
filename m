Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178312;
	b=1DqCZnagfmqQQ/UburhSNHcbRtlpxU0Vx2nI+ZpzJgN7u8DL7C2hM9GjzRzYb0in8owI
	 1xKCcIzUVUC/mnWPVJGAixpJW+Wx6p2bXSr+0mQU34t8CJOeJ+MqAS93l/7FJvhiD8XE/
	 jP9Bz+z4VbNfPKJhmMJWJ3Gc167KUfmcS7sU5o24/hAEpzlwjr7PzFfGT4QrjCpciy1ek
	 umDsYmTez4Ue/sa3OcMEReoj/om5mATaJGdIkZm0KGerRKlKPFT5ZIXUXEAZcBHfTh6il
	 Pd2t6WBWbCIsuTpq0pU5CnBGq6SSHGpRcHGmfw2Pr3RVw5wJDqyKxx+WSIjv7ZANBHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178312;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VPrzUUX1/AgRAC3MboR4XO4tTZdV+G2Yhgi5aZTSkos=;
	b=0AyBYLooT3BjD5LxTyILTu4swhQCvioHAUvCAummiEJIyWzJelLNY99SIxFoHqAMYM+e
	 tOWaJHoJHCahLDwZ5HFkVzbFLHwwLqbKU432aBUKJ+gXXc881Ipa5Dll2588331UUGScv
	 NBIoVNeytKkcQkqEfBUMSNqHMjX9IUo6FweKvg9QyaQExo7BIcPhuIVE6z4Z/4BCx9n8Y
	 n85kaIo3Ba/cfdWIWuEgphe6TKtG6kDZ79YPUx6bI8szb6QW5EdomJah51LY+/e92nxPS
	 t/AQr80zdl4oxX+h5C7w9RWznr2aNb8FWAFhbh3+Mu6qSSr9kQvxn0DlFYbka31e14g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QP9LbBiO;
	arc=none smtp.remote-ip=115.124.30.131
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCB606A331
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 09:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BCCB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QP9LbBiO
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793178307; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VPrzUUX1/AgRAC3MboR4XO4tTZdV+G2Yhgi5aZTSkos=;
	b=QP9LbBiOZ4rsJgyxQ3TvGTYFhXBvgIMIms/zEZe1yy8sPEiDK+AL/zPJH0p8aPra5JnSvXwwj0q7uVh6y0RBCk8w5lmyiRypwl20dPiqG1oSlo+qkJD1LTrEFrH7zcKB1M19Z1/1scATxsneV3DiXKMXG/SK3nPk/P/Lk44QAg8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDgOu9a_1793178293;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XDgOu9a_1793178293 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 17:05:06 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: alex@shazbot.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: [PATCH v6 0/3] iommufd: Recommended reservations query and opt-in IOAS reservation
Date: Wed, 28 Oct 2026 17:04:50 +0800
Message-ID: <20261028090453.2392991-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261028071906.2325378-1-guanghuifeng@linux.alibaba.com>
References: <20261028071906.2325378-1-guanghuifeng@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets userspace learn which IOVA ranges the kernel
recommends avoiding for a device, and optionally feed them back so
the IOAS allocator enforces them.

The motivating case is a PCI device behind a PCIe switch: DMA using
IOVAs that fall inside the host bridge MMIO windows may be misrouted
as peer-to-peer traffic instead of reaching the root complex for IOMMU
translation.  The DMA IOVA layer already avoids these windows
internally, but passthrough userspace had no way to learn about them.
Per commit cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back into dma specific path.")
this information must not be forced through the IOMMU reserved-region
API, so the series is fully opt-in:

  Patch 1 adds iommu_for_each_pci_mmio_window(), a callback-based
  iterator in the IOMMU core, and refactors dma-iommu.c to share it.

  Patch 2 adds IOMMU_GET_RECOMMENDED_RESERVATIONS, a per-device query
  returning recommended ranges (currently PCI host bridge MMIO
  windows) as struct iommu_iova_range entries.  Advisory only.

  Patch 3 adds IOMMU_IOAS_RESERVE_IOVAS, letting userspace send
  chosen ranges back in to restrict the IOAS allocator: reserved
  ranges disappear from IOMMU_IOAS_IOVA_RANGES and are rejected by
  mapping.  Overlapping reservations are permitted, so the same
  ranges recommended for several devices behind one host bridge can
  each be reserved independently.

Typical flow: bind device -> query recommendations -> reserve chosen
ranges -> map.  Userspace that ignores the new ioctls sees no
behaviour change.

[1] https://lore.kernel.org/all/20260921115513.GK11599@ziepe.ca/
[2] https://lore.kernel.org/all/20261027182947.GI1685504@ziepe.ca/
[3] https://lore.kernel.org/all/20261027183418.GJ1685504@ziepe.ca/

v5: https://lore.kernel.org/all/20261028071906.2325378-1-guanghuifeng@linux.alibaba.com/
v4: https://lore.kernel.org/all/20261025133000.205508-1-guanghuifeng@linux.alibaba.com/
v3: https://lore.kernel.org/all/20261004162213.3787623-1-guanghuifeng@linux.alibaba.com/
v2: https://lore.kernel.org/all/20260921103922.1113752-1-guanghuifeng@linux.alibaba.com/
v1: https://lore.kernel.org/all/20260921070234.897736-1-guanghuifeng@linux.alibaba.com/

Changes since v5:
- Patch 3: reject ranges with start or last >= ULONG_MAX with
  -EOVERFLOW, matching the existing checks in IOMMU_IOAS_MAP/UNMAP/
  COPY; on 32-bit kernels such ranges would be silently truncated
  when passed to iopt_reserve_iova(), and a wrapped pair could even
  insert an inverted node into the reserved interval tree (reported
  by the Sashiko AI review of v5).
- Patch 3: drop the iommufd_ucmd_respond() call - all fields of
  struct iommu_ioas_reserve_iovas are inputs and the handler never
  modifies them, matching iommufd_ioas_allow_iovas() which also
  returns directly (reported by the Sashiko AI review of v5).

Changes since v4 (all per Jason's review [2][3]):
- Patch 1: drop the single-pointer wrapper struct in dma-iommu.c and
  pass the iova_domain directly as callback data.
- Patch 1: drop the typedef kdoc and trim the iterator kdoc to the
  essential description.
- Patch 1: WARN_ON(!bridge) instead of a silent check; inline the
  start/end temporaries.
- Patch 2: reuse struct iommu_iova_range instead of adding a new
  per-window struct.
- Patch 2: rename away from PCI-specific naming: the interface is now
  IOMMU_GET_RECOMMENDED_RESERVATIONS reporting recommended reserved
  regions, with PCI host bridge MMIO windows as the first source.
- Patch 3 (new): add IOMMU_IOAS_RESERVE_IOVAS so userspace can send
  the ranges back in to create a restriction for the allocator, as
  requested in [3].  The NULL-owner cleanup in iopt_destroy_table()
  is no longer conditional on CONFIG_IOMMUFD_TEST since production
  userspace can now create such reservations.

Changes since v3:
- Helper redesigned as a callback iterator shared with dma-iommu.c
  (v4 changes).

Changes since v2:
- Redesign from forced reservation to opt-in query (v3 changes).

Guanghui Feng (3):
  iommu: Add iommu_for_each_pci_mmio_window() iterator
  iommufd: Add IOMMU_GET_RECOMMENDED_RESERVATIONS ioctl
  iommufd: Add IOMMU_IOAS_RESERVE_IOVAS ioctl

 drivers/iommu/dma-iommu.c               | 22 +++++---
 drivers/iommu/iommu-priv.h              | 17 ++++++
 drivers/iommu/iommu.c                   | 37 +++++++++++++
 drivers/iommu/iommufd/device.c          | 65 ++++++++++++++++++++++
 drivers/iommu/iommufd/io_pagetable.c    |  7 ++-
 drivers/iommu/iommufd/ioas.c            | 51 +++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  2 +
 drivers/iommu/iommufd/main.c            |  7 +++
 include/uapi/linux/iommufd.h            | 73 +++++++++++++++++++++++++
 9 files changed, 271 insertions(+), 10 deletions(-)

-- 
2.43.7

