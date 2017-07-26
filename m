From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu/amd: Fix schedule-while-atomic BUG in initialization
	code
Date: Wed, 26 Jul 2017 14:26:14 +0200
Message-ID: <20170726122614.GP15833@8bytes.org>
References: <20170725135618.hev4vj7w24gm3a5q@shodan.usersys.redhat.com>
	<alpine.DEB.2.20.1707261241220.2186@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1707261241220.2186@nanos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Artem Savkov <asavkov-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Artem, Thomas,

On Wed, Jul 26, 2017 at 12:42:49PM +0200, Thomas Gleixner wrote:
> On Tue, 25 Jul 2017, Artem Savkov wrote:
> 
> > Hi,
> > 
> > Commit 1c3c5ea "sched/core: Enable might_sleep() and smp_processor_id()
> > checks early" seem to have uncovered an issue with amd-iommu/x2apic.
> > 
> > Starting with that commit the following warning started to show up on AMD
> > systems during boot:
>  
> > [    0.160000] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:747 
> 
> > [    0.160000]  mutex_lock_nested+0x1b/0x20 
> > [    0.160000]  register_syscore_ops+0x1d/0x70 
> > [    0.160000]  state_next+0x119/0x910 
> > [    0.160000]  iommu_go_to_state+0x29/0x30 
> > [    0.160000]  amd_iommu_enable+0x13/0x23 
> > [    0.160000]  irq_remapping_enable+0x1b/0x39 
> > [    0.160000]  enable_IR_x2apic+0x91/0x196 
> > [    0.160000]  default_setup_apic_routing+0x16/0x6e 
> > [    0.160000]  native_smp_prepare_cpus+0x257/0x2d5

Thanks for the report!

> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2440,7 +2440,6 @@ static int __init state_next(void)
>  		break;
>  	case IOMMU_ACPI_FINISHED:
>  		early_enable_iommus();
> -		register_syscore_ops(&amd_iommu_syscore_ops);
>  		x86_platform.iommu_shutdown = disable_iommus;
>  		init_state = IOMMU_ENABLED;
>  		break;
> @@ -2559,6 +2558,8 @@ static int __init amd_iommu_init(void)
>  			for_each_iommu(iommu)
>  				iommu_flush_all_caches(iommu);
>  		}
> +	} else {
> +		register_syscore_ops(&amd_iommu_syscore_ops);
>  	}
>  
>  	return ret;

Yes, that should fix it, but I think its better to just move the
register_syscore_ops() call to a later initialization step, like in the
patch below. I tested it an will queue it to my iommu/fixes branch.

>From 461242d7211c7777901b6ccdf349cc89235bd5da Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Wed, 26 Jul 2017 14:17:55 +0200
Subject: [PATCH] iommu/amd: Fix schedule-while-atomic BUG in initialization
 code

The register_syscore_ops() function takes a mutex and might
sleep. In the IOMMU initialization code it is invoked during
irq-remapping setup already, where irqs are disabled.

This causes a schedule-while-atomic bug:

 BUG: sleeping function called from invalid context at kernel/locking/mutex.c:747
 in_atomic(): 0, irqs_disabled(): 1, pid: 1, name: swapper/0
 no locks held by swapper/0/1.
 irq event stamp: 304
 hardirqs last  enabled at (303): [<ffffffff818a87b6>] _raw_spin_unlock_irqrestore+0x36/0x60
 hardirqs last disabled at (304): [<ffffffff8235d440>] enable_IR_x2apic+0x79/0x196
 softirqs last  enabled at (36): [<ffffffff818ae75f>] __do_softirq+0x35f/0x4ec
 softirqs last disabled at (31): [<ffffffff810c1955>] irq_exit+0x105/0x120
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc2.1.el7a.test.x86_64.debug #1
 Hardware name:          PowerEdge C6145 /040N24, BIOS 3.5.0 10/28/2014
 Call Trace:
  dump_stack+0x85/0xca
  ___might_sleep+0x22a/0x260
  __might_sleep+0x4a/0x80
  __mutex_lock+0x58/0x960
  ? iommu_completion_wait.part.17+0xb5/0x160
  ? register_syscore_ops+0x1d/0x70
  ? iommu_flush_all_caches+0x120/0x150
  mutex_lock_nested+0x1b/0x20
  register_syscore_ops+0x1d/0x70
  state_next+0x119/0x910
  iommu_go_to_state+0x29/0x30
  amd_iommu_enable+0x13/0x23

Fix it by moving the register_syscore_ops() call to the next
initialization step, which runs with irqs enabled.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 5cc597b383c7..372303700566 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2440,11 +2440,11 @@ static int __init state_next(void)
 		break;
 	case IOMMU_ACPI_FINISHED:
 		early_enable_iommus();
-		register_syscore_ops(&amd_iommu_syscore_ops);
 		x86_platform.iommu_shutdown = disable_iommus;
 		init_state = IOMMU_ENABLED;
 		break;
 	case IOMMU_ENABLED:
+		register_syscore_ops(&amd_iommu_syscore_ops);
 		ret = amd_iommu_init_pci();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
 		enable_iommus_v2();
-- 
2.13.1
