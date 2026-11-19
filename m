Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072170;
	b=OFscERHQ6TlzNYhHV68C+kT90ndb8HuIsxCxPSY0zPJmqYU10xwLL0cA5n6LnfzGsbva
	 5ngoj5mStQV9syKrKg5YoPD39HqXrWPIhBYX8EasJ+nF4gBhxTHJkE2EboLpFpLUNw6B1
	 6ylbckbBCgspuA+P/R92WoIp9Z3F9YvjEjnHP7rFR3zR6v7QZW7OWlOpNf81mszaAsKch
	 l6KhinokE9q+tewizFeZpElbWTL+fYNy9tWqn9ihwVDoFGvpjFqYAg+GBDCUvK8XjrenR
	 wPj/YOv8jQjTRnzoaxlQ5bSLXaAoKBweTrkA6J1yBWmpUEyu4UGSrnSK6mPvyUUXvcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072170;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GI/EJYAO2f2q4uohtMP3CSKMcRVSkK/beZWUfhj380w=;
	b=pIR+2bGG+an1GLQseKa9NIeXSq8WjcZo8RHNn3+iMU1IrhMYYT7cy/986VB4WvID0wjD
	 zkGs7PsW0GoDx7G30FZ0beLIR0HHTH6RfHVUTAqVgdMvoUKJaPxh3z9AFLfXmFWQzJTv1
	 sosVFBnxdl9Yp9oKf5fVXzsPgxT8PlsBwvWQzFJ1xadOJzPmi8LSss/P+Q8cffPwSrdrk
	 g4EzBHUGzKN670hTw0WKoqxyrTPC5HNQgBDowdBQcnPmIGHU+Ojc+4QxBQg23olqQUJPB
	 dKVNplPltF+pBNkDQ8/RJ9Sq+yw93NfQOGsHGCNulYJktvmklrmPnHyOqoEowfeZf6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NOnmUuvC;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4C606A332
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 07:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06C4C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NOnmUuvC
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795072160; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GI/EJYAO2f2q4uohtMP3CSKMcRVSkK/beZWUfhj380w=;
	b=NOnmUuvC5o0EaFOSdcPAPhkpClvJvCrREE70rjlgvpuKwI9KMH6vNvjq57uMbBMkQVeid+Pk2HhnVqlzb5tyHAg4zGjno9E/yyKvE/R/5cvilPc+Fbr344Du1GyKLYQz42UIGGh1nZfaqkd6bpUJh3ybzmrMJm10qpcqwunkLwU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XF2mQ2V_1795072145;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XF2mQ2V_1795072145 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 15:09:19 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@nvidia.com
Cc: alex@shazbot.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: [PATCH v7 0/3] iommufd: Recommended reservations query and opt-in IOAS reservation
Date: Thu, 19 Nov 2026 15:09:02 +0800
Message-ID: <20261119070905.1336240-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <179502940167.3851267.4719665473088413793.b4-review@b4>
References: <179502940167.3851267.4719665473088413793.b4-review@b4>
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

v6: https://lore.kernel.org/all/20261028090453.2392991-1-guanghuifeng@linux.alibaba.com/
v5: https://lore.kernel.org/all/20261028071906.2325378-1-guanghuifeng@linux.alibaba.com/
v4: https://lore.kernel.org/all/20261025133000.205508-1-guanghuifeng@linux.alibaba.com/
v3: https://lore.kernel.org/all/20261004162213.3787623-1-guanghuifeng@linux.alibaba.com/
v2: https://lore.kernel.org/all/20260921103922.1113752-1-guanghuifeng@linux.alibaba.com/
v1: https://lore.kernel.org/all/20260921070234.897736-1-guanghuifeng@linux.alibaba.com/

Changes since v6:
- Patch 3: use > ULONG_MAX instead of >= ULONG_MAX for the range
  bounds check.  struct iommu_iova_range is an inclusive [start, last]
  interval and ULONG_MAX is a valid upper bound (iopt_table_add_domain()
  reserves up to ULONG_MAX), so >= wrongly rejected ranges ending at
  ULONG_MAX.  Per Jason's review of v6.

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

The suggested removal of the now-redundant IOMMU_TEST_OP_ADD_RESERVED
selftest op (switching the selftests to IOMMU_IOAS_RESERVE_IOVAS for
coverage) will follow as a separate patch.

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

