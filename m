From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 2/3] iommu/io-pgtable-arm: Add support to use system cache
Date: Mon, 21 Jan 2019 11:23:34 +0530
Message-ID: <20190121055335.15430-3-vivek.gautam@codeaurora.org>
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190121055335.15430-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Few Qualcomm platforms such as, sdm845 have an additional outer
cache called as System cache, aka. Last level cache (LLC) that
allows non-coherent devices to upgrade to using caching.

There is a fundamental assumption that non-coherent devices can't
access caches. This change adds an exception where they *can* use
some level of cache despite still being non-coherent overall.
The coherent devices that use cacheable memory, and CPU make use of
this system cache by default.

Looking at memory types, we have following -
a) Normal uncached :- MAIR 0x44, inner non-cacheable,
                      outer non-cacheable;
b) Normal cached :-   MAIR 0xff, inner read write-back non-transient,
                      outer read write-back non-transient;
                      attribute setting for coherenet I/O devices.
and, for non-coherent i/o devices that can allocate in system cache
another type gets added -
c) Normal sys-cached :- MAIR 0xf4, inner non-cacheable,
                        outer read write-back non-transient

Coherent I/O devices use system cache by marking the memory as
normal cached.
Non-coherent I/O devices should mark the memory as normal
sys-cached in page tables to use system cache.

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm.c | 15 +++++++++++++--
 drivers/iommu/io-pgtable.h     |  4 ++++
 include/linux/iommu.h          |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index c76919c30f1a..0e55772702da 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -168,10 +168,12 @@
 #define ARM_LPAE_MAIR_ATTR_MASK		0xff
 #define ARM_LPAE_MAIR_ATTR_DEVICE	0x04
 #define ARM_LPAE_MAIR_ATTR_NC		0x44
+#define ARM_LPAE_MAIR_ATTR_QCOM_SYS_CACHE	0xf4
 #define ARM_LPAE_MAIR_ATTR_WBRWA	0xff
 #define ARM_LPAE_MAIR_ATTR_IDX_NC	0
 #define ARM_LPAE_MAIR_ATTR_IDX_CACHE	1
 #define ARM_LPAE_MAIR_ATTR_IDX_DEV	2
+#define ARM_LPAE_MAIR_ATTR_IDX_QCOM_SYS_CACHE	3
 
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
@@ -443,6 +445,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 		else if (prot & IOMMU_CACHE)
 			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
+		else if (prot & IOMMU_QCOM_SYS_CACHE)
+			pte |= (ARM_LPAE_MAIR_ATTR_IDX_QCOM_SYS_CACHE
+				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	} else {
 		pte = ARM_LPAE_PTE_HAP_FAULT;
 		if (prot & IOMMU_READ)
@@ -781,7 +786,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
 			    IO_PGTABLE_QUIRK_NON_STRICT |
-			    IO_PGTABLE_QUIRK_NON_COHERENT))
+			    IO_PGTABLE_QUIRK_NON_COHERENT |
+			    IO_PGTABLE_QUIRK_QCOM_SYS_CACHE))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -794,6 +800,9 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	if (cfg->quirks & IO_PGTABLE_QUIRK_NON_COHERENT)
 		reg |= ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT |
 		       ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_ORGN0_SHIFT;
+	else if (cfg->quirks & IO_PGTABLE_QUIRK_QCOM_SYS_CACHE)
+		reg |= ARM_LPAE_TCR_RGN_NC << ARM_LPAE_TCR_IRGN0_SHIFT |
+		      ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT;
 	else
 		reg |= ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_IRGN0_SHIFT |
 		       ARM_LPAE_TCR_RGN_WBWA << ARM_LPAE_TCR_ORGN0_SHIFT;
@@ -848,7 +857,9 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	      (ARM_LPAE_MAIR_ATTR_WBRWA
 	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_CACHE)) |
 	      (ARM_LPAE_MAIR_ATTR_DEVICE
-	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV));
+	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV)) |
+	      (ARM_LPAE_MAIR_ATTR_QCOM_SYS_CACHE
+	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_QCOM_SYS_CACHE));
 
 	cfg->arm_lpae_s1_cfg.mair[0] = reg;
 	cfg->arm_lpae_s1_cfg.mair[1] = 0;
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 46604cf7b017..fb237e8aa9f1 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -80,6 +80,9 @@ struct io_pgtable_cfg {
 	 *      pagetables even on a coherent SMMU for cases where reducing
 	 *      snoop traffic/latency on walks outweighs the cost of cache
 	 *      maintenance on PTE updates.
+	 *
+	 * IO_PGTABLE_QUIRK_QCOM_SYS_CACHE: Force using outer system cache
+	 *      for non-coherent devices on Qcom platforms.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
@@ -88,6 +91,7 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_NO_DMA		BIT(4)
 	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(5)
 	#define IO_PGTABLE_QUIRK_NON_COHERENT	BIT(6)
+	#define IO_PGTABLE_QUIRK_QCOM_SYS_CACHE BIT(7)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e90da6b6f3d1..08bb6befad5e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -31,6 +31,7 @@
 #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
 #define IOMMU_NOEXEC	(1 << 3)
 #define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
+#define IOMMU_QCOM_SYS_CACHE	(1 << 6)
 /*
  * Where the bus hardware includes a privilege level as part of its access type
  * markings, and certain devices are capable of issuing transactions marked as
@@ -125,6 +126,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	DOMAIN_ATTR_QCOM_SYS_CACHE,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
