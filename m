From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2] iommu/io-pgtable: Rationalise quirk handling
Date: Fri, 12 Feb 2016 17:09:46 +0000
Message-ID: <62860b753f304beef7b4b6f1e13d7094252f2f37.1455294748.git.robin.murphy@arm.com>
References: <cover.1453723096.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1453723096.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

As the number of io-pgtable implementations grows beyond 1, it's time
to rationalise the quirks mechanism before things have a chance to
start getting really ugly and out-of-hand.

To that end:
- Indicate exactly which quirks each format can/does support.
- Fail creating a table if a caller wants unsupported quirks.
- Properly document where each quirk applies and why.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Just to allay any confusion, I intend this as a followup to the
short-descriptor[1] and Mediatek IOMMU[2] patches, rather than a
crucial addition, so it can either get picked up along with those
or wait 'til later.

v2:
- Use unsigned long for the bitmap.
- Do format-specific checks inline.
- Enough of a difference that I don't feel comfortable putting
  Laurent's reviewed-by from v1 on it...

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/12007
[2]:http://thread.gmane.org/gmane.linux.kernel.iommu/11974

 drivers/iommu/io-pgtable-arm-v7s.c |  5 +++++
 drivers/iommu/io-pgtable-arm.c     | 13 +++++++++++--
 drivers/iommu/io-pgtable.h         | 22 ++++++++++++++++++----
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index d39a021..9fcceb1 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -623,6 +623,11 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
 		return NULL;
 
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
+			    IO_PGTABLE_QUIRK_NO_PERMS |
+			    IO_PGTABLE_QUIRK_TLBI_ON_MAP))
+		return NULL;
+
 	data = kmalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return NULL;
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 4095af2..debdf04 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -658,8 +658,12 @@ static struct io_pgtable *
 arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 {
 	u64 reg;
-	struct arm_lpae_io_pgtable *data = arm_lpae_alloc_pgtable(cfg);
+	struct arm_lpae_io_pgtable *data;
 
+	if (cfg->quirks & ~IO_PGTABLE_QUIRK_ARM_NS)
+		return NULL;
+
+	data = arm_lpae_alloc_pgtable(cfg);
 	if (!data)
 		return NULL;
 
@@ -742,8 +746,13 @@ static struct io_pgtable *
 arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 {
 	u64 reg, sl;
-	struct arm_lpae_io_pgtable *data = arm_lpae_alloc_pgtable(cfg);
+	struct arm_lpae_io_pgtable *data;
 
+	/* The NS quirk doesn't apply at stage 2 */
+	if (cfg->quirks)
+		return NULL;
+
+	data = arm_lpae_alloc_pgtable(cfg);
 	if (!data)
 		return NULL;
 
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 4faee7d..d4f5027 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -47,10 +47,24 @@ struct iommu_gather_ops {
  *                 page table walker.
  */
 struct io_pgtable_cfg {
-	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0) /* Set NS bit in PTEs */
-	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1) /* No AP/XN bits */
-	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2) /* TLB Inv. on map */
-	int				quirks;
+	/*
+	 * IO_PGTABLE_QUIRK_ARM_NS: (ARM formats) Set NS and NSTABLE bits in
+	 *	stage 1 PTEs, for hardware which insists on validating them
+	 *	even in	non-secure state where they should normally be ignored.
+	 *
+	 * IO_PGTABLE_QUIRK_NO_PERMS: Ignore the IOMMU_READ, IOMMU_WRITE and
+	 *	IOMMU_NOEXEC flags and map everything with full access, for
+	 *	hardware which does not implement the permissions of a given
+	 *	format, and/or requires some format-specific default value.
+	 *
+	 * IO_PGTABLE_QUIRK_TLBI_ON_MAP: If the format forbids caching invalid
+	 *	(unmapped) entries but the hardware might do so anyway, perform
+	 *	TLB maintenance when mapping as well as when unmapping.
+	 */
+	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
+	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
+	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
+	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
 	unsigned int			oas;
-- 
2.7.0.25.gfc10eb5.dirty
