From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: iommu/arm-smmu: Regression (sleeping function called from invalid
	context)
Date: Fri, 31 Jan 2014 00:55:52 +0100
Message-ID: <20140130235552.GL13543@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

Seems that commit a44a9791e778d9ccda50d5534028ed4057a9a45b
(iommu/arm-smmu: use mutex instead of spinlock for locking page tables)
introduced a regression.

At least I've hit

  BUG: scheduling while atomic: ksoftirqd/0/3/0x00000100

and after turning on CONFIG_DEBUG_ATOMIC_SLEEP I get

  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:96
  in_atomic(): 1, irqs_disabled(): 128, pid: 1, name: swapper/0
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0-00013-gd414667 #411
  [<c0014740>] (unwind_backtrace+0x0/0xf8) from [<c00115b0>] (show_stack+0x10/0x14)
  [<c00115b0>] (show_stack+0x10/0x14) from [<c057f12c>] (dump_stack+0x74/0xa8)
  [<c057f12c>] (dump_stack+0x74/0xa8) from [<c0583460>] (mutex_lock+0x18/0x64)
  [<c0583460>] (mutex_lock+0x18/0x64) from [<c042a5fc>] (arm_smmu_handle_mapping+0xfc/0x644)
  [<c042a5fc>] (arm_smmu_handle_mapping+0xfc/0x644) from [<c0429674>] (iommu_map+0xf0/0x148)
  [<c0429674>] (iommu_map+0xf0/0x148) from [<c00199c8>] (__map_sg_chunk+0x208/0x414)
  [<c00199c8>] (__map_sg_chunk+0x208/0x414) from [<c0019d50>] (__iommu_map_sg+0x17c/0x208)
  [<c0019d50>] (__iommu_map_sg+0x17c/0x208) from [<c0019df8>] (arm_iommu_map_sg+0x1c/0x24)
  [<c0019df8>] (arm_iommu_map_sg+0x1c/0x24) from [<c031edb4>] (ata_qc_issue+0x258/0x370)
  [<c031edb4>] (ata_qc_issue+0x258/0x370) from [<c0323b68>] (ata_scsi_translate+0x90/0x150)
  [<c0323b68>] (ata_scsi_translate+0x90/0x150) from [<c0327368>] (ata_scsi_queuecmd+0x84/0x248)
  [<c0327368>] (ata_scsi_queuecmd+0x84/0x248) from [<c0301ed8>] (scsi_dispatch_cmd+0x94/0x134)
  [<c0301ed8>] (scsi_dispatch_cmd+0x94/0x134) from [<c0307ecc>] (scsi_request_fn+0x3dc/0x5dc)
  [<c0307ecc>] (scsi_request_fn+0x3dc/0x5dc) from [<c0250034>] (__blk_run_queue+0x34/0x44)
  [<c0250034>] (__blk_run_queue+0x34/0x44) from [<c02539e0>] (blk_queue_bio+0x178/0x26c)
  [<c02539e0>] (blk_queue_bio+0x178/0x26c) from [<c02512a0>] (generic_make_request+0xa8/0xc8)
  [<c02512a0>] (generic_make_request+0xa8/0xc8) from [<c0251348>] (submit_bio+0x88/0x134)
  [<c0251348>] (submit_bio+0x88/0x134) from [<c0113938>] (_submit_bh+0x1a4/0x254)
  [<c0113938>] (_submit_bh+0x1a4/0x254) from [<c0114210>] (ll_rw_block+0x94/0xec)
  [<c0114210>] (ll_rw_block+0x94/0xec) from [<c0116078>] (__breadahead+0x30/0x48)
  [<c0116078>] (__breadahead+0x30/0x48) from [<c0171ca4>] (__ext4_get_inode_loc+0x3c4/0x450)
  [<c0171ca4>] (__ext4_get_inode_loc+0x3c4/0x450) from [<c017409c>] (ext4_iget+0x60/0x96c)
  [<c017409c>] (ext4_iget+0x60/0x96c) from [<c017cdc0>] (ext4_lookup+0x74/0x164)
  [<c017cdc0>] (ext4_lookup+0x74/0x164) from [<c00f14a4>] (lookup_real+0x20/0x50)
  [<c00f14a4>] (lookup_real+0x20/0x50) from [<c00f235c>] (__lookup_hash+0x34/0x44)
  [<c00f235c>] (__lookup_hash+0x34/0x44) from [<c00f23a4>] (lookup_slow+0x38/0x9c)
  [<c00f23a4>] (lookup_slow+0x38/0x9c) from [<c00f30d4>] (link_path_walk+0x308/0x7f0)
  [<c00f30d4>] (link_path_walk+0x308/0x7f0) from [<c00f6384>] (path_openat+0x8c/0x63c)
  [<c00f6384>] (path_openat+0x8c/0x63c) from [<c00f6c34>] (do_filp_open+0x2c/0x80)
  [<c00f6c34>] (do_filp_open+0x2c/0x80) from [<c00edce0>] (open_exec+0x2c/0xf8)
  [<c00edce0>] (open_exec+0x2c/0xf8) from [<c00eee98>] (do_execve+0x1a4/0x5a4)
  [<c00eee98>] (do_execve+0x1a4/0x5a4) from [<c000873c>] (try_to_run_init_process+0x1c/0x50)
  [<c000873c>] (try_to_run_init_process+0x1c/0x50) from [<c057b7a0>] (kernel_init+0xa8/0x110)
  [<c057b7a0>] (kernel_init+0xa8/0x110) from [<c000e378>] (ret_from_fork+0x14/0x3c)

