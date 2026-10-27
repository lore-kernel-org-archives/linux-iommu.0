Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067967;
	b=PbZNnkD9F+xQPEzOsAstFLethatTYIFreF+Xd377YfD7IKQ0SWK8/5j+byI8hNsvHgbw
	 CJfSjCa3hDMProzNp/J/Hm6boGanvTX/AhekU1tqgJOYcOYLuOJLSzxkv8KhdexQST/QF
	 +yqF2yoihlmeXHJVVxeg8qyun0JSq//J1q+AWLVVyaZ7Ux4VbevV9OvPRMXhAJ3y3nv1B
	 6GrCn8QqTq+Hkca5CvkmpOCxU48T4IwFP1rC13yiNXpAk2mVq5QzYrC4nM0z4yywOQaVP
	 o5Ksz8D0QSe4wgRmoKARTRzjEFtifjSy0BrpRFEEYMjgI/qix/xmw323qUSFNJoDDnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067967;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oRhShPPOcteMIklOC32ElFWu5deX0aw4aDjLcQqHn0s=;
	b=1aSZVOtVlXi7A4FEmi4eKzrJxzeT6+t6ZnRxUAfIqJa4KeP+oEpC7KyFxRtpW5CxbTos
	 aUR5LjRMJhlxM0Z2MICA08eSvgB9yyW3c1IneshaHqfmxkH8s5qmMfGwtgatQTc8uGQTX
	 1c3MwaXcUd/V/ieBlvj1dFzTjTTgChSJjzDAHrEHAuvhfiqAy2FU9xbbAZ+LojOJ+9GXE
	 v8kkUCMpWf7SwPTDErgSh58uzDfKuvOYynShEiKli82cKk8qRcFFysE7znvzEZavyuF9J
	 ixbD/sRhf//ENcRmCXLhj3My6J3tCAx0aFLCJ7uWXiWb/piuLcyoKNx19wh1NoJ6pgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1kQRTeX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E7606A31A;
	Tue, 27 Oct 2026 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1kQRTeX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81571F01825;
	Tue, 27 Oct 2026 02:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067967;
	bh=oRhShPPOcteMIklOC32ElFWu5deX0aw4aDjLcQqHn0s=;
	h=From:To:Cc:Subject:Date;
	b=R1kQRTeXc5NVba7ZOeHyJdIykGyfdmHmg91Qk1iPskX5Z0DeaYkGLWo88aSHX7dca
	 AlaNjqhUvP4uc7zSKVXRkB/jg+1llW5FIO6VayIMaFu8f5YTxgPGNcD6EpN3tW4Q7z
	 nPiAsrJucHfHfGYB5bf+sMvbiMnHTviJL9hklyVXoXPxxmtI0VJpFHe3NC0DOM5uhS
	 aeFYZZ1+QWFw2nQDEQf1+QxBpo4EBntftL1EQ/vmINbjURnY0XIa8B7VynbcvVJloL
	 IdCLm4jfMC9qdDOJ0wsCIy6ciW6gFhn3LGyejmrSR8XoPCADtIwsIqLnog2/9mQUgA
	 Gc62zJLgUCH6Q==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: tglx@kernel.org,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	leon@kernel.org,
	mbloch@nvidia.com,
	iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 00/11] dma-mapping: add dma_alloc_attrs_node() and dma_alloc_coherent_node()
Date: Mon, 26 Oct 2026 19:25:17 -0700
Message-ID: <20261027022528.633359-1-kuba@kernel.org>
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
Content-Transfer-Encoding: 8bit

Hi!

I want to add NUMA-awareness to a networking driver (bnxt) and
I run into the inexistence of dma_alloc_coherent_node().

On NUMA systems networking drivers want to allocate rings
and buffers close to the NAPI-handling core rather than
allocating all from where the device is connected.

Looks like we have accumulated 6 drivers which do:

       set_dev_node(dma_dev, numa_node);
       va = dma_alloc_coherent(...);
       set_dev_node(dma_dev, old_node);

IMHO this looks like an ugly hack. Can we add an API
with the Node ID explicitly passed in?


In the unlikely case anyone feels the urgent need to merge
this please pull (so that we can also pull this into net-next):

  git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/dma_alloc_coherent_node

Jakub Kicinski (11):
  dma-contiguous: pass the NUMA node to dma_alloc_contiguous()
  dma-direct: pass the NUMA node to dma_direct_alloc()
  iommu/dma: pass the NUMA node to iommu_dma_alloc()
  dma-mapping: add dma_alloc_attrs_node() and dma_alloc_coherent_node()
  eth: libwx: restore the device's NUMA node after ring allocation
  eth: libwx: use dma_alloc_coherent_node()
  eth: ixgbe: use dma_alloc_coherent_node()
  eth: xgbe: use dma_alloc_coherent_node()
  eth: fungible: use dma_alloc_coherent_node()
  eth: mlx5: use dma_alloc_coherent_node()
  eth: mlx4: use dma_alloc_coherent_node()

 Documentation/core-api/dma-api.rst            | 15 ++++++++
 include/linux/dma-direct.h                    |  2 +-
 include/linux/dma-map-ops.h                   |  5 +--
 include/linux/dma-mapping.h                   | 14 ++++++++
 include/linux/iommu-dma.h                     |  2 +-
 include/linux/mlx4/device.h                   |  2 +-
 include/linux/mlx5/driver.h                   |  2 --
 arch/x86/kernel/amd_gart_64.c                 |  3 +-
 drivers/iommu/dma-iommu.c                     | 30 +++++++++-------
 drivers/net/ethernet/amd/xgbe/xgbe-desc.c     |  6 +---
 .../net/ethernet/fungible/funcore/fun_queue.c |  8 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 ++++-------
 drivers/net/ethernet/mellanox/mlx4/alloc.c    | 12 +++----
 drivers/net/ethernet/mellanox/mlx4/en_cq.c    |  9 ++---
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  5 ++-
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    |  5 ++-
 .../net/ethernet/mellanox/mlx5/core/alloc.c   | 24 ++-----------
 .../net/ethernet/mellanox/mlx5/core/main.c    |  4 ---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 22 +++++-------
 kernel/dma/contiguous.c                       | 12 +++----
 kernel/dma/direct.c                           | 20 ++++++-----
 kernel/dma/mapping.c                          | 34 ++++++++++++++++---
 kernel/dma/ops_helpers.c                      |  5 +--
 24 files changed, 137 insertions(+), 126 deletions(-)

-- 
2.56.0

