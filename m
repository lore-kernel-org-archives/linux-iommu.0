From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] x86: don't include asm/x86_init.h in asm/setup.h
Date: Thu, 19 Oct 2017 12:53:02 +0200
Message-ID: <20171019105451.2892046-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

This is a preparation to allow using 'struct timespec64' in the
asm/x86_init.h.  Unfortunately, we can't use a forward declaration
for timespec64 since it is defined as a macro on 64-bit architectures,
and including linux/time64.h breaks compilation of arch/x86/boot/,
which runs in realmode and can't use many of the regular kernel
headers.

As a workaround, I stop including asm/x86_init.h. This works fine
for the realmode boot code since it does not require any of the
x86_init.h contents, and setup.h doesn't either. However, a couple
of other files that do need x86_init.h used to rely on it being
included indirectly, so I have to put an explicit include in there
now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/setup.h            | 1 -
 arch/x86/kernel/platform-quirks.c       | 1 +
 arch/x86/platform/ce4100/ce4100.c       | 1 +
 arch/x86/platform/intel-mid/intel-mid.c | 1 +
 arch/x86/platform/olpc/olpc.c           | 1 +
 drivers/iommu/dmar.c                    | 1 +
 6 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index a65cf544686a..deed84119a22 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -27,7 +27,6 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/bootparam.h>
-#include <asm/x86_init.h>
 
 extern u64 relocated_ramdisk;
 
diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
index 502a77d0adb0..d900c7b176f0 100644
--- a/arch/x86/kernel/platform-quirks.c
+++ b/arch/x86/kernel/platform-quirks.c
@@ -3,6 +3,7 @@
 
 #include <asm/setup.h>
 #include <asm/bios_ebda.h>
+#include <asm/x86_init.h>
 
 void __init x86_early_init_platform_quirks(void)
 {
diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index ce4b06733c09..885196300927 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -22,6 +22,7 @@
 #include <asm/io.h>
 #include <asm/io_apic.h>
 #include <asm/emergency-restart.h>
+#include <asm/x86_init.h>
 
 /*
  * The CE4100 platform has an internal 8051 Microcontroller which is
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 86676cec99a1..c6322263610a 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -35,6 +35,7 @@
 #include <asm/intel_scu_ipc.h>
 #include <asm/apb_timer.h>
 #include <asm/reboot.h>
+#include <asm/x86_init.h>
 
 #include "intel_mid_weak_decls.h"
 
diff --git a/arch/x86/platform/olpc/olpc.c b/arch/x86/platform/olpc/olpc.c
index 7c3077e58fa0..11a54f386911 100644
--- a/arch/x86/platform/olpc/olpc.c
+++ b/arch/x86/platform/olpc/olpc.c
@@ -26,6 +26,7 @@
 #include <asm/setup.h>
 #include <asm/olpc.h>
 #include <asm/olpc_ofw.h>
+#include <asm/x86_init.h>
 
 struct olpc_platform_t olpc_platform_info;
 EXPORT_SYMBOL_GPL(olpc_platform_info);
diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 1ea7cd537873..e9304d6247e1 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -41,6 +41,7 @@
 #include <linux/iommu.h>
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
+#include <asm/x86_init.h>
 
 #include "irq_remapping.h"
 
-- 
2.9.0