After reverting commit a44a9791e778d9ccda50d5534028ed4057a9a45b I have
fewer warnings/errors but still I've seen:

  BUG: sleeping function called from invalid context at mm/page_alloc.c:2679
  in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.13.0-00016-g6e90346 #413
  [<c0014740>] (unwind_backtrace+0x0/0xf8) from [<c00115b0>] (show_stack+0x10/0x14)
  [<c00115b0>] (show_stack+0x10/0x14) from [<c057ea24>] (dump_stack+0x74/0xa8)
  [<c057ea24>] (dump_stack+0x74/0xa8) from [<c00acc1c>] (__alloc_pages_nodemask+0x174/0x930)
  [<c00acc1c>] (__alloc_pages_nodemask+0x174/0x930) from [<c042a250>] (arm_smmu_handle_mapping+0x470/0x66c)
  [<c042a250>] (arm_smmu_handle_mapping+0x470/0x66c) from [<c0428e74>] (iommu_map+0xf0/0x148)
  [<c0428e74>] (iommu_map+0xf0/0x148) from [<c001935c>] (__map_sg_chunk+0x198/0x2d4)
  [<c001935c>] (__map_sg_chunk+0x198/0x2d4) from [<c0019614>] (__iommu_map_sg+0x17c/0x208)
  [<c0019614>] (__iommu_map_sg+0x17c/0x208) from [<c00196bc>] (arm_iommu_map_sg+0x1c/0x24)
  [<c00196bc>] (arm_iommu_map_sg+0x1c/0x24) from [<c031e5b4>] (ata_qc_issue+0x258/0x370)
  [<c031e5b4>] (ata_qc_issue+0x258/0x370) from [<c0323368>] (ata_scsi_translate+0x90/0x150)
  [<c0323368>] (ata_scsi_translate+0x90/0x150) from [<c0326b68>] (ata_scsi_queuecmd+0x84/0x248)
  [<c0326b68>] (ata_scsi_queuecmd+0x84/0x248) from [<c03016d8>] (scsi_dispatch_cmd+0x94/0x134)
  [<c03016d8>] (scsi_dispatch_cmd+0x94/0x134) from [<c03076cc>] (scsi_request_fn+0x3dc/0x5dc)
  [<c03076cc>] (scsi_request_fn+0x3dc/0x5dc) from [<c024f834>] (__blk_run_queue+0x34/0x44)
  [<c024f834>] (__blk_run_queue+0x34/0x44) from [<c024fabc>] (blk_run_queue+0x1c/0x2c)
  [<c024fabc>] (blk_run_queue+0x1c/0x2c) from [<c030638c>] (scsi_run_queue+0xc4/0x240)
  [<c030638c>] (scsi_run_queue+0xc4/0x240) from [<c0307f0c>] (scsi_next_command+0x2c/0x38)
  [<c0307f0c>] (scsi_next_command+0x2c/0x38) from [<c030815c>] (scsi_io_completion+0x1fc/0x630)
  [<c030815c>] (scsi_io_completion+0x1fc/0x630) from [<c0257a94>] (blk_done_softirq+0x74/0x8c)
  [<c0257a94>] (blk_done_softirq+0x74/0x8c) from [<c002856c>] (__do_softirq+0xe4/0x210)
  [<c002856c>] (__do_softirq+0xe4/0x210) from [<c00289c4>] (irq_exit+0xa0/0xec)
  [<c00289c4>] (irq_exit+0xa0/0xec) from [<c000eb98>] (handle_IRQ+0x3c/0x90)
  [<c000eb98>] (handle_IRQ+0x3c/0x90) from [<c0008538>] (gic_handle_irq+0x28/0x5c)
  [<c0008538>] (gic_handle_irq+0x28/0x5c) from [<c0012040>] (__irq_svc+0x40/0x50)

Maybe that was the reason why the offending commit was introduced(?).

I think with the current code "atomic allocations" should be used when
IO page tables are created. With below patch I've not triggered above
errors.

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 429c95e..0418d69 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1398,7 +1398,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 
 	if (pmd_none(*pmd)) {
 		/* Allocate a new set of tables */
-		pgtable_t table = alloc_page(PGALLOC_GFP);
+		pgtable_t table = alloc_page(GFP_ATOMIC);
 		if (!table)
 			return -ENOMEM;
 
@@ -1503,7 +1503,7 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 
 #ifndef __PAGETABLE_PMD_FOLDED
 	if (pud_none(*pud)) {
-		pmd = pmd_alloc_one(NULL, addr);
+		pmd = (pmd_t *) get_zeroed_page(GFP_ATOMIC);
 		if (!pmd)
 			return -ENOMEM;
 	} else
@@ -1532,7 +1532,7 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 
 #ifndef __PAGETABLE_PUD_FOLDED
 	if (pgd_none(*pgd)) {
-		pud = pud_alloc_one(NULL, addr);
+		pud = (pud_t *) get_zeroed_page(GFP_ATOMIC);
 		if (!pud)
 			return -ENOMEM;
 	} else
