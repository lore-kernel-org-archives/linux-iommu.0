From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 05/12] memory: Add NVIDIA Tegra memory controller support
Date: Fri,  7 Nov 2014 17:00:56 +0100
Message-ID: <1415376063-17205-6-git-send-email-thierry.reding@gmail.com>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415376063-17205-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The memory controller on NVIDIA Tegra exposes various knobs that can be
used to tune the behaviour of the clients attached to it.

Currently this driver sets up the latency allowance registers to the HW
defaults. Eventually an API should be exported by this driver (via a
custom API or a generic subsystem) to allow clients to register latency
requirements.

This driver also registers an IOMMU (SMMU) that's implemented by the
memory controller. It is supported on Tegra30, Tegra114 and Tegra124
currently. Tegra20 has a GART instead.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Hi Joerg,

As I mentioned in the cover-letter, I would like to take this whole series
through the Tegra tree to simplify dependency handling. Can I have your
Acked-by on this patch?

Thanks,
Thierry

Changes in v6:
- add Kconfig options so that dependencies can be properly encoded
- split memory-controller and SMMU code into separate files
- move num_address_bits field from SMMU to MC structure

Changes in v5:
- remove unused tegra_mc_set_bandwidth() function
- split Tegra132 support into a separate patch
- use correct register for GPU SWGROUP
- fix build failures on 64-bit

Changes in v4:
- remove DMA/IOMMU integration glue
- don't initialize linear SMMU mapping
- fail attachment for non-masters
- free empty page tables

Changes in v3:
- drop changes related to probe ordering that were rejected
- remove old SMMU driver

 drivers/iommu/Makefile                   |    1 -
 drivers/iommu/tegra-smmu.c               | 1295 ------------------------------
 drivers/memory/Kconfig                   |   12 +-
 drivers/memory/Makefile                  |    3 +-
 drivers/memory/tegra/Kconfig             |   16 +
 drivers/memory/tegra/Makefile            |    8 +
 drivers/memory/tegra/mc.c                |  300 +++++++
 drivers/memory/tegra/mc.h                |  125 +++
 drivers/memory/tegra/smmu.c              |  716 +++++++++++++++++
 drivers/memory/tegra/tegra114.c          |  948 ++++++++++++++++++++++
 drivers/memory/tegra/tegra124.c          |  995 +++++++++++++++++++++++
 drivers/memory/tegra/tegra30.c           |  970 ++++++++++++++++++++++
 drivers/memory/tegra30-mc.c              |  378 ---------
 include/dt-bindings/memory/tegra114-mc.h |   25 +
 include/dt-bindings/memory/tegra124-mc.h |   31 +
 include/dt-bindings/memory/tegra30-mc.h  |   24 +
 16 files changed, 4162 insertions(+), 1685 deletions(-)
 delete mode 100644 drivers/iommu/tegra-smmu.c
 create mode 100644 drivers/memory/tegra/Kconfig
 create mode 100644 drivers/memory/tegra/Makefile
 create mode 100644 drivers/memory/tegra/mc.c
 create mode 100644 drivers/memory/tegra/mc.h
 create mode 100644 drivers/memory/tegra/smmu.c
 create mode 100644 drivers/memory/tegra/tegra114.c
 create mode 100644 drivers/memory/tegra/tegra124.c
 create mode 100644 drivers/memory/tegra/tegra30.c
 delete mode 100644 drivers/memory/tegra30-mc.c
 create mode 100644 include/dt-bindings/memory/tegra114-mc.h
 create mode 100644 include/dt-bindings/memory/tegra124-mc.h
 create mode 100644 include/dt-bindings/memory/tegra30-mc.h

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 7b976f294a69..f66df810b21c 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
 obj-$(CONFIG_OMAP_IOMMU_DEBUG) += omap-iommu-debug.o
 obj-$(CONFIG_ROCKCHIP_IOMMU) += rockchip-iommu.o
 obj-$(CONFIG_TEGRA_IOMMU_GART) += tegra-gart.o
-obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_SHMOBILE_IOMMU) += shmobile-iommu.o
 obj-$(CONFIG_SHMOBILE_IPMMU) += shmobile-ipmmu.o
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
deleted file mode 100644
index 3afdf43f732a..000000000000
--- a/drivers/iommu/tegra-smmu.c
+++ /dev/null
@@ -1,1295 +0,0 @@
-/*
- * IOMMU API for SMMU in Tegra30
- *
- * Copyright (c) 2011-2013, NVIDIA CORPORATION.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#define pr_fmt(fmt)	"%s(): " fmt, __func__
-
-#include <linux/err.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/mm.h>
-#include <linux/pagemap.h>
-#include <linux/device.h>
-#include <linux/sched.h>
-#include <linux/iommu.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_iommu.h>
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-
-#include <soc/tegra/ahb.h>
-
-#include <asm/page.h>
-#include <asm/cacheflush.h>
-
-enum smmu_hwgrp {
-	HWGRP_AFI,
-	HWGRP_AVPC,
-	HWGRP_DC,
-	HWGRP_DCB,
-	HWGRP_EPP,
-	HWGRP_G2,
-	HWGRP_HC,
-	HWGRP_HDA,
-	HWGRP_ISP,
-	HWGRP_MPE,
-	HWGRP_NV,
-	HWGRP_NV2,
-	HWGRP_PPCS,
-	HWGRP_SATA,
-	HWGRP_VDE,
-	HWGRP_VI,
-
-	HWGRP_COUNT,
-
-	HWGRP_END = ~0,
-};
-
-#define HWG_AFI		(1 << HWGRP_AFI)
-#define HWG_AVPC	(1 << HWGRP_AVPC)
-#define HWG_DC		(1 << HWGRP_DC)
-#define HWG_DCB		(1 << HWGRP_DCB)
-#define HWG_EPP		(1 << HWGRP_EPP)
-#define HWG_G2		(1 << HWGRP_G2)
-#define HWG_HC		(1 << HWGRP_HC)
-#define HWG_HDA		(1 << HWGRP_HDA)
-#define HWG_ISP		(1 << HWGRP_ISP)
-#define HWG_MPE		(1 << HWGRP_MPE)
-#define HWG_NV		(1 << HWGRP_NV)
-#define HWG_NV2		(1 << HWGRP_NV2)
-#define HWG_PPCS	(1 << HWGRP_PPCS)
-#define HWG_SATA	(1 << HWGRP_SATA)
-#define HWG_VDE		(1 << HWGRP_VDE)
-#define HWG_VI		(1 << HWGRP_VI)
-
-/* bitmap of the page sizes currently supported */
-#define SMMU_IOMMU_PGSIZES	(SZ_4K)
-
-#define SMMU_CONFIG				0x10
-#define SMMU_CONFIG_DISABLE			0
-#define SMMU_CONFIG_ENABLE			1
-
-/* REVISIT: To support multiple MCs */
-enum {
-	_MC = 0,
-};
-
-enum {
-	_TLB = 0,
-	_PTC,
-};
-
-#define SMMU_CACHE_CONFIG_BASE			0x14
-#define __SMMU_CACHE_CONFIG(mc, cache)		(SMMU_CACHE_CONFIG_BASE + 4 * cache)
-#define SMMU_CACHE_CONFIG(cache)		__SMMU_CACHE_CONFIG(_MC, cache)
-
-#define SMMU_CACHE_CONFIG_STATS_SHIFT		31
-#define SMMU_CACHE_CONFIG_STATS_ENABLE		(1 << SMMU_CACHE_CONFIG_STATS_SHIFT)
-#define SMMU_CACHE_CONFIG_STATS_TEST_SHIFT	30
-#define SMMU_CACHE_CONFIG_STATS_TEST		(1 << SMMU_CACHE_CONFIG_STATS_TEST_SHIFT)
-
-#define SMMU_TLB_CONFIG_HIT_UNDER_MISS__ENABLE	(1 << 29)
-#define SMMU_TLB_CONFIG_ACTIVE_LINES__VALUE	0x10
-#define SMMU_TLB_CONFIG_RESET_VAL		0x20000010
-
-#define SMMU_PTC_CONFIG_CACHE__ENABLE		(1 << 29)
-#define SMMU_PTC_CONFIG_INDEX_MAP__PATTERN	0x3f
-#define SMMU_PTC_CONFIG_RESET_VAL		0x2000003f
-
-#define SMMU_PTB_ASID				0x1c
-#define SMMU_PTB_ASID_CURRENT_SHIFT		0
-
-#define SMMU_PTB_DATA				0x20
-#define SMMU_PTB_DATA_RESET_VAL			0
-#define SMMU_PTB_DATA_ASID_NONSECURE_SHIFT	29
-#define SMMU_PTB_DATA_ASID_WRITABLE_SHIFT	30
-#define SMMU_PTB_DATA_ASID_READABLE_SHIFT	31
-
-#define SMMU_TLB_FLUSH				0x30
-#define SMMU_TLB_FLUSH_VA_MATCH_ALL		0
-#define SMMU_TLB_FLUSH_VA_MATCH_SECTION		2
-#define SMMU_TLB_FLUSH_VA_MATCH_GROUP		3
-#define SMMU_TLB_FLUSH_ASID_SHIFT		29
-#define SMMU_TLB_FLUSH_ASID_MATCH_DISABLE	0
-#define SMMU_TLB_FLUSH_ASID_MATCH_ENABLE	1
-#define SMMU_TLB_FLUSH_ASID_MATCH_SHIFT		31
-
-#define SMMU_PTC_FLUSH				0x34
-#define SMMU_PTC_FLUSH_TYPE_ALL			0
-#define SMMU_PTC_FLUSH_TYPE_ADR			1
-#define SMMU_PTC_FLUSH_ADR_SHIFT		4
-
-#define SMMU_ASID_SECURITY			0x38
-
-#define SMMU_STATS_CACHE_COUNT_BASE		0x1f0
-
-#define SMMU_STATS_CACHE_COUNT(mc, cache, hitmiss)		\
-	(SMMU_STATS_CACHE_COUNT_BASE + 8 * cache + 4 * hitmiss)
-
-#define SMMU_TRANSLATION_ENABLE_0		0x228
-#define SMMU_TRANSLATION_ENABLE_1		0x22c
-#define SMMU_TRANSLATION_ENABLE_2		0x230
-
-#define SMMU_AFI_ASID	0x238   /* PCIE */
-#define SMMU_AVPC_ASID	0x23c   /* AVP */
-#define SMMU_DC_ASID	0x240   /* Display controller */
-#define SMMU_DCB_ASID	0x244   /* Display controller B */
-#define SMMU_EPP_ASID	0x248   /* Encoder pre-processor */
-#define SMMU_G2_ASID	0x24c   /* 2D engine */
-#define SMMU_HC_ASID	0x250   /* Host1x */
-#define SMMU_HDA_ASID	0x254   /* High-def audio */
-#define SMMU_ISP_ASID	0x258   /* Image signal processor */
-#define SMMU_MPE_ASID	0x264   /* MPEG encoder */
-#define SMMU_NV_ASID	0x268   /* (3D) */
-#define SMMU_NV2_ASID	0x26c   /* (3D) */
-#define SMMU_PPCS_ASID	0x270   /* AHB */
-#define SMMU_SATA_ASID	0x278   /* SATA */
-#define SMMU_VDE_ASID	0x27c   /* Video decoder */
-#define SMMU_VI_ASID	0x280   /* Video input */
-
-#define SMMU_PDE_NEXT_SHIFT		28
-
-#define SMMU_TLB_FLUSH_VA_SECTION__MASK		0xffc00000
-#define SMMU_TLB_FLUSH_VA_SECTION__SHIFT	12 /* right shift */
-#define SMMU_TLB_FLUSH_VA_GROUP__MASK		0xffffc000
-#define SMMU_TLB_FLUSH_VA_GROUP__SHIFT		12 /* right shift */
-#define SMMU_TLB_FLUSH_VA(iova, which)	\
-	((((iova) & SMMU_TLB_FLUSH_VA_##which##__MASK) >> \
-		SMMU_TLB_FLUSH_VA_##which##__SHIFT) |	\
-	SMMU_TLB_FLUSH_VA_MATCH_##which)
-#define SMMU_PTB_ASID_CUR(n)	\
-		((n) << SMMU_PTB_ASID_CURRENT_SHIFT)
-#define SMMU_TLB_FLUSH_ASID_MATCH_disable		\
-		(SMMU_TLB_FLUSH_ASID_MATCH_DISABLE <<	\
-			SMMU_TLB_FLUSH_ASID_MATCH_SHIFT)
-#define SMMU_TLB_FLUSH_ASID_MATCH__ENABLE		\
-		(SMMU_TLB_FLUSH_ASID_MATCH_ENABLE <<	\
-			SMMU_TLB_FLUSH_ASID_MATCH_SHIFT)
-
-#define SMMU_PAGE_SHIFT 12
-#define SMMU_PAGE_SIZE	(1 << SMMU_PAGE_SHIFT)
-#define SMMU_PAGE_MASK	((1 << SMMU_PAGE_SHIFT) - 1)
-
-#define SMMU_PDIR_COUNT	1024
-#define SMMU_PDIR_SIZE	(sizeof(unsigned long) * SMMU_PDIR_COUNT)
-#define SMMU_PTBL_COUNT	1024
-#define SMMU_PTBL_SIZE	(sizeof(unsigned long) * SMMU_PTBL_COUNT)
-#define SMMU_PDIR_SHIFT	12
-#define SMMU_PDE_SHIFT	12
-#define SMMU_PTE_SHIFT	12
-#define SMMU_PFN_MASK	0x000fffff
-
-#define SMMU_ADDR_TO_PFN(addr)	((addr) >> 12)
-#define SMMU_ADDR_TO_PDN(addr)	((addr) >> 22)
-#define SMMU_PDN_TO_ADDR(pdn)	((pdn) << 22)
-
-#define _READABLE	(1 << SMMU_PTB_DATA_ASID_READABLE_SHIFT)
-#define _WRITABLE	(1 << SMMU_PTB_DATA_ASID_WRITABLE_SHIFT)
-#define _NONSECURE	(1 << SMMU_PTB_DATA_ASID_NONSECURE_SHIFT)
-#define _PDE_NEXT	(1 << SMMU_PDE_NEXT_SHIFT)
-#define _MASK_ATTR	(_READABLE | _WRITABLE | _NONSECURE)
-
-#define _PDIR_ATTR	(_READABLE | _WRITABLE | _NONSECURE)
-
-#define _PDE_ATTR	(_READABLE | _WRITABLE | _NONSECURE)
-#define _PDE_ATTR_N	(_PDE_ATTR | _PDE_NEXT)
-#define _PDE_VACANT(pdn)	(((pdn) << 10) | _PDE_ATTR)
-
-#define _PTE_ATTR	(_READABLE | _WRITABLE | _NONSECURE)
-#define _PTE_VACANT(addr)	(((addr) >> SMMU_PAGE_SHIFT) | _PTE_ATTR)
-
-#define SMMU_MK_PDIR(page, attr)	\
-		((page_to_phys(page) >> SMMU_PDIR_SHIFT) | (attr))
-#define SMMU_MK_PDE(page, attr)		\
-		(unsigned long)((page_to_phys(page) >> SMMU_PDE_SHIFT) | (attr))
-#define SMMU_EX_PTBL_PAGE(pde)		\
-		pfn_to_page((unsigned long)(pde) & SMMU_PFN_MASK)
-#define SMMU_PFN_TO_PTE(pfn, attr)	(unsigned long)((pfn) | (attr))
-
-#define SMMU_ASID_ENABLE(asid)	((asid) | (1 << 31))
-#define SMMU_ASID_DISABLE	0
-#define SMMU_ASID_ASID(n)	((n) & ~SMMU_ASID_ENABLE(0))
-
-#define NUM_SMMU_REG_BANKS	3
-
-#define smmu_client_enable_hwgrp(c, m)	smmu_client_set_hwgrp(c, m, 1)
-#define smmu_client_disable_hwgrp(c)	smmu_client_set_hwgrp(c, 0, 0)
-#define __smmu_client_enable_hwgrp(c, m) __smmu_client_set_hwgrp(c, m, 1)
-#define __smmu_client_disable_hwgrp(c)	__smmu_client_set_hwgrp(c, 0, 0)
-
-#define HWGRP_INIT(client) [HWGRP_##client] = SMMU_##client##_ASID
-
-static const u32 smmu_hwgrp_asid_reg[] = {
-	HWGRP_INIT(AFI),
-	HWGRP_INIT(AVPC),
-	HWGRP_INIT(DC),
-	HWGRP_INIT(DCB),
-	HWGRP_INIT(EPP),
-	HWGRP_INIT(G2),
-	HWGRP_INIT(HC),
-	HWGRP_INIT(HDA),
-	HWGRP_INIT(ISP),
-	HWGRP_INIT(MPE),
-	HWGRP_INIT(NV),
-	HWGRP_INIT(NV2),
-	HWGRP_INIT(PPCS),
-	HWGRP_INIT(SATA),
-	HWGRP_INIT(VDE),
-	HWGRP_INIT(VI),
-};
-#define HWGRP_ASID_REG(x) (smmu_hwgrp_asid_reg[x])
-
-/*
- * Per client for address space
- */
-struct smmu_client {
-	struct device		*dev;
-	struct list_head	list;
-	struct smmu_as		*as;
-	u32			hwgrp;
-};
-
-/*
- * Per address space
- */
-struct smmu_as {
-	struct smmu_device	*smmu;	/* back pointer to container */
-	unsigned int		asid;
-	spinlock_t		lock;	/* for pagetable */
-	struct page		*pdir_page;
-	unsigned long		pdir_attr;
-	unsigned long		pde_attr;
-	unsigned long		pte_attr;
-	unsigned int		*pte_count;
-
-	struct list_head	client;
-	spinlock_t		client_lock; /* for client list */
-};
-
-struct smmu_debugfs_info {
-	struct smmu_device *smmu;
-	int mc;
-	int cache;
-};
-
-/*
- * Per SMMU device - IOMMU device
- */
-struct smmu_device {
-	void __iomem	*regbase;	/* register offset base */
-	void __iomem	**regs;		/* register block start address array */
-	void __iomem	**rege;		/* register block end address array */
-	int		nregs;		/* number of register blocks */
-
-	unsigned long	iovmm_base;	/* remappable base address */
-	unsigned long	page_count;	/* total remappable size */
-	spinlock_t	lock;
-	char		*name;
-	struct device	*dev;
-	struct page *avp_vector_page;	/* dummy page shared by all AS's */
-
-	/*
-	 * Register image savers for suspend/resume
-	 */
-	unsigned long translation_enable_0;
-	unsigned long translation_enable_1;
-	unsigned long translation_enable_2;
-	unsigned long asid_security;
-
-	struct dentry *debugfs_root;
-	struct smmu_debugfs_info *debugfs_info;
-
-	struct device_node *ahb;
-
-	int		num_as;
-	struct smmu_as	as[0];		/* Run-time allocated array */
-};
-
-static struct smmu_device *smmu_handle; /* unique for a system */
-
-/*
- *	SMMU register accessors
- */
-static bool inline smmu_valid_reg(struct smmu_device *smmu,
-				  void __iomem *addr)
-{
-	int i;
-
-	for (i = 0; i < smmu->nregs; i++) {
-		if (addr < smmu->regs[i])
-			break;
-		if (addr <= smmu->rege[i])
-			return true;
-	}
-
-	return false;
-}
-
-static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
-{
-	void __iomem *addr = smmu->regbase + offs;
-
-	BUG_ON(!smmu_valid_reg(smmu, addr));
-
-	return readl(addr);
-}
-
-static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
-{
-	void __iomem *addr = smmu->regbase + offs;
-
-	BUG_ON(!smmu_valid_reg(smmu, addr));
-
-	writel(val, addr);
-}
-
-#define VA_PAGE_TO_PA(va, page)	\
-	(page_to_phys(page) + ((unsigned long)(va) & ~PAGE_MASK))
-
-#define FLUSH_CPU_DCACHE(va, page, size)	\
-	do {	\
-		unsigned long _pa_ = VA_PAGE_TO_PA(va, page);		\
-		__cpuc_flush_dcache_area((void *)(va), (size_t)(size));	\
-		outer_flush_range(_pa_, _pa_+(size_t)(size));		\
-	} while (0)
-
-/*
- * Any interaction between any block on PPSB and a block on APB or AHB
- * must have these read-back barriers to ensure the APB/AHB bus
- * transaction is complete before initiating activity on the PPSB
- * block.
- */
-#define FLUSH_SMMU_REGS(smmu)	smmu_read(smmu, SMMU_CONFIG)
-
-#define smmu_client_hwgrp(c) (u32)((c)->dev->platform_data)
-
-static int __smmu_client_set_hwgrp(struct smmu_client *c,
-				   unsigned long map, int on)
-{
-	int i;
-	struct smmu_as *as = c->as;
-	u32 val, offs, mask = SMMU_ASID_ENABLE(as->asid);
-	struct smmu_device *smmu = as->smmu;
-
-	WARN_ON(!on && map);
-	if (on && !map)
-		return -EINVAL;
-	if (!on)
-		map = smmu_client_hwgrp(c);
-
-	for_each_set_bit(i, &map, HWGRP_COUNT) {
-		offs = HWGRP_ASID_REG(i);
-		val = smmu_read(smmu, offs);
-		if (on) {
-			if (WARN_ON(val & mask))
-				goto err_hw_busy;
-			val |= mask;
-		} else {
-			WARN_ON((val & mask) == mask);
-			val &= ~mask;
-		}
-		smmu_write(smmu, val, offs);
-	}
-	FLUSH_SMMU_REGS(smmu);
-	c->hwgrp = map;
-	return 0;
-
-err_hw_busy:
-	for_each_set_bit(i, &map, HWGRP_COUNT) {
-		offs = HWGRP_ASID_REG(i);
-		val = smmu_read(smmu, offs);
-		val &= ~mask;
-		smmu_write(smmu, val, offs);
-	}
-	return -EBUSY;
-}
-
-static int smmu_client_set_hwgrp(struct smmu_client *c, u32 map, int on)
-{
-	u32 val;
-	unsigned long flags;
-	struct smmu_as *as = c->as;
-	struct smmu_device *smmu = as->smmu;
-
-	spin_lock_irqsave(&smmu->lock, flags);
-	val = __smmu_client_set_hwgrp(c, map, on);
-	spin_unlock_irqrestore(&smmu->lock, flags);
-	return val;
-}
-
-/*
- * Flush all TLB entries and all PTC entries
- * Caller must lock smmu
- */
-static void smmu_flush_regs(struct smmu_device *smmu, int enable)
-{
-	u32 val;
-
-	smmu_write(smmu, SMMU_PTC_FLUSH_TYPE_ALL, SMMU_PTC_FLUSH);
-	FLUSH_SMMU_REGS(smmu);
-	val = SMMU_TLB_FLUSH_VA_MATCH_ALL |
-		SMMU_TLB_FLUSH_ASID_MATCH_disable;
-	smmu_write(smmu, val, SMMU_TLB_FLUSH);
-
-	if (enable)
-		smmu_write(smmu, SMMU_CONFIG_ENABLE, SMMU_CONFIG);
-	FLUSH_SMMU_REGS(smmu);
-}
-
-static int smmu_setup_regs(struct smmu_device *smmu)
-{
-	int i;
-	u32 val;
-
-	for (i = 0; i < smmu->num_as; i++) {
-		struct smmu_as *as = &smmu->as[i];
-		struct smmu_client *c;
-
-		smmu_write(smmu, SMMU_PTB_ASID_CUR(as->asid), SMMU_PTB_ASID);
-		val = as->pdir_page ?
-			SMMU_MK_PDIR(as->pdir_page, as->pdir_attr) :
-			SMMU_PTB_DATA_RESET_VAL;
-		smmu_write(smmu, val, SMMU_PTB_DATA);
-
-		list_for_each_entry(c, &as->client, list)
-			__smmu_client_set_hwgrp(c, c->hwgrp, 1);
-	}
-
-	smmu_write(smmu, smmu->translation_enable_0, SMMU_TRANSLATION_ENABLE_0);
-	smmu_write(smmu, smmu->translation_enable_1, SMMU_TRANSLATION_ENABLE_1);
-	smmu_write(smmu, smmu->translation_enable_2, SMMU_TRANSLATION_ENABLE_2);
-	smmu_write(smmu, smmu->asid_security, SMMU_ASID_SECURITY);
-	smmu_write(smmu, SMMU_TLB_CONFIG_RESET_VAL, SMMU_CACHE_CONFIG(_TLB));
-	smmu_write(smmu, SMMU_PTC_CONFIG_RESET_VAL, SMMU_CACHE_CONFIG(_PTC));
-
-	smmu_flush_regs(smmu, 1);
-
-	return tegra_ahb_enable_smmu(smmu->ahb);
-}
-
-static void flush_ptc_and_tlb(struct smmu_device *smmu,
-		      struct smmu_as *as, dma_addr_t iova,
-		      unsigned long *pte, struct page *page, int is_pde)
-{
-	u32 val;
-	unsigned long tlb_flush_va = is_pde
-		?  SMMU_TLB_FLUSH_VA(iova, SECTION)
-		:  SMMU_TLB_FLUSH_VA(iova, GROUP);
-
-	val = SMMU_PTC_FLUSH_TYPE_ADR | VA_PAGE_TO_PA(pte, page);
-	smmu_write(smmu, val, SMMU_PTC_FLUSH);
-	FLUSH_SMMU_REGS(smmu);
-	val = tlb_flush_va |
-		SMMU_TLB_FLUSH_ASID_MATCH__ENABLE |
-		(as->asid << SMMU_TLB_FLUSH_ASID_SHIFT);
-	smmu_write(smmu, val, SMMU_TLB_FLUSH);
-	FLUSH_SMMU_REGS(smmu);
-}
-
-static void free_ptbl(struct smmu_as *as, dma_addr_t iova)
-{
-	unsigned long pdn = SMMU_ADDR_TO_PDN(iova);
-	unsigned long *pdir = (unsigned long *)page_address(as->pdir_page);
-
-	if (pdir[pdn] != _PDE_VACANT(pdn)) {
-		dev_dbg(as->smmu->dev, "pdn: %lx\n", pdn);
-
-		ClearPageReserved(SMMU_EX_PTBL_PAGE(pdir[pdn]));
-		__free_page(SMMU_EX_PTBL_PAGE(pdir[pdn]));
-		pdir[pdn] = _PDE_VACANT(pdn);
-		FLUSH_CPU_DCACHE(&pdir[pdn], as->pdir_page, sizeof pdir[pdn]);
-		flush_ptc_and_tlb(as->smmu, as, iova, &pdir[pdn],
-				  as->pdir_page, 1);
-	}
-}
-
-static void free_pdir(struct smmu_as *as)
-{
-	unsigned addr;
-	int count;
-	struct device *dev = as->smmu->dev;
-
-	if (!as->pdir_page)
-		return;
-
-	addr = as->smmu->iovmm_base;
-	count = as->smmu->page_count;
-	while (count-- > 0) {
-		free_ptbl(as, addr);
-		addr += SMMU_PAGE_SIZE * SMMU_PTBL_COUNT;
-	}
-	ClearPageReserved(as->pdir_page);
-	__free_page(as->pdir_page);
-	as->pdir_page = NULL;
-	devm_kfree(dev, as->pte_count);
-	as->pte_count = NULL;
-}
-
-/*
- * Maps PTBL for given iova and returns the PTE address
- * Caller must unmap the mapped PTBL returned in *ptbl_page_p
- */
-static unsigned long *locate_pte(struct smmu_as *as,
-				 dma_addr_t iova, bool allocate,
-				 struct page **ptbl_page_p,
-				 unsigned int **count)
-{
-	unsigned long ptn = SMMU_ADDR_TO_PFN(iova);
-	unsigned long pdn = SMMU_ADDR_TO_PDN(iova);
-	unsigned long *pdir = page_address(as->pdir_page);
-	unsigned long *ptbl;
-
-	if (pdir[pdn] != _PDE_VACANT(pdn)) {
-		/* Mapped entry table already exists */
-		*ptbl_page_p = SMMU_EX_PTBL_PAGE(pdir[pdn]);
-		ptbl = page_address(*ptbl_page_p);
-	} else if (!allocate) {
-		return NULL;
-	} else {
-		int pn;
-		unsigned long addr = SMMU_PDN_TO_ADDR(pdn);
-
-		/* Vacant - allocate a new page table */
-		dev_dbg(as->smmu->dev, "New PTBL pdn: %lx\n", pdn);
-
-		*ptbl_page_p = alloc_page(GFP_ATOMIC);
-		if (!*ptbl_page_p) {
-			dev_err(as->smmu->dev,
-				"failed to allocate smmu_device page table\n");
-			return NULL;
-		}
-		SetPageReserved(*ptbl_page_p);
-		ptbl = (unsigned long *)page_address(*ptbl_page_p);
-		for (pn = 0; pn < SMMU_PTBL_COUNT;
-		     pn++, addr += SMMU_PAGE_SIZE) {
-			ptbl[pn] = _PTE_VACANT(addr);
-		}
-		FLUSH_CPU_DCACHE(ptbl, *ptbl_page_p, SMMU_PTBL_SIZE);
-		pdir[pdn] = SMMU_MK_PDE(*ptbl_page_p,
-					as->pde_attr | _PDE_NEXT);
-		FLUSH_CPU_DCACHE(&pdir[pdn], as->pdir_page, sizeof pdir[pdn]);
-		flush_ptc_and_tlb(as->smmu, as, iova, &pdir[pdn],
-				  as->pdir_page, 1);
-	}
-	*count = &as->pte_count[pdn];
-
-	return &ptbl[ptn % SMMU_PTBL_COUNT];
-}
-
-#ifdef CONFIG_SMMU_SIG_DEBUG
-static void put_signature(struct smmu_as *as,
-			  dma_addr_t iova, unsigned long pfn)
-{
-	struct page *page;
-	unsigned long *vaddr;
-
-	page = pfn_to_page(pfn);
-	vaddr = page_address(page);
-	if (!vaddr)
-		return;
-
-	vaddr[0] = iova;
-	vaddr[1] = pfn << PAGE_SHIFT;
-	FLUSH_CPU_DCACHE(vaddr, page, sizeof(vaddr[0]) * 2);
-}
-#else
-static inline void put_signature(struct smmu_as *as,
-				 unsigned long addr, unsigned long pfn)
-{
-}
-#endif
-
-/*
- * Caller must not hold as->lock
- */
-static int alloc_pdir(struct smmu_as *as)
-{
-	unsigned long *pdir, flags;
-	int pdn, err = 0;
-	u32 val;
-	struct smmu_device *smmu = as->smmu;
-	struct page *page;
-	unsigned int *cnt;
-
-	/*
-	 * do the allocation, then grab as->lock
-	 */
-	cnt = devm_kzalloc(smmu->dev,
-			   sizeof(cnt[0]) * SMMU_PDIR_COUNT,
-			   GFP_KERNEL);
-	page = alloc_page(GFP_KERNEL | __GFP_DMA);
-
-	spin_lock_irqsave(&as->lock, flags);
-
-	if (as->pdir_page) {
-		/* We raced, free the redundant */
-		err = -EAGAIN;
-		goto err_out;
-	}
-
-	if (!page || !cnt) {
-		dev_err(smmu->dev, "failed to allocate at %s\n", __func__);
-		err = -ENOMEM;
-		goto err_out;
-	}
-
-	as->pdir_page = page;
-	as->pte_count = cnt;
-
-	SetPageReserved(as->pdir_page);
-	pdir = page_address(as->pdir_page);
-
-	for (pdn = 0; pdn < SMMU_PDIR_COUNT; pdn++)
-		pdir[pdn] = _PDE_VACANT(pdn);
-	FLUSH_CPU_DCACHE(pdir, as->pdir_page, SMMU_PDIR_SIZE);
-	val = SMMU_PTC_FLUSH_TYPE_ADR | VA_PAGE_TO_PA(pdir, as->pdir_page);
-	smmu_write(smmu, val, SMMU_PTC_FLUSH);
-	FLUSH_SMMU_REGS(as->smmu);
-	val = SMMU_TLB_FLUSH_VA_MATCH_ALL |
-		SMMU_TLB_FLUSH_ASID_MATCH__ENABLE |
-		(as->asid << SMMU_TLB_FLUSH_ASID_SHIFT);
-	smmu_write(smmu, val, SMMU_TLB_FLUSH);
-	FLUSH_SMMU_REGS(as->smmu);
-
-	spin_unlock_irqrestore(&as->lock, flags);
-
-	return 0;
-
-err_out:
-	spin_unlock_irqrestore(&as->lock, flags);
-
-	devm_kfree(smmu->dev, cnt);
-	if (page)
-		__free_page(page);
-	return err;
-}
-
-static void __smmu_iommu_unmap(struct smmu_as *as, dma_addr_t iova)
-{
-	unsigned long *pte;
-	struct page *page;
-	unsigned int *count;
-
-	pte = locate_pte(as, iova, false, &page, &count);
-	if (WARN_ON(!pte))
-		return;
-
-	if (WARN_ON(*pte == _PTE_VACANT(iova)))
-		return;
-
-	*pte = _PTE_VACANT(iova);
-	FLUSH_CPU_DCACHE(pte, page, sizeof(*pte));
-	flush_ptc_and_tlb(as->smmu, as, iova, pte, page, 0);
-	if (!--(*count))
-		free_ptbl(as, iova);
-}
-
-static void __smmu_iommu_map_pfn(struct smmu_as *as, dma_addr_t iova,
-				 unsigned long pfn)
-{
-	struct smmu_device *smmu = as->smmu;
-	unsigned long *pte;
-	unsigned int *count;
-	struct page *page;
-
-	pte = locate_pte(as, iova, true, &page, &count);
-	if (WARN_ON(!pte))
-		return;
-
-	if (*pte == _PTE_VACANT(iova))
-		(*count)++;
-	*pte = SMMU_PFN_TO_PTE(pfn, as->pte_attr);
-	if (unlikely((*pte == _PTE_VACANT(iova))))
-		(*count)--;
-	FLUSH_CPU_DCACHE(pte, page, sizeof(*pte));
-	flush_ptc_and_tlb(smmu, as, iova, pte, page, 0);
-	put_signature(as, iova, pfn);
-}
-
-static int smmu_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t pa, size_t bytes, int prot)
-{
-	struct smmu_as *as = domain->priv;
-	unsigned long pfn = __phys_to_pfn(pa);
-	unsigned long flags;
-
-	dev_dbg(as->smmu->dev, "[%d] %08lx:%pa\n", as->asid, iova, &pa);
-
-	if (!pfn_valid(pfn))
-		return -ENOMEM;
-
-	spin_lock_irqsave(&as->lock, flags);
-	__smmu_iommu_map_pfn(as, iova, pfn);
-	spin_unlock_irqrestore(&as->lock, flags);
-	return 0;
-}
-
-static size_t smmu_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t bytes)
-{
-	struct smmu_as *as = domain->priv;
-	unsigned long flags;
-
-	dev_dbg(as->smmu->dev, "[%d] %08lx\n", as->asid, iova);
-
-	spin_lock_irqsave(&as->lock, flags);
-	__smmu_iommu_unmap(as, iova);
-	spin_unlock_irqrestore(&as->lock, flags);
-	return SMMU_PAGE_SIZE;
-}
-
-static phys_addr_t smmu_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
-{
-	struct smmu_as *as = domain->priv;
-	unsigned long *pte;
-	unsigned int *count;
-	struct page *page;
-	unsigned long pfn;
-	unsigned long flags;
-
-	spin_lock_irqsave(&as->lock, flags);
-
-	pte = locate_pte(as, iova, true, &page, &count);
-	pfn = *pte & SMMU_PFN_MASK;
-	WARN_ON(!pfn_valid(pfn));
-	dev_dbg(as->smmu->dev,
-		"iova:%08llx pfn:%08lx asid:%d\n", (unsigned long long)iova,
-		 pfn, as->asid);
-
-	spin_unlock_irqrestore(&as->lock, flags);
-	return PFN_PHYS(pfn);
-}
-
-static bool smmu_iommu_capable(enum iommu_cap cap)
-{
-	return false;
-}
-
-static int smmu_iommu_attach_dev(struct iommu_domain *domain,
-				 struct device *dev)
-{
-	struct smmu_as *as = domain->priv;
-	struct smmu_device *smmu = as->smmu;
-	struct smmu_client *client, *c;
-	u32 map;
-	int err;
-
-	client = devm_kzalloc(smmu->dev, sizeof(*c), GFP_KERNEL);
-	if (!client)
-		return -ENOMEM;
-	client->dev = dev;
-	client->as = as;
-	map = (unsigned long)dev->platform_data;
-	if (!map)
-		return -EINVAL;
-
-	err = smmu_client_enable_hwgrp(client, map);
-	if (err)
-		goto err_hwgrp;
-
-	spin_lock(&as->client_lock);
-	list_for_each_entry(c, &as->client, list) {
-		if (c->dev == dev) {
-			dev_err(smmu->dev,
-				"%s is already attached\n", dev_name(c->dev));
-			err = -EINVAL;
-			goto err_client;
-		}
-	}
-	list_add(&client->list, &as->client);
-	spin_unlock(&as->client_lock);
-
-	/*
-	 * Reserve "page zero" for AVP vectors using a common dummy
-	 * page.
-	 */
-	if (map & HWG_AVPC) {
-		struct page *page;
-
-		page = as->smmu->avp_vector_page;
-		__smmu_iommu_map_pfn(as, 0, page_to_pfn(page));
-
-		pr_info("Reserve \"page zero\" for AVP vectors using a common dummy\n");
-	}
-
-	dev_dbg(smmu->dev, "%s is attached\n", dev_name(dev));
-	return 0;
-
-err_client:
-	smmu_client_disable_hwgrp(client);
-	spin_unlock(&as->client_lock);
-err_hwgrp:
-	devm_kfree(smmu->dev, client);
-	return err;
-}
-
-static void smmu_iommu_detach_dev(struct iommu_domain *domain,
-				  struct device *dev)
-{
-	struct smmu_as *as = domain->priv;
-	struct smmu_device *smmu = as->smmu;
-	struct smmu_client *c;
-
-	spin_lock(&as->client_lock);
-
-	list_for_each_entry(c, &as->client, list) {
-		if (c->dev == dev) {
-			smmu_client_disable_hwgrp(c);
-			list_del(&c->list);
-			devm_kfree(smmu->dev, c);
-			c->as = NULL;
-			dev_dbg(smmu->dev,
-				"%s is detached\n", dev_name(c->dev));
-			goto out;
-		}
-	}
-	dev_err(smmu->dev, "Couldn't find %s\n", dev_name(dev));
-out:
-	spin_unlock(&as->client_lock);
-}
-
-static int smmu_iommu_domain_init(struct iommu_domain *domain)
-{
-	int i, err = -EAGAIN;
-	unsigned long flags;
-	struct smmu_as *as;
-	struct smmu_device *smmu = smmu_handle;
-
-	/* Look for a free AS with lock held */
-	for  (i = 0; i < smmu->num_as; i++) {
-		as = &smmu->as[i];
-
-		if (as->pdir_page)
-			continue;
-
-		err = alloc_pdir(as);
-		if (!err)
-			goto found;
-
-		if (err != -EAGAIN)
-			break;
-	}
-	if (i == smmu->num_as)
-		dev_err(smmu->dev,  "no free AS\n");
-	return err;
-
-found:
-	spin_lock_irqsave(&smmu->lock, flags);
-
-	/* Update PDIR register */
-	smmu_write(smmu, SMMU_PTB_ASID_CUR(as->asid), SMMU_PTB_ASID);
-	smmu_write(smmu,
-		   SMMU_MK_PDIR(as->pdir_page, as->pdir_attr), SMMU_PTB_DATA);
-	FLUSH_SMMU_REGS(smmu);
-
-	spin_unlock_irqrestore(&smmu->lock, flags);
-
-	domain->priv = as;
-
-	domain->geometry.aperture_start = smmu->iovmm_base;
-	domain->geometry.aperture_end   = smmu->iovmm_base +
-		smmu->page_count * SMMU_PAGE_SIZE - 1;
-	domain->geometry.force_aperture = true;
-
-	dev_dbg(smmu->dev, "smmu_as@%p\n", as);
-
-	return 0;
-}
-
-static void smmu_iommu_domain_destroy(struct iommu_domain *domain)
-{
-	struct smmu_as *as = domain->priv;
-	struct smmu_device *smmu = as->smmu;
-	unsigned long flags;
-
-	spin_lock_irqsave(&as->lock, flags);
-
-	if (as->pdir_page) {
-		spin_lock(&smmu->lock);
-		smmu_write(smmu, SMMU_PTB_ASID_CUR(as->asid), SMMU_PTB_ASID);
-		smmu_write(smmu, SMMU_PTB_DATA_RESET_VAL, SMMU_PTB_DATA);
-		FLUSH_SMMU_REGS(smmu);
-		spin_unlock(&smmu->lock);
-
-		free_pdir(as);
-	}
-
-	if (!list_empty(&as->client)) {
-		struct smmu_client *c;
-
-		list_for_each_entry(c, &as->client, list)
-			smmu_iommu_detach_dev(domain, c->dev);
-	}
-
-	spin_unlock_irqrestore(&as->lock, flags);
-
-	domain->priv = NULL;
-	dev_dbg(smmu->dev, "smmu_as@%p\n", as);
-}
-
-static const struct iommu_ops smmu_iommu_ops = {
-	.capable	= smmu_iommu_capable,
-	.domain_init	= smmu_iommu_domain_init,
-	.domain_destroy	= smmu_iommu_domain_destroy,
-	.attach_dev	= smmu_iommu_attach_dev,
-	.detach_dev	= smmu_iommu_detach_dev,
-	.map		= smmu_iommu_map,
-	.unmap		= smmu_iommu_unmap,
-	.iova_to_phys	= smmu_iommu_iova_to_phys,
-	.pgsize_bitmap	= SMMU_IOMMU_PGSIZES,
-};
-
-/* Should be in the order of enum */
-static const char * const smmu_debugfs_mc[] = { "mc", };
-static const char * const smmu_debugfs_cache[] = {  "tlb", "ptc", };
-
-static ssize_t smmu_debugfs_stats_write(struct file *file,
-					const char __user *buffer,
-					size_t count, loff_t *pos)
-{
-	struct smmu_debugfs_info *info;
-	struct smmu_device *smmu;
-	int i;
-	enum {
-		_OFF = 0,
-		_ON,
-		_RESET,
-	};
-	const char * const command[] = {
-		[_OFF]		= "off",
-		[_ON]		= "on",
-		[_RESET]	= "reset",
-	};
-	char str[] = "reset";
-	u32 val;
-	size_t offs;
-
-	count = min_t(size_t, count, sizeof(str));
-	if (copy_from_user(str, buffer, count))
-		return -EINVAL;
-
-	for (i = 0; i < ARRAY_SIZE(command); i++)
-		if (strncmp(str, command[i],
-			    strlen(command[i])) == 0)
-			break;
-
-	if (i == ARRAY_SIZE(command))
-		return -EINVAL;
-
-	info = file_inode(file)->i_private;
-	smmu = info->smmu;
-
-	offs = SMMU_CACHE_CONFIG(info->cache);
-	val = smmu_read(smmu, offs);
-	switch (i) {
-	case _OFF:
-		val &= ~SMMU_CACHE_CONFIG_STATS_ENABLE;
-		val &= ~SMMU_CACHE_CONFIG_STATS_TEST;
-		smmu_write(smmu, val, offs);
-		break;
-	case _ON:
-		val |= SMMU_CACHE_CONFIG_STATS_ENABLE;
-		val &= ~SMMU_CACHE_CONFIG_STATS_TEST;
-		smmu_write(smmu, val, offs);
-		break;
-	case _RESET:
-		val |= SMMU_CACHE_CONFIG_STATS_TEST;
-		smmu_write(smmu, val, offs);
-		val &= ~SMMU_CACHE_CONFIG_STATS_TEST;
-		smmu_write(smmu, val, offs);
-		break;
-	default:
-		BUG();
-		break;
-	}
-
-	dev_dbg(smmu->dev, "%s() %08x, %08x @%08x\n", __func__,
-		val, smmu_read(smmu, offs), offs);
-
-	return count;
-}
-
-static int smmu_debugfs_stats_show(struct seq_file *s, void *v)
-{
-	struct smmu_debugfs_info *info = s->private;
-	struct smmu_device *smmu = info->smmu;
-	int i;
-	const char * const stats[] = { "hit", "miss", };
-
-
-	for (i = 0; i < ARRAY_SIZE(stats); i++) {
-		u32 val;
-		size_t offs;
-
-		offs = SMMU_STATS_CACHE_COUNT(info->mc, info->cache, i);
-		val = smmu_read(smmu, offs);
-		seq_printf(s, "%s:%08x ", stats[i], val);
-
-		dev_dbg(smmu->dev, "%s() %s %08x @%08x\n", __func__,
-			stats[i], val, offs);
-	}
-	seq_printf(s, "\n");
-	return 0;
-}
-
-static int smmu_debugfs_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, smmu_debugfs_stats_show, inode->i_private);
-}
-
-static const struct file_operations smmu_debugfs_stats_fops = {
-	.open		= smmu_debugfs_stats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.write		= smmu_debugfs_stats_write,
-};
-
-static void smmu_debugfs_delete(struct smmu_device *smmu)
-{
-	debugfs_remove_recursive(smmu->debugfs_root);
-	kfree(smmu->debugfs_info);
-}
-
-static void smmu_debugfs_create(struct smmu_device *smmu)
-{
-	int i;
-	size_t bytes;
-	struct dentry *root;
-
-	bytes = ARRAY_SIZE(smmu_debugfs_mc) * ARRAY_SIZE(smmu_debugfs_cache) *
-		sizeof(*smmu->debugfs_info);
-	smmu->debugfs_info = kmalloc(bytes, GFP_KERNEL);
-	if (!smmu->debugfs_info)
-		return;
-
-	root = debugfs_create_dir(dev_name(smmu->dev), NULL);
-	if (!root)
-		goto err_out;
-	smmu->debugfs_root = root;
-
-	for (i = 0; i < ARRAY_SIZE(smmu_debugfs_mc); i++) {
-		int j;
-		struct dentry *mc;
-
-		mc = debugfs_create_dir(smmu_debugfs_mc[i], root);
-		if (!mc)
-			goto err_out;
-
-		for (j = 0; j < ARRAY_SIZE(smmu_debugfs_cache); j++) {
-			struct dentry *cache;
-			struct smmu_debugfs_info *info;
-
-			info = smmu->debugfs_info;
-			info += i * ARRAY_SIZE(smmu_debugfs_mc) + j;
-			info->smmu = smmu;
-			info->mc = i;
-			info->cache = j;
-
-			cache = debugfs_create_file(smmu_debugfs_cache[j],
-						    S_IWUGO | S_IRUGO, mc,
-						    (void *)info,
-						    &smmu_debugfs_stats_fops);
-			if (!cache)
-				goto err_out;
-		}
-	}
-
-	return;
-
-err_out:
-	smmu_debugfs_delete(smmu);
-}
-
-static int tegra_smmu_suspend(struct device *dev)
-{
-	struct smmu_device *smmu = dev_get_drvdata(dev);
-
-	smmu->translation_enable_0 = smmu_read(smmu, SMMU_TRANSLATION_ENABLE_0);
-	smmu->translation_enable_1 = smmu_read(smmu, SMMU_TRANSLATION_ENABLE_1);
-	smmu->translation_enable_2 = smmu_read(smmu, SMMU_TRANSLATION_ENABLE_2);
-	smmu->asid_security = smmu_read(smmu, SMMU_ASID_SECURITY);
-	return 0;
-}
-
-static int tegra_smmu_resume(struct device *dev)
-{
-	struct smmu_device *smmu = dev_get_drvdata(dev);
-	unsigned long flags;
-	int err;
-
-	spin_lock_irqsave(&smmu->lock, flags);
-	err = smmu_setup_regs(smmu);
-	spin_unlock_irqrestore(&smmu->lock, flags);
-	return err;
-}
-
-static int tegra_smmu_probe(struct platform_device *pdev)
-{
-	struct smmu_device *smmu;
-	struct device *dev = &pdev->dev;
-	int i, asids, err = 0;
-	dma_addr_t uninitialized_var(base);
-	size_t bytes, uninitialized_var(size);
-
-	if (smmu_handle)
-		return -EIO;
-
-	BUILD_BUG_ON(PAGE_SHIFT != SMMU_PAGE_SHIFT);
-
-	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
-		return -ENODEV;
-
-	bytes = sizeof(*smmu) + asids * sizeof(*smmu->as);
-	smmu = devm_kzalloc(dev, bytes, GFP_KERNEL);
-	if (!smmu) {
-		dev_err(dev, "failed to allocate smmu_device\n");
-		return -ENOMEM;
-	}
-
-	smmu->nregs = pdev->num_resources;
-	smmu->regs = devm_kzalloc(dev, 2 * smmu->nregs * sizeof(*smmu->regs),
-				  GFP_KERNEL);
-	smmu->rege = smmu->regs + smmu->nregs;
-	if (!smmu->regs)
-		return -ENOMEM;
-	for (i = 0; i < smmu->nregs; i++) {
-		struct resource *res;
-
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		smmu->regs[i] = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(smmu->regs[i]))
-			return PTR_ERR(smmu->regs[i]);
-		smmu->rege[i] = smmu->regs[i] + resource_size(res) - 1;
-	}
-	/* Same as "mc" 1st regiter block start address */
-	smmu->regbase = (void __iomem *)((u32)smmu->regs[0] & PAGE_MASK);
-
-	err = of_get_dma_window(dev->of_node, NULL, 0, NULL, &base, &size);
-	if (err)
-		return -ENODEV;
-
-	if (size & SMMU_PAGE_MASK)
-		return -EINVAL;
-
-	size >>= SMMU_PAGE_SHIFT;
-	if (!size)
-		return -EINVAL;
-
-	smmu->ahb = of_parse_phandle(dev->of_node, "nvidia,ahb", 0);
-	if (!smmu->ahb)
-		return -ENODEV;
-
-	smmu->dev = dev;
-	smmu->num_as = asids;
-	smmu->iovmm_base = base;
-	smmu->page_count = size;
-
-	smmu->translation_enable_0 = ~0;
-	smmu->translation_enable_1 = ~0;
-	smmu->translation_enable_2 = ~0;
-	smmu->asid_security = 0;
-
-	for (i = 0; i < smmu->num_as; i++) {
-		struct smmu_as *as = &smmu->as[i];
-
-		as->smmu = smmu;
-		as->asid = i;
-		as->pdir_attr = _PDIR_ATTR;
-		as->pde_attr = _PDE_ATTR;
-		as->pte_attr = _PTE_ATTR;
-
-		spin_lock_init(&as->lock);
-		spin_lock_init(&as->client_lock);
-		INIT_LIST_HEAD(&as->client);
-	}
-	spin_lock_init(&smmu->lock);
-	err = smmu_setup_regs(smmu);
-	if (err)
-		return err;
-	platform_set_drvdata(pdev, smmu);
-
-	smmu->avp_vector_page = alloc_page(GFP_KERNEL);
-	if (!smmu->avp_vector_page)
-		return -ENOMEM;
-
-	smmu_debugfs_create(smmu);
-	smmu_handle = smmu;
-	bus_set_iommu(&platform_bus_type, &smmu_iommu_ops);
-	return 0;
-}
-
-static int tegra_smmu_remove(struct platform_device *pdev)
-{
-	struct smmu_device *smmu = platform_get_drvdata(pdev);
-	int i;
-
-	smmu_debugfs_delete(smmu);
-
-	smmu_write(smmu, SMMU_CONFIG_DISABLE, SMMU_CONFIG);
-	for (i = 0; i < smmu->num_as; i++)
-		free_pdir(&smmu->as[i]);
-	__free_page(smmu->avp_vector_page);
-	smmu_handle = NULL;
-	return 0;
-}
-
-static const struct dev_pm_ops tegra_smmu_pm_ops = {
-	.suspend	= tegra_smmu_suspend,
-	.resume		= tegra_smmu_resume,
-};
-
-static const struct of_device_id tegra_smmu_of_match[] = {
-	{ .compatible = "nvidia,tegra30-smmu", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, tegra_smmu_of_match);
-
-static struct platform_driver tegra_smmu_driver = {
-	.probe		= tegra_smmu_probe,
-	.remove		= tegra_smmu_remove,
-	.driver = {
-		.owner	= THIS_MODULE,
-		.name	= "tegra-smmu",
-		.pm	= &tegra_smmu_pm_ops,
-		.of_match_table = tegra_smmu_of_match,
-	},
-};
-
-static int tegra_smmu_init(void)
-{
-	return platform_driver_register(&tegra_smmu_driver);
-}
-
-static void __exit tegra_smmu_exit(void)
-{
-	platform_driver_unregister(&tegra_smmu_driver);
-}
-
-subsys_initcall(tegra_smmu_init);
-module_exit(tegra_smmu_exit);
-
-MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra30");
-MODULE_AUTHOR("Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
-MODULE_ALIAS("platform:tegra-smmu");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 6d91c27fd4c8..08bd4cfca2a4 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -61,16 +61,6 @@ config TEGRA20_MC
 	  analysis, especially for IOMMU/GART(Graphics Address
 	  Relocation Table) module.
 
-config TEGRA30_MC
-	bool "Tegra30 Memory Controller(MC) driver"
-	default y
-	depends on ARCH_TEGRA_3x_SOC
-	help
-	  This driver is for the Memory Controller(MC) module available
-	  in Tegra30 SoCs, mainly for a address translation fault
-	  analysis, especially for IOMMU/SMMU(System Memory Management
-	  Unit) module.
-
 config FSL_CORENET_CF
 	tristate "Freescale CoreNet Error Reporting"
 	depends on FSL_SOC_BOOKE
@@ -85,4 +75,6 @@ config FSL_IFC
 	bool
 	depends on FSL_SOC
 
+source "drivers/memory/tegra/Kconfig"
+
 endif
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index c32d31981be3..ad98bb232623 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -12,4 +12,5 @@ obj-$(CONFIG_FSL_CORENET_CF)	+= fsl-corenet-cf.o
 obj-$(CONFIG_FSL_IFC)		+= fsl_ifc.o
 obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
 obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
-obj-$(CONFIG_TEGRA30_MC)	+= tegra30-mc.o
+
+obj-$(CONFIG_TEGRA_MC)		+= tegra/
diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
new file mode 100644
index 000000000000..8dd06d2be8f1
--- /dev/null
+++ b/drivers/memory/tegra/Kconfig
@@ -0,0 +1,16 @@
+config TEGRA_MC
+	bool "NVIDIA Tegra Memory Controller support"
+	default y
+	depends on ARCH_TEGRA
+	help
+	  This driver supports the Memory Controller (MC) hardware found on
+	  NVIDIA Tegra SoCs.
+
+config TEGRA_IOMMU_SMMU
+	bool "NVIDIA Tegra SMMU support"
+	default y
+	depends on TEGRA_MC
+	select IOMMU_API
+	help
+	  This driver supports the IOMMU hardware (SMMU) found on NVIDIA Tegra
+	  SoCs (Tegra30 up to Tegra124).
diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
new file mode 100644
index 000000000000..b0732cc5686a
--- /dev/null
+++ b/drivers/memory/tegra/Makefile
@@ -0,0 +1,8 @@
+tegra-mc-y := mc.o
+tegra-mc-$(CONFIG_TEGRA_IOMMU_SMMU) += smmu.o
+
+tegra-mc-$(CONFIG_ARCH_TEGRA_3x_SOC)  += tegra30.o
+tegra-mc-$(CONFIG_ARCH_TEGRA_114_SOC) += tegra114.o
+tegra-mc-$(CONFIG_ARCH_TEGRA_124_SOC) += tegra124.o
+
+obj-$(CONFIG_TEGRA_MC) += tegra-mc.o
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
new file mode 100644
index 000000000000..359281def893
--- /dev/null
+++ b/drivers/memory/tegra/mc.c
@@ -0,0 +1,300 @@
+/*
+ * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "mc.h"
+
+#define MC_INTSTATUS 0x000
+#define  MC_INT_DECERR_MTS (1 << 16)
+#define  MC_INT_SECERR_SEC (1 << 13)
+#define  MC_INT_DECERR_VPR (1 << 12)
+#define  MC_INT_INVALID_APB_ASID_UPDATE (1 << 11)
+#define  MC_INT_INVALID_SMMU_PAGE (1 << 10)
+#define  MC_INT_ARBITRATION_EMEM (1 << 9)
+#define  MC_INT_SECURITY_VIOLATION (1 << 8)
+#define  MC_INT_DECERR_EMEM (1 << 6)
+
+#define MC_INTMASK 0x004
+
+#define MC_ERR_STATUS 0x08
+#define  MC_ERR_STATUS_TYPE_SHIFT 28
+#define  MC_ERR_STATUS_TYPE_INVALID_SMMU_PAGE (6 << MC_ERR_STATUS_TYPE_SHIFT)
+#define  MC_ERR_STATUS_TYPE_MASK (0x7 << MC_ERR_STATUS_TYPE_SHIFT)
+#define  MC_ERR_STATUS_READABLE (1 << 27)
+#define  MC_ERR_STATUS_WRITABLE (1 << 26)
+#define  MC_ERR_STATUS_NONSECURE (1 << 25)
+#define  MC_ERR_STATUS_ADR_HI_SHIFT 20
+#define  MC_ERR_STATUS_ADR_HI_MASK 0x3
+#define  MC_ERR_STATUS_SECURITY (1 << 17)
+#define  MC_ERR_STATUS_RW (1 << 16)
+#define  MC_ERR_STATUS_CLIENT_MASK 0x7f
+
+#define MC_ERR_ADR 0x0c
+
+#define MC_EMEM_ARB_CFG 0x90
+#define  MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE(x)	(((x) & 0x1ff) << 0)
+#define  MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE_MASK	0x1ff
+#define MC_EMEM_ARB_MISC0 0xd8
+
+static const struct of_device_id tegra_mc_of_match[] = {
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+	{ .compatible = "nvidia,tegra30-mc", .data = &tegra30_mc_soc },
+#endif
+#ifdef CONFIG_ARCH_TEGRA_114_SOC
+	{ .compatible = "nvidia,tegra114-mc", .data = &tegra114_mc_soc },
+#endif
+#ifdef CONFIG_ARCH_TEGRA_124_SOC
+	{ .compatible = "nvidia,tegra124-mc", .data = &tegra124_mc_soc },
+#endif
+	{ }
+};
+
+static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
+{
+	unsigned long long tick;
+	unsigned int i;
+	u32 value;
+
+	/* compute the number of MC clock cycles per tick */
+	tick = mc->tick * clk_get_rate(mc->clk);
+	do_div(tick, NSEC_PER_SEC);
+
+	value = readl(mc->regs + MC_EMEM_ARB_CFG);
+	value &= ~MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE_MASK;
+	value |= MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE(tick);
+	writel(value, mc->regs + MC_EMEM_ARB_CFG);
+
+	/* write latency allowance defaults */
+	for (i = 0; i < mc->soc->num_clients; i++) {
+		const struct tegra_mc_la *la = &mc->soc->clients[i].la;
+		u32 value;
+
+		value = readl(mc->regs + la->reg);
+		value &= ~(la->mask << la->shift);
+		value |= (la->def & la->mask) << la->shift;
+		writel(value, mc->regs + la->reg);
+	}
+
+	return 0;
+}
+
+static const char *const status_names[32] = {
+	[ 1] = "External interrupt",
+	[ 6] = "EMEM address decode error",
+	[ 8] = "Security violation",
+	[ 9] = "EMEM arbitration error",
+	[10] = "Page fault",
+	[11] = "Invalid APB ASID update",
+	[12] = "VPR violation",
+	[13] = "Secure carveout violation",
+	[16] = "MTS carveout violation",
+};
+
+static const char *const error_names[8] = {
+	[2] = "EMEM decode error",
+	[3] = "TrustZone violation",
+	[4] = "Carveout violation",
+	[6] = "SMMU translation error",
+};
+
+static irqreturn_t tegra_mc_irq(int irq, void *data)
+{
+	struct tegra_mc *mc = data;
+	unsigned long status, mask;
+	unsigned int bit;
+
+	/* mask all interrupts to avoid flooding */
+	status = mc_readl(mc, MC_INTSTATUS);
+	mask = mc_readl(mc, MC_INTMASK);
+
+	for_each_set_bit(bit, &status, 32) {
+		const char *error = status_names[bit] ?: "unknown";
+		const char *client = "unknown", *desc;
+		const char *direction, *secure;
+		phys_addr_t addr = 0;
+		unsigned int i;
+		char perm[7];
+		u8 id, type;
+		u32 value;
+
+		value = mc_readl(mc, MC_ERR_STATUS);
+
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+		if (mc->soc->num_address_bits > 32) {
+			addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
+				MC_ERR_STATUS_ADR_HI_MASK);
+			addr <<= 32;
+		}
+#endif
+
+		if (value & MC_ERR_STATUS_RW)
+			direction = "write";
+		else
+			direction = "read";
+
+		if (value & MC_ERR_STATUS_SECURITY)
+			secure = "secure ";
+		else
+			secure = "";
+
+		id = value & MC_ERR_STATUS_CLIENT_MASK;
+
+		for (i = 0; i < mc->soc->num_clients; i++) {
+			if (mc->soc->clients[i].id == id) {
+				client = mc->soc->clients[i].name;
+				break;
+			}
+		}
+
+		type = (value & MC_ERR_STATUS_TYPE_MASK) >>
+		       MC_ERR_STATUS_TYPE_SHIFT;
+		desc = error_names[type];
+
+		switch (value & MC_ERR_STATUS_TYPE_MASK) {
+		case MC_ERR_STATUS_TYPE_INVALID_SMMU_PAGE:
+			perm[0] = ' ';
+			perm[1] = '[';
+
+			if (value & MC_ERR_STATUS_READABLE)
+				perm[2] = 'R';
+			else
+				perm[2] = '-';
+
+			if (value & MC_ERR_STATUS_WRITABLE)
+				perm[3] = 'W';
+			else
+				perm[3] = '-';
+
+			if (value & MC_ERR_STATUS_NONSECURE)
+				perm[4] = '-';
+			else
+				perm[4] = 'S';
+
+			perm[5] = ']';
+			perm[6] = '\0';
+			break;
+
+		default:
+			perm[0] = '\0';
+			break;
+		}
+
+		value = mc_readl(mc, MC_ERR_ADR);
+		addr |= value;
+
+		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
+				    client, secure, direction, &addr, error,
+				    desc, perm);
+	}
+
+	/* clear interrupts */
+	mc_writel(mc, status, MC_INTSTATUS);
+
+	return IRQ_HANDLED;
+}
+
+static int tegra_mc_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct resource *res;
+	struct tegra_mc *mc;
+	u32 value;
+	int err;
+
+	match = of_match_node(tegra_mc_of_match, pdev->dev.of_node);
+	if (!match)
+		return -ENODEV;
+
+	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
+	if (!mc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mc);
+	mc->soc = match->data;
+	mc->dev = &pdev->dev;
+
+	/* length of MC tick in nanoseconds */
+	mc->tick = 30;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mc->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mc->regs))
+		return PTR_ERR(mc->regs);
+
+	mc->clk = devm_clk_get(&pdev->dev, "mc");
+	if (IS_ERR(mc->clk)) {
+		dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
+			PTR_ERR(mc->clk));
+		return PTR_ERR(mc->clk);
+	}
+
+	err = tegra_mc_setup_latency_allowance(mc);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to setup latency allowance: %d\n",
+			err);
+		return err;
+	}
+
+	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU)) {
+		mc->smmu = tegra_smmu_probe(&pdev->dev, mc->soc->smmu, mc);
+		if (IS_ERR(mc->smmu)) {
+			dev_err(&pdev->dev, "failed to probe SMMU: %ld\n",
+				PTR_ERR(mc->smmu));
+			return PTR_ERR(mc->smmu);
+		}
+	}
+
+	mc->irq = platform_get_irq(pdev, 0);
+	if (mc->irq < 0) {
+		dev_err(&pdev->dev, "interrupt not specified\n");
+		return mc->irq;
+	}
+
+	err = devm_request_irq(&pdev->dev, mc->irq, tegra_mc_irq, IRQF_SHARED,
+			       dev_name(&pdev->dev), mc);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", mc->irq,
+			err);
+		return err;
+	}
+
+	value = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
+		MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
+		MC_INT_ARBITRATION_EMEM | MC_INT_SECURITY_VIOLATION |
+		MC_INT_DECERR_EMEM;
+	mc_writel(mc, value, MC_INTMASK);
+
+	return 0;
+}
+
+static struct platform_driver tegra_mc_driver = {
+	.driver = {
+		.name = "tegra-mc",
+		.of_match_table = tegra_mc_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.prevent_deferred_probe = true,
+	.probe = tegra_mc_probe,
+};
+
+static int tegra_mc_init(void)
+{
+	return platform_driver_register(&tegra_mc_driver);
+}
+arch_initcall(tegra_mc_init);
+
+MODULE_AUTHOR("Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
+MODULE_DESCRIPTION("NVIDIA Tegra Memory Controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
new file mode 100644
index 000000000000..7cf7f5bb3cb3
--- /dev/null
+++ b/drivers/memory/tegra/mc.h
@@ -0,0 +1,125 @@
+/*
+ * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MEMORY_TEGRA_MC_H
+#define MEMORY_TEGRA_MC_H
+
+#include <linux/io.h>
+#include <linux/types.h>
+
+struct page;
+
+struct tegra_smmu_enable {
+	unsigned int reg;
+	unsigned int bit;
+};
+
+/* latency allowance */
+struct tegra_mc_la {
+	unsigned int reg;
+	unsigned int shift;
+	unsigned int mask;
+	unsigned int def;
+};
+
+struct tegra_mc_client {
+	unsigned int id;
+	const char *name;
+	unsigned int swgroup;
+
+	unsigned int fifo_size;
+
+	struct tegra_smmu_enable smmu;
+	struct tegra_mc_la la;
+};
+
+struct tegra_smmu_swgroup {
+	unsigned int swgroup;
+	unsigned int reg;
+};
+
+struct tegra_smmu_ops {
+	void (*flush_dcache)(struct page *page, unsigned long offset,
+			     size_t size);
+};
+
+struct tegra_smmu_soc {
+	const struct tegra_mc_client *clients;
+	unsigned int num_clients;
+
+	const struct tegra_smmu_swgroup *swgroups;
+	unsigned int num_swgroups;
+
+	bool supports_round_robin_arbitration;
+	bool supports_request_limit;
+
+	unsigned int num_asids;
+
+	const struct tegra_smmu_ops *ops;
+};
+
+struct tegra_mc_soc {
+	const struct tegra_mc_client *clients;
+	unsigned int num_clients;
+
+	unsigned int num_address_bits;
+	unsigned int atom_size;
+
+	const struct tegra_smmu_soc *smmu;
+};
+
+struct tegra_smmu;
+
+struct tegra_mc {
+	struct device *dev;
+	struct tegra_smmu *smmu;
+	void __iomem *regs;
+	struct clk *clk;
+	int irq;
+
+	const struct tegra_mc_soc *soc;
+	unsigned long tick;
+};
+
+static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
+{
+	return readl(mc->regs + offset);
+}
+
+static inline void mc_writel(struct tegra_mc *mc, u32 value,
+			     unsigned long offset)
+{
+	writel(value, mc->regs + offset);
+}
+
+#ifdef CONFIG_TEGRA_IOMMU_SMMU
+struct tegra_smmu *tegra_smmu_probe(struct device *dev,
+				    const struct tegra_smmu_soc *soc,
+				    struct tegra_mc *mc);
+#else
+static inline struct tegra_smmu *
+tegra_smmu_probe(struct device *dev, const struct tegra_smmu_soc *soc,
+		 struct tegra_mc *mc)
+{
+	return NULL;
+}
+#endif
+
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+extern const struct tegra_mc_soc tegra30_mc_soc;
+#endif
+
+#ifdef CONFIG_ARCH_TEGRA_114_SOC
+extern const struct tegra_mc_soc tegra114_mc_soc;
+#endif
+
+#ifdef CONFIG_ARCH_TEGRA_124_SOC
+extern const struct tegra_mc_soc tegra124_mc_soc;
+#endif
+
+#endif /* MEMORY_TEGRA_MC_H */
diff --git a/drivers/memory/tegra/smmu.c b/drivers/memory/tegra/smmu.c
new file mode 100644
index 000000000000..b4e5a535e705
--- /dev/null
+++ b/drivers/memory/tegra/smmu.c
@@ -0,0 +1,716 @@
+/*
+ * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/iommu.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <soc/tegra/ahb.h>
+
+#include "mc.h"
+
+struct tegra_smmu {
+	void __iomem *regs;
+	struct device *dev;
+
+	struct tegra_mc *mc;
+	const struct tegra_smmu_soc *soc;
+
+	unsigned long *asids;
+	struct mutex lock;
+
+	struct list_head list;
+};
+
+struct tegra_smmu_as {
+	struct iommu_domain *domain;
+	struct tegra_smmu *smmu;
+	unsigned int use_count;
+	struct page *count;
+	struct page *pd;
+	unsigned id;
+	u32 attr;
+};
+
+static inline void smmu_writel(struct tegra_smmu *smmu, u32 value,
+			       unsigned long offset)
+{
+	writel(value, smmu->regs + offset);
+}
+
+static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
+{
+	return readl(smmu->regs + offset);
+}
+
+#define SMMU_CONFIG 0x010
+#define  SMMU_CONFIG_ENABLE (1 << 0)
+
+#define SMMU_TLB_CONFIG 0x14
+#define  SMMU_TLB_CONFIG_HIT_UNDER_MISS (1 << 29)
+#define  SMMU_TLB_CONFIG_ROUND_ROBIN_ARBITRATION (1 << 28)
+#define  SMMU_TLB_CONFIG_ACTIVE_LINES(x) ((x) & 0x3f)
+
+#define SMMU_PTC_CONFIG 0x18
+#define  SMMU_PTC_CONFIG_ENABLE (1 << 29)
+#define  SMMU_PTC_CONFIG_REQ_LIMIT(x) (((x) & 0x0f) << 24)
+#define  SMMU_PTC_CONFIG_INDEX_MAP(x) ((x) & 0x3f)
+
+#define SMMU_PTB_ASID 0x01c
+#define  SMMU_PTB_ASID_VALUE(x) ((x) & 0x7f)
+
+#define SMMU_PTB_DATA 0x020
+#define  SMMU_PTB_DATA_VALUE(page, attr) (page_to_phys(page) >> 12 | (attr))
+
+#define SMMU_MK_PDE(page, attr) (page_to_phys(page) >> SMMU_PTE_SHIFT | (attr))
+
+#define SMMU_TLB_FLUSH 0x030
+#define  SMMU_TLB_FLUSH_VA_MATCH_ALL     (0 << 0)
+#define  SMMU_TLB_FLUSH_VA_MATCH_SECTION (2 << 0)
+#define  SMMU_TLB_FLUSH_VA_MATCH_GROUP   (3 << 0)
+#define  SMMU_TLB_FLUSH_ASID(x)          (((x) & 0x7f) << 24)
+#define  SMMU_TLB_FLUSH_VA_SECTION(addr) ((((addr) & 0xffc00000) >> 12) | \
+					  SMMU_TLB_FLUSH_VA_MATCH_SECTION)
+#define  SMMU_TLB_FLUSH_VA_GROUP(addr)   ((((addr) & 0xffffc000) >> 12) | \
+					  SMMU_TLB_FLUSH_VA_MATCH_GROUP)
+#define  SMMU_TLB_FLUSH_ASID_MATCH       (1 << 31)
+
+#define SMMU_PTC_FLUSH 0x034
+#define  SMMU_PTC_FLUSH_TYPE_ALL (0 << 0)
+#define  SMMU_PTC_FLUSH_TYPE_ADR (1 << 0)
+
+#define SMMU_PTC_FLUSH_HI 0x9b8
+#define  SMMU_PTC_FLUSH_HI_MASK 0x3
+
+/* per-SWGROUP SMMU_*_ASID register */
+#define SMMU_ASID_ENABLE (1 << 31)
+#define SMMU_ASID_MASK 0x7f
+#define SMMU_ASID_VALUE(x) ((x) & SMMU_ASID_MASK)
+
+/* page table definitions */
+#define SMMU_NUM_PDE 1024
+#define SMMU_NUM_PTE 1024
+
+#define SMMU_SIZE_PD (SMMU_NUM_PDE * 4)
+#define SMMU_SIZE_PT (SMMU_NUM_PTE * 4)
+
+#define SMMU_PDE_SHIFT 22
+#define SMMU_PTE_SHIFT 12
+
+#define SMMU_PFN_MASK 0x000fffff
+
+#define SMMU_PD_READABLE	(1 << 31)
+#define SMMU_PD_WRITABLE	(1 << 30)
+#define SMMU_PD_NONSECURE	(1 << 29)
+
+#define SMMU_PDE_READABLE	(1 << 31)
+#define SMMU_PDE_WRITABLE	(1 << 30)
+#define SMMU_PDE_NONSECURE	(1 << 29)
+#define SMMU_PDE_NEXT		(1 << 28)
+
+#define SMMU_PTE_READABLE	(1 << 31)
+#define SMMU_PTE_WRITABLE	(1 << 30)
+#define SMMU_PTE_NONSECURE	(1 << 29)
+
+#define SMMU_PDE_ATTR		(SMMU_PDE_READABLE | SMMU_PDE_WRITABLE | \
+				 SMMU_PDE_NONSECURE)
+#define SMMU_PTE_ATTR		(SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
+				 SMMU_PTE_NONSECURE)
+
+static inline void smmu_flush_ptc(struct tegra_smmu *smmu, struct page *page,
+				  unsigned long offset)
+{
+	phys_addr_t phys = page ? page_to_phys(page) : 0;
+	u32 value;
+
+	if (page) {
+		offset &= ~(smmu->mc->soc->atom_size - 1);
+
+		if (smmu->mc->soc->num_address_bits > 32) {
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+			value = (phys >> 32) & SMMU_PTC_FLUSH_HI_MASK;
+#else
+			value = 0;
+#endif
+			smmu_writel(smmu, value, SMMU_PTC_FLUSH_HI);
+		}
+
+		value = (phys + offset) | SMMU_PTC_FLUSH_TYPE_ADR;
+	} else {
+		value = SMMU_PTC_FLUSH_TYPE_ALL;
+	}
+
+	smmu_writel(smmu, value, SMMU_PTC_FLUSH);
+}
+
+static inline void smmu_flush_tlb(struct tegra_smmu *smmu)
+{
+	smmu_writel(smmu, SMMU_TLB_FLUSH_VA_MATCH_ALL, SMMU_TLB_FLUSH);
+}
+
+static inline void smmu_flush_tlb_asid(struct tegra_smmu *smmu,
+				       unsigned long asid)
+{
+	u32 value;
+
+	value = SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_ASID(asid) |
+		SMMU_TLB_FLUSH_VA_MATCH_ALL;
+	smmu_writel(smmu, value, SMMU_TLB_FLUSH);
+}
+
+static inline void smmu_flush_tlb_section(struct tegra_smmu *smmu,
+					  unsigned long asid,
+					  unsigned long iova)
+{
+	u32 value;
+
+	value = SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_ASID(asid) |
+		SMMU_TLB_FLUSH_VA_SECTION(iova);
+	smmu_writel(smmu, value, SMMU_TLB_FLUSH);
+}
+
+static inline void smmu_flush_tlb_group(struct tegra_smmu *smmu,
+					unsigned long asid,
+					unsigned long iova)
+{
+	u32 value;
+
+	value = SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_ASID(asid) |
+		SMMU_TLB_FLUSH_VA_GROUP(iova);
+	smmu_writel(smmu, value, SMMU_TLB_FLUSH);
+}
+
+static inline void smmu_flush(struct tegra_smmu *smmu)
+{
+	smmu_readl(smmu, SMMU_CONFIG);
+}
+
+static int tegra_smmu_alloc_asid(struct tegra_smmu *smmu, unsigned int *idp)
+{
+	unsigned long id;
+
+	mutex_lock(&smmu->lock);
+
+	id = find_first_zero_bit(smmu->asids, smmu->soc->num_asids);
+	if (id >= smmu->soc->num_asids) {
+		mutex_unlock(&smmu->lock);
+		return -ENOSPC;
+	}
+
+	set_bit(id, smmu->asids);
+	*idp = id;
+
+	mutex_unlock(&smmu->lock);
+	return 0;
+}
+
+static void tegra_smmu_free_asid(struct tegra_smmu *smmu, unsigned int id)
+{
+	mutex_lock(&smmu->lock);
+	clear_bit(id, smmu->asids);
+	mutex_unlock(&smmu->lock);
+}
+
+static int tegra_smmu_domain_init(struct iommu_domain *domain)
+{
+	struct tegra_smmu_as *as;
+	unsigned int i;
+	uint32_t *pd;
+
+	as = kzalloc(sizeof(*as), GFP_KERNEL);
+	if (!as)
+		return -ENOMEM;
+
+	as->attr = SMMU_PD_READABLE | SMMU_PD_WRITABLE | SMMU_PD_NONSECURE;
+	as->domain = domain;
+
+	as->pd = alloc_page(GFP_KERNEL | __GFP_DMA);
+	if (!as->pd) {
+		kfree(as);
+		return -ENOMEM;
+	}
+
+	as->count = alloc_page(GFP_KERNEL);
+	if (!as->count) {
+		__free_page(as->pd);
+		kfree(as);
+		return -ENOMEM;
+	}
+
+	/* clear PDEs */
+	pd = page_address(as->pd);
+	SetPageReserved(as->pd);
+
+	for (i = 0; i < SMMU_NUM_PDE; i++)
+		pd[i] = 0;
+
+	/* clear PDE usage counters */
+	pd = page_address(as->count);
+	SetPageReserved(as->count);
+
+	for (i = 0; i < SMMU_NUM_PDE; i++)
+		pd[i] = 0;
+
+	domain->priv = as;
+
+	return 0;
+}
+
+static void tegra_smmu_domain_destroy(struct iommu_domain *domain)
+{
+	struct tegra_smmu_as *as = domain->priv;
+
+	/* TODO: free page directory and page tables */
+	ClearPageReserved(as->pd);
+
+	kfree(as);
+}
+
+static const struct tegra_smmu_swgroup *
+tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup)
+{
+	const struct tegra_smmu_swgroup *group = NULL;
+	unsigned int i;
+
+	for (i = 0; i < smmu->soc->num_swgroups; i++) {
+		if (smmu->soc->swgroups[i].swgroup == swgroup) {
+			group = &smmu->soc->swgroups[i];
+			break;
+		}
+	}
+
+	return group;
+}
+
+static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
+			      unsigned int asid)
+{
+	const struct tegra_smmu_swgroup *group;
+	unsigned int i;
+	u32 value;
+
+	for (i = 0; i < smmu->soc->num_clients; i++) {
+		const struct tegra_mc_client *client = &smmu->soc->clients[i];
+
+		if (client->swgroup != swgroup)
+			continue;
+
+		value = smmu_readl(smmu, client->smmu.reg);
+		value |= BIT(client->smmu.bit);
+		smmu_writel(smmu, value, client->smmu.reg);
+	}
+
+	group = tegra_smmu_find_swgroup(smmu, swgroup);
+	if (group) {
+		value = smmu_readl(smmu, group->reg);
+		value &= ~SMMU_ASID_MASK;
+		value |= SMMU_ASID_VALUE(asid);
+		value |= SMMU_ASID_ENABLE;
+		smmu_writel(smmu, value, group->reg);
+	}
+}
+
+static void tegra_smmu_disable(struct tegra_smmu *smmu, unsigned int swgroup,
+			       unsigned int asid)
+{
+	const struct tegra_smmu_swgroup *group;
+	unsigned int i;
+	u32 value;
+
+	group = tegra_smmu_find_swgroup(smmu, swgroup);
+	if (group) {
+		value = smmu_readl(smmu, group->reg);
+		value &= ~SMMU_ASID_MASK;
+		value |= SMMU_ASID_VALUE(asid);
+		value &= ~SMMU_ASID_ENABLE;
+		smmu_writel(smmu, value, group->reg);
+	}
+
+	for (i = 0; i < smmu->soc->num_clients; i++) {
+		const struct tegra_mc_client *client = &smmu->soc->clients[i];
+
+		if (client->swgroup != swgroup)
+			continue;
+
+		value = smmu_readl(smmu, client->smmu.reg);
+		value &= ~BIT(client->smmu.bit);
+		smmu_writel(smmu, value, client->smmu.reg);
+	}
+}
+
+static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
+				 struct tegra_smmu_as *as)
+{
+	u32 value;
+	int err;
+
+	if (as->use_count > 0)
+		return 0;
+
+	err = tegra_smmu_alloc_asid(smmu, &as->id);
+	if (err < 0)
+		return err;
+
+	smmu->soc->ops->flush_dcache(as->pd, 0, SMMU_SIZE_PD);
+	smmu_flush_ptc(smmu, as->pd, 0);
+	smmu_flush_tlb_asid(smmu, as->id);
+
+	smmu_writel(smmu, as->id & 0x7f, SMMU_PTB_ASID);
+	value = SMMU_PTB_DATA_VALUE(as->pd, as->attr);
+	smmu_writel(smmu, value, SMMU_PTB_DATA);
+	smmu_flush(smmu);
+
+	as->smmu = smmu;
+	as->use_count++;
+
+	return 0;
+}
+
+static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
+				    struct tegra_smmu_as *as)
+{
+	if (--as->use_count > 0)
+		return;
+
+	tegra_smmu_free_asid(smmu, as->id);
+	as->smmu = NULL;
+}
+
+static int tegra_smmu_attach_dev(struct iommu_domain *domain,
+				 struct device *dev)
+{
+	struct tegra_smmu *smmu = dev->archdata.iommu;
+	struct tegra_smmu_as *as = domain->priv;
+	struct device_node *np = dev->of_node;
+	struct of_phandle_args args;
+	unsigned int index = 0;
+	int err = 0;
+
+	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
+					   &args)) {
+		unsigned int swgroup = args.args[0];
+
+		if (args.np != smmu->dev->of_node)
+			continue;
+
+		err = tegra_smmu_as_prepare(smmu, as);
+		if (err < 0)
+			return err;
+
+		tegra_smmu_enable(smmu, swgroup, as->id);
+		index++;
+	}
+
+	if (index == 0)
+		return -ENODEV;
+
+	return 0;
+}
+
+static void tegra_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	struct tegra_smmu_as *as = domain->priv;
+	struct device_node *np = dev->of_node;
+	struct tegra_smmu *smmu = as->smmu;
+	struct of_phandle_args args;
+	unsigned int index = 0;
+
+	while (of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
+					  &args)) {
+		unsigned int swgroup = args.args[0];
+
+		if (args.np != smmu->dev->of_node)
+			continue;
+
+		tegra_smmu_disable(smmu, swgroup, as->id);
+		tegra_smmu_as_unprepare(smmu, as);
+		index++;
+	}
+}
+
+static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
+		       struct page **pagep)
+{
+	u32 *pd = page_address(as->pd), *pt, *count;
+	u32 pde = (iova >> SMMU_PDE_SHIFT) & 0x3ff;
+	u32 pte = (iova >> SMMU_PTE_SHIFT) & 0x3ff;
+	struct tegra_smmu *smmu = as->smmu;
+	struct page *page;
+	unsigned int i;
+
+	if (pd[pde] == 0) {
+		page = alloc_page(GFP_KERNEL | __GFP_DMA);
+		if (!page)
+			return NULL;
+
+		pt = page_address(page);
+		SetPageReserved(page);
+
+		for (i = 0; i < SMMU_NUM_PTE; i++)
+			pt[i] = 0;
+
+		smmu->soc->ops->flush_dcache(page, 0, SMMU_SIZE_PT);
+
+		pd[pde] = SMMU_MK_PDE(page, SMMU_PDE_ATTR | SMMU_PDE_NEXT);
+
+		smmu->soc->ops->flush_dcache(as->pd, pde << 2, 4);
+		smmu_flush_ptc(smmu, as->pd, pde << 2);
+		smmu_flush_tlb_section(smmu, as->id, iova);
+		smmu_flush(smmu);
+	} else {
+		page = pfn_to_page(pd[pde] & SMMU_PFN_MASK);
+		pt = page_address(page);
+	}
+
+	*pagep = page;
+
+	/* Keep track of entries in this page table. */
+	count = page_address(as->count);
+	if (pt[pte] == 0)
+		count[pde]++;
+
+	return &pt[pte];
+}
+
+static void as_put_pte(struct tegra_smmu_as *as, dma_addr_t iova)
+{
+	u32 pde = (iova >> SMMU_PDE_SHIFT) & 0x3ff;
+	u32 pte = (iova >> SMMU_PTE_SHIFT) & 0x3ff;
+	u32 *count = page_address(as->count);
+	u32 *pd = page_address(as->pd), *pt;
+	struct page *page;
+
+	page = pfn_to_page(pd[pde] & SMMU_PFN_MASK);
+	pt = page_address(page);
+
+	/*
+	 * When no entries in this page table are used anymore, return the
+	 * memory page to the system.
+	 */
+	if (pt[pte] != 0) {
+		if (--count[pde] == 0) {
+			ClearPageReserved(page);
+			__free_page(page);
+			pd[pde] = 0;
+		}
+
+		pt[pte] = 0;
+	}
+}
+
+static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot)
+{
+	struct tegra_smmu_as *as = domain->priv;
+	struct tegra_smmu *smmu = as->smmu;
+	unsigned long offset;
+	struct page *page;
+	u32 *pte;
+
+	pte = as_get_pte(as, iova, &page);
+	if (!pte)
+		return -ENOMEM;
+
+	*pte = __phys_to_pfn(paddr) | SMMU_PTE_ATTR;
+	offset = offset_in_page(pte);
+
+	smmu->soc->ops->flush_dcache(page, offset, 4);
+	smmu_flush_ptc(smmu, page, offset);
+	smmu_flush_tlb_group(smmu, as->id, iova);
+	smmu_flush(smmu);
+
+	return 0;
+}
+
+static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+			       size_t size)
+{
+	struct tegra_smmu_as *as = domain->priv;
+	struct tegra_smmu *smmu = as->smmu;
+	unsigned long offset;
+	struct page *page;
+	u32 *pte;
+
+	pte = as_get_pte(as, iova, &page);
+	if (!pte)
+		return 0;
+
+	offset = offset_in_page(pte);
+	as_put_pte(as, iova);
+
+	smmu->soc->ops->flush_dcache(page, offset, 4);
+	smmu_flush_ptc(smmu, page, offset);
+	smmu_flush_tlb_group(smmu, as->id, iova);
+	smmu_flush(smmu);
+
+	return size;
+}
+
+static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
+					   dma_addr_t iova)
+{
+	struct tegra_smmu_as *as = domain->priv;
+	struct page *page;
+	unsigned long pfn;
+	u32 *pte;
+
+	pte = as_get_pte(as, iova, &page);
+	pfn = *pte & SMMU_PFN_MASK;
+
+	return PFN_PHYS(pfn);
+}
+
+static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct tegra_mc *mc;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return NULL;
+
+	mc = platform_get_drvdata(pdev);
+	if (!mc)
+		return NULL;
+
+	return mc->smmu;
+}
+
+static int tegra_smmu_add_device(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct of_phandle_args args;
+	unsigned int index = 0;
+
+	while (of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
+					  &args) == 0) {
+		struct tegra_smmu *smmu;
+
+		smmu = tegra_smmu_find(args.np);
+		if (smmu) {
+			/*
+			 * Only a single IOMMU master interface is currently
+			 * supported by the Linux kernel, so abort after the
+			 * first match.
+			 */
+			dev->archdata.iommu = smmu;
+			break;
+		}
+
+		index++;
+	}
+
+	return 0;
+}
+
+static void tegra_smmu_remove_device(struct device *dev)
+{
+	dev->archdata.iommu = NULL;
+}
+
+static const struct iommu_ops tegra_smmu_ops = {
+	.domain_init = tegra_smmu_domain_init,
+	.domain_destroy = tegra_smmu_domain_destroy,
+	.attach_dev = tegra_smmu_attach_dev,
+	.detach_dev = tegra_smmu_detach_dev,
+	.add_device = tegra_smmu_add_device,
+	.remove_device = tegra_smmu_remove_device,
+	.map = tegra_smmu_map,
+	.unmap = tegra_smmu_unmap,
+	.iova_to_phys = tegra_smmu_iova_to_phys,
+
+	.pgsize_bitmap = SZ_4K,
+};
+
+static void tegra_smmu_ahb_enable(void)
+{
+	static const struct of_device_id ahb_match[] = {
+		{ .compatible = "nvidia,tegra30-ahb", },
+		{ }
+	};
+	struct device_node *ahb;
+
+	ahb = of_find_matching_node(NULL, ahb_match);
+	if (ahb) {
+		tegra_ahb_enable_smmu(ahb);
+		of_node_put(ahb);
+	}
+}
+
+struct tegra_smmu *tegra_smmu_probe(struct device *dev,
+				    const struct tegra_smmu_soc *soc,
+				    struct tegra_mc *mc)
+{
+	struct tegra_smmu *smmu;
+	size_t size;
+	u32 value;
+	int err;
+
+	/* This can happen on Tegra20 which doesn't have an SMMU */
+	if (!soc)
+		return NULL;
+
+	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
+	if (!smmu)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * This is a bit of a hack. Ideally we'd want to simply return this
+	 * value. However the IOMMU registration process will attempt to add
+	 * all devices to the IOMMU when bus_set_iommu() is called. In order
+	 * not to rely on global variables to track the IOMMU instance, we
+	 * set it here so that it can be looked up from the .add_device()
+	 * callback via the IOMMU device's .drvdata field.
+	 */
+	mc->smmu = smmu;
+
+	size = BITS_TO_LONGS(soc->num_asids) * sizeof(long);
+
+	smmu->asids = devm_kzalloc(dev, size, GFP_KERNEL);
+	if (!smmu->asids)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&smmu->lock);
+
+	smmu->regs = mc->regs;
+	smmu->soc = soc;
+	smmu->dev = dev;
+	smmu->mc = mc;
+
+	value = SMMU_PTC_CONFIG_ENABLE | SMMU_PTC_CONFIG_INDEX_MAP(0x3f);
+
+	if (soc->supports_request_limit)
+		value |= SMMU_PTC_CONFIG_REQ_LIMIT(8);
+
+	smmu_writel(smmu, value, SMMU_PTC_CONFIG);
+
+	value = SMMU_TLB_CONFIG_HIT_UNDER_MISS |
+		SMMU_TLB_CONFIG_ACTIVE_LINES(0x20);
+
+	if (soc->supports_round_robin_arbitration)
+		value |= SMMU_TLB_CONFIG_ROUND_ROBIN_ARBITRATION;
+
+	smmu_writel(smmu, value, SMMU_TLB_CONFIG);
+
+	smmu_flush_ptc(smmu, NULL, 0);
+	smmu_flush_tlb(smmu);
+	smmu_writel(smmu, SMMU_CONFIG_ENABLE, SMMU_CONFIG);
+	smmu_flush(smmu);
+
+	tegra_smmu_ahb_enable();
+
+	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	return smmu;
+}
diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
new file mode 100644
index 000000000000..511e9a25c151
--- /dev/null
+++ b/drivers/memory/tegra/tegra114.c
@@ -0,0 +1,948 @@
+/*
+ * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/of.h>
+#include <linux/mm.h>
+
+#include <asm/cacheflush.h>
+
+#include <dt-bindings/memory/tegra114-mc.h>
+
+#include "mc.h"
+
+static const struct tegra_mc_client tegra114_mc_clients[] = {
+	{
+		.id = 0x00,
+		.name = "ptcr",
+		.swgroup = TEGRA_SWGROUP_PTC,
+	}, {
+		.id = 0x01,
+		.name = "display0a",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 1,
+		},
+		.la = {
+			.reg = 0x2e8,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x02,
+		.name = "display0ab",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 2,
+		},
+		.la = {
+			.reg = 0x2f4,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x03,
+		.name = "display0b",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 3,
+		},
+		.la = {
+			.reg = 0x2e8,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x04,
+		.name = "display0bb",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 4,
+		},
+		.la = {
+			.reg = 0x2f4,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x05,
+		.name = "display0c",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 5,
+		},
+		.la = {
+			.reg = 0x2ec,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x06,
+		.name = "display0cb",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 6,
+		},
+		.la = {
+			.reg = 0x2f8,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x09,
+		.name = "eppup",
+		.swgroup = TEGRA_SWGROUP_EPP,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 9,
+		},
+		.la = {
+			.reg = 0x300,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x33,
+		},
+	}, {
+		.id = 0x0a,
+		.name = "g2pr",
+		.swgroup = TEGRA_SWGROUP_G2,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 10,
+		},
+		.la = {
+			.reg = 0x308,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x09,
+		},
+	}, {
+		.id = 0x0b,
+		.name = "g2sr",
+		.swgroup = TEGRA_SWGROUP_G2,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 11,
+		},
+		.la = {
+			.reg = 0x308,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x09,
+		},
+	}, {
+		.id = 0x0f,
+		.name = "avpcarm7r",
+		.swgroup = TEGRA_SWGROUP_AVPC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 15,
+		},
+		.la = {
+			.reg = 0x2e4,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x04,
+		},
+	}, {
+		.id = 0x10,
+		.name = "displayhc",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 16,
+		},
+		.la = {
+			.reg = 0x2f0,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x68,
+		},
+	}, {
+		.id = 0x11,
+		.name = "displayhcb",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 17,
+		},
+		.la = {
+			.reg = 0x2fc,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x68,
+		},
+	}, {
+		.id = 0x12,
+		.name = "fdcdrd",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 18,
+		},
+		.la = {
+			.reg = 0x334,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x0c,
+		},
+	}, {
+		.id = 0x13,
+		.name = "fdcdrd2",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 19,
+		},
+		.la = {
+			.reg = 0x33c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x0c,
+		},
+	}, {
+		.id = 0x14,
+		.name = "g2dr",
+		.swgroup = TEGRA_SWGROUP_G2,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 20,
+		},
+		.la = {
+			.reg = 0x30c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x0a,
+		},
+	}, {
+		.id = 0x15,
+		.name = "hdar",
+		.swgroup = TEGRA_SWGROUP_HDA,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 21,
+		},
+		.la = {
+			.reg = 0x318,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x16,
+		.name = "host1xdmar",
+		.swgroup = TEGRA_SWGROUP_HC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 22,
+		},
+		.la = {
+			.reg = 0x310,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x10,
+		},
+	}, {
+		.id = 0x17,
+		.name = "host1xr",
+		.swgroup = TEGRA_SWGROUP_HC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 23,
+		},
+		.la = {
+			.reg = 0x310,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xa5,
+		},
+	}, {
+		.id = 0x18,
+		.name = "idxsrd",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 24,
+		},
+		.la = {
+			.reg = 0x334,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x0b,
+		},
+	}, {
+		.id = 0x1c,
+		.name = "msencsrd",
+		.swgroup = TEGRA_SWGROUP_MSENC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 28,
+		},
+		.la = {
+			.reg = 0x328,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x1d,
+		.name = "ppcsahbdmar",
+		.swgroup = TEGRA_SWGROUP_PPCS,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 29,
+		},
+		.la = {
+			.reg = 0x344,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	}, {
+		.id = 0x1e,
+		.name = "ppcsahbslvr",
+		.swgroup = TEGRA_SWGROUP_PPCS,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 30,
+		},
+		.la = {
+			.reg = 0x344,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xe8,
+		},
+	}, {
+		.id = 0x20,
+		.name = "texl2srd",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 0,
+		},
+		.la = {
+			.reg = 0x338,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x0c,
+		},
+	}, {
+		.id = 0x22,
+		.name = "vdebsevr",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 2,
+		},
+		.la = {
+			.reg = 0x354,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x23,
+		.name = "vdember",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 3,
+		},
+		.la = {
+			.reg = 0x354,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x24,
+		.name = "vdemcer",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 4,
+		},
+		.la = {
+			.reg = 0x358,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xb8,
+		},
+	}, {
+		.id = 0x25,
+		.name = "vdetper",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 5,
+		},
+		.la = {
+			.reg = 0x358,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xee,
+		},
+	}, {
+		.id = 0x26,
+		.name = "mpcorelpr",
+		.swgroup = TEGRA_SWGROUP_MPCORELP,
+		.la = {
+			.reg = 0x324,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x04,
+		},
+	}, {
+		.id = 0x27,
+		.name = "mpcorer",
+		.swgroup = TEGRA_SWGROUP_MPCORE,
+		.la = {
+			.reg = 0x320,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x04,
+		},
+	}, {
+		.id = 0x28,
+		.name = "eppu",
+		.swgroup = TEGRA_SWGROUP_EPP,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 8,
+		},
+		.la = {
+			.reg = 0x300,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x33,
+		},
+	}, {
+		.id = 0x29,
+		.name = "eppv",
+		.swgroup = TEGRA_SWGROUP_EPP,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 9,
+		},
+		.la = {
+			.reg = 0x304,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x6c,
+		},
+	}, {
+		.id = 0x2a,
+		.name = "eppy",
+		.swgroup = TEGRA_SWGROUP_EPP,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 10,
+		},
+		.la = {
+			.reg = 0x304,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x6c,
+		},
+	}, {
+		.id = 0x2b,
+		.name = "msencswr",
+		.swgroup = TEGRA_SWGROUP_MSENC,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 11,
+		},
+		.la = {
+			.reg = 0x328,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x2c,
+		.name = "viwsb",
+		.swgroup = TEGRA_SWGROUP_VI,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 12,
+		},
+		.la = {
+			.reg = 0x364,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x47,
+		},
+	}, {
+		.id = 0x2d,
+		.name = "viwu",
+		.swgroup = TEGRA_SWGROUP_VI,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 13,
+		},
+		.la = {
+			.reg = 0x368,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x2e,
+		.name = "viwv",
+		.swgroup = TEGRA_SWGROUP_VI,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 14,
+		},
+		.la = {
+			.reg = 0x368,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x2f,
+		.name = "viwy",
+		.swgroup = TEGRA_SWGROUP_VI,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 15,
+		},
+		.la = {
+			.reg = 0x36c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x47,
+		},
+	}, {
+		.id = 0x30,
+		.name = "g2dw",
+		.swgroup = TEGRA_SWGROUP_G2,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 16,
+		},
+		.la = {
+			.reg = 0x30c,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x9,
+		},
+	}, {
+		.id = 0x32,
+		.name = "avpcarm7w",
+		.swgroup = TEGRA_SWGROUP_AVPC,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 18,
+		},
+		.la = {
+			.reg = 0x2e4,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x0e,
+		},
+	}, {
+		.id = 0x33,
+		.name = "fdcdwr",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 19,
+		},
+		.la = {
+			.reg = 0x338,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x10,
+		},
+	}, {
+		.id = 0x34,
+		.name = "fdcwr2",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 20,
+		},
+		.la = {
+			.reg = 0x340,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x10,
+		},
+	}, {
+		.id = 0x35,
+		.name = "hdaw",
+		.swgroup = TEGRA_SWGROUP_HDA,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 21,
+		},
+		.la = {
+			.reg = 0x318,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x36,
+		.name = "host1xw",
+		.swgroup = TEGRA_SWGROUP_HC,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 22,
+		},
+		.la = {
+			.reg = 0x314,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x25,
+		},
+	}, {
+		.id = 0x37,
+		.name = "ispw",
+		.swgroup = TEGRA_SWGROUP_ISP,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 23,
+		},
+		.la = {
+			.reg = 0x31c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x38,
+		.name = "mpcorelpw",
+		.swgroup = TEGRA_SWGROUP_MPCORELP,
+		.la = {
+			.reg = 0x324,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x39,
+		.name = "mpcorew",
+		.swgroup = TEGRA_SWGROUP_MPCORE,
+		.la = {
+			.reg = 0x320,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x0e,
+		},
+	}, {
+		.id = 0x3b,
+		.name = "ppcsahbdmaw",
+		.swgroup = TEGRA_SWGROUP_PPCS,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 27,
+		},
+		.la = {
+			.reg = 0x348,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xa5,
+		},
+	}, {
+		.id = 0x3c,
+		.name = "ppcsahbslvw",
+		.swgroup = TEGRA_SWGROUP_PPCS,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 28,
+		},
+		.la = {
+			.reg = 0x348,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xe8,
+		},
+	}, {
+		.id = 0x3e,
+		.name = "vdebsevw",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 30,
+		},
+		.la = {
+			.reg = 0x35c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x3f,
+		.name = "vdedbgw",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 31,
+		},
+		.la = {
+			.reg = 0x35c,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x40,
+		.name = "vdembew",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 0,
+		},
+		.la = {
+			.reg = 0x360,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x89,
+		},
+	}, {
+		.id = 0x41,
+		.name = "vdetpmw",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 1,
+		},
+		.la = {
+			.reg = 0x360,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x59,
+		},
+	}, {
+		.id = 0x4a,
+		.name = "xusb_hostr",
+		.swgroup = TEGRA_SWGROUP_XUSB_HOST,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 10,
+		},
+		.la = {
+			.reg = 0x37c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xa5,
+		},
+	}, {
+		.id = 0x4b,
+		.name = "xusb_hostw",
+		.swgroup = TEGRA_SWGROUP_XUSB_HOST,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 11,
+		},
+		.la = {
+			.reg = 0x37c,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xa5,
+		},
+	}, {
+		.id = 0x4c,
+		.name = "xusb_devr",
+		.swgroup = TEGRA_SWGROUP_XUSB_DEV,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 12,
+		},
+		.la = {
+			.reg = 0x380,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xa5,
+		},
+	}, {
+		.id = 0x4d,
+		.name = "xusb_devw",
+		.swgroup = TEGRA_SWGROUP_XUSB_DEV,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 13,
+		},
+		.la = {
+			.reg = 0x380,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xa5,
+		},
+	}, {
+		.id = 0x4e,
+		.name = "fdcdwr3",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 14,
+		},
+		.la = {
+			.reg = 0x388,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x10,
+		},
+	}, {
+		.id = 0x4f,
+		.name = "fdcdrd3",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 15,
+		},
+		.la = {
+			.reg = 0x384,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x0c,
+		},
+	}, {
+		.id = 0x50,
+		.name = "fdcwr4",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 16,
+		},
+		.la = {
+			.reg = 0x388,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x10,
+		},
+	}, {
+		.id = 0x51,
+		.name = "fdcrd4",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 17,
+		},
+		.la = {
+			.reg = 0x384,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x0c,
+		},
+	}, {
+		.id = 0x52,
+		.name = "emucifr",
+		.swgroup = TEGRA_SWGROUP_EMUCIF,
+		.la = {
+			.reg = 0x38c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x04,
+		},
+	}, {
+		.id = 0x53,
+		.name = "emucifw",
+		.swgroup = TEGRA_SWGROUP_EMUCIF,
+		.la = {
+			.reg = 0x38c,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x0e,
+		},
+	}, {
+		.id = 0x54,
+		.name = "tsecsrd",
+		.swgroup = TEGRA_SWGROUP_TSEC,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 20,
+		},
+		.la = {
+			.reg = 0x390,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	}, {
+		.id = 0x55,
+		.name = "tsecswr",
+		.swgroup = TEGRA_SWGROUP_TSEC,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 21,
+		},
+		.la = {
+			.reg = 0x390,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	},
+};
+
+static const struct tegra_smmu_swgroup tegra114_swgroups[] = {
+	{ .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240 },
+	{ .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244 },
+	{ .swgroup = TEGRA_SWGROUP_EPP,       .reg = 0x248 },
+	{ .swgroup = TEGRA_SWGROUP_G2,        .reg = 0x24c },
+	{ .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
+	{ .swgroup = TEGRA_SWGROUP_NV,        .reg = 0x268 },
+	{ .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
+	{ .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250 },
+	{ .swgroup = TEGRA_SWGROUP_MSENC,     .reg = 0x264 },
+	{ .swgroup = TEGRA_SWGROUP_PPCS,      .reg = 0x270 },
+	{ .swgroup = TEGRA_SWGROUP_VDE,       .reg = 0x27c },
+	{ .swgroup = TEGRA_SWGROUP_VI,        .reg = 0x280 },
+	{ .swgroup = TEGRA_SWGROUP_ISP,       .reg = 0x258 },
+	{ .swgroup = TEGRA_SWGROUP_XUSB_HOST, .reg = 0x288 },
+	{ .swgroup = TEGRA_SWGROUP_XUSB_DEV,  .reg = 0x28c },
+	{ .swgroup = TEGRA_SWGROUP_TSEC,      .reg = 0x294 },
+};
+
+static void tegra114_flush_dcache(struct page *page, unsigned long offset,
+				  size_t size)
+{
+	phys_addr_t phys = page_to_phys(page) + offset;
+	void *virt = page_address(page) + offset;
+
+	__cpuc_flush_dcache_area(virt, size);
+	outer_flush_range(phys, phys + size);
+}
+
+static const struct tegra_smmu_ops tegra114_smmu_ops = {
+	.flush_dcache = tegra114_flush_dcache,
+};
+
+static const struct tegra_smmu_soc tegra114_smmu_soc = {
+	.clients = tegra114_mc_clients,
+	.num_clients = ARRAY_SIZE(tegra114_mc_clients),
+	.swgroups = tegra114_swgroups,
+	.num_swgroups = ARRAY_SIZE(tegra114_swgroups),
+	.supports_round_robin_arbitration = false,
+	.supports_request_limit = false,
+	.num_asids = 4,
+	.ops = &tegra114_smmu_ops,
+};
+
+const struct tegra_mc_soc tegra114_mc_soc = {
+	.clients = tegra114_mc_clients,
+	.num_clients = ARRAY_SIZE(tegra114_mc_clients),
+	.num_address_bits = 32,
+	.atom_size = 32,
+	.smmu = &tegra114_smmu_soc,
+};
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
new file mode 100644
index 000000000000..278d40b854c1
--- /dev/null
+++ b/drivers/memory/tegra/tegra124.c
@@ -0,0 +1,995 @@
+/*
+ * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/of.h>
+#include <linux/mm.h>
+
+#include <asm/cacheflush.h>
+
+#include <dt-bindings/memory/tegra124-mc.h>
+
+#include "mc.h"
+
+static const struct tegra_mc_client tegra124_mc_clients[] = {
+	{
+		.id = 0x00,
+		.name = "ptcr",
+		.swgroup = TEGRA_SWGROUP_PTC,
+	}, {
+		.id = 0x01,
+		.name = "display0a",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 1,
+		},
+		.la = {
+			.reg = 0x2e8,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xc2,
+		},
+	}, {
+		.id = 0x02,
+		.name = "display0ab",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 2,
+		},
+		.la = {
+			.reg = 0x2f4,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xc6,
+		},
+	}, {
+		.id = 0x03,
+		.name = "display0b",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 3,
+		},
+		.la = {
+			.reg = 0x2e8,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	}, {
+		.id = 0x04,
+		.name = "display0bb",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 4,
+		},
+		.la = {
+			.reg = 0x2f4,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	}, {
+		.id = 0x05,
+		.name = "display0c",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 5,
+		},
+		.la = {
+			.reg = 0x2ec,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	}, {
+		.id = 0x06,
+		.name = "display0cb",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 6,
+		},
+		.la = {
+			.reg = 0x2f8,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	}, {
+		.id = 0x0e,
+		.name = "afir",
+		.swgroup = TEGRA_SWGROUP_AFI,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 14,
+		},
+		.la = {
+			.reg = 0x2e0,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x13,
+		},
+	}, {
+		.id = 0x0f,
+		.name = "avpcarm7r",
+		.swgroup = TEGRA_SWGROUP_AVPC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 15,
+		},
+		.la = {
+			.reg = 0x2e4,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x04,
+		},
+	}, {
+		.id = 0x10,
+		.name = "displayhc",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 16,
+		},
+		.la = {
+			.reg = 0x2f0,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	}, {
+		.id = 0x11,
+		.name = "displayhcb",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 17,
+		},
+		.la = {
+			.reg = 0x2fc,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	}, {
+		.id = 0x15,
+		.name = "hdar",
+		.swgroup = TEGRA_SWGROUP_HDA,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 21,
+		},
+		.la = {
+			.reg = 0x318,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x24,
+		},
+	}, {
+		.id = 0x16,
+		.name = "host1xdmar",
+		.swgroup = TEGRA_SWGROUP_HC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 22,
+		},
+		.la = {
+			.reg = 0x310,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x1e,
+		},
+	}, {
+		.id = 0x17,
+		.name = "host1xr",
+		.swgroup = TEGRA_SWGROUP_HC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 23,
+		},
+		.la = {
+			.reg = 0x310,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	}, {
+		.id = 0x1c,
+		.name = "msencsrd",
+		.swgroup = TEGRA_SWGROUP_MSENC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 28,
+		},
+		.la = {
+			.reg = 0x328,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x23,
+		},
+	}, {
+		.id = 0x1d,
+		.name = "ppcsahbdmar",
+		.swgroup = TEGRA_SWGROUP_PPCS,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 29,
+		},
+		.la = {
+			.reg = 0x344,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x49,
+		},
+	}, {
+		.id = 0x1e,
+		.name = "ppcsahbslvr",
+		.swgroup = TEGRA_SWGROUP_PPCS,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 30,
+		},
+		.la = {
+			.reg = 0x344,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x1a,
+		},
+	}, {
+		.id = 0x1f,
+		.name = "satar",
+		.swgroup = TEGRA_SWGROUP_SATA,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 31,
+		},
+		.la = {
+			.reg = 0x350,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x65,
+		},
+	}, {
+		.id = 0x22,
+		.name = "vdebsevr",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 2,
+		},
+		.la = {
+			.reg = 0x354,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x4f,
+		},
+	}, {
+		.id = 0x23,
+		.name = "vdember",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 3,
+		},
+		.la = {
+			.reg = 0x354,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x3d,
+		},
+	}, {
+		.id = 0x24,
+		.name = "vdemcer",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 4,
+		},
+		.la = {
+			.reg = 0x358,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x66,
+		},
+	}, {
+		.id = 0x25,
+		.name = "vdetper",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 5,
+		},
+		.la = {
+			.reg = 0x358,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xa5,
+		},
+	}, {
+		.id = 0x26,
+		.name = "mpcorelpr",
+		.swgroup = TEGRA_SWGROUP_MPCORELP,
+		.la = {
+			.reg = 0x324,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x04,
+		},
+	}, {
+		.id = 0x27,
+		.name = "mpcorer",
+		.swgroup = TEGRA_SWGROUP_MPCORE,
+		.la = {
+			.reg = 0x320,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x04,
+		},
+	}, {
+		.id = 0x2b,
+		.name = "msencswr",
+		.swgroup = TEGRA_SWGROUP_MSENC,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 11,
+		},
+		.la = {
+			.reg = 0x328,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x31,
+		.name = "afiw",
+		.swgroup = TEGRA_SWGROUP_AFI,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 17,
+		},
+		.la = {
+			.reg = 0x2e0,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x32,
+		.name = "avpcarm7w",
+		.swgroup = TEGRA_SWGROUP_AVPC,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 18,
+		},
+		.la = {
+			.reg = 0x2e4,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x35,
+		.name = "hdaw",
+		.swgroup = TEGRA_SWGROUP_HDA,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 21,
+		},
+		.la = {
+			.reg = 0x318,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x36,
+		.name = "host1xw",
+		.swgroup = TEGRA_SWGROUP_HC,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 22,
+		},
+		.la = {
+			.reg = 0x314,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x38,
+		.name = "mpcorelpw",
+		.swgroup = TEGRA_SWGROUP_MPCORELP,
+		.la = {
+			.reg = 0x324,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x39,
+		.name = "mpcorew",
+		.swgroup = TEGRA_SWGROUP_MPCORE,
+		.la = {
+			.reg = 0x320,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x3b,
+		.name = "ppcsahbdmaw",
+		.swgroup = TEGRA_SWGROUP_PPCS,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 27,
+		},
+		.la = {
+			.reg = 0x348,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x3c,
+		.name = "ppcsahbslvw",
+		.swgroup = TEGRA_SWGROUP_PPCS,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 28,
+		},
+		.la = {
+			.reg = 0x348,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x3d,
+		.name = "sataw",
+		.swgroup = TEGRA_SWGROUP_SATA,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 29,
+		},
+		.la = {
+			.reg = 0x350,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x65,
+		},
+	}, {
+		.id = 0x3e,
+		.name = "vdebsevw",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 30,
+		},
+		.la = {
+			.reg = 0x35c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x3f,
+		.name = "vdedbgw",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 31,
+		},
+		.la = {
+			.reg = 0x35c,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x40,
+		.name = "vdembew",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 0,
+		},
+		.la = {
+			.reg = 0x360,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x41,
+		.name = "vdetpmw",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 1,
+		},
+		.la = {
+			.reg = 0x360,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x44,
+		.name = "ispra",
+		.swgroup = TEGRA_SWGROUP_ISP2,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 4,
+		},
+		.la = {
+			.reg = 0x370,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x18,
+		},
+	}, {
+		.id = 0x46,
+		.name = "ispwa",
+		.swgroup = TEGRA_SWGROUP_ISP2,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 6,
+		},
+		.la = {
+			.reg = 0x374,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x47,
+		.name = "ispwb",
+		.swgroup = TEGRA_SWGROUP_ISP2,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 7,
+		},
+		.la = {
+			.reg = 0x374,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x4a,
+		.name = "xusb_hostr",
+		.swgroup = TEGRA_SWGROUP_XUSB_HOST,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 10,
+		},
+		.la = {
+			.reg = 0x37c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x39,
+		},
+	}, {
+		.id = 0x4b,
+		.name = "xusb_hostw",
+		.swgroup = TEGRA_SWGROUP_XUSB_HOST,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 11,
+		},
+		.la = {
+			.reg = 0x37c,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x4c,
+		.name = "xusb_devr",
+		.swgroup = TEGRA_SWGROUP_XUSB_DEV,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 12,
+		},
+		.la = {
+			.reg = 0x380,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x39,
+		},
+	}, {
+		.id = 0x4d,
+		.name = "xusb_devw",
+		.swgroup = TEGRA_SWGROUP_XUSB_DEV,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 13,
+		},
+		.la = {
+			.reg = 0x380,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x4e,
+		.name = "isprab",
+		.swgroup = TEGRA_SWGROUP_ISP2B,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 14,
+		},
+		.la = {
+			.reg = 0x384,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x18,
+		},
+	}, {
+		.id = 0x50,
+		.name = "ispwab",
+		.swgroup = TEGRA_SWGROUP_ISP2B,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 16,
+		},
+		.la = {
+			.reg = 0x388,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x51,
+		.name = "ispwbb",
+		.swgroup = TEGRA_SWGROUP_ISP2B,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 17,
+		},
+		.la = {
+			.reg = 0x388,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x54,
+		.name = "tsecsrd",
+		.swgroup = TEGRA_SWGROUP_TSEC,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 20,
+		},
+		.la = {
+			.reg = 0x390,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x9b,
+		},
+	}, {
+		.id = 0x55,
+		.name = "tsecswr",
+		.swgroup = TEGRA_SWGROUP_TSEC,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 21,
+		},
+		.la = {
+			.reg = 0x390,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x56,
+		.name = "a9avpscr",
+		.swgroup = TEGRA_SWGROUP_A9AVP,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 22,
+		},
+		.la = {
+			.reg = 0x3a4,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x04,
+		},
+	}, {
+		.id = 0x57,
+		.name = "a9avpscw",
+		.swgroup = TEGRA_SWGROUP_A9AVP,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 23,
+		},
+		.la = {
+			.reg = 0x3a4,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x58,
+		.name = "gpusrd",
+		.swgroup = TEGRA_SWGROUP_GPU,
+		.smmu = {
+			/* read-only */
+			.reg = 0x230,
+			.bit = 24,
+		},
+		.la = {
+			.reg = 0x3c8,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x1a,
+		},
+	}, {
+		.id = 0x59,
+		.name = "gpuswr",
+		.swgroup = TEGRA_SWGROUP_GPU,
+		.smmu = {
+			/* read-only */
+			.reg = 0x230,
+			.bit = 25,
+		},
+		.la = {
+			.reg = 0x3c8,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x5a,
+		.name = "displayt",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 26,
+		},
+		.la = {
+			.reg = 0x2f0,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	}, {
+		.id = 0x60,
+		.name = "sdmmcra",
+		.swgroup = TEGRA_SWGROUP_SDMMC1A,
+		.smmu = {
+			.reg = 0x234,
+			.bit = 0,
+		},
+		.la = {
+			.reg = 0x3b8,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x49,
+		},
+	}, {
+		.id = 0x61,
+		.name = "sdmmcraa",
+		.swgroup = TEGRA_SWGROUP_SDMMC2A,
+		.smmu = {
+			.reg = 0x234,
+			.bit = 1,
+		},
+		.la = {
+			.reg = 0x3bc,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x49,
+		},
+	}, {
+		.id = 0x62,
+		.name = "sdmmcr",
+		.swgroup = TEGRA_SWGROUP_SDMMC3A,
+		.smmu = {
+			.reg = 0x234,
+			.bit = 2,
+		},
+		.la = {
+			.reg = 0x3c0,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x49,
+		},
+	}, {
+		.id = 0x63,
+		.swgroup = TEGRA_SWGROUP_SDMMC4A,
+		.name = "sdmmcrab",
+		.smmu = {
+			.reg = 0x234,
+			.bit = 3,
+		},
+		.la = {
+			.reg = 0x3c4,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x49,
+		},
+	}, {
+		.id = 0x64,
+		.name = "sdmmcwa",
+		.swgroup = TEGRA_SWGROUP_SDMMC1A,
+		.smmu = {
+			.reg = 0x234,
+			.bit = 4,
+		},
+		.la = {
+			.reg = 0x3b8,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x65,
+		.name = "sdmmcwaa",
+		.swgroup = TEGRA_SWGROUP_SDMMC2A,
+		.smmu = {
+			.reg = 0x234,
+			.bit = 5,
+		},
+		.la = {
+			.reg = 0x3bc,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x66,
+		.name = "sdmmcw",
+		.swgroup = TEGRA_SWGROUP_SDMMC3A,
+		.smmu = {
+			.reg = 0x234,
+			.bit = 6,
+		},
+		.la = {
+			.reg = 0x3c0,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x67,
+		.name = "sdmmcwab",
+		.swgroup = TEGRA_SWGROUP_SDMMC4A,
+		.smmu = {
+			.reg = 0x234,
+			.bit = 7,
+		},
+		.la = {
+			.reg = 0x3c4,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x6c,
+		.name = "vicsrd",
+		.swgroup = TEGRA_SWGROUP_VIC,
+		.smmu = {
+			.reg = 0x234,
+			.bit = 12,
+		},
+		.la = {
+			.reg = 0x394,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x1a,
+		},
+	}, {
+		.id = 0x6d,
+		.name = "vicswr",
+		.swgroup = TEGRA_SWGROUP_VIC,
+		.smmu = {
+			.reg = 0x234,
+			.bit = 13,
+		},
+		.la = {
+			.reg = 0x394,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x72,
+		.name = "viw",
+		.swgroup = TEGRA_SWGROUP_VI,
+		.smmu = {
+			.reg = 0x234,
+			.bit = 18,
+		},
+		.la = {
+			.reg = 0x398,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x73,
+		.name = "displayd",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x234,
+			.bit = 19,
+		},
+		.la = {
+			.reg = 0x3c8,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	},
+};
+
+static const struct tegra_smmu_swgroup tegra124_swgroups[] = {
+	{ .swgroup = TEGRA_SWGROUP_DC,        .reg = 0x240 },
+	{ .swgroup = TEGRA_SWGROUP_DCB,       .reg = 0x244 },
+	{ .swgroup = TEGRA_SWGROUP_AFI,       .reg = 0x238 },
+	{ .swgroup = TEGRA_SWGROUP_AVPC,      .reg = 0x23c },
+	{ .swgroup = TEGRA_SWGROUP_HDA,       .reg = 0x254 },
+	{ .swgroup = TEGRA_SWGROUP_HC,        .reg = 0x250 },
+	{ .swgroup = TEGRA_SWGROUP_MSENC,     .reg = 0x264 },
+	{ .swgroup = TEGRA_SWGROUP_PPCS,      .reg = 0x270 },
+	{ .swgroup = TEGRA_SWGROUP_SATA,      .reg = 0x274 },
+	{ .swgroup = TEGRA_SWGROUP_VDE,       .reg = 0x27c },
+	{ .swgroup = TEGRA_SWGROUP_ISP2,      .reg = 0x258 },
+	{ .swgroup = TEGRA_SWGROUP_XUSB_HOST, .reg = 0x288 },
+	{ .swgroup = TEGRA_SWGROUP_XUSB_DEV,  .reg = 0x28c },
+	{ .swgroup = TEGRA_SWGROUP_ISP2B,     .reg = 0xaa4 },
+	{ .swgroup = TEGRA_SWGROUP_TSEC,      .reg = 0x294 },
+	{ .swgroup = TEGRA_SWGROUP_A9AVP,     .reg = 0x290 },
+	{ .swgroup = TEGRA_SWGROUP_GPU,       .reg = 0xaac },
+	{ .swgroup = TEGRA_SWGROUP_SDMMC1A,   .reg = 0xa94 },
+	{ .swgroup = TEGRA_SWGROUP_SDMMC2A,   .reg = 0xa98 },
+	{ .swgroup = TEGRA_SWGROUP_SDMMC3A,   .reg = 0xa9c },
+	{ .swgroup = TEGRA_SWGROUP_SDMMC4A,   .reg = 0xaa0 },
+	{ .swgroup = TEGRA_SWGROUP_VIC,       .reg = 0x284 },
+	{ .swgroup = TEGRA_SWGROUP_VI,        .reg = 0x280 },
+};
+
+#ifdef CONFIG_ARCH_TEGRA_124_SOC
+static void tegra124_flush_dcache(struct page *page, unsigned long offset,
+				  size_t size)
+{
+	phys_addr_t phys = page_to_phys(page) + offset;
+	void *virt = page_address(page) + offset;
+
+	__cpuc_flush_dcache_area(virt, size);
+	outer_flush_range(phys, phys + size);
+}
+
+static const struct tegra_smmu_ops tegra124_smmu_ops = {
+	.flush_dcache = tegra124_flush_dcache,
+};
+
+static const struct tegra_smmu_soc tegra124_smmu_soc = {
+	.clients = tegra124_mc_clients,
+	.num_clients = ARRAY_SIZE(tegra124_mc_clients),
+	.swgroups = tegra124_swgroups,
+	.num_swgroups = ARRAY_SIZE(tegra124_swgroups),
+	.supports_round_robin_arbitration = true,
+	.supports_request_limit = true,
+	.num_asids = 128,
+	.ops = &tegra124_smmu_ops,
+};
+
+const struct tegra_mc_soc tegra124_mc_soc = {
+	.clients = tegra124_mc_clients,
+	.num_clients = ARRAY_SIZE(tegra124_mc_clients),
+	.num_address_bits = 34,
+	.atom_size = 32,
+	.smmu = &tegra124_smmu_soc,
+};
+#endif /* CONFIG_ARCH_TEGRA_124_SOC */
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
new file mode 100644
index 000000000000..71fe9376fe53
--- /dev/null
+++ b/drivers/memory/tegra/tegra30.c
@@ -0,0 +1,970 @@
+/*
+ * Copyright (C) 2014 NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/of.h>
+#include <linux/mm.h>
+
+#include <asm/cacheflush.h>
+
+#include <dt-bindings/memory/tegra30-mc.h>
+
+#include "mc.h"
+
+static const struct tegra_mc_client tegra30_mc_clients[] = {
+	{
+		.id = 0x00,
+		.name = "ptcr",
+		.swgroup = TEGRA_SWGROUP_PTC,
+	}, {
+		.id = 0x01,
+		.name = "display0a",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 1,
+		},
+		.la = {
+			.reg = 0x2e8,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x02,
+		.name = "display0ab",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 2,
+		},
+		.la = {
+			.reg = 0x2f4,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x03,
+		.name = "display0b",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 3,
+		},
+		.la = {
+			.reg = 0x2e8,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x04,
+		.name = "display0bb",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 4,
+		},
+		.la = {
+			.reg = 0x2f4,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x05,
+		.name = "display0c",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 5,
+		},
+		.la = {
+			.reg = 0x2ec,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x06,
+		.name = "display0cb",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 6,
+		},
+		.la = {
+			.reg = 0x2f8,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x07,
+		.name = "display1b",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 7,
+		},
+		.la = {
+			.reg = 0x2ec,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x08,
+		.name = "display1bb",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 8,
+		},
+		.la = {
+			.reg = 0x2f8,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x4e,
+		},
+	}, {
+		.id = 0x09,
+		.name = "eppup",
+		.swgroup = TEGRA_SWGROUP_EPP,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 9,
+		},
+		.la = {
+			.reg = 0x300,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x17,
+		},
+	}, {
+		.id = 0x0a,
+		.name = "g2pr",
+		.swgroup = TEGRA_SWGROUP_G2,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 10,
+		},
+		.la = {
+			.reg = 0x308,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x09,
+		},
+	}, {
+		.id = 0x0b,
+		.name = "g2sr",
+		.swgroup = TEGRA_SWGROUP_G2,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 11,
+		},
+		.la = {
+			.reg = 0x308,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x09,
+		},
+	}, {
+		.id = 0x0c,
+		.name = "mpeunifbr",
+		.swgroup = TEGRA_SWGROUP_MPE,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 12,
+		},
+		.la = {
+			.reg = 0x328,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	}, {
+		.id = 0x0d,
+		.name = "viruv",
+		.swgroup = TEGRA_SWGROUP_VI,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 13,
+		},
+		.la = {
+			.reg = 0x364,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x2c,
+		},
+	}, {
+		.id = 0x0e,
+		.name = "afir",
+		.swgroup = TEGRA_SWGROUP_AFI,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 14,
+		},
+		.la = {
+			.reg = 0x2e0,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x10,
+		},
+	}, {
+		.id = 0x0f,
+		.name = "avpcarm7r",
+		.swgroup = TEGRA_SWGROUP_AVPC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 15,
+		},
+		.la = {
+			.reg = 0x2e4,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x04,
+		},
+	}, {
+		.id = 0x10,
+		.name = "displayhc",
+		.swgroup = TEGRA_SWGROUP_DC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 16,
+		},
+		.la = {
+			.reg = 0x2f0,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x11,
+		.name = "displayhcb",
+		.swgroup = TEGRA_SWGROUP_DCB,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 17,
+		},
+		.la = {
+			.reg = 0x2fc,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x12,
+		.name = "fdcdrd",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 18,
+		},
+		.la = {
+			.reg = 0x334,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x0a,
+		},
+	}, {
+		.id = 0x13,
+		.name = "fdcdrd2",
+		.swgroup = TEGRA_SWGROUP_NV2,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 19,
+		},
+		.la = {
+			.reg = 0x33c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x0a,
+		},
+	}, {
+		.id = 0x14,
+		.name = "g2dr",
+		.swgroup = TEGRA_SWGROUP_G2,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 20,
+		},
+		.la = {
+			.reg = 0x30c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x0a,
+		},
+	}, {
+		.id = 0x15,
+		.name = "hdar",
+		.swgroup = TEGRA_SWGROUP_HDA,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 21,
+		},
+		.la = {
+			.reg = 0x318,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x16,
+		.name = "host1xdmar",
+		.swgroup = TEGRA_SWGROUP_HC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 22,
+		},
+		.la = {
+			.reg = 0x310,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x05,
+		},
+	}, {
+		.id = 0x17,
+		.name = "host1xr",
+		.swgroup = TEGRA_SWGROUP_HC,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 23,
+		},
+		.la = {
+			.reg = 0x310,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x50,
+		},
+	}, {
+		.id = 0x18,
+		.name = "idxsrd",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 24,
+		},
+		.la = {
+			.reg = 0x334,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x13,
+		},
+	}, {
+		.id = 0x19,
+		.name = "idxsrd2",
+		.swgroup = TEGRA_SWGROUP_NV2,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 25,
+		},
+		.la = {
+			.reg = 0x33c,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x13,
+		},
+	}, {
+		.id = 0x1a,
+		.name = "mpe_ipred",
+		.swgroup = TEGRA_SWGROUP_MPE,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 26,
+		},
+		.la = {
+			.reg = 0x328,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x80,
+		},
+	}, {
+		.id = 0x1b,
+		.name = "mpeamemrd",
+		.swgroup = TEGRA_SWGROUP_MPE,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 27,
+		},
+		.la = {
+			.reg = 0x32c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x42,
+		},
+	}, {
+		.id = 0x1c,
+		.name = "mpecsrd",
+		.swgroup = TEGRA_SWGROUP_MPE,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 28,
+		},
+		.la = {
+			.reg = 0x32c,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x1d,
+		.name = "ppcsahbdmar",
+		.swgroup = TEGRA_SWGROUP_PPCS,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 29,
+		},
+		.la = {
+			.reg = 0x344,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x10,
+		},
+	}, {
+		.id = 0x1e,
+		.name = "ppcsahbslvr",
+		.swgroup = TEGRA_SWGROUP_PPCS,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 30,
+		},
+		.la = {
+			.reg = 0x344,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x12,
+		},
+	}, {
+		.id = 0x1f,
+		.name = "satar",
+		.swgroup = TEGRA_SWGROUP_SATA,
+		.smmu = {
+			.reg = 0x228,
+			.bit = 31,
+		},
+		.la = {
+			.reg = 0x350,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x33,
+		},
+	}, {
+		.id = 0x20,
+		.name = "texsrd",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 0,
+		},
+		.la = {
+			.reg = 0x338,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x13,
+		},
+	}, {
+		.id = 0x21,
+		.name = "texsrd2",
+		.swgroup = TEGRA_SWGROUP_NV2,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 1,
+		},
+		.la = {
+			.reg = 0x340,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x13,
+		},
+	}, {
+		.id = 0x22,
+		.name = "vdebsevr",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 2,
+		},
+		.la = {
+			.reg = 0x354,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x23,
+		.name = "vdember",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 3,
+		},
+		.la = {
+			.reg = 0x354,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xd0,
+		},
+	}, {
+		.id = 0x24,
+		.name = "vdemcer",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 4,
+		},
+		.la = {
+			.reg = 0x358,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x2a,
+		},
+	}, {
+		.id = 0x25,
+		.name = "vdetper",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 5,
+		},
+		.la = {
+			.reg = 0x358,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x74,
+		},
+	}, {
+		.id = 0x26,
+		.name = "mpcorelpr",
+		.swgroup = TEGRA_SWGROUP_MPCORELP,
+		.la = {
+			.reg = 0x324,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x04,
+		},
+	}, {
+		.id = 0x27,
+		.name = "mpcorer",
+		.swgroup = TEGRA_SWGROUP_MPCORE,
+		.la = {
+			.reg = 0x320,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x04,
+		},
+	}, {
+		.id = 0x28,
+		.name = "eppu",
+		.swgroup = TEGRA_SWGROUP_EPP,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 8,
+		},
+		.la = {
+			.reg = 0x300,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x6c,
+		},
+	}, {
+		.id = 0x29,
+		.name = "eppv",
+		.swgroup = TEGRA_SWGROUP_EPP,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 9,
+		},
+		.la = {
+			.reg = 0x304,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x6c,
+		},
+	}, {
+		.id = 0x2a,
+		.name = "eppy",
+		.swgroup = TEGRA_SWGROUP_EPP,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 10,
+		},
+		.la = {
+			.reg = 0x304,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x6c,
+		},
+	}, {
+		.id = 0x2b,
+		.name = "mpeunifbw",
+		.swgroup = TEGRA_SWGROUP_MPE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 11,
+		},
+		.la = {
+			.reg = 0x330,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x13,
+		},
+	}, {
+		.id = 0x2c,
+		.name = "viwsb",
+		.swgroup = TEGRA_SWGROUP_VI,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 12,
+		},
+		.la = {
+			.reg = 0x364,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x12,
+		},
+	}, {
+		.id = 0x2d,
+		.name = "viwu",
+		.swgroup = TEGRA_SWGROUP_VI,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 13,
+		},
+		.la = {
+			.reg = 0x368,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xb2,
+		},
+	}, {
+		.id = 0x2e,
+		.name = "viwv",
+		.swgroup = TEGRA_SWGROUP_VI,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 14,
+		},
+		.la = {
+			.reg = 0x368,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xb2,
+		},
+	}, {
+		.id = 0x2f,
+		.name = "viwy",
+		.swgroup = TEGRA_SWGROUP_VI,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 15,
+		},
+		.la = {
+			.reg = 0x36c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x12,
+		},
+	}, {
+		.id = 0x30,
+		.name = "g2dw",
+		.swgroup = TEGRA_SWGROUP_G2,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 16,
+		},
+		.la = {
+			.reg = 0x30c,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x9,
+		},
+	}, {
+		.id = 0x31,
+		.name = "afiw",
+		.swgroup = TEGRA_SWGROUP_AFI,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 17,
+		},
+		.la = {
+			.reg = 0x2e0,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x0c,
+		},
+	}, {
+		.id = 0x32,
+		.name = "avpcarm7w",
+		.swgroup = TEGRA_SWGROUP_AVPC,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 18,
+		},
+		.la = {
+			.reg = 0x2e4,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x0e,
+		},
+	}, {
+		.id = 0x33,
+		.name = "fdcdwr",
+		.swgroup = TEGRA_SWGROUP_NV,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 19,
+		},
+		.la = {
+			.reg = 0x338,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x0a,
+		},
+	}, {
+		.id = 0x34,
+		.name = "fdcwr2",
+		.swgroup = TEGRA_SWGROUP_NV2,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 20,
+		},
+		.la = {
+			.reg = 0x340,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x0a,
+		},
+	}, {
+		.id = 0x35,
+		.name = "hdaw",
+		.swgroup = TEGRA_SWGROUP_HDA,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 21,
+		},
+		.la = {
+			.reg = 0x318,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x36,
+		.name = "host1xw",
+		.swgroup = TEGRA_SWGROUP_HC,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 22,
+		},
+		.la = {
+			.reg = 0x314,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x10,
+		},
+	}, {
+		.id = 0x37,
+		.name = "ispw",
+		.swgroup = TEGRA_SWGROUP_ISP,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 23,
+		},
+		.la = {
+			.reg = 0x31c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x38,
+		.name = "mpcorelpw",
+		.swgroup = TEGRA_SWGROUP_MPCORELP,
+		.la = {
+			.reg = 0x324,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x0e,
+		},
+	}, {
+		.id = 0x39,
+		.name = "mpcorew",
+		.swgroup = TEGRA_SWGROUP_MPCORE,
+		.la = {
+			.reg = 0x320,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x0e,
+		},
+	}, {
+		.id = 0x3a,
+		.name = "mpecswr",
+		.swgroup = TEGRA_SWGROUP_MPE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 26,
+		},
+		.la = {
+			.reg = 0x330,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x3b,
+		.name = "ppcsahbdmaw",
+		.swgroup = TEGRA_SWGROUP_PPCS,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 27,
+		},
+		.la = {
+			.reg = 0x348,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x10,
+		},
+	}, {
+		.id = 0x3c,
+		.name = "ppcsahbslvw",
+		.swgroup = TEGRA_SWGROUP_PPCS,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 28,
+		},
+		.la = {
+			.reg = 0x348,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x06,
+		},
+	}, {
+		.id = 0x3d,
+		.name = "sataw",
+		.swgroup = TEGRA_SWGROUP_SATA,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 29,
+		},
+		.la = {
+			.reg = 0x350,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x33,
+		},
+	}, {
+		.id = 0x3e,
+		.name = "vdebsevw",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 30,
+		},
+		.la = {
+			.reg = 0x35c,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x3f,
+		.name = "vdedbgw",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x22c,
+			.bit = 31,
+		},
+		.la = {
+			.reg = 0x35c,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0xff,
+		},
+	}, {
+		.id = 0x40,
+		.name = "vdembew",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 0,
+		},
+		.la = {
+			.reg = 0x360,
+			.shift = 0,
+			.mask = 0xff,
+			.def = 0x42,
+		},
+	}, {
+		.id = 0x41,
+		.name = "vdetpmw",
+		.swgroup = TEGRA_SWGROUP_VDE,
+		.smmu = {
+			.reg = 0x230,
+			.bit = 1,
+		},
+		.la = {
+			.reg = 0x360,
+			.shift = 16,
+			.mask = 0xff,
+			.def = 0x2a,
+		},
+	},
+};
+
+static const struct tegra_smmu_swgroup tegra30_swgroups[] = {
+	{ .swgroup = TEGRA_SWGROUP_DC,   .reg = 0x240 },
+	{ .swgroup = TEGRA_SWGROUP_DCB,  .reg = 0x244 },
+	{ .swgroup = TEGRA_SWGROUP_EPP,  .reg = 0x248 },
+	{ .swgroup = TEGRA_SWGROUP_G2,   .reg = 0x24c },
+	{ .swgroup = TEGRA_SWGROUP_MPE,  .reg = 0x264 },
+	{ .swgroup = TEGRA_SWGROUP_VI,   .reg = 0x280 },
+	{ .swgroup = TEGRA_SWGROUP_AFI,  .reg = 0x238 },
+	{ .swgroup = TEGRA_SWGROUP_AVPC, .reg = 0x23c },
+	{ .swgroup = TEGRA_SWGROUP_NV,   .reg = 0x268 },
+	{ .swgroup = TEGRA_SWGROUP_NV2,  .reg = 0x26c },
+	{ .swgroup = TEGRA_SWGROUP_HDA,  .reg = 0x254 },
+	{ .swgroup = TEGRA_SWGROUP_HC,   .reg = 0x250 },
+	{ .swgroup = TEGRA_SWGROUP_PPCS, .reg = 0x270 },
+	{ .swgroup = TEGRA_SWGROUP_SATA, .reg = 0x278 },
+	{ .swgroup = TEGRA_SWGROUP_VDE,  .reg = 0x27c },
+	{ .swgroup = TEGRA_SWGROUP_ISP,  .reg = 0x258 },
+};
+
+static void tegra30_flush_dcache(struct page *page, unsigned long offset,
+				 size_t size)
+{
+	phys_addr_t phys = page_to_phys(page) + offset;
+	void *virt = page_address(page) + offset;
+
+	__cpuc_flush_dcache_area(virt, size);
+	outer_flush_range(phys, phys + size);
+}
+
+static const struct tegra_smmu_ops tegra30_smmu_ops = {
+	.flush_dcache = tegra30_flush_dcache,
+};
+
+static const struct tegra_smmu_soc tegra30_smmu_soc = {
+	.clients = tegra30_mc_clients,
+	.num_clients = ARRAY_SIZE(tegra30_mc_clients),
+	.swgroups = tegra30_swgroups,
+	.num_swgroups = ARRAY_SIZE(tegra30_swgroups),
+	.supports_round_robin_arbitration = false,
+	.supports_request_limit = false,
+	.num_asids = 4,
+	.ops = &tegra30_smmu_ops,
+};
+
+const struct tegra_mc_soc tegra30_mc_soc = {
+	.clients = tegra30_mc_clients,
+	.num_clients = ARRAY_SIZE(tegra30_mc_clients),
+	.num_address_bits = 32,
+	.atom_size = 16,
+	.smmu = &tegra30_smmu_soc,
+};
diff --git a/drivers/memory/tegra30-mc.c b/drivers/memory/tegra30-mc.c
deleted file mode 100644
index ef7934535fd1..000000000000
--- a/drivers/memory/tegra30-mc.c
+++ /dev/null
@@ -1,378 +0,0 @@
-/*
- * Tegra30 Memory Controller
- *
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/ratelimit.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-
-#define DRV_NAME "tegra30-mc"
-
-#define MC_INTSTATUS			0x0
-#define MC_INTMASK			0x4
-
-#define MC_INT_ERR_SHIFT		6
-#define MC_INT_ERR_MASK			(0x1f << MC_INT_ERR_SHIFT)
-#define MC_INT_DECERR_EMEM		BIT(MC_INT_ERR_SHIFT)
-#define MC_INT_SECURITY_VIOLATION	BIT(MC_INT_ERR_SHIFT + 2)
-#define MC_INT_ARBITRATION_EMEM		BIT(MC_INT_ERR_SHIFT + 3)
-#define MC_INT_INVALID_SMMU_PAGE	BIT(MC_INT_ERR_SHIFT + 4)
-
-#define MC_ERR_STATUS			0x8
-#define MC_ERR_ADR			0xc
-
-#define MC_ERR_TYPE_SHIFT		28
-#define MC_ERR_TYPE_MASK		(7 << MC_ERR_TYPE_SHIFT)
-#define MC_ERR_TYPE_DECERR_EMEM		2
-#define MC_ERR_TYPE_SECURITY_TRUSTZONE	3
-#define MC_ERR_TYPE_SECURITY_CARVEOUT	4
-#define MC_ERR_TYPE_INVALID_SMMU_PAGE	6
-
-#define MC_ERR_INVALID_SMMU_PAGE_SHIFT	25
-#define MC_ERR_INVALID_SMMU_PAGE_MASK	(7 << MC_ERR_INVALID_SMMU_PAGE_SHIFT)
-#define MC_ERR_RW_SHIFT			16
-#define MC_ERR_RW			BIT(MC_ERR_RW_SHIFT)
-#define MC_ERR_SECURITY			BIT(MC_ERR_RW_SHIFT + 1)
-
-#define SECURITY_VIOLATION_TYPE		BIT(30)	/* 0=TRUSTZONE, 1=CARVEOUT */
-
-#define MC_EMEM_ARB_CFG			0x90
-#define MC_EMEM_ARB_OUTSTANDING_REQ	0x94
-#define MC_EMEM_ARB_TIMING_RCD		0x98
-#define MC_EMEM_ARB_TIMING_RP		0x9c
-#define MC_EMEM_ARB_TIMING_RC		0xa0
-#define MC_EMEM_ARB_TIMING_RAS		0xa4
-#define MC_EMEM_ARB_TIMING_FAW		0xa8
-#define MC_EMEM_ARB_TIMING_RRD		0xac
-#define MC_EMEM_ARB_TIMING_RAP2PRE	0xb0
-#define MC_EMEM_ARB_TIMING_WAP2PRE	0xb4
-#define MC_EMEM_ARB_TIMING_R2R		0xb8
-#define MC_EMEM_ARB_TIMING_W2W		0xbc
-#define MC_EMEM_ARB_TIMING_R2W		0xc0
-#define MC_EMEM_ARB_TIMING_W2R		0xc4
-
-#define MC_EMEM_ARB_DA_TURNS		0xd0
-#define MC_EMEM_ARB_DA_COVERS		0xd4
-#define MC_EMEM_ARB_MISC0		0xd8
-#define MC_EMEM_ARB_MISC1		0xdc
-
-#define MC_EMEM_ARB_RING3_THROTTLE	0xe4
-#define MC_EMEM_ARB_OVERRIDE		0xe8
-
-#define MC_TIMING_CONTROL		0xfc
-
-#define MC_CLIENT_ID_MASK		0x7f
-
-#define NUM_MC_REG_BANKS		4
-
-struct tegra30_mc {
-	void __iomem *regs[NUM_MC_REG_BANKS];
-	struct device *dev;
-	u32 ctx[0];
-};
-
-static inline u32 mc_readl(struct tegra30_mc *mc, u32 offs)
-{
-	u32 val = 0;
-
-	if (offs < 0x10)
-		val = readl(mc->regs[0] + offs);
-	else if (offs < 0x1f0)
-		val = readl(mc->regs[1] + offs - 0x3c);
-	else if (offs < 0x228)
-		val = readl(mc->regs[2] + offs - 0x200);
-	else if (offs < 0x400)
-		val = readl(mc->regs[3] + offs - 0x284);
-
-	return val;
-}
-
-static inline void mc_writel(struct tegra30_mc *mc, u32 val, u32 offs)
-{
-	if (offs < 0x10)
-		writel(val, mc->regs[0] + offs);
-	else if (offs < 0x1f0)
-		writel(val, mc->regs[1] + offs - 0x3c);
-	else if (offs < 0x228)
-		writel(val, mc->regs[2] + offs - 0x200);
-	else if (offs < 0x400)
-		writel(val, mc->regs[3] + offs - 0x284);
-}
-
-static const char * const tegra30_mc_client[] = {
-	"csr_ptcr",
-	"cbr_display0a",
-	"cbr_display0ab",
-	"cbr_display0b",
-	"cbr_display0bb",
-	"cbr_display0c",
-	"cbr_display0cb",
-	"cbr_display1b",
-	"cbr_display1bb",
-	"cbr_eppup",
-	"cbr_g2pr",
-	"cbr_g2sr",
-	"cbr_mpeunifbr",
-	"cbr_viruv",
-	"csr_afir",
-	"csr_avpcarm7r",
-	"csr_displayhc",
-	"csr_displayhcb",
-	"csr_fdcdrd",
-	"csr_fdcdrd2",
-	"csr_g2dr",
-	"csr_hdar",
-	"csr_host1xdmar",
-	"csr_host1xr",
-	"csr_idxsrd",
-	"csr_idxsrd2",
-	"csr_mpe_ipred",
-	"csr_mpeamemrd",
-	"csr_mpecsrd",
-	"csr_ppcsahbdmar",
-	"csr_ppcsahbslvr",
-	"csr_satar",
-	"csr_texsrd",
-	"csr_texsrd2",
-	"csr_vdebsevr",
-	"csr_vdember",
-	"csr_vdemcer",
-	"csr_vdetper",
-	"csr_mpcorelpr",
-	"csr_mpcorer",
-	"cbw_eppu",
-	"cbw_eppv",
-	"cbw_eppy",
-	"cbw_mpeunifbw",
-	"cbw_viwsb",
-	"cbw_viwu",
-	"cbw_viwv",
-	"cbw_viwy",
-	"ccw_g2dw",
-	"csw_afiw",
-	"csw_avpcarm7w",
-	"csw_fdcdwr",
-	"csw_fdcdwr2",
-	"csw_hdaw",
-	"csw_host1xw",
-	"csw_ispw",
-	"csw_mpcorelpw",
-	"csw_mpcorew",
-	"csw_mpecswr",
-	"csw_ppcsahbdmaw",
-	"csw_ppcsahbslvw",
-	"csw_sataw",
-	"csw_vdebsevw",
-	"csw_vdedbgw",
-	"csw_vdembew",
-	"csw_vdetpmw",
-};
-
-static void tegra30_mc_decode(struct tegra30_mc *mc, int n)
-{
-	u32 err, addr;
-	const char * const mc_int_err[] = {
-		"MC_DECERR",
-		"Unknown",
-		"MC_SECURITY_ERR",
-		"MC_ARBITRATION_EMEM",
-		"MC_SMMU_ERR",
-	};
-	const char * const err_type[] = {
-		"Unknown",
-		"Unknown",
-		"DECERR_EMEM",
-		"SECURITY_TRUSTZONE",
-		"SECURITY_CARVEOUT",
-		"Unknown",
-		"INVALID_SMMU_PAGE",
-		"Unknown",
-	};
-	char attr[6];
-	int cid, perm, type, idx;
-	const char *client = "Unknown";
-
-	idx = n - MC_INT_ERR_SHIFT;
-	if ((idx < 0) || (idx >= ARRAY_SIZE(mc_int_err)) || (idx == 1)) {
-		dev_err_ratelimited(mc->dev, "Unknown interrupt status %08lx\n",
-				    BIT(n));
-		return;
-	}
-
-	err = mc_readl(mc, MC_ERR_STATUS);
-
-	type = (err & MC_ERR_TYPE_MASK) >> MC_ERR_TYPE_SHIFT;
-	perm = (err & MC_ERR_INVALID_SMMU_PAGE_MASK) >>
-		MC_ERR_INVALID_SMMU_PAGE_SHIFT;
-	if (type == MC_ERR_TYPE_INVALID_SMMU_PAGE)
-		sprintf(attr, "%c-%c-%c",
-			(perm & BIT(2)) ? 'R' : '-',
-			(perm & BIT(1)) ? 'W' : '-',
-			(perm & BIT(0)) ? 'S' : '-');
-	else
-		attr[0] = '\0';
-
-	cid = err & MC_CLIENT_ID_MASK;
-	if (cid < ARRAY_SIZE(tegra30_mc_client))
-		client = tegra30_mc_client[cid];
-
-	addr = mc_readl(mc, MC_ERR_ADR);
-
-	dev_err_ratelimited(mc->dev, "%s (0x%08x): 0x%08x %s (%s %s %s %s)\n",
-			   mc_int_err[idx], err, addr, client,
-			   (err & MC_ERR_SECURITY) ? "secure" : "non-secure",
-			   (err & MC_ERR_RW) ? "write" : "read",
-			   err_type[type], attr);
-}
-
-static const u32 tegra30_mc_ctx[] = {
-	MC_EMEM_ARB_CFG,
-	MC_EMEM_ARB_OUTSTANDING_REQ,
-	MC_EMEM_ARB_TIMING_RCD,
-	MC_EMEM_ARB_TIMING_RP,
-	MC_EMEM_ARB_TIMING_RC,
-	MC_EMEM_ARB_TIMING_RAS,
-	MC_EMEM_ARB_TIMING_FAW,
-	MC_EMEM_ARB_TIMING_RRD,
-	MC_EMEM_ARB_TIMING_RAP2PRE,
-	MC_EMEM_ARB_TIMING_WAP2PRE,
-	MC_EMEM_ARB_TIMING_R2R,
-	MC_EMEM_ARB_TIMING_W2W,
-	MC_EMEM_ARB_TIMING_R2W,
-	MC_EMEM_ARB_TIMING_W2R,
-	MC_EMEM_ARB_DA_TURNS,
-	MC_EMEM_ARB_DA_COVERS,
-	MC_EMEM_ARB_MISC0,
-	MC_EMEM_ARB_MISC1,
-	MC_EMEM_ARB_RING3_THROTTLE,
-	MC_EMEM_ARB_OVERRIDE,
-	MC_INTMASK,
-};
-
-#ifdef CONFIG_PM
-static int tegra30_mc_suspend(struct device *dev)
-{
-	int i;
-	struct tegra30_mc *mc = dev_get_drvdata(dev);
-
-	for (i = 0; i < ARRAY_SIZE(tegra30_mc_ctx); i++)
-		mc->ctx[i] = mc_readl(mc, tegra30_mc_ctx[i]);
-	return 0;
-}
-
-static int tegra30_mc_resume(struct device *dev)
-{
-	int i;
-	struct tegra30_mc *mc = dev_get_drvdata(dev);
-
-	for (i = 0; i < ARRAY_SIZE(tegra30_mc_ctx); i++)
-		mc_writel(mc, mc->ctx[i], tegra30_mc_ctx[i]);
-
-	mc_writel(mc, 1, MC_TIMING_CONTROL);
-	/* Read-back to ensure that write reached */
-	mc_readl(mc, MC_TIMING_CONTROL);
-	return 0;
-}
-#endif
-
-static UNIVERSAL_DEV_PM_OPS(tegra30_mc_pm,
-			    tegra30_mc_suspend,
-			    tegra30_mc_resume, NULL);
-
-static const struct of_device_id tegra30_mc_of_match[] = {
-	{ .compatible = "nvidia,tegra30-mc", },
-	{},
-};
-
-static irqreturn_t tegra30_mc_isr(int irq, void *data)
-{
-	u32 stat, mask, bit;
-	struct tegra30_mc *mc = data;
-
-	stat = mc_readl(mc, MC_INTSTATUS);
-	mask = mc_readl(mc, MC_INTMASK);
-	mask &= stat;
-	if (!mask)
-		return IRQ_NONE;
-	while ((bit = ffs(mask)) != 0) {
-		tegra30_mc_decode(mc, bit - 1);
-		mask &= ~BIT(bit - 1);
-	}
-
-	mc_writel(mc, stat, MC_INTSTATUS);
-	return IRQ_HANDLED;
-}
-
-static int tegra30_mc_probe(struct platform_device *pdev)
-{
-	struct resource *irq;
-	struct tegra30_mc *mc;
-	size_t bytes;
-	int err, i;
-	u32 intmask;
-
-	bytes = sizeof(*mc) + sizeof(u32) * ARRAY_SIZE(tegra30_mc_ctx);
-	mc = devm_kzalloc(&pdev->dev, bytes, GFP_KERNEL);
-	if (!mc)
-		return -ENOMEM;
-	mc->dev = &pdev->dev;
-
-	for (i = 0; i < ARRAY_SIZE(mc->regs); i++) {
-		struct resource *res;
-
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		mc->regs[i] = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(mc->regs[i]))
-			return PTR_ERR(mc->regs[i]);
-	}
-
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq)
-		return -ENODEV;
-	err = devm_request_irq(&pdev->dev, irq->start, tegra30_mc_isr,
-			       IRQF_SHARED, dev_name(&pdev->dev), mc);
-	if (err)
-		return -ENODEV;
-
-	platform_set_drvdata(pdev, mc);
-
-	intmask = MC_INT_INVALID_SMMU_PAGE |
-		MC_INT_DECERR_EMEM | MC_INT_SECURITY_VIOLATION;
-	mc_writel(mc, intmask, MC_INTMASK);
-	return 0;
-}
-
-static struct platform_driver tegra30_mc_driver = {
-	.probe = tegra30_mc_probe,
-	.driver = {
-		.name = DRV_NAME,
-		.owner = THIS_MODULE,
-		.of_match_table = tegra30_mc_of_match,
-		.pm = &tegra30_mc_pm,
-	},
-};
-module_platform_driver(tegra30_mc_driver);
-
-MODULE_AUTHOR("Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
-MODULE_DESCRIPTION("Tegra30 MC driver");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/dt-bindings/memory/tegra114-mc.h b/include/dt-bindings/memory/tegra114-mc.h
new file mode 100644
index 000000000000..8f48985a3139
--- /dev/null
+++ b/include/dt-bindings/memory/tegra114-mc.h
@@ -0,0 +1,25 @@
+#ifndef DT_BINDINGS_MEMORY_TEGRA114_MC_H
+#define DT_BINDINGS_MEMORY_TEGRA114_MC_H
+
+#define TEGRA_SWGROUP_PTC	0
+#define TEGRA_SWGROUP_DC	1
+#define TEGRA_SWGROUP_DCB	2
+#define TEGRA_SWGROUP_EPP	3
+#define TEGRA_SWGROUP_G2	4
+#define TEGRA_SWGROUP_AVPC	5
+#define TEGRA_SWGROUP_NV	6
+#define TEGRA_SWGROUP_HDA	7
+#define TEGRA_SWGROUP_HC	8
+#define TEGRA_SWGROUP_MSENC	9
+#define TEGRA_SWGROUP_PPCS	10
+#define TEGRA_SWGROUP_VDE	11
+#define TEGRA_SWGROUP_MPCORELP	12
+#define TEGRA_SWGROUP_MPCORE	13
+#define TEGRA_SWGROUP_VI	14
+#define TEGRA_SWGROUP_ISP	15
+#define TEGRA_SWGROUP_XUSB_HOST	16
+#define TEGRA_SWGROUP_XUSB_DEV	17
+#define TEGRA_SWGROUP_EMUCIF	18
+#define TEGRA_SWGROUP_TSEC	19
+
+#endif
diff --git a/include/dt-bindings/memory/tegra124-mc.h b/include/dt-bindings/memory/tegra124-mc.h
new file mode 100644
index 000000000000..7d8ee798f34e
--- /dev/null
+++ b/include/dt-bindings/memory/tegra124-mc.h
@@ -0,0 +1,31 @@
+#ifndef DT_BINDINGS_MEMORY_TEGRA124_MC_H
+#define DT_BINDINGS_MEMORY_TEGRA124_MC_H
+
+#define TEGRA_SWGROUP_PTC	0
+#define TEGRA_SWGROUP_DC	1
+#define TEGRA_SWGROUP_DCB	2
+#define TEGRA_SWGROUP_AFI	3
+#define TEGRA_SWGROUP_AVPC	4
+#define TEGRA_SWGROUP_HDA	5
+#define TEGRA_SWGROUP_HC	6
+#define TEGRA_SWGROUP_MSENC	7
+#define TEGRA_SWGROUP_PPCS	8
+#define TEGRA_SWGROUP_SATA	9
+#define TEGRA_SWGROUP_VDE	10
+#define TEGRA_SWGROUP_MPCORELP	11
+#define TEGRA_SWGROUP_MPCORE	12
+#define TEGRA_SWGROUP_ISP2	13
+#define TEGRA_SWGROUP_XUSB_HOST	14
+#define TEGRA_SWGROUP_XUSB_DEV	15
+#define TEGRA_SWGROUP_ISP2B	16
+#define TEGRA_SWGROUP_TSEC	17
+#define TEGRA_SWGROUP_A9AVP	18
+#define TEGRA_SWGROUP_GPU	19
+#define TEGRA_SWGROUP_SDMMC1A	20
+#define TEGRA_SWGROUP_SDMMC2A	21
+#define TEGRA_SWGROUP_SDMMC3A	22
+#define TEGRA_SWGROUP_SDMMC4A	23
+#define TEGRA_SWGROUP_VIC	24
+#define TEGRA_SWGROUP_VI	25
+
+#endif
diff --git a/include/dt-bindings/memory/tegra30-mc.h b/include/dt-bindings/memory/tegra30-mc.h
new file mode 100644
index 000000000000..502beb03d777
--- /dev/null
+++ b/include/dt-bindings/memory/tegra30-mc.h
@@ -0,0 +1,24 @@
+#ifndef DT_BINDINGS_MEMORY_TEGRA30_MC_H
+#define DT_BINDINGS_MEMORY_TEGRA30_MC_H
+
+#define TEGRA_SWGROUP_PTC	0
+#define TEGRA_SWGROUP_DC	1
+#define TEGRA_SWGROUP_DCB	2
+#define TEGRA_SWGROUP_EPP	3
+#define TEGRA_SWGROUP_G2	4
+#define TEGRA_SWGROUP_MPE	5
+#define TEGRA_SWGROUP_VI	6
+#define TEGRA_SWGROUP_AFI	7
+#define TEGRA_SWGROUP_AVPC	8
+#define TEGRA_SWGROUP_NV	9
+#define TEGRA_SWGROUP_NV2	10
+#define TEGRA_SWGROUP_HDA	11
+#define TEGRA_SWGROUP_HC	12
+#define TEGRA_SWGROUP_PPCS	13
+#define TEGRA_SWGROUP_SATA	14
+#define TEGRA_SWGROUP_VDE	15
+#define TEGRA_SWGROUP_MPCORELP	16
+#define TEGRA_SWGROUP_MPCORE	17
+#define TEGRA_SWGROUP_ISP	18
+
+#endif
-- 
2.1.3
