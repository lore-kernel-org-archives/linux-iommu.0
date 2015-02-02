From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC Patch V1] iommu/vt-d: Fix build failure caused by incorrect
	Kconfig
Date: Mon,  2 Feb 2015 11:07:44 +0800
Message-ID: <1422846464-14558-1-git-send-email-jiang.liu@linux.intel.com>
References: <1422713299.3030.23.camel@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422713299.3030.23.camel-RlY5vtjFyJ3QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yann Droneaud <ydroneaud-RlY5vtjFyJ3QT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Yann Droneaud <ydroneaud-RlY5vtjFyJ3QT0dZR+AlfA@public.gmane.org> reported one build failure as
below, which should be caused by incorrect Kconfig.
  CC      arch/ia64/kernel/pci-dma.o
../arch/ia64/kernel/pci-dma.c: In function 'pci_iommu_init':
../arch/ia64/kernel/pci-dma.c:41:3: error: implicit declaration of function 'intel_iommu_init' [-Werror=implicit-function-declaration]
   intel_iommu_init();
   ^
../arch/ia64/kernel/pci-dma.c: In function 'pci_iommu_alloc':
../arch/ia64/kernel/pci-dma.c:103:2: error: implicit declaration of function 'detect_intel_iommu' [-Werror=implicit-function-declaration]
  detect_intel_iommu();
  ^

It should be noted Kconfig complain with the following:

warning: (IA64) selects PM which has unmet direct dependencies (PM_SLEEP || PM_RUNTIME)
warning: (IA64_DIG_VTD) selects INTEL_IOMMU which has unmet direct dependencies (IOMMU_SUPPORT && PCI_MSI && ACPI && (X86 || IA64_GENERIC))
warning: (IA64) selects PM which has unmet direct dependencies (PM_SLEEP || PM_RUNTIME)
warning: (IA64_DIG_VTD) selects INTEL_IOMMU which has unmet direct dependencies (IOMMU_SUPPORT && PCI_MSI && ACPI && (X86 || IA64_GENERIC))

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
Hi Yann,
	Could you please help to test whether this patch fix the build
failure and the Kconfig warnings?
Thanks!
Gerry
---
 drivers/iommu/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 325188eef1c1..718a0c9f7bdc 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -89,7 +89,7 @@ config DMAR_TABLE
 
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
-	depends on PCI_MSI && ACPI && (X86 || IA64_GENERIC)
+	depends on PCI_MSI && ACPI && (X86 || IA64_DIG_VTD)
 	select IOMMU_API
 	select DMAR_TABLE
 	help
-- 
1.7.10.4
