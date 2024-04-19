Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26160136E03
	for <iommu@lists.linux.dev>; Fri, 19 Apr 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545704; cv=none; b=Nu0IaiEY0uxfsIp44C4NtbI7l0yy+FacaK+s8IFc9Q20gUnwZPicDUL90YBeNeYIHcPJMkgxjJv/c4WJ4GeMv49M4FyA9wBQRp2XC/9HpLRs4t42uGl/0T+FGm8ChnWYS7KYFfn1tHhFtx3ZIXC1P5JCpJFCXvbxVlEFv1kNCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545704; c=relaxed/simple;
	bh=/Sgalow7R8qrgIOMiewpK7cg75Gx/+KiRjQFIynuSmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oUtwkTY2ZjL9BE0RFMHPW1xLVq5Kq7Cr4ktW4Q6/XrCFrMpsz2SlywJmg/pdt7lqbNjFCsxiwZgUOPn0ThBxrmKUOWWo7H6+t3z9DM//W+ucQnROqqX4qv2XwAugp0DoAuCDLYt6C7CSJpaBRTLRHTjquE+el0ul3OVKXnWOipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C5AC2F;
	Fri, 19 Apr 2024 09:55:30 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 931823F792;
	Fri, 19 Apr 2024 09:54:57 -0700 (PDT)
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
Subject: [PATCH v4 0/7] iommu, dma-mapping: Simplify arch_setup_dma_ops()
Date: Fri, 19 Apr 2024 17:54:39 +0100
Message-Id: <cover.1713523152.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: https://lore.kernel.org/linux-iommu/cover.1707493264.git.robin.murphy@arm.com/

Hi all,

Since this ended up missing the boat for 6.9, here's a rebase and resend
with the additional tags from v3 collected.

Cheers,
Robin.


Robin Murphy (7):
  OF: Retire dma-ranges mask workaround
  OF: Simplify DMA range calculations
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

