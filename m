From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 11/19] x86,
	irq: Move irq_remapping_enabled declaration to iommu code
Date: Tue, 20 Nov 2012 14:12:48 +0100
Message-ID: <1353417176-18945-12-git-send-email-joro@8bytes.org>
References: <1353417176-18945-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1353417176-18945-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Remove the last left-over from this flag from x86 code.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Acked-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
---
 arch/x86/include/asm/irq_remapping.h |    4 ----
 drivers/iommu/dmar.c                 |    2 ++
 drivers/iommu/intel-iommu.c          |    2 ++
 drivers/iommu/irq_remapping.h        |    1 +
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index fb99a73..6f4b48b 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -26,8 +26,6 @@
 
 #ifdef CONFIG_IRQ_REMAP
 
-extern int irq_remapping_enabled;
-
 extern void setup_irq_remapping_ops(void);
 extern int irq_remapping_supported(void);
 extern int irq_remapping_prepare(void);
@@ -49,8 +47,6 @@ extern void panic_if_irq_remap(const char *msg);
 
 #else  /* CONFIG_IRQ_REMAP */
 
-#define irq_remapping_enabled	0
-
 static inline void setup_irq_remapping_ops(void) { }
 static inline int irq_remapping_supported(void) { return 0; }
 static inline int irq_remapping_prepare(void) { return -ENODEV; }
diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 86e2f4a..174bb65 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -41,6 +41,8 @@
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
 
+#include "irq_remapping.h"
+
 /* No locks are needed as DMA remapping hardware unit
  * list is constructed at boot time and hotplug of
  * these units are not supported by the architecture.
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d4a4cd4..51ddb33 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -46,6 +46,8 @@
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
 
+#include "irq_remapping.h"
+
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
 
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 95363ac..ecb6376 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -34,6 +34,7 @@ struct msi_msg;
 extern int disable_irq_remap;
 extern int disable_sourceid_checking;
 extern int no_x2apic_optout;
+extern int irq_remapping_enabled;
 
 struct irq_remap_ops {
 	/* Check whether Interrupt Remapping is supported */
-- 
1.7.9.5
