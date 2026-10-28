Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171971;
	b=mAhUx3IdaQwIv6amrmaWMHrwuWRTnlYT/XOIozY71isICALk3hYmJsVbA8F2Qu4xdr/Z
	 hSBUS/o9lRFhtDDU2jleMia20fNUzz9QkPjirEJEkHyPQAKoNPnLKP+iNQAfS8wiplxB2
	 qIzrmHkOZ3QgMoAFmmj257eV7yxWHlwBaqHIUAa899/4T2hWStnFXbMJJmOKz5apN/9pJ
	 e+fR09kfmjsEzHggN2giU/HxfnSGysw1q57wYl1CfeqIFnzemPxPTsj5fgJpXIJe4tyn1
	 ZeIRqvYblcxs9S1szD/0WWfb8aMhSURNqAPSsVD+nu4vzC4vB2O6Ofprc10QaNPSs2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171971;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3aHPVVIPnG9pMc4aDDsCeUp5qbD59uz8wrHrN0OpuoI=;
	b=bMl7GhrmQRmEphcIkRbQKTH8RG5VVoD4Alejs55N5Irytk3/cpM+QhaiHIKmJpnv7xVS
	 fnL4FZQoSe7BEhzclgByawINBqQPIJ/W2Dc/RTOXJC8i4Emty3MAA5Cgu24NJRtsTCHyU
	 0UaMbwEOF0mvyxP7a2ZS1co8QC9juyJHy87GMl0ModtOB9lO2p7kYeG1R6garjoYOlZiW
	 Kqi7lUSUzaq+czJf9PBI8WwrQ+iJ7X5yOUkRjWEhhw9vM/QMuJvYVE3gTxdlXy5dGbbLm
	 tgyDSZKo3GpiJGi06eXHpcbOqN5vKgF1Vc7Ya+IuFG/qgfI3rJSEusIYH9i9+fj27Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PkGNY52B;
	arc=none smtp.remote-ip=115.124.30.131
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D94606A33A
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 07:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83D94606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PkGNY52B
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793171960; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3aHPVVIPnG9pMc4aDDsCeUp5qbD59uz8wrHrN0OpuoI=;
	b=PkGNY52BGukqTvBIrNUcQqHdxoniKl2Nwc25fTEIxLsEP6/Y0ui9n1hjoS4hPw7Ddv6MD4KtWwCP+LdtX7jQseo1De1PKXMO7471qKwIOOmTxT8WeneX3QR26W1mtBYmikvDR2qCuzxEWV0sHZyaCsjLCj+LUe9XdC0LCkcQkvo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDg7jeH_1793171946;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XDg7jeH_1793171946 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 15:19:19 +0800
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
Subject: [PATCH v5 0/3] iommufd: Recommended reservations query and opt-in IOAS reservation
Date: Wed, 28 Oct 2026 15:19:03 +0800
Message-ID: <20261028071906.2325378-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261027183418.GJ1685504@ziepe.ca>
References: <20261027183418.GJ1685504@ziepe.ca>
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

v4: https://lore.kernel.org/all/20261025133000.205508-1-guanghuifeng@linux.alibaba.com/
v3: https://lore.kernel.org/all/20261004162213.3787623-1-guanghuifeng@linux.alibaba.com/
v2: https://lore.kernel.org/all/20260921103922.1113752-1-guanghuifeng@linux.alibaba.com/
v1: https://lore.kernel.org/all/20260921070234.897736-1-guanghuifeng@linux.alibaba.com/

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
 drivers/iommu/iommufd/ioas.c            | 49 +++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  2 +
 drivers/iommu/iommufd/main.c            |  7 +++
 include/uapi/linux/iommufd.h            | 71 +++++++++++++++++++++++++
 9 files changed, 267 insertions(+), 10 deletions(-)

-- 
2.43.7

