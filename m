Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990686;
	b=FcdDj07wRICE/4fUlBwfHWUGd/zTFkdgjxkeuxy/ts9aN5SgtotEDh/TbfK0z/+/F/aa
	 ZjHCmkF92mJrvIDJ7bJAvxtG5VZETCr4ai1Fk3z3XNC5yXSkLYlAPLoO3EVlXhB23qXhF
	 gGcggWxt4iUzGvn2qtMdE0BkVGivhzpRkNc9fav7kxRcdrz961Nb2GdpXg6f4i+SbWZxU
	 mQm1mT05PPBDHRc9Dg5OWv6PWXUfZmNwgtjlW9EHobl+CnkYeZ8XbKbuI4z5qt8dDIhhd
	 CIgJtqZIc2TwZWjx3bdQfKqlPo0vHPsrhn8C+qLUP9gRqm81DCOTW/pp1Lsb+srg0HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990686;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OMcIjs1WgTeVdAIKvt1/vm65nh/B3WUmvDyrX849LgY=;
	b=yzjo1Vhh+bfCPonxHO9kg3dtIM9CsOhOW4D7YB77Ig053Itra7AjuF/oYBsxqDujDBRD
	 RSVKAQ64QOVMc4Bx4pHc7pAqV8exm9FJN3GAR4lW2iihs1FwY05g2Qlm4A6mnZzV/P3n+
	 mU0UPXuSInVMM/zGmOywsemixS0GTMgM+B8wWD9n9eL872Rdms+Pip/wXnOdtizhnvMC8
	 Fqd8en1GA7znE6c+5qZWip/yf08Iseh5WNirMWDNQTqNUwfm2lQhXrw6ThexKmm6XnDrI
	 GO75BLfZeQg5wD7XkiTdyRyZOu73tQxolFkmIYG++tRdn5f0gLWG6j901ldzpQ4lHhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuEFNuBt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A7606A329;
	Fri,  6 Nov 2026 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuEFNuBt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF471F0089F;
	Fri,  6 Nov 2026 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990686;
	bh=OMcIjs1WgTeVdAIKvt1/vm65nh/B3WUmvDyrX849LgY=;
	h=From:To:Cc:Subject:Date;
	b=BuEFNuBtyipalUXO6X9JkI42E7uDqsbdlwBzHPxkVkfxINMm90vmL8ncHxL/ImaSu
	 C3LTDdVNNsekQXrwQuZXcuSHvfvuQjsOYWYX7rJC6IXyTPfeCiw64O6YMNPvpZ8LFx
	 lLTRiZMV5sNJtCkvBvGJJW2CI06bPt6KOs3t8NFxkT7TzYtTJyraBRtb1WvL5x2JF+
	 hUm4c8Rs1996Dxg9+K9IjcrQQllkbODkT5pTILBxJ/BSZWlsEFZnHVFtEL5koLYezK
	 +T2hVxvuDyr1MHV8qHY5ilLszSe3NG4NImNjWfNpOxPuhrVPxHxKdnGmfM7VTW6Xko
	 osa7RiXoVfhhw==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 00/11] dma-mapping: add dma_alloc_attrs_node() and dma_alloc_coherent_node()
Date: Fri,  6 Nov 2026 10:44:22 -0800
Message-ID: <20261106184433.761422-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

On NUMA systems networking drivers want to allocate rings
and buffers close to the NAPI-handling core rather than
allocating all from where the device is connected.

Looks like we have accumulated 6 drivers which do:

       set_dev_node(dma_dev, numa_node);
       va = dma_alloc_coherent(...);
       set_dev_node(dma_dev, old_node);

Introduce dma_alloc_coherent_node() so that such racy
hacks are no longer necessary.

Note that making dma_map_ops->alloc() callbacks explicit-node-aware
is left for future work.

Stable tag on top of v7.4-rc1, so that we can also pull this into
the networking tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/dma_alloc_coherent_node

v1:
 - add the API first, then wire up the node in dma-direct, iommu-dma
   and CMA (Robin)
 - add dma_direct_alloc_node() and keep dma_direct_alloc() as a wrapper,
   swiotlb-xen uses it as its ->alloc (fixes the build on arm/arm64),
   arch/x86 no longer needs changes
 - docs: drop the NUMA_NO_NODE suggestion from dma-api.rst (Björn)
 - docs: document that CMA does not fall back to other nodes' areas (Björn)
 - docs: document which allocations ignore the node
 - explain the separate GPL-only export in the commit message (Marek)
rfc: https://lore.kernel.org/20261027022528.633359-1-kuba@kernel.org

Jakub Kicinski (11):
  dma-mapping: add dma_alloc_attrs_node() and dma_alloc_coherent_node()
  dma-direct: add dma_direct_alloc_node()
  iommu/dma: pass the NUMA node to iommu_dma_alloc()
  dma-contiguous: pass the NUMA node to dma_alloc_contiguous()
  eth: libwx: restore the device's NUMA node after ring allocation
  eth: libwx: use dma_alloc_coherent_node()
  eth: ixgbe: use dma_alloc_coherent_node()
  eth: xgbe: use dma_alloc_coherent_node()
  eth: fungible: use dma_alloc_coherent_node()
  eth: mlx5: use dma_alloc_coherent_node()
  eth: mlx4: use dma_alloc_coherent_node()

 Documentation/core-api/dma-api.rst            | 17 ++++++++
 include/linux/dma-direct.h                    | 11 ++++-
 include/linux/dma-map-ops.h                   |  5 ++-
 include/linux/dma-mapping.h                   | 14 +++++++
 include/linux/iommu-dma.h                     |  2 +-
 include/linux/mlx4/device.h                   |  2 +-
 include/linux/mlx5/driver.h                   |  2 -
 drivers/iommu/dma-iommu.c                     | 30 ++++++++------
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c     |  6 +--
 .../net/ethernet/fungible/funcore/fun_queue.c |  8 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 +++-------
 drivers/net/ethernet/mellanox/mlx4/alloc.c    | 12 +++---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c    |  9 +----
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  5 +--
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    |  5 +--
 .../net/ethernet/mellanox/mlx5/core/alloc.c   | 24 ++---------
 .../net/ethernet/mellanox/mlx5/core/main.c    |  4 --
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 22 ++++------
 kernel/dma/contiguous.c                       | 12 +++---
 kernel/dma/direct.c                           | 22 +++++-----
 kernel/dma/mapping.c                          | 40 +++++++++++++++++--
 kernel/dma/ops_helpers.c                      |  5 ++-
 23 files changed, 152 insertions(+), 127 deletions(-)

-- 
2.56.0

