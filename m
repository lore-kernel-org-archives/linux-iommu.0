From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 7/7] iommu/arm-smmu: remove pgtable_page_{c,d}tor()
Date: Fri, 29 Aug 2014 15:47:45 +0100
Message-ID: <1409323665-9605-8-git-send-email-will.deacon@arm.com>
References: <1409323665-9605-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409323665-9605-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: vladimir.murzin-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, hans-7z9IcJk4adCsTnJN9+BGXg@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>

If split page table lock for PTE tables is enabled (CONFIG_SPLIT_PTLOCK_CPUS
<=NR_CPUS) pgtable_page_ctor() leads to non-atomic allocation for ptlock with
a spinlock held, resulting in:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 466 at kernel/locking/lockdep.c:2742 lockdep_trace_alloc+0xd8/0xf4()
DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
Modules linked in:
CPU: 0 PID: 466 Comm: dma0chan0-copy0 Not tainted 3.16.0-3d47efb-clean-pl330-dma_test-ve-a15-a32-slr-m
c-on-3+ #55
[<80014748>] (unwind_backtrace) from [<80011640>] (show_stack+0x10/0x14)
[<80011640>] (show_stack) from [<802bf864>] (dump_stack+0x80/0xb4)
[<802bf864>] (dump_stack) from [<8002385c>] (warn_slowpath_common+0x64/0x88)
[<8002385c>] (warn_slowpath_common) from [<80023914>] (warn_slowpath_fmt+0x30/0x40)
[<80023914>] (warn_slowpath_fmt) from [<8005d818>] (lockdep_trace_alloc+0xd8/0xf4)
[<8005d818>] (lockdep_trace_alloc) from [<800d3d78>] (kmem_cache_alloc+0x24/0x144)
[<800d3d78>] (kmem_cache_alloc) from [<800bfae4>] (ptlock_alloc+0x18/0x2c)
[<800bfae4>] (ptlock_alloc) from [<802b1ec0>] (arm_smmu_handle_mapping+0x4c0/0x690)
[<802b1ec0>] (arm_smmu_handle_mapping) from [<802b0cd8>] (iommu_map+0xe0/0x148)
[<802b0cd8>] (iommu_map) from [<80019098>] (arm_coherent_iommu_map_page+0x160/0x278)
[<80019098>] (arm_coherent_iommu_map_page) from [<801f4d78>] (dmatest_func+0x60c/0x1098)
[<801f4d78>] (dmatest_func) from [<8003f8ac>] (kthread+0xcc/0xe8)
[<8003f8ac>] (kthread) from [<8000e868>] (ret_from_fork+0x14/0x2c)
---[ end trace ce0d27e6f434acf8 ]--

Split page tables lock is not used in the driver. In fact, page tables are
guarded with domain lock, so remove calls to pgtable_page_{c,d}tor().

Signed-off-by: Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 98bb1b746517..a83cc2a2a2ca 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -997,7 +997,6 @@ static void arm_smmu_free_ptes(pmd_t *pmd)
 {
 	pgtable_t table = pmd_pgtable(*pmd);
 
-	pgtable_page_dtor(table);
 	__free_page(table);
 }
 
@@ -1263,10 +1262,6 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 			return -ENOMEM;
 
 		arm_smmu_flush_pgtable(smmu, page_address(table), PAGE_SIZE);
-		if (!pgtable_page_ctor(table)) {
-			__free_page(table);
-			return -ENOMEM;
-		}
 		pmd_populate(NULL, pmd, table);
 		arm_smmu_flush_pgtable(smmu, pmd, sizeof(*pmd));
 	}
-- 
2.1.0
