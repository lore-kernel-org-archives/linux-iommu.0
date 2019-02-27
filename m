From: lantianyu1986@gmail.com
Subject: [PATCH V6 1/3] x86/Hyper-V: Set x2apic destination mode to physical when x2apic is available
Date: Wed, 27 Feb 2019 22:54:03 +0800
Message-ID: <1551279245-25888-2-git-send-email-Tianyu.Lan@microsoft.com>
References: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551279245-25888-1-git-send-email-Tianyu.Lan@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, joro@8bytes.org, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, nicolas.ferre@microchip.com, arnd@arndb.de, michael.h.kelley@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com, dan.carpenter@oracle.com
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
set x2apic destination mode to physcial mode when x2apic is available
and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
8-bit APIC id.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v5:
       - Fix comile error due to x2apic_phys

Change since v2:
       - Fix compile error due to x2apic_phys
       - Fix comment indent
Change since v1:
       - Remove redundant extern for x2apic_phys
---
 arch/x86/kernel/cpu/mshyperv.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e81a2db..3fa238a 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -328,6 +328,18 @@ static void __init ms_hyperv_init_platform(void)
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
 # endif
+
+	/*
+	 * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
+	 * set x2apic destination mode to physcial mode when x2apic is available
+	 * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
+	 * have 8-bit APIC id.
+	 */
+# ifdef CONFIG_X86_X2APIC
+	if (x2apic_supported())
+		x2apic_phys = 1;
+# endif
+
 #endif
 }
 
-- 
2.7.4
