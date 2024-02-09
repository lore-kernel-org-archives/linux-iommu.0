Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A296364D6
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497425; cv=none; b=iKgX7nnKd/UejlUGO1hANy4hODleE0qA7KoiMoN3Qe6azo3bPK/mTr9UKuqdDw1QWROqPBRvYbBOYCgT1QhGN/ce3803fdpswUxaVrXeCa3yuZfH3HGnQAb+sQ9ZVZSaWeRPZ1ikLhjv32Ooa6GGhry9b5D0DdYEW5EQRvGFCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497425; c=relaxed/simple;
	bh=jodxKeMIB3u02I6vwJHLmyAGch/HD5ufVLh3ZfgAW3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RQLzmX/w+SL7mS0QJhyD/JXo81znZjw/+e/TNNXRzf8i/d/ARDQySfJv0QcWnmr3OzVwn5q5Y/JTXfi69RD487h3Bo1Gv6b2r+Uj5elmR6l5eLwvVjkmMSKhLW89WSr7LYPt3jhOH43AV7Ho3SwNNgnnMG+5g2Cz9dCNNlTFVE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A10CADA7;
	Fri,  9 Feb 2024 08:51:04 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF0DA3F64C;
	Fri,  9 Feb 2024 08:50:18 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/7] dma-mapping: Simplify arch_setup_dma_ops()
Date: Fri,  9 Feb 2024 16:49:57 +0000
Message-Id: <cover.1707493264.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: https://lore.kernel.org/linux-iommu/cover.1702486837.git.robin.murphy@arm.com/

Hi all,

Here's v3, rebased and fixing the thinko from v2, so unless anything
else has changed behind my back I hope it's good to go (via the IOMMU
tree, as mentioned before).

Thanks,
Robin.


Robin Murphy (7):
  OF: Retire dma-ranges mask workaround
  OF: Simplify DMA range ca1lculations
  ACPI/IORT: Handle memory address size limits as limits
  dma-mapping: Add helpers for dma_range_map bounds
  iommu/dma: Make limit checks self-contained
  iommu/dma: Centralise iommu_setup_dma_ops()
  dma-mapping: Simplify arch_setup_dma_ops()

 arch/arc/mm/dma.c               |  3 +--
 arch/arm/mm/dma-mapping-nommu.c |  3 +--
 arch/arm/mm/dma-mapping.c       | 16 +++++++------
 arch/arm64/mm/dma-mapping.c     |  5 +---
 arch/loongarch/kernel/dma.c     |  9 ++-----
 arch/mips/mm/dma-noncoherent.c  |  3 +--
 arch/riscv/mm/dma-noncoherent.c |  3 +--
 drivers/acpi/arm64/dma.c        | 17 ++++---------
 drivers/acpi/arm64/iort.c       | 20 ++++++++--------
 drivers/acpi/scan.c             |  7 +-----
 drivers/hv/hv_common.c          |  6 +----
 drivers/iommu/amd/iommu.c       |  8 -------
 drivers/iommu/dma-iommu.c       | 39 ++++++++++++------------------
 drivers/iommu/dma-iommu.h       | 14 +++++------
 drivers/iommu/intel/iommu.c     |  7 ------
 drivers/iommu/iommu.c           | 20 ++++++----------
 drivers/iommu/s390-iommu.c      |  6 -----
 drivers/iommu/virtio-iommu.c    | 10 --------
 drivers/of/device.c             | 42 ++++++---------------------------
 include/linux/acpi_iort.h       |  4 ++--
 include/linux/dma-direct.h      | 18 ++++++++++++++
 include/linux/dma-map-ops.h     |  6 ++---
 include/linux/iommu.h           |  7 ------
 23 files changed, 89 insertions(+), 184 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

