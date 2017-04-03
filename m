From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/io-pgtable-arm: Avoid shift overflow in block size
Date: Mon,  3 Apr 2017 13:12:10 +0100
Message-ID: <db7c46e78bae4054d22a2524095857c5eda834f7.1491221353.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The recursive nature of __arm_lpae_{map,unmap}() means that
ARM_LPAE_BLOCK_SIZE() is evaluated for every level, including those
where block mappings aren't possible. This in itself is harmless enough,
as we will only ever be called with valid sizes from the pgsize_bitmap,
and thus always recurse down past any imaginary block sizes. The only
problem is that most of those imaginary sizes overflow the type used for
the calculation, and thus trigger warnings under UBsan:

[   63.020939] ================================================================================
[   63.021284] UBSAN: Undefined behaviour in drivers/iommu/io-pgtable-arm.c:312:22
[   63.021602] shift exponent 39 is too large for 32-bit type 'int'
[   63.021909] CPU: 0 PID: 1119 Comm: lkvm Not tainted 4.7.0-rc3+ #819
[   63.022163] Hardware name: FVP Base (DT)
[   63.022345] Call trace:
[   63.022629] [<ffffff900808f258>] dump_backtrace+0x0/0x3a8
[   63.022975] [<ffffff900808f614>] show_stack+0x14/0x20
[   63.023294] [<ffffff90086bc9dc>] dump_stack+0x104/0x148
[   63.023609] [<ffffff9008713ce8>] ubsan_epilogue+0x18/0x68
[   63.023956] [<ffffff9008714410>] __ubsan_handle_shift_out_of_bounds+0x18c/0x1bc
[   63.024365] [<ffffff900890fcb0>] __arm_lpae_map+0x720/0xae0
[   63.024732] [<ffffff9008910170>] arm_lpae_map+0x100/0x190
[   63.025049] [<ffffff90089183d8>] arm_smmu_map+0x78/0xc8
[   63.025390] [<ffffff9008906c18>] iommu_map+0x130/0x230
[   63.025763] [<ffffff9008bf7564>] vfio_iommu_type1_attach_group+0x4bc/0xa00
[   63.026156] [<ffffff9008bf3c78>] vfio_fops_unl_ioctl+0x320/0x580
[   63.026515] [<ffffff9008377420>] do_vfs_ioctl+0x140/0xd28
[   63.026858] [<ffffff9008378094>] SyS_ioctl+0x8c/0xa0
[   63.027179] [<ffffff9008086e70>] el0_svc_naked+0x24/0x28
[   63.027412] ================================================================================

Perform the shift in a 64-bit type to prevent the theoretical overflow
and keep the peace. As it turns out, this generates identical code for
32-bit ARM, and marginally shorter AArch64 code, so it's good all round.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f9bc6ebb8140..6e5df5e0a3bd 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -74,7 +74,7 @@
 
 /* Calculate the block/page mapping size at level l for pagetable in d. */
 #define ARM_LPAE_BLOCK_SIZE(l,d)					\
-	(1 << (ilog2(sizeof(arm_lpae_iopte)) +				\
+	(1ULL << (ilog2(sizeof(arm_lpae_iopte)) +			\
 		((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level)))
 
 /* Page table bits */
-- 
2.11.0.dirty
