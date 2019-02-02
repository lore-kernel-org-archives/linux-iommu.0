From: lantianyu1986@gmail.com
Subject: [PATCH V2 1/3] x86/Hyper-V: Set x2apic destination mode to physical when x2apic is available
Date: Sat,  2 Feb 2019 21:14:45 +0800
Message-ID: <1549113287-5606-2-git-send-email-Tianyu.Lan@microsoft.com>
References: <1549113287-5606-1-git-send-email-Tianyu.Lan@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549113287-5606-1-git-send-email-Tianyu.Lan@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, joro@8bytes.org, mchehab+samsung@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, akpm@linux-foundation.org, nicolas.ferre@microchip.com, arnd@arndb.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com, dan.carpenter@oracle.com
List-Id: iommu@lists.linux-foundation.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
set x2apic destination mode to physcial mode when x2apic is available
and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
8-bit APIC id.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       - Remove redundant extern for x2apic_phys
---
 arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e81a2db..4bd6d90 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -328,6 +328,16 @@ static void __init ms_hyperv_init_platform(void)
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
 # endif
+
+/*
+ * Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
+ * set x2apic destination mode to physcial mode when x2apic is available
+ * and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs
+ * have 8-bit APIC id.
+ */
+	if (IS_ENABLED(CONFIG_HYPERV_IOMMU) && x2apic_supported())
+		x2apic_phys = 1;
+
 #endif
 }
 
-- 
2.7.4
