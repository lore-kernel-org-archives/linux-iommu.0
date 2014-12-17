From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch v1 01/17] x86, smpboot: Remove pointless preempt_disable() in
	native_smp_prepare_cpus()
Date: Wed, 17 Dec 2014 12:35:32 +0800
Message-ID: <1418790948-22804-2-git-send-email-jiang.liu@linux.intel.com>
References: <1418790948-22804-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418790948-22804-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>, Igor Mammedov <imammedo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

There is no reason to keep preemption disabled in this function.

We only have two other threads live: kthreadd and idle. Neither of
them is going to preempt. But that preempt_disable forces all the code
inside to do GFP_ATOMIC allocations which is just insane.

Remove it.

Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Tested-by: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Link: http://lkml.kernel.org/r/20141205084147.153643952-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 arch/x86/kernel/smpboot.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 7a8f5845e8eb..6d7022c683e3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1084,7 +1084,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 {
 	unsigned int i;
 
-	preempt_disable();
 	smp_cpu_index_default();
 
 	/*
@@ -1102,22 +1101,19 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	}
 	set_cpu_sibling_map(0);
 
-
 	if (smp_sanity_check(max_cpus) < 0) {
 		pr_info("SMP disabled\n");
 		disable_smp();
-		goto out;
+		return;
 	}
 
 	default_setup_apic_routing();
 
-	preempt_disable();
 	if (read_apic_id() != boot_cpu_physical_apicid) {
 		panic("Boot APIC ID in local APIC unexpected (%d vs %d)",
 		     read_apic_id(), boot_cpu_physical_apicid);
 		/* Or can we switch back to PIC here? */
 	}
-	preempt_enable();
 
 	connect_bsp_APIC();
 
@@ -1151,8 +1147,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 		uv_system_init();
 
 	set_mtrr_aps_delayed_init();
-out:
-	preempt_enable();
 }
 
 void arch_enable_nonboot_cpus_begin(void)
-- 
1.7.10.4
