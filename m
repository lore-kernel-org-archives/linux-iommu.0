From: lantianyu1986@gmail.com
Subject: [PATCH V4 1/3] x86/Hyper-V: Set x2apic destination mode to physical
 when x2apic is available
Date: Mon, 11 Feb 2019 22:20:22 +0800
Message-ID: <1549894824-26623-2-git-send-email-Tianyu.Lan@microsoft.com>
References: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, mchehab+samsung@kernel.org, sashal@kernel.org, sthemmin@microsoft.com, joro@8bytes.org, x86@kernel.org, michael.h.kelley@microsoft.com, mingo@redhat.com, dan.carpenter@oracle.com, Lan Tianyu <Tianyu.Lan@microsoft.com>, arnd@arndb.de, haiyangz@microsoft.com, alex.williamson@redhat.com, bp@alien8.de, tglx@linutronix.de, gregkh@linuxfoundation.org, nicolas.ferre@microchip.com, iommu@lists.linux-foundation.org, devel@linuxdriverproject.org, vkuznets@redhat.com, davem@davemloft.net
List-Id: iommu@lists.linux-foundation.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
set x2apic destination mode to physcial mode when x2apic is available
and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
8-bit APIC id.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v2:
       - Fix compile error due to x2apic_phys
       - Fix comment indent
Change since v1:
       - Remove redundant extern for x2apic_phys
---
 arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e81a2db..0c29e4e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -328,6 +328,16 @@ static void __init ms_hyperv_init_platform(void)
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
+	if (IS_ENABLED(CONFIG_X86_X2APIC) && x2apic_supported())
+		x2apic_phys = 1;
+
 #endif
 }
 
-- 
2.7.4
