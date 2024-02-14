Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69775FF17
	for <iommu@lists.linux.dev>; Wed, 14 Feb 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927764; cv=none; b=R/asI2hdzp+W+h2HyPpuagFYSdZz3Z/NkIeNjvW9xYbRKafuZBnsBAgXrktCM7YJKwZEIqWMbzh/v/oR+pjtHSx6v99foukCHyUIGH4ohTJGSY9S2uUcuSBoLRz4vXkE5/Y8eDOY2lTKeVYfC36FogVsqPdrfQpQHyjxdXm/cQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927764; c=relaxed/simple;
	bh=/p1Alr34TjW78H6O+WCKsMe1YvlhwfLn1wdHdogT8+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oqq69lBoI73beqmSlrFWt4sRq+SXgJEmEVnPAQ19aYPITuAZf9WFuFx/QjfptNYreVyxqdos6s0pIJSB5R0IPfkJMFwAS6tsDQMeVtHVrrbZ2uhUEMue4y0ENu9IFOM108S5FM41OMhqUPKRJ3q9B1Hh3UxpoF7bbQkt9eeYds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=feep2AjH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feep2AjH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707927762; x=1739463762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/p1Alr34TjW78H6O+WCKsMe1YvlhwfLn1wdHdogT8+A=;
  b=feep2AjH+KRXfJD5z1uqxI2GAUrDs08/K3n1KWn5dY3WonqeBlGUlrvx
   jKG8qYEXtteV5BMfm89yKGA5dutJDOfJPABRoD4F1ys3gt8C2mpZV3chL
   TqCDIc8mHwLZ19qePg+Lj+DqFgYHypNZaTht371rLT9w1FvQiQG6WrXPD
   h35yPm1mmhuAGtZZkiQKWwVdR0uY2AZEYA0u6guAXSlwJmMH072je9wIr
   Ndv9fcVGnSYj0resdnCDzssW0oKN0jpUSp1vvlwNBLgpypyLYReeRRCdf
   aHtmTOHoCQK4umfJRUygX5Hd0BwmhcJLkQBcLnLtf1P0nKrywMDgs1sTQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5755528"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="5755528"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 08:22:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="26399956"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 14 Feb 2024 08:22:38 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/7] dma: skip calling no-op sync ops when possible
Date: Wed, 14 Feb 2024 17:21:54 +0100
Message-ID: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series grew from Eric's idea and patch at [0]. The idea of using the
shortcut for direct DMA as well belongs to Chris.

When an architecture doesn't need DMA synchronization and the buffer is
not an SWIOTLB buffer, most of times the kernel and the drivers end up
calling DMA sync operations for nothing.
Even when DMA is direct, this involves a good non-inline call ladder and
eats a bunch of CPU time. With IOMMU, this results in calling indirect
calls on hotpath just to check what is already known and return.
XSk is been using a custom shortcut for that for quite some time.
I recently wanted to introduce a similar one for Page Pool. Let's combine
all this into one generic shortcut, which would cover all DMA sync ops
and all types of DMA (direct, IOMMU, ...).

* #1 adds stub inlines to be able to skip DMA sync ops or even compile
     them out when not needed.
* #2 adds the generic shortcut and enables it for direct DMA.
* #3 adds ability to skip DMA syncs behind an IOMMU.
* #4-5 are just cleanups for Page Pool to avoid merge conflicts in future.
* #6 checks for the shortcut as early as possible in the Page Pool code to
     make sure no cycles wasted.
* #7 replaces XSk's shortcut with the generic one.

On 100G NIC, the result is +3-5% for direct DMA and +10-11% for IOMMU.
As a bonus, XSk core now allows batched buffer allocations for IOMMU
setups.
If the shortcut is not available on some system, there should be no
visible performance regressions.

[0] https://lore.kernel.org/netdev/20221115182841.2640176-1-edumazet@google.com

Alexander Lobakin (7):
  dma: compile-out DMA sync op calls when not used
  dma: avoid redundant calls for sync operations
  iommu/dma: avoid expensive indirect calls for sync operations
  page_pool: make sure frag API fields don't span between cachelines
  page_pool: don't use driver-set flags field directly
  page_pool: check for DMA sync shortcut earlier
  xsk: use generic DMA sync shortcut instead of a custom one

 kernel/dma/Kconfig                            |  4 +
 include/net/page_pool/types.h                 | 21 ++++-
 include/linux/device.h                        |  5 ++
 include/linux/dma-map-ops.h                   | 21 +++++
 include/linux/dma-mapping.h                   | 84 ++++++++++++++++---
 include/net/xdp_sock_drv.h                    |  7 +-
 include/net/xsk_buff_pool.h                   | 13 +--
 drivers/base/dd.c                             |  2 +
 drivers/iommu/dma-iommu.c                     |  3 +-
 drivers/net/ethernet/engleder/tsnep_main.c    |  2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-xsk.c  |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  2 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |  2 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  2 +-
 drivers/net/ethernet/netronome/nfp/nfd3/xsk.c |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +-
 kernel/dma/mapping.c                          | 59 ++++++++++---
 kernel/dma/swiotlb.c                          |  8 ++
 net/core/page_pool.c                          | 67 +++++++++------
 net/xdp/xsk_buff_pool.c                       | 29 +------
 23 files changed, 239 insertions(+), 106 deletions(-)

---
From v2[1]:
* #1:
  * use two tabs for indenting multi-line function prototypes (Chris);
* #2:
  * make shortcut clearing function generic and move it out of the
    SWIOTLB code (Chris);
  * remove dma_set_skip_sync(): use direct assignment during the initial
    setup, not used anywhere else (Chris);
  * commitmsg: remove "NIC" and the workaround paragraph (Chris).

From v1[2]:
* #1:
  * use static inlines instead of macros (Chris);
  * move CONFIG_DMA_NEED_SYNC check into dma_skip_sync() (Robin);
* #2:
  * use a new dma_map_ops flag instead of new callback, assume the same
    conditions as for direct DMA are enough (Petr, Robin);
  * add more code comments to make sure the whole idea and path are
    clear (Petr, Robin, Chris);
* #2, #3: correct the Git tags and the authorship a bit.

Not addressed in v2:
* #1:
  * dma_sync_*range_*() are still wrapped, as some subsystems may want
    to call the underscored versions directly (e.g. Page Pool);
* #2:
  * the new dev->dma_skip_sync bit is still preferred over checking for
    READ_ONCE(dev->dma_uses_io_tlb) + dev_is_dma_coherent() on hotpath
    as a faster solution.

[1] https://lore.kernel.org/netdev/20240205110426.764393-1-aleksander.lobakin@intel.com
[2] https://lore.kernel.org/netdev/20240126135456.704351-1-aleksander.lobakin@intel.com
-- 
2.43.0

