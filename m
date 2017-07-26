From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: amd-iommu/x2apic: sleeping function called from invalid
 context
Date: Wed, 26 Jul 2017 12:42:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1707261241220.2186@nanos>
References: <20170725135618.hev4vj7w24gm3a5q@shodan.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170725135618.hev4vj7w24gm3a5q-TUG+jSMfqtFQcClZ3XN9yxcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Artem Savkov <asavkov-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 25 Jul 2017, Artem Savkov wrote:

> Hi,
> 
> Commit 1c3c5ea "sched/core: Enable might_sleep() and smp_processor_id()
> checks early" seem to have uncovered an issue with amd-iommu/x2apic.
> 
> Starting with that commit the following warning started to show up on AMD
> systems during boot:
 
> [    0.160000] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:747 

> [    0.160000]  mutex_lock_nested+0x1b/0x20 
> [    0.160000]  register_syscore_ops+0x1d/0x70 
> [    0.160000]  state_next+0x119/0x910 
> [    0.160000]  iommu_go_to_state+0x29/0x30 
> [    0.160000]  amd_iommu_enable+0x13/0x23 
> [    0.160000]  irq_remapping_enable+0x1b/0x39 
> [    0.160000]  enable_IR_x2apic+0x91/0x196 
> [    0.160000]  default_setup_apic_routing+0x16/0x6e 
> [    0.160000]  native_smp_prepare_cpus+0x257/0x2d5 

Yep, that's clearly stupid. The completely untested patch below should cure
the issue.

Thanks,

	tglx

8<---------------	
	
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2440,7 +2440,6 @@ static int __init state_next(void)
 		break;
 	case IOMMU_ACPI_FINISHED:
 		early_enable_iommus();
-		register_syscore_ops(&amd_iommu_syscore_ops);
 		x86_platform.iommu_shutdown = disable_iommus;
 		init_state = IOMMU_ENABLED;
 		break;
@@ -2559,6 +2558,8 @@ static int __init amd_iommu_init(void)
 			for_each_iommu(iommu)
 				iommu_flush_all_caches(iommu);
 		}
+	} else {
+		register_syscore_ops(&amd_iommu_syscore_ops);
 	}
 
 	return ret;
