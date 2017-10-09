From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] iommu/exynos: Remove initconst attribute to avoid potential
 kernel oops
Date: Mon, 09 Oct 2017 13:40:23 +0200
Message-ID: <20171009114023.3427-1-m.szyprowski@samsung.com>
References: <CGME20171009114035eucas1p102089b889ad374b33c3302f1ad84e783@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Exynos SYSMMU registers standard platform device with sysmmu_of_match
table, what means that this table is accessed every time a new platform
device is registered in a system. This might happen also after the boot,
so the table must not be attributed as initconst to avoid potential kernel
oops caused by access to freed memory.

Fixes: 6b21a5db3642 ("iommu/exynos: Support for device tree")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Hi!

This issue was there from the beggining of the device tree
support, I'm really surprised that it has not been noticed it till
now. This patch fixes the following hard-to-debug kernel issue:

Unable to handle kernel paging request at virtual address ffffff80090fb018
Mem abort info:
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000007
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 39-bit VAs, pgd = ffffff80097f9000
[ffffff80090fb018] *pgd=00000008ffffe003, *pud=00000008ffffe003, *pmd=00000008ffffb003, *pte=0000000000000000
Internal error: Oops: 96000007 [#1] PREEMPT SMP
Modules linked in:
CPU: 7 PID: 102 Comm: kworker/7:1 Tainted: G S              4.14.0-rc1+ #4572
Hardware name: Samsung DREAMLTE EUR rev10 board based on EXYNOS8895 (DT)
Workqueue: events deferred_probe_work_func
task: ffffffc87a7f1b00 task.stack: ffffff8009b88000
PC is at __of_match_node+0x24/0x7c
LR is at of_match_node+0x38/0x5c
pc : [<ffffff800871ac6c>] lr : [<ffffff800871acfc>] pstate: a00001c5
sp : ffffff8009b8bba0
x29: ffffff8009b8bba0 x28: ffffffc87ff8fc00
x27: ffffff80095c7000 x26: ffffff80096e76e0
x25: ffffff8008f1e7a0 x24: ffffff800965d000
x23: ffffff800977d008 x22: 0000000000000000
x21: ffffffc87ffcd598 x20: 0000000000000000
x19: ffffff80090fb018 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000
x15: 0000000000000008 x14: 0000000000000000
x13: 0000000000000040 x12: 0000000000000038
x11: 0000000000000001 x10: 0101010101010101
x9 : 06fefeff01fefeff x8 : 7f7f7f7f7f7f7f7f
x7 : 2f2f2f2f382f3030 x6 : 4354571454455d5d
x5 : 5d5d455414575443 x4 : ffffff8009b8c000
x3 : ffffff8009b88000 x2 : 0000000000000000
x1 : ffffffc87ffcd598 x0 : ffffff80090fb018
Process kworker/7:1 (pid: 102, stack limit = 0xffffff8009b88000)
Call trace:
Exception stack(0xffffff8009b8ba60 to 0xffffff8009b8bba0)
ba60: ffffff80090fb018 ffffffc87ffcd598 0000000000000000 ffffff8009b88000
ba80: ffffff8009b8c000 5d5d455414575443 4354571454455d5d 2f2f2f2f382f3030
baa0: 7f7f7f7f7f7f7f7f 06fefeff01fefeff 0101010101010101 0000000000000001
bac0: 0000000000000038 0000000000000040 0000000000000000 0000000000000008
bae0: 0000000000000000 0000000000000000 0000000000000000 ffffff80090fb018
bb00: 0000000000000000 ffffffc87ffcd598 0000000000000000 ffffff800977d008
bb20: ffffff800965d000 ffffff8008f1e7a0 ffffff80096e76e0 ffffff80095c7000
bb40: ffffffc87ff8fc00 ffffff8009b8bba0 ffffff800871acfc ffffff8009b8bba0
bb60: ffffff800871ac6c 00000000a00001c5 ffffffc800000000 ffffff800871acec
bb80: ffffffffffffffff ffffff800871acec ffffff8009b8bba0 ffffff800871ac6c
[<ffffff800871ac6c>] __of_match_node+0x24/0x7c
[<ffffff800871acfc>] of_match_node+0x38/0x5c
[<ffffff800871c5d0>] of_match_device+0x18/0x28
[<ffffff80085031c0>] platform_match+0x4c/0xc8
[<ffffff8008500c68>] __device_attach_driver+0x3c/0x138
[<ffffff80084fe7a0>] bus_for_each_drv+0x54/0x94
[<ffffff8008500510>] __device_attach+0xc4/0x154
[<ffffff8008500d74>] device_initial_probe+0x10/0x18
[<ffffff80084ff844>] bus_probe_device+0x90/0x98
[<ffffff80084ffdf8>] deferred_probe_work_func+0x64/0x18c
[<ffffff80080b5f24>] process_one_work+0x150/0x3dc
[<ffffff80080b6208>] worker_thread+0x58/0x3b8
[<ffffff80080bbbc4>] kthread+0x104/0x130
[<ffffff8008085340>] ret_from_fork+0x10/0x20
Code: aa0103f5 b40002a0 52800014 d2800016 (39400264)
---[ end trace 4a748776163027e1 ]---

I'm not sure however if it makes sense to add the above kernel log to the
commit message as it doesn't directly point to the code fixed by this patch.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland
---
 drivers/iommu/exynos-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d90cc9f2dd9c..1a7e8c2c89ea 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -740,7 +740,7 @@ static const struct dev_pm_ops sysmmu_pm_ops = {
 				pm_runtime_force_resume)
 };
 
-static const struct of_device_id sysmmu_of_match[] __initconst = {
+static const struct of_device_id sysmmu_of_match[] = {
 	{ .compatible	= "samsung,exynos-sysmmu", },
 	{ },
 };
-- 
2.14.2
