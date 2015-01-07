From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch v2 04/16] x86/apic: Panic if kernel doesn't support x2apic but
	BIOS has enabled x2apic
Date: Wed,  7 Jan 2015 15:31:31 +0800
Message-ID: <1420615903-28253-5-git-send-email-jiang.liu@linux.intel.com>
References: <1420615903-28253-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1420615903-28253-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, HATAYAMA Daisuke <d.hatayama-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, Jan Beulich <JBeulich-IBi9RG/b67k@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Oren Twaig <oren-Yzr3oMT/Kq5BDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "H. Peter Anvin" <hpa-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When kernel doesn't support X2APIC but BIOS has enabled X2APIC, system
may panic or hang without useful messages. On the other hand, it's
hard to dynamically disable X2APIC when CONFIG_X86_X2APIC is disabled.
So panic with a clear message in such a case.

System panics as below when X2APIC is disabled and interrupt remapping
is enabled:
[    0.316118] LAPIC pending interrupts after 512 EOI
[    0.322126] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.368655] Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC
[    0.378300] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.18.0+ #340
[    0.385300] Hardware name: Intel Corporation BRICKLAND/BRICKLAND, BIOS BRIVTIN1.86B.0051.L05.1406240953 06/24/2014
[    0.396997]  ffff88046dc03000 ffff88046c307dd8 ffffffff8179dada 00000000000043f2
[    0.405629]  ffffffff81a92158 ffff88046c307e58 ffffffff8179b757 0000000000000002
[    0.414261]  0000000000000008 ffff88046c307e68 ffff88046c307e08 ffffffff813ad82b
[    0.422890] Call Trace:
[    0.425711]  [<ffffffff8179dada>] dump_stack+0x45/0x57
[    0.431533]  [<ffffffff8179b757>] panic+0xc1/0x1f5
[    0.436978]  [<ffffffff813ad82b>] ? delay_tsc+0x3b/0x70
[    0.442910]  [<ffffffff8166fa2c>] panic_if_irq_remap+0x1c/0x20
[    0.449524]  [<ffffffff81d73645>] setup_IO_APIC+0x405/0x82e
[    0.464979]  [<ffffffff81d6fcc2>] native_smp_prepare_cpus+0x2d9/0x31c
[    0.472274]  [<ffffffff81d5d0ac>] kernel_init_freeable+0xd6/0x223
[    0.479170]  [<ffffffff81792ad0>] ? rest_init+0x80/0x80
[    0.485099]  [<ffffffff81792ade>] kernel_init+0xe/0xf0
[    0.490932]  [<ffffffff817a537c>] ret_from_fork+0x7c/0xb0
[    0.497054]  [<ffffffff81792ad0>] ? rest_init+0x80/0x80
[    0.502983] ---[ end Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC

System hangs as below when X2APIC and interrupt remapping are both disabled:
[    1.102782] pci 0000:00:02.0: System wakeup disabled by ACPI
[    1.109351] pci 0000:00:03.0: System wakeup disabled by ACPI
[    1.115915] pci 0000:00:03.2: System wakeup disabled by ACPI
[    1.122479] pci 0000:00:03.3: System wakeup disabled by ACPI
[    1.132274] pci 0000:00:1c.0: Enabling MPC IRBNCE
[    1.137620] pci 0000:00:1c.0: Intel PCH root port ACS workaround enabled
[    1.145239] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    1.151790] pci 0000:00:1c.7: Enabling MPC IRBNCE
[    1.157128] pci 0000:00:1c.7: Intel PCH root port ACS workaround enabled
[    1.164748] pci 0000:00:1c.7: System wakeup disabled by ACPI
[    1.171447] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    1.178612] acpiphp: Slot [8] registered
[    1.183095] pci 0000:00:02.0: PCI bridge to [bus 01]
[    1.188867] acpiphp: Slot [2] registered

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 arch/x86/kernel/apic/apic.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 36249c715da0..8b58e23bc5e8 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1597,6 +1597,14 @@ void __init enable_IR_x2apic(void)
 	int ret, x2apic_enabled = 0;
 	int hardware_init_ret;
 
+	if (!IS_ENABLED(CONFIG_X86_X2APIC)) {
+		u64 msr;
+
+		rdmsrl(MSR_IA32_APICBASE, msr);
+		if (msr & X2APIC_ENABLE)
+			panic("BIOS has enabled x2apic but kernel doesn't support x2apic, please disable x2apic in BIOS.\n");
+	}
+
 	hardware_init_ret = irq_remapping_prepare();
 	if (hardware_init_ret && !x2apic_supported())
 		return;
-- 
1.7.10.4
