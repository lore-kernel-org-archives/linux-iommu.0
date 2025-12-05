Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097121C16E
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764944553; cv=none; b=O9EttA2+LTAxVdXkXct+pa3ck9yJWYPbFbmwoZGZKi/P14+j/iSDgE0LlR8L/4wZvoNTuNDdHEXVhinrapuEExtsnAi8WhM7riBNAp5rOK+sOto4eYDi9acM4dtREKDVSh7rsJfnFgxSBQRVXQSe3GMextd/OpmrAv1sbIzXsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764944553; c=relaxed/simple;
	bh=HFsGcFoFwsAheAGObibFbcTIYKr7GW7+pOtQ2stGPyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=B7BclKbkJgTs3Rh+2ZhV83K3wkoazzKto0NZHSzjjKEure5/UgjkYmMsrl1HOKzCaNC0RPhrBp6IA3KLgue8okliiKygen2DmEOFn7bH9ICC4fcOUZZjywjqDCXV9OIhngMLFeNdW1ynG/oIlMG03tWJWqm/9et69SXatJMUOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Okta2BWO; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Okta2BWO"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251205142228euoutp01eaafeac667c39ea2f3f640531e3c651d~_V7c3v6ux2643426434euoutp01Y
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 14:22:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251205142228euoutp01eaafeac667c39ea2f3f640531e3c651d~_V7c3v6ux2643426434euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764944548;
	bh=Bf/qqi4FMQaMoXDfofztqb8qbd72Hr5aFWbNZYxdK88=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Okta2BWO+ftCkTyK23kQag43ImB4mA2DLcplQBEkRjZVAljBHZynv7pC4OWXrPloe
	 GdIkgXclwVxXTe2jD6YQ85/jrbGp8Nqj0MExJYeNfVFiOY+ZSkhV+4JEOdAL4h33LD
	 bvQI4rZvIvIHst1VSUCSbOz5F8QfcE7JEN9+NQUw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251205142228eucas1p1aab883d1f97c36be48751b7cdc40985c~_V7cgKvhb2370423704eucas1p1s;
	Fri,  5 Dec 2025 14:22:28 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251205142227eusmtip19739347c8222b07e7ea01fb0a9615a92~_V7cE1Bcy3107631076eusmtip1D;
	Fri,  5 Dec 2025 14:22:27 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
	<m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy
	<robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Qinxin Xia <xiaqinxin@huawei.com>
Subject: [GIT PULL] dma-mapping updates for Linux 6.19
Date: Fri,  5 Dec 2025 15:22:11 +0100
Message-Id: <20251205142211.1639096-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251205142228eucas1p1aab883d1f97c36be48751b7cdc40985c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251205142228eucas1p1aab883d1f97c36be48751b7cdc40985c
X-EPHeader: CA
X-CMS-RootMailID: 20251205142228eucas1p1aab883d1f97c36be48751b7cdc40985c
References: <CGME20251205142228eucas1p1aab883d1f97c36be48751b7cdc40985c@eucas1p1.samsung.com>

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/dma-mapping-6.19-2025-12-05

for you to fetch changes up to 131971f67e258170c678fe572fda95f8cef88e66:

  dma-mapping: remove unused map_page callback (2025-10-29 10:27:31 +0100)

----------------------------------------------------------------
dma-mapping updates for Linux 6.19:

- next part of DMA mapping API refactoring to physical addresses as the primary
interface instead of page+offset parameters; this time dma_map_ops callbacks
are converted to physical addresses, what in turn results also in some
simplification of architecture specific code (Leon Romanovsky and Jason
Gunthorpe)
- clarify that dma_map_benchmark is not a kernel self-test, but standalone
tool (Qinxin Xia)

----------------------------------------------------------------
Leon Romanovsky (14):
      dma-mapping: prepare dma_map_ops to conversion to physical address
      dma-mapping: convert dummy ops to physical address mapping
      ARM: dma-mapping: Reduce struct page exposure in arch_sync_dma*()
      ARM: dma-mapping: Switch to physical address mapping callbacks
      xen: swiotlb: Switch to physical address mapping callbacks
      dma-mapping: remove unused mapping resource callbacks
      alpha: Convert mapping routine to rely on physical address
      MIPS/jazzdma: Provide physical address directly
      parisc: Convert DMA map_page to map_phys interface
      powerpc: Convert to physical address DMA mapping
      sparc: Use physical address DMA mapping
      x86: Use physical address for DMA mapping
      xen: swiotlb: Convert mapping routine to rely on physical address
      dma-mapping: remove unused map_page callback

Qinxin Xia (2):
      dma-mapping: benchmark: Restore padding to ensure uABI remained consistent
      tools/dma: move dma_map_benchmark from selftests to tools/dma

 arch/alpha/kernel/pci_iommu.c                      |  48 +++---
 arch/arm/mm/dma-mapping.c                          | 180 ++++++---------------
 arch/mips/jazz/jazzdma.c                           |  20 ++-
 arch/powerpc/include/asm/iommu.h                   |   8 +-
 arch/powerpc/kernel/dma-iommu.c                    |  22 ++-
 arch/powerpc/kernel/iommu.c                        |  14 +-
 arch/powerpc/platforms/ps3/system-bus.c            |  33 ++--
 arch/powerpc/platforms/pseries/ibmebus.c           |  15 +-
 arch/powerpc/platforms/pseries/vio.c               |  21 +--
 arch/sparc/kernel/iommu.c                          |  30 ++--
 arch/sparc/kernel/pci_sun4v.c                      |  31 ++--
 arch/sparc/mm/io-unit.c                            |  38 ++---
 arch/sparc/mm/iommu.c                              |  46 +++---
 arch/x86/kernel/amd_gart_64.c                      |  19 +--
 drivers/parisc/ccio-dma.c                          |  54 ++++---
 drivers/parisc/iommu-helpers.h                     |  10 +-
 drivers/parisc/sba_iommu.c                         |  54 +++----
 drivers/xen/grant-dma-ops.c                        |  20 ++-
 drivers/xen/swiotlb-xen.c                          |  63 ++++----
 include/linux/dma-map-ops.h                        |  14 +-
 include/{ => uapi}/linux/map_benchmark.h           |  14 +-
 kernel/dma/dummy.c                                 |  13 +-
 kernel/dma/map_benchmark.c                         |   2 +-
 kernel/dma/mapping.c                               |  26 +--
 kernel/dma/ops_helpers.c                           |  12 +-
 tools/Makefile                                     |  13 +-
 tools/dma/.gitignore                               |   3 +
 tools/dma/Makefile                                 |  55 +++++++
 tools/{testing/selftests => }/dma/config           |   0
 .../selftests => }/dma/dma_map_benchmark.c         |   1 -
 tools/testing/selftests/dma/Makefile               |   7 -
 31 files changed, 436 insertions(+), 450 deletions(-)
 rename include/{ => uapi}/linux/map_benchmark.h (76%)
 create mode 100644 tools/dma/.gitignore
 create mode 100644 tools/dma/Makefile
 rename tools/{testing/selftests => }/dma/config (100%)
 rename tools/{testing/selftests => }/dma/dma_map_benchmark.c (99%)
 delete mode 100644 tools/testing/selftests/dma/Makefile
----------------------------------------------------------------

Thanks!

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland

