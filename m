Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB63C2D7
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 06:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=7zxKJM+hffyzY8/mnbPlZjh2fBXL9zN4AP03zResViY=; b=c11kkHW1gkFJ1DDyT7B7Lq4ggE
	elct902Q3wmKH6ivTqzkxq1kIRLCVebdk+0lefqrqgPmmW3OzkXwLG40UAqboNlENMi1KCODtF3P0
	Shr/S+4CazLK+B/7ftHazEpioiTtuZ4wZzTuAS3H1LX5bi5IXJKZBGo1UV2XNDDizxS4aEGYRBtkM
	VYRm3K/RrsZnMJGQ27wEp3eC6jZ4VZpi6x9vDzdFvopfIFx9cmQ7l2+iXo68Y9fYYB1Yqe8ma2PlK
	6A0qUx+04xqOAOWLKKlcuPDySZHbhkmKgIE//glpNni26064xWleSL1/4DMSse8O8JLXg+DFSHVh5
	/UrfNPYQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1phlLQ-002hoJ-0x;
	Thu, 30 Mar 2023 06:01:08 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org
Subject: [PATCH] iommu: PGTABLE_LPAE is also for RISCV
Date: Wed, 29 Mar 2023 23:01:05 -0700
Message-Id: <20230330060105.29460-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On riscv64, linux-next-20233030 (and for several days earlier),
there is a kconfig warning:

WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
  Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
  Selected by [y]:
  - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]

and build errors:

riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L140':
io-pgtable-arm.c:(.init.text+0x1e8): undefined reference to `alloc_io_pgtable_ops'
riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L168':
io-pgtable-arm.c:(.init.text+0xab0): undefined reference to `free_io_pgtable_ops'
riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L140':
ipmmu-vmsa.c:(.text+0xbc4): undefined reference to `free_io_pgtable_ops'
riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L0 ':
ipmmu-vmsa.c:(.text+0x145e): undefined reference to `alloc_io_pgtable_ops'

Add RISCV as an allowed ARCH dependency to fix these problems.

Fixes: d286a58bc8f4 ("iommu: Tidy up io-pgtable dependencies")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Cc: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org
---
 drivers/iommu/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -32,7 +32,7 @@ config IOMMU_IO_PGTABLE
 config IOMMU_IO_PGTABLE_LPAE
 	bool "ARMv7/v8 Long Descriptor Format"
 	select IOMMU_IO_PGTABLE
-	depends on ARM || ARM64 || COMPILE_TEST
+	depends on ARM || ARM64 || RISCV || COMPILE_TEST
 	depends on !GENERIC_ATOMIC64	# for cmpxchg64()
 	help
 	  Enable support for the ARM long descriptor pagetable format.
