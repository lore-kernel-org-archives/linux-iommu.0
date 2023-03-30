Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E18BEE
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lH22MfJIcQmsTzdoJbOcWiocllL7iIB6Gn2R5IPwbtA=; b=chSMsIYmRHyrgsJenrc6k7iulK
	vkLxxOqgENYMoMgVQdjMvd3+YmI/wtTuZwoWhojz7C/5UWFv+1oitVkJjl9TXV8SLPAu1F6Jap+1h
	NtUsnCtOHxmZPgUYdGuDSHsoKjwHcrQQ1j56AooEiKQppTvIeFoJW1ku7IZYwNVszKVqNcKPRX9aj
	FxMwGPvAffQ6rA4TLkTnuYkxW7gwhwcfHeC77OTg78cbdPtN0FbG9wLTASwJJf2428tPWaQmFCOuN
	s/xowZsTepl0+4ghPdAPaf6DGOOPZtQj27G1yXhVLsZrvGqV6w3b+novy4/82dO3dhXcKD5H1wARe
	nt4FBkmQ==;
Received: from [71.59.149.187] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1phvbO-004YvS-2H;
	Thu, 30 Mar 2023 16:58:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Conor Dooley <conor@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] iommu: make IPMMU_VMSA dependencies more strict
Date: Thu, 30 Mar 2023 09:58:17 -0700
Message-Id: <20230330165817.21920-1-rdunlap@infradead.org>
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

Add ARM || ARM64 || COMPILE_TEST dependencies to IPMMU_VMSA to prevent
these issues, i.e., so that ARCH_RENESAS on RISC-V is not allowed.

This makes the ARCH dependencies become:
	depends on (ARCH_RENESAS && (ARM || ARM64)) || COMPILE_TEST
but that can be a bit hard to read.

Fixes: 8292493c22c8 ("riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Cc: Conor Dooley <conor@kernel.org>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/iommu/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -287,6 +287,7 @@ config EXYNOS_IOMMU_DEBUG
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
 	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
