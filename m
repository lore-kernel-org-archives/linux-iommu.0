From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Fix out-of-bounds dereference
Date: Mon, 7 Nov 2016 15:47:20 +0000
Message-ID: <20161107154719.GK19796@leverpostej>
References: <dea89ff1b2bd97b08d72f5c32fcf228bec767142.1478533142.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <dea89ff1b2bd97b08d72f5c32fcf228bec767142.1478533142.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 07, 2016 at 03:39:02PM +0000, Robin Murphy wrote:
> When we iterate a master's config entries, what we generally care
> about is the entry's stream map index, rather than the entry index
> itself, so it's nice to have the iterator automatically assign the
> former from the latter. Unfortunately, booting with KASAN reveals
> the oversight that using a simple comma operator results in the
> entry index being dereferenced before being checked for validity,
> so we always access one element past the end of the fwspec array.
> 
> Flip things around so that the check always happens before the index
> may be dereferenced.
> 
> Fixes: adfec2e709d2 ("iommu/arm-smmu: Convert to iommu_fwspec")
> Reported-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

This patch fixes the KASAN splats as I saw (example below).

With this patch applied, my dmesg is free of errors.

So feel free to add:

Tested-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

Thanks,
Mark.

==================================================================
BUG: KASAN: slab-out-of-bounds in arm_smmu_add_device+0x510/0x960 at addr ffff800935c6e72c
Read of size 2 by task swapper/0/1
CPU: 4 PID: 1 Comm: swapper/0 Not tainted 4.9.0-rc3-00005-g8cc374c #79
Hardware name: ARM Juno development board (r1) (DT)
Call trace:
[<ffff20000808b2d8>] dump_backtrace+0x0/0x278
[<ffff20000808b564>] show_stack+0x14/0x20
[<ffff2000084e4e4c>] dump_stack+0xa4/0xc8
[<ffff200008256984>] kasan_object_err+0x24/0x80
[<ffff200008256c40>] kasan_report_error+0x208/0x4d0
[<ffff200008257330>] kasan_report+0x40/0x48
[<ffff200008255624>] __asan_load2+0x84/0x98
[<ffff200008743e80>] arm_smmu_add_device+0x510/0x960
[<ffff20000873acf8>] iommu_bus_notifier+0x120/0x160
[<ffff2000081038e4>] notifier_call_chain+0x6c/0xb8
[<ffff200008103dfc>] __blocking_notifier_call_chain+0x5c/0xa0
[<ffff200008103e54>] blocking_notifier_call_chain+0x14/0x20
[<ffff20000874ef98>] device_add+0x5c8/0x840
[<ffff20000863d574>] amba_device_try_add+0x1cc/0x298
[<ffff20000863d7a8>] amba_device_add+0x20/0x148
[<ffff200008ad4344>] of_platform_bus_create+0x34c/0x428
[<ffff200008ad4554>] of_platform_populate+0x4c/0xb8
[<ffff200009389c9c>] of_platform_default_populate_init+0x78/0x8c
[<ffff200008083a28>] do_one_initcall+0x90/0x1c8
[<ffff200009331038>] kernel_init_freeable+0x280/0x324
[<ffff200008cb5d00>] kernel_init+0x10/0x110
[<ffff200008083680>] ret_from_fork+0x10/0x50
Object at ffff800935c6e700, in cache kmalloc-128 size: 128
Allocated:
PID = 1
 [<ffff20000808ac90>] save_stack_trace_tsk+0x0/0x180
 [<ffff20000808ae38>] save_stack_trace+0x28/0x38
 [<ffff200008255ebc>] kasan_kmalloc+0xdc/0x188
 [<ffff200008252780>] __kmalloc+0x148/0x238
 [<ffff200008743b38>] arm_smmu_add_device+0x1c8/0x960
 [<ffff20000873acf8>] iommu_bus_notifier+0x120/0x160
 [<ffff2000081038e4>] notifier_call_chain+0x6c/0xb8
 [<ffff200008103dfc>] __blocking_notifier_call_chain+0x5c/0xa0
 [<ffff200008103e54>] blocking_notifier_call_chain+0x14/0x20
 [<ffff20000874ef98>] device_add+0x5c8/0x840
 [<ffff20000863d574>] amba_device_try_add+0x1cc/0x298
 [<ffff20000863d7a8>] amba_device_add+0x20/0x148
 [<ffff200008ad4344>] of_platform_bus_create+0x34c/0x428
 [<ffff200008ad4554>] of_platform_populate+0x4c/0xb8
 [<ffff200009389c9c>] of_platform_default_populate_init+0x78/0x8c
 [<ffff200008083a28>] do_one_initcall+0x90/0x1c8
 [<ffff200009331038>] kernel_init_freeable+0x280/0x324
 [<ffff200008cb5d00>] kernel_init+0x10/0x110
 [<ffff200008083680>] ret_from_fork+0x10/0x50
Freed:
PID = 0
(stack is not available)
Memory state around the buggy address:
 ffff800935c6e600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff800935c6e680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff800935c6e700: 00 00 00 00 00 04 fc fc fc fc fc fc fc fc fc fc
                                  ^
 ffff800935c6e780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff800935c6e800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
