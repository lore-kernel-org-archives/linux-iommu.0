From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 0/4] Generic IOMMU page table framework
Date: Mon, 15 Dec 2014 01:49:30 +0200
Message-ID: <2133922.nksBEtjI2q@avalon>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417089078-22900-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Robin.Murphy-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Thursday 27 November 2014 11:51:14 Will Deacon wrote:
> Hi all,
> 
> This series introduces a generic IOMMU page table allocation framework,
> implements support for ARM long-descriptors and then ports the arm-smmu
> driver over to the new code.
> 
> There are a few reasons for doing this:
> 
>   - Page table code is hard, and I don't enjoy shopping
> 
>   - A number of IOMMUs actually use the same table format, but currently
>     duplicate the code
> 
>   - It provides a CPU (and architecture) independent allocator, which
>     may be useful for some systems where the CPU is using a different
>     table format for its own mappings
> 
> As illustrated in the final patch, an IOMMU driver interacts with the
> allocator by passing in a configuration structure describing the
> input and output address ranges, the supported pages sizes and a set of
> ops for performing various TLB invalidation and PTE flushing routines.
> 
> The LPAE code implements support for 4k/2M/1G, 16k/32M and 64k/512M
> mappings, but I decided not to implement the contiguous bit in the
> interest of trying to keep the code semi-readable. This could always be
> added later, if needed.
> 
> I also included some self-tests for the LPAE implementation. Ideally
> we'd merge these, but I'm also happy to drop them if there are
> objections.
> 
> Tested with the self-tests, but also VFIO + MMU-500 at stage-1 and
> stage-2. Patches taken against my iommu/devel branch (queued by Joerg
> for 3.19).
> 
> All feedback welcome.

I've successfully tested the patch set with the Renesas IPMMU-VMSA driver with
the following extension to the allocator.

Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

>From 4bebb7f3a5a48541d4c89ce7c61e6ff66686c3a9 Mon Sep 17 00:00:00 2001
From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Date: Sun, 14 Dec 2014 23:34:50 +0200
Subject: [PATCH] iommu: io-pgtable-arm: Add Non-Secure quirk

The quirk causes the Non-Secure bit to be set in all page table entries.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm.c | 7 +++++++
 drivers/iommu/io-pgtable.h     | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 669e322a83a4..b6910e142734 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -80,11 +80,13 @@
 #define ARM_LPAE_PTE_TYPE_TABLE		3
 #define ARM_LPAE_PTE_TYPE_PAGE		3
 
+#define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
 #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
 #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
 #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
 #define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
 #define ARM_LPAE_PTE_SH_IS		(((arm_lpae_iopte)3) << 8)
+#define ARM_LPAE_PTE_NS			(((arm_lpae_iopte)1) << 5)
 #define ARM_LPAE_PTE_VALID		(((arm_lpae_iopte)1) << 0)
 
 #define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
@@ -201,6 +203,9 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 	if (iopte_leaf(*ptep, lvl))
 		return -EEXIST;
 
+	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NON_SECURE)
+		pte |= ARM_LPAE_PTE_NS;
+
 	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
 		pte |= ARM_LPAE_PTE_TYPE_PAGE;
 	else
@@ -244,6 +249,8 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		data->iop.cfg.tlb->flush_pgtable(cptep, 1UL << data->pg_shift,
 						 cookie);
 		pte = __pa(cptep) | ARM_LPAE_PTE_TYPE_TABLE;
+		if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NON_SECURE)
+			pte |= ARM_LPAE_PTE_NSTABLE;
 		*ptep = pte;
 		data->iop.cfg.tlb->flush_pgtable(ptep, sizeof(*ptep), cookie);
 	} else {
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index c1cff3d045db..a41a15d30596 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -24,6 +24,9 @@ struct iommu_gather_ops {
 	void (*flush_pgtable)(void *ptr, size_t size, void *cookie);
 };
 
+/* Set the Non-Secure bit in the PTEs */
+#define IO_PGTABLE_QUIRK_NON_SECURE	(1 << 0)
+
 struct io_pgtable_cfg {
 	int			quirks; /* IO_PGTABLE_QUIRK_* */
 	unsigned long		pgsize_bitmap;
-- 

> --->8
> 
> Will Deacon (4):
>   iommu: introduce generic page table allocation framework
>   iommu: add ARM LPAE page table allocator
>   iommu: add self-consistency tests to ARM LPAE IO page table allocator
>   iommu/arm-smmu: make use of generic LPAE allocator
> 
>  MAINTAINERS                    |   1 +
>  arch/arm64/Kconfig             |   1 -
>  drivers/iommu/Kconfig          |  32 +-
>  drivers/iommu/Makefile         |   2 +
>  drivers/iommu/arm-smmu.c       | 872 +++++++++++---------------------------
>  drivers/iommu/io-pgtable-arm.c | 925 ++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable.c     |  78 ++++
>  drivers/iommu/io-pgtable.h     |  77 ++++
>  8 files changed, 1361 insertions(+), 627 deletions(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm.c
>  create mode 100644 drivers/iommu/io-pgtable.c
>  create mode 100644 drivers/iommu/io-pgtable.h

-- 
Regards,

Laurent Pinchart
