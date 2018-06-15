From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 16/25] MIPS: move coherentio setup to setup.c
Date: Fri, 15 Jun 2018 13:08:45 +0200
Message-ID: <20180615110854.19253-17-hch@lst.de>
References: <20180615110854.19253-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180615110854.19253-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Tom Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiaxun Yang <jiaxun.yang-nEvAom26CKtBDgjK7y7TUQ@public.gmane.org>, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

We want to be able to use it even when not building dma-default.c
in the near future.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/mips/kernel/setup.c   | 24 ++++++++++++++++++++++++
 arch/mips/mm/dma-default.c | 23 -----------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 2c96c0c68116..3d4524309b5c 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -36,6 +36,7 @@
 #include <asm/cdmm.h>
 #include <asm/cpu.h>
 #include <asm/debug.h>
+#include <asm/dma-coherence.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp-ops.h>
@@ -1055,3 +1056,26 @@ static int __init debugfs_mips(void)
 }
 arch_initcall(debugfs_mips);
 #endif
+
+#if defined(CONFIG_DMA_MAYBE_COHERENT) && !defined(CONFIG_DMA_PERDEV_COHERENT)
+/* User defined DMA coherency from command line. */
+enum coherent_io_user_state coherentio = IO_COHERENCE_DEFAULT;
+EXPORT_SYMBOL_GPL(coherentio);
+int hw_coherentio = 0;	/* Actual hardware supported DMA coherency setting. */
+
+static int __init setcoherentio(char *str)
+{
+	coherentio = IO_COHERENCE_ENABLED;
+	pr_info("Hardware DMA cache coherency (command line)\n");
+	return 0;
+}
+early_param("coherentio", setcoherentio);
+
+static int __init setnocoherentio(char *str)
+{
+	coherentio = IO_COHERENCE_DISABLED;
+	pr_info("Software DMA cache coherency (command line)\n");
+	return 0;
+}
+early_param("nocoherentio", setnocoherentio);
+#endif
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 2db6c2a6f964..10b56e8a2076 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -24,29 +24,6 @@
 
 #include <dma-coherence.h>
 
-#if defined(CONFIG_DMA_MAYBE_COHERENT) && !defined(CONFIG_DMA_PERDEV_COHERENT)
-/* User defined DMA coherency from command line. */
-enum coherent_io_user_state coherentio = IO_COHERENCE_DEFAULT;
-EXPORT_SYMBOL_GPL(coherentio);
-int hw_coherentio = 0;	/* Actual hardware supported DMA coherency setting. */
-
-static int __init setcoherentio(char *str)
-{
-	coherentio = IO_COHERENCE_ENABLED;
-	pr_info("Hardware DMA cache coherency (command line)\n");
-	return 0;
-}
-early_param("coherentio", setcoherentio);
-
-static int __init setnocoherentio(char *str)
-{
-	coherentio = IO_COHERENCE_DISABLED;
-	pr_info("Software DMA cache coherency (command line)\n");
-	return 0;
-}
-early_param("nocoherentio", setnocoherentio);
-#endif
-
 static inline struct page *dma_addr_to_page(struct device *dev,
 	dma_addr_t dma_addr)
 {
-- 
2.17.1
