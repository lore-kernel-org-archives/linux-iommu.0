From: Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v3 3/6] iommu: add ARM short descriptor page table allocator.
Date: Thu, 16 Jul 2015 17:04:32 +0800
Message-ID: <1437037475-9065-4-git-send-email-yong.wu@mediatek.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, cloud.chou@mediatek.com, frederic.chen@mediatek.com, yong.wu@mediatek.com
List-Id: iommu@lists.linux-foundation.org

This patch is for ARM Short Descriptor Format.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/Kconfig                |   18 +
 drivers/iommu/Makefile               |    1 +
 drivers/iommu/io-pgtable-arm-short.c |  742 ++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c       |    3 -
 drivers/iommu/io-pgtable.c           |    4 +
 drivers/iommu/io-pgtable.h           |   13 +
 6 files changed, 778 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm-short.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f1fb1d3..f50dbf3 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -39,6 +39,24 @@ config IOMMU_IO_PGTABLE_LPAE_SELFTEST
 
 	  If unsure, say N here.
 
+config IOMMU_IO_PGTABLE_SHORT
+	bool "ARMv7/v8 Short Descriptor Format"
+	select IOMMU_IO_PGTABLE
+	depends on ARM || ARM64 || COMPILE_TEST
+	help
+	  Enable support for the ARM Short descriptor pagetable format.
+	  This allocator supports 2 levels translation tables which supports
+	  a memory map based on memory sections or pages.
+
+config IOMMU_IO_PGTABLE_SHORT_SELFTEST
+	bool "Short Descriptor selftests"
+	depends on IOMMU_IO_PGTABLE_SHORT
+	help
+	  Enable self-tests for Short Descriptor page table allocator.
+	  This performs a series of page-table consistency checks during boot.
+
+	  If unsure, say N here.
+
 endmenu
 
 config IOMMU_IOVA
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index c6dcc51..06df3e6 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
+obj-$(CONFIG_IOMMU_IO_PGTABLE_SHORT) += io-pgtable-arm-short.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
diff --git a/drivers/iommu/io-pgtable-arm-short.c b/drivers/iommu/io-pgtable-arm-short.c
new file mode 100644
index 0000000..340d590
--- /dev/null
+++ b/drivers/iommu/io-pgtable-arm-short.c
@@ -0,0 +1,742 @@
+/*
+ * Copyright (c) 2014-2015 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#define pr_fmt(fmt)	"arm-short-desc io-pgtable: "fmt
+
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/iommu.h>
+#include <linux/errno.h>
+
+#include "io-pgtable.h"
+
+typedef u32 arm_short_iopte;
+
+struct arm_short_io_pgtable {
+	struct io_pgtable	iop;
+	struct kmem_cache	*ptekmem;
+	size_t			pgd_size;
+	void			*pgd;
+};
+
+#define io_pgtable_to_data(x)			\
+	container_of((x), struct arm_short_io_pgtable, iop)
+
+#define io_pgtable_ops_to_data(x)		\
+	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
+
+#define ARM_SHORT_PGDIR_SHIFT			20
+#define ARM_SHORT_PAGE_SHIFT			12
+#define ARM_SHORT_PTRS_PER_PTE			\
+	(1 << (ARM_SHORT_PGDIR_SHIFT - ARM_SHORT_PAGE_SHIFT))
+#define ARM_SHORT_BYTES_PER_PTE			\
+	(ARM_SHORT_PTRS_PER_PTE * sizeof(arm_short_iopte))
+
+/* level 1 pagetable */
+#define ARM_SHORT_PGD_TYPE_PGTABLE		BIT(0)
+#define ARM_SHORT_PGD_SECTION_XN		(BIT(0) | BIT(4))
+#define ARM_SHORT_PGD_TYPE_SECTION		BIT(1)
+#define ARM_SHORT_PGD_PGTABLE_XN		BIT(2)
+#define ARM_SHORT_PGD_B				BIT(2)
+#define ARM_SHORT_PGD_C				BIT(3)
+#define ARM_SHORT_PGD_PGTABLE_NS		BIT(3)
+#define ARM_SHORT_PGD_IMPLE			BIT(9)
+#define ARM_SHORT_PGD_TEX0			BIT(12)
+#define ARM_SHORT_PGD_S				BIT(16)
+#define ARM_SHORT_PGD_nG			BIT(17)
+#define ARM_SHORT_PGD_SUPERSECTION		BIT(18)
+#define ARM_SHORT_PGD_SECTION_NS		BIT(19)
+
+#define ARM_SHORT_PGD_TYPE_SUPERSECTION		\
+	(ARM_SHORT_PGD_TYPE_SECTION | ARM_SHORT_PGD_SUPERSECTION)
+#define ARM_SHORT_PGD_SECTION_TYPE_MSK		\
+	(ARM_SHORT_PGD_TYPE_SECTION | ARM_SHORT_PGD_SUPERSECTION)
+#define ARM_SHORT_PGD_PGTABLE_TYPE_MSK		\
+	(ARM_SHORT_PGD_TYPE_SECTION | ARM_SHORT_PGD_TYPE_PGTABLE)
+#define ARM_SHORT_PGD_TYPE_IS_PGTABLE(pgd)	\
+	(((pgd) & ARM_SHORT_PGD_PGTABLE_TYPE_MSK) == ARM_SHORT_PGD_TYPE_PGTABLE)
+#define ARM_SHORT_PGD_TYPE_IS_SECTION(pgd)	\
+	(((pgd) & ARM_SHORT_PGD_SECTION_TYPE_MSK) == ARM_SHORT_PGD_TYPE_SECTION)
+#define ARM_SHORT_PGD_TYPE_IS_SUPERSECTION(pgd)	\
+	(((pgd) & ARM_SHORT_PGD_SECTION_TYPE_MSK) == \
+	ARM_SHORT_PGD_TYPE_SUPERSECTION)
+#define ARM_SHORT_PGD_PGTABLE_MSK		0xfffffc00
+#define ARM_SHORT_PGD_SECTION_MSK		(~(SZ_1M - 1))
+#define ARM_SHORT_PGD_SUPERSECTION_MSK		(~(SZ_16M - 1))
+
+/* level 2 pagetable */
+#define ARM_SHORT_PTE_TYPE_LARGE		BIT(0)
+#define ARM_SHORT_PTE_SMALL_XN			BIT(0)
+#define ARM_SHORT_PTE_TYPE_SMALL		BIT(1)
+#define ARM_SHORT_PTE_B				BIT(2)
+#define ARM_SHORT_PTE_C				BIT(3)
+#define ARM_SHORT_PTE_SMALL_TEX0		BIT(6)
+#define ARM_SHORT_PTE_IMPLE			BIT(9)
+#define ARM_SHORT_PTE_S				BIT(10)
+#define ARM_SHORT_PTE_nG			BIT(11)
+#define ARM_SHORT_PTE_LARGE_TEX0		BIT(12)
+#define ARM_SHORT_PTE_LARGE_XN			BIT(15)
+#define ARM_SHORT_PTE_LARGE_MSK			(~(SZ_64K - 1))
+#define ARM_SHORT_PTE_SMALL_MSK			(~(SZ_4K - 1))
+#define ARM_SHORT_PTE_TYPE_MSK			\
+	(ARM_SHORT_PTE_TYPE_LARGE | ARM_SHORT_PTE_TYPE_SMALL)
+#define ARM_SHORT_PTE_TYPE_IS_SMALLPAGE(pte)	\
+	(((((pte) & ARM_SHORT_PTE_TYPE_MSK) >> 1) << 1)\
+	== ARM_SHORT_PTE_TYPE_SMALL)
+#define ARM_SHORT_PTE_TYPE_IS_LARGEPAGE(pte)	\
+	(((pte) & ARM_SHORT_PTE_TYPE_MSK) == ARM_SHORT_PTE_TYPE_LARGE)
+
+#define ARM_SHORT_PGD_IDX(a)			((a) >> ARM_SHORT_PGDIR_SHIFT)
+#define ARM_SHORT_PTE_IDX(a)			\
+	(((a) >> ARM_SHORT_PAGE_SHIFT) & (ARM_SHORT_PTRS_PER_PTE - 1))
+
+#define ARM_SHORT_GET_PTE_VA(pgd)		\
+	(phys_to_virt((unsigned long)pgd & ARM_SHORT_PGD_PGTABLE_MSK))
+
+#define ARM_SHORT_PTE_LARGE_GET_PROT(pte)	\
+	(((pte) & (~ARM_SHORT_PTE_LARGE_MSK)) & ~ARM_SHORT_PTE_TYPE_MSK)
+
+#define ARM_SHORT_PGD_GET_PROT(pgd)		\
+	(((pgd) & (~ARM_SHORT_PGD_SECTION_MSK)) & ~ARM_SHORT_PGD_SUPERSECTION)
+
+static bool selftest_running;
+
+static arm_short_iopte *
+arm_short_get_pte_in_pgd(arm_short_iopte pgd, unsigned int iova)
+{
+	arm_short_iopte *pte;
+
+	pte = ARM_SHORT_GET_PTE_VA(pgd);
+	pte += ARM_SHORT_PTE_IDX(iova);
+	return pte;
+}
+
+static void _arm_short_free_pgtable(struct arm_short_io_pgtable *data,
+				    arm_short_iopte *pgd)
+{
+	const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
+	arm_short_iopte *pte;
+	int i;
+
+	pte = ARM_SHORT_GET_PTE_VA(*pgd);
+	for (i = 0; i < ARM_SHORT_PTRS_PER_PTE; i++) {
+		if (pte[i] != 0)
+			return;
+	}
+
+	/* Free whole pte and set pgd to zero while all pte is unmap */
+	kmem_cache_free(data->ptekmem, pte);
+	*pgd = 0;
+	tlb->flush_pgtable(pgd, sizeof(*pgd), data->iop.cookie);
+}
+
+static arm_short_iopte
+__arm_short_pte_prot(struct arm_short_io_pgtable *data, int prot, bool large)
+{
+	arm_short_iopte pteprot;
+
+	pteprot = ARM_SHORT_PTE_S | ARM_SHORT_PTE_nG;
+	pteprot |= large ? ARM_SHORT_PTE_TYPE_LARGE :
+				ARM_SHORT_PTE_TYPE_SMALL;
+	if (prot & IOMMU_CACHE)
+		pteprot |=  ARM_SHORT_PTE_B | ARM_SHORT_PTE_C;
+	if (prot & IOMMU_WRITE)
+		pteprot |= large ? ARM_SHORT_PTE_LARGE_TEX0 :
+				ARM_SHORT_PTE_SMALL_TEX0;
+	if (prot & IOMMU_NOEXEC)
+		pteprot |= large ? ARM_SHORT_PTE_LARGE_XN :
+			ARM_SHORT_PTE_SMALL_XN;
+	return pteprot;
+}
+
+static arm_short_iopte
+__arm_short_pgd_prot(struct arm_short_io_pgtable *data, int prot, bool super)
+{
+	arm_short_iopte pgdprot;
+
+	pgdprot = ARM_SHORT_PGD_S | ARM_SHORT_PGD_nG;
+	pgdprot |= super ? ARM_SHORT_PGD_TYPE_SUPERSECTION :
+				ARM_SHORT_PGD_TYPE_SECTION;
+	if (prot & IOMMU_CACHE)
+		pgdprot |= ARM_SHORT_PGD_C | ARM_SHORT_PGD_B;
+	if (prot & IOMMU_WRITE)
+		pgdprot |= ARM_SHORT_PGD_TEX0;
+	if (prot & IOMMU_NOEXEC)
+		pgdprot |= ARM_SHORT_PGD_SECTION_XN;
+	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
+		pgdprot |= ARM_SHORT_PGD_SECTION_NS;
+	return pgdprot;
+}
+
+static arm_short_iopte
+__arm_short_pte_prot_split(struct arm_short_io_pgtable *data,
+			   arm_short_iopte pgdprot,
+			   arm_short_iopte pteprot_large,
+			   bool large)
+{
+	arm_short_iopte pteprot = 0;
+
+	pteprot = ARM_SHORT_PTE_S | ARM_SHORT_PTE_nG;
+	pteprot |= large ? ARM_SHORT_PTE_TYPE_LARGE :
+				ARM_SHORT_PTE_TYPE_SMALL;
+	/* section to pte prot */
+	if (pgdprot & ARM_SHORT_PGD_C)
+		pteprot |= ARM_SHORT_PTE_C;
+	if (pgdprot & ARM_SHORT_PGD_B)
+		pteprot |= ARM_SHORT_PTE_B;
+	if (pgdprot & ARM_SHORT_PGD_TEX0)
+		pteprot |= large ? ARM_SHORT_PTE_LARGE_TEX0 :
+				ARM_SHORT_PTE_SMALL_TEX0;
+	if (pgdprot & ARM_SHORT_PGD_nG)
+		pteprot |= ARM_SHORT_PTE_nG;
+	if (pgdprot & ARM_SHORT_PGD_SECTION_XN)
+		pteprot |= large ? ARM_SHORT_PTE_LARGE_XN :
+				ARM_SHORT_PTE_SMALL_XN;
+
+	/* large page to small page pte prot. Only large page may split */
+	if (pteprot_large && !large) {
+		if (pteprot_large & ARM_SHORT_PTE_LARGE_TEX0)
+			pteprot |= ARM_SHORT_PTE_SMALL_TEX0;
+		if (pteprot_large & ARM_SHORT_PTE_LARGE_XN)
+			pteprot |= ARM_SHORT_PTE_SMALL_XN;
+	}
+	return pteprot;
+}
+
+static arm_short_iopte
+__arm_short_pgtable_prot(struct arm_short_io_pgtable *data, bool noexec)
+{
+	arm_short_iopte pgdprot = 0;
+
+	pgdprot = ARM_SHORT_PGD_TYPE_PGTABLE;
+	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
+		pgdprot |= ARM_SHORT_PGD_PGTABLE_NS;
+	if (noexec)
+		pgdprot |= ARM_SHORT_PGD_PGTABLE_XN;
+	return pgdprot;
+}
+
+static int
+_arm_short_map(struct arm_short_io_pgtable *data,
+	       unsigned int iova, phys_addr_t paddr,
+	       arm_short_iopte pgdprot, arm_short_iopte pteprot,
+	       bool large)
+{
+	const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
+	arm_short_iopte *pgd = data->pgd, *pte;
+	void *cookie = data->iop.cookie, *pte_va;
+	unsigned int ptenr = large ? 16 : 1;
+	int i, quirk = data->iop.cfg.quirks;
+	bool ptenew = false;
+
+	pgd += ARM_SHORT_PGD_IDX(iova);
+
+	if (!pteprot) { /* section or supersection */
+		if (quirk & IO_PGTABLE_QUIRK_SHORT_MTK)
+			pgdprot &= ~ARM_SHORT_PGD_SECTION_XN;
+		pte = pgd;
+		pteprot = pgdprot;
+	} else {        /* page or largepage */
+		if (quirk & IO_PGTABLE_QUIRK_SHORT_MTK) {
+			if (large) { /* special Bit */
+				if (pteprot & ARM_SHORT_PTE_LARGE_TEX0) {
+					pteprot &= ~ARM_SHORT_PTE_LARGE_TEX0;
+					pteprot |= ARM_SHORT_PTE_SMALL_TEX0;
+				}
+				pteprot &= ~ARM_SHORT_PTE_LARGE_XN;
+			} else {
+				pteprot &= ~ARM_SHORT_PTE_SMALL_XN;
+			}
+		}
+
+		if (!(*pgd)) {
+			pte_va = kmem_cache_zalloc(data->ptekmem, GFP_ATOMIC);
+			if (unlikely(!pte_va))
+				return -ENOMEM;
+			ptenew = true;
+			*pgd = virt_to_phys(pte_va) | pgdprot;
+			kmemleak_ignore(pte_va);
+			tlb->flush_pgtable(pgd, sizeof(*pgd), cookie);
+		}
+		pte = arm_short_get_pte_in_pgd(*pgd, iova);
+	}
+
+	pteprot |= (arm_short_iopte)paddr;
+	for (i = 0; i < ptenr; i++) {
+		if (pte[i]) {/* Someone else may have allocated for this pte */
+			WARN_ON(!selftest_running);
+			goto err_exist_pte;
+		}
+		pte[i] = pteprot;
+	}
+	tlb->flush_pgtable(pte, ptenr * sizeof(*pte), cookie);
+
+	return 0;
+
+err_exist_pte:
+	while (i--)
+		pte[i] = 0;
+	if (ptenew)
+		kmem_cache_free(data->ptekmem, pte_va);
+	return -EEXIST;
+}
+
+static int arm_short_map(struct io_pgtable_ops *ops, unsigned long iova,
+			 phys_addr_t paddr, size_t size, int prot)
+{
+	struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
+	int ret;
+	arm_short_iopte pgdprot = 0, pteprot = 0;
+	bool large;
+
+	/* If no access, then nothing to do */
+	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
+		return 0;
+
+	switch (size) {
+	case SZ_4K:
+	case SZ_64K:
+		large = (size == SZ_64K) ? true : false;
+		pteprot = __arm_short_pte_prot(data, prot, large);
+		pgdprot = __arm_short_pgtable_prot(data, prot & IOMMU_NOEXEC);
+		break;
+
+	case SZ_1M:
+	case SZ_16M:
+		large = (size == SZ_16M) ? true : false;
+		pgdprot = __arm_short_pgd_prot(data, prot, large);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (WARN_ON((iova | paddr) & (size - 1)))
+		return -EINVAL;
+
+	ret = _arm_short_map(data, iova, paddr, pgdprot, pteprot, large);
+
+	tlb->tlb_add_flush(iova, size, true, data->iop.cookie);
+	tlb->tlb_sync(data->iop.cookie);
+	return ret;
+}
+
+static phys_addr_t arm_short_iova_to_phys(struct io_pgtable_ops *ops,
+					  unsigned long iova)
+{
+	struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	arm_short_iopte *pte, *pgd = data->pgd;
+	phys_addr_t pa = 0;
+
+	pgd += ARM_SHORT_PGD_IDX(iova);
+
+	if (ARM_SHORT_PGD_TYPE_IS_PGTABLE(*pgd)) {
+		pte = arm_short_get_pte_in_pgd(*pgd, iova);
+
+		if (ARM_SHORT_PTE_TYPE_IS_LARGEPAGE(*pte)) {
+			pa = (*pte) & ARM_SHORT_PTE_LARGE_MSK;
+			pa |= iova & ~ARM_SHORT_PTE_LARGE_MSK;
+		} else if (ARM_SHORT_PTE_TYPE_IS_SMALLPAGE(*pte)) {
+			pa = (*pte) & ARM_SHORT_PTE_SMALL_MSK;
+			pa |= iova & ~ARM_SHORT_PTE_SMALL_MSK;
+		}
+	} else if (ARM_SHORT_PGD_TYPE_IS_SECTION(*pgd)) {
+		pa = (*pgd) & ARM_SHORT_PGD_SECTION_MSK;
+		pa |= iova & ~ARM_SHORT_PGD_SECTION_MSK;
+	} else if (ARM_SHORT_PGD_TYPE_IS_SUPERSECTION(*pgd)) {
+		pa = (*pgd) & ARM_SHORT_PGD_SUPERSECTION_MSK;
+		pa |= iova & ~ARM_SHORT_PGD_SUPERSECTION_MSK;
+	}
+
+	return pa;
+}
+
+static int
+arm_short_split_blk_unmap(struct io_pgtable_ops *ops, unsigned int iova,
+			  phys_addr_t paddr, size_t size,
+			  arm_short_iopte pgdprotup, arm_short_iopte pteprotup,
+			  size_t blk_size)
+{
+	struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	unsigned long *pgbitmap = &cfg->pgsize_bitmap;
+	unsigned int blk_base, blk_start, blk_end;
+	arm_short_iopte pgdprot, pteprot;
+	size_t mapsize = 0, nextmapsize;
+	phys_addr_t blk_paddr;
+	int ret;
+	unsigned int i;
+
+	/* find the nearest mapsize */
+	for (i = find_first_bit(pgbitmap, BITS_PER_LONG);
+	     i < BITS_PER_LONG && ((1 << i) < blk_size) &&
+	     IS_ALIGNED(size, 1 << i);
+	     i = find_next_bit(pgbitmap, BITS_PER_LONG, i + 1))
+		mapsize = 1 << i;
+
+	if (WARN_ON(!mapsize))
+		return 0; /* Bytes unmapped */
+	nextmapsize = 1 << i;
+
+	blk_base = iova & ~(blk_size - 1);
+	blk_start = blk_base;
+	blk_end = blk_start + blk_size;
+	blk_paddr = paddr;
+
+	for (; blk_start < blk_end;
+	     blk_start += mapsize, blk_paddr += mapsize) {
+		/* Unmap! */
+		if (blk_start == iova)
+			continue;
+
+		/* Try to upper map */
+		if (blk_base != blk_start &&
+		    IS_ALIGNED(blk_start | blk_paddr, nextmapsize) &&
+		    mapsize != nextmapsize) {
+			mapsize = nextmapsize;
+			i = find_next_bit(pgbitmap, BITS_PER_LONG, i + 1);
+			if (i < BITS_PER_LONG)
+				nextmapsize = 1 << i;
+		}
+
+		if (mapsize == SZ_1M) {
+			pgdprot = pgdprotup;
+			pgdprot |= __arm_short_pgd_prot(data, 0, false);
+			pteprot = 0;
+		} else { /* small or large page */
+			bool noexec = (blk_size == SZ_64K) ?
+				(pteprotup & ARM_SHORT_PTE_LARGE_XN) :
+				(pgdprotup & ARM_SHORT_PGD_SECTION_XN);
+
+			pteprot = __arm_short_pte_prot_split(
+						data, pgdprotup, pteprotup,
+						mapsize == SZ_64K);
+			pgdprot = __arm_short_pgtable_prot(data, noexec);
+		}
+
+		ret = _arm_short_map(data, blk_start, blk_paddr, pgdprot,
+				     pteprot, mapsize == SZ_64K);
+		if (ret < 0) {
+			/* Free the table we allocated */
+			arm_short_iopte *pgd = data->pgd, *pte;
+
+			pgd += ARM_SHORT_PGD_IDX(blk_base);
+			if (*pgd) {
+				pte = ARM_SHORT_GET_PTE_VA(*pgd);
+				kmem_cache_free(data->ptekmem, pte);
+				*pgd = 0;
+				tlb->flush_pgtable(pgd, sizeof(*pgd),
+						   data->iop.cookie);
+			}
+			return 0;/* Bytes unmapped */
+		}
+		tlb->tlb_add_flush(blk_start, mapsize, true, data->iop.cookie);
+		tlb->tlb_sync(data->iop.cookie);
+	}
+
+	return size;
+}
+
+static int arm_short_unmap(struct io_pgtable_ops *ops,
+			   unsigned long iova,
+			   size_t size)
+{
+	struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
+	void *cookie = data->iop.cookie;
+	arm_short_iopte *pgd, *pte = NULL;
+	arm_short_iopte pgdprot, pteprot = 0;
+	phys_addr_t paddr;
+	unsigned int nrtoclean, iova_base, blk_size = 0;
+
+	pgd = (arm_short_iopte *)data->pgd + ARM_SHORT_PGD_IDX(iova);
+
+	/* get block size */
+	if (ARM_SHORT_PGD_TYPE_IS_PGTABLE(*pgd)) {
+		pte = arm_short_get_pte_in_pgd(*pgd, iova);
+
+		if (ARM_SHORT_PTE_TYPE_IS_SMALLPAGE(*pte))
+			blk_size = SZ_4K;
+		else if (ARM_SHORT_PTE_TYPE_IS_LARGEPAGE(*pte))
+			blk_size = SZ_64K;
+		else
+			WARN_ON(1);
+	} else if (ARM_SHORT_PGD_TYPE_IS_SECTION(*pgd)) {
+		blk_size = SZ_1M;
+	} else if (ARM_SHORT_PGD_TYPE_IS_SUPERSECTION(*pgd)) {
+		blk_size = SZ_16M;
+	} else {
+		WARN_ON(1);
+	}
+
+	iova_base = iova & ~(blk_size - 1);
+	pgd = (arm_short_iopte *)data->pgd + ARM_SHORT_PGD_IDX(iova_base);
+	paddr = arm_short_iova_to_phys(ops, iova_base);
+	pgdprot = *pgd;
+
+	if (blk_size == SZ_4K || blk_size == SZ_64K) {
+		pte = arm_short_get_pte_in_pgd(*pgd, iova_base);
+		pteprot = *pte;
+		nrtoclean = blk_size / SZ_4K;
+		memset(pte, 0, nrtoclean * sizeof(*pte));
+		tlb->flush_pgtable(pte, nrtoclean * sizeof(*pte), cookie);
+
+		_arm_short_free_pgtable(data, pgd);
+	} else if (blk_size == SZ_1M || blk_size == SZ_16M) {
+		nrtoclean = blk_size / SZ_1M;
+		memset(pgd, 0, nrtoclean * sizeof(*pgd));
+		tlb->flush_pgtable(pgd, nrtoclean * sizeof(*pgd), cookie);
+	}
+
+	tlb->tlb_add_flush(iova, blk_size, true, cookie);
+	tlb->tlb_sync(cookie);
+
+	if (blk_size > size) { /* Split the block */
+		return arm_short_split_blk_unmap(
+				ops, iova, paddr, size,
+				ARM_SHORT_PGD_GET_PROT(pgdprot),
+				ARM_SHORT_PTE_LARGE_GET_PROT(pteprot),
+				blk_size);
+	} else if (blk_size < size) {
+		/* Unmap the block while remap partial again after split */
+		return blk_size +
+			arm_short_unmap(ops, iova + blk_size, size - blk_size);
+	}
+
+	return size;
+}
+
+static struct io_pgtable *
+arm_short_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	struct arm_short_io_pgtable *data;
+
+	if (cfg->ias > 32)
+		return NULL;
+
+	if (cfg->oas > 32)
+		return NULL;
+
+	cfg->pgsize_bitmap &=
+		(cfg->quirks & IO_PGTABLE_QUIRK_SHORT_SUPERSECTION) ?
+		(SZ_4K | SZ_64K | SZ_1M | SZ_16M) : (SZ_4K | SZ_64K | SZ_1M);
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	data->pgd_size = SZ_16K;
+	data->pgd = alloc_pages_exact(data->pgd_size,
+				      GFP_KERNEL | __GFP_ZERO | __GFP_DMA);
+	if (!data->pgd)
+		goto out_free_data;
+
+	cfg->tlb->flush_pgtable(data->pgd, data->pgd_size, cookie);
+
+	data->ptekmem = kmem_cache_create("io-pgtable-arm-short",
+					  ARM_SHORT_BYTES_PER_PTE,
+					  ARM_SHORT_BYTES_PER_PTE,
+					  0, NULL);
+	if (!data->ptekmem)
+		goto out_free_pte;
+
+	/* TTBRs */
+	cfg->arm_short_cfg.ttbr[0] = virt_to_phys(data->pgd);
+	cfg->arm_short_cfg.ttbr[1] = 0;
+
+	cfg->arm_short_cfg.tcr = 0;
+	cfg->arm_short_cfg.nmrr = 0;
+	cfg->arm_short_cfg.prrr = 0;
+
+	data->iop.ops = (struct io_pgtable_ops) {
+		.map		= arm_short_map,
+		.unmap		= arm_short_unmap,
+		.iova_to_phys	= arm_short_iova_to_phys,
+	};
+
+	return &data->iop;
+
+out_free_pte:
+	free_pages_exact(data->pgd, data->pgd_size);
+out_free_data:
+	kfree(data);
+	return NULL;
+}
+
+static void arm_short_free_pgtable(struct io_pgtable *iop)
+{
+	struct arm_short_io_pgtable *data = io_pgtable_to_data(iop);
+
+	kmem_cache_destroy(data->ptekmem);
+	free_pages_exact(data->pgd, data->pgd_size);
+	kfree(data);
+}
+
+struct io_pgtable_init_fns io_pgtable_arm_short_init_fns = {
+	.alloc	= arm_short_alloc_pgtable,
+	.free	= arm_short_free_pgtable,
+};
+
+#ifdef CONFIG_IOMMU_IO_PGTABLE_SHORT_SELFTEST
+
+static struct io_pgtable_cfg *cfg_cookie;
+
+static void dummy_tlb_flush_all(void *cookie)
+{
+	WARN_ON(cookie != cfg_cookie);
+}
+
+static void dummy_tlb_add_flush(unsigned long iova, size_t size, bool leaf,
+				void *cookie)
+{
+	WARN_ON(cookie != cfg_cookie);
+	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
+}
+
+static void dummy_tlb_sync(void *cookie)
+{
+	WARN_ON(cookie != cfg_cookie);
+}
+
+static void dummy_flush_pgtable(void *ptr, size_t size, void *cookie)
+{
+	WARN_ON(cookie != cfg_cookie);
+}
+
+static struct iommu_gather_ops dummy_tlb_ops = {
+	.tlb_flush_all	= dummy_tlb_flush_all,
+	.tlb_add_flush	= dummy_tlb_add_flush,
+	.tlb_sync	= dummy_tlb_sync,
+	.flush_pgtable	= dummy_flush_pgtable,
+};
+
+#define __FAIL(ops)	({						\
+		WARN(1, "selftest: test failed\n");	\
+		selftest_running = false;				\
+		-EFAULT;						\
+})
+
+static int __init arm_short_do_selftests(void)
+{
+	struct io_pgtable_ops *ops;
+	struct io_pgtable_cfg cfg = {
+		.tlb = &dummy_tlb_ops,
+		.oas = 32,
+		.ias = 32,
+		.quirks = IO_PGTABLE_QUIRK_ARM_NS |
+			IO_PGTABLE_QUIRK_SHORT_SUPERSECTION,
+		.pgsize_bitmap = SZ_4K | SZ_64K | SZ_1M | SZ_16M,
+	};
+	unsigned int iova, size, iova_start;
+	unsigned int i, loopnr = 0;
+
+	selftest_running = true;
+
+	cfg_cookie = &cfg;
+
+	ops = alloc_io_pgtable_ops(ARM_SHORT_DESC, &cfg, &cfg);
+	if (!ops) {
+		pr_err("Failed to alloc short desc io pgtable\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Initial sanity checks.
+	 * Empty page tables shouldn't provide any translations.
+	 */
+	if (ops->iova_to_phys(ops, 42))
+		return __FAIL(ops);
+
+	if (ops->iova_to_phys(ops, SZ_1G + 42))
+		return __FAIL(ops);
+
+	if (ops->iova_to_phys(ops, SZ_2G + 42))
+		return __FAIL(ops);
+
+	/*
+	 * Distinct mappings of different granule sizes.
+	 */
+	iova = 0;
+	i = find_first_bit(&cfg.pgsize_bitmap, BITS_PER_LONG);
+	while (i != BITS_PER_LONG) {
+		size = 1UL << i;
+		if (ops->map(ops, iova, iova, size, IOMMU_READ |
+						    IOMMU_WRITE |
+						    IOMMU_NOEXEC |
+						    IOMMU_CACHE))
+			return __FAIL(ops);
+
+		/* Overlapping mappings */
+		if (!ops->map(ops, iova, iova + size, size,
+			      IOMMU_READ | IOMMU_NOEXEC))
+			return __FAIL(ops);
+
+		if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+			return __FAIL(ops);
+
+		iova += SZ_16M;
+		i++;
+		i = find_next_bit(&cfg.pgsize_bitmap, BITS_PER_LONG, i);
+		loopnr++;
+	}
+
+	/* Partial unmap */
+	i = 1;
+	size = 1UL << __ffs(cfg.pgsize_bitmap);
+	while (i < loopnr) {
+		iova_start = i * SZ_16M;
+		if (ops->unmap(ops, iova_start + size, size) != size)
+			return __FAIL(ops);
+
+		/* Remap of partial unmap */
+		if (ops->map(ops, iova_start + size, size, size, IOMMU_READ))
+			return __FAIL(ops);
+
+		if (ops->iova_to_phys(ops, iova_start + size + 42)
+		    != (size + 42))
+			return __FAIL(ops);
+		i++;
+	}
+
+	/* Full unmap */
+	iova = 0;
+	i = find_first_bit(&cfg.pgsize_bitmap, BITS_PER_LONG);
+	while (i != BITS_PER_LONG) {
+		size = 1UL << i;
+
+		if (ops->unmap(ops, iova, size) != size)
+			return __FAIL(ops);
+
+		if (ops->iova_to_phys(ops, iova + 42))
+			return __FAIL(ops);
+
+		/* Remap full block */
+		if (ops->map(ops, iova, iova, size, IOMMU_WRITE))
+			return __FAIL(ops);
+
+		if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+			return __FAIL(ops);
+
+		iova += SZ_16M;
+		i++;
+		i = find_next_bit(&cfg.pgsize_bitmap, BITS_PER_LONG, i);
+	}
+
+	free_io_pgtable_ops(ops);
+
+	selftest_running = false;
+	return 0;
+}
+subsys_initcall(arm_short_do_selftests);
+#endif
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 4e46021..13aad17 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -36,9 +36,6 @@
 #define io_pgtable_to_data(x)						\
 	container_of((x), struct arm_lpae_io_pgtable, iop)
 
-#define io_pgtable_ops_to_pgtable(x)					\
-	container_of((x), struct io_pgtable, ops)
-
 #define io_pgtable_ops_to_data(x)					\
 	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
 
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 6436fe2..14a9b3a 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -28,6 +28,7 @@ extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_arm_short_init_fns;
 
 static const struct io_pgtable_init_fns *
 io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =
@@ -38,6 +39,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =
 	[ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
 	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
 #endif
+#ifdef CONFIG_IOMMU_IO_PGTABLE_SHORT
+	[ARM_SHORT_DESC] = &io_pgtable_arm_short_init_fns,
+#endif
 };
 
 struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 10e32f6..7261ada 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -9,6 +9,7 @@ enum io_pgtable_fmt {
 	ARM_32_LPAE_S2,
 	ARM_64_LPAE_S1,
 	ARM_64_LPAE_S2,
+	ARM_SHORT_DESC,
 	IO_PGTABLE_NUM_FMTS,
 };
 
@@ -44,6 +45,8 @@ struct iommu_gather_ops {
  */
 struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_NS	(1 << 0)	/* Set NS bit in PTEs */
+	#define IO_PGTABLE_QUIRK_SHORT_SUPERSECTION     BIT(1)
+	#define IO_PGTABLE_QUIRK_SHORT_MTK		BIT(2)
 	int				quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
@@ -62,6 +65,13 @@ struct io_pgtable_cfg {
 			u64	vttbr;
 			u64	vtcr;
 		} arm_lpae_s2_cfg;
+
+		struct {
+			u32	ttbr[2];
+			u32	tcr;
+			u32	nmrr;
+			u32	prrr;
+		} arm_short_cfg;
 	};
 };
 
@@ -128,6 +138,9 @@ struct io_pgtable {
 	struct io_pgtable_ops	ops;
 };
 
+#define io_pgtable_ops_to_pgtable(x)		\
+	container_of((x), struct io_pgtable, ops)
+
 /**
  * struct io_pgtable_init_fns - Alloc/free a set of page tables for a
  *                              particular format.
-- 
1.7.9.5
