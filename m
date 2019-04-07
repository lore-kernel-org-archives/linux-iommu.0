From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 2/6] iommu: keep dma mode build options consistent with
	cmdline options
Date: Sun, 7 Apr 2019 20:41:43 +0800
Message-ID: <20190407124147.13576-3-thunder.leizhen__12405.1766631723$1554641319$gmane$org@huawei.com>
References: <20190407124147.13576-1-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190407124147.13576-1-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Ott <sebott-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael
	Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, "H . Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel@>
Cc: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

First, add build option IOMMU_DMA_MODE_LAZY, so that we have the
opportunity to set lazy mode as default at build time. Then put the
three config options in an choice, make people can only choose one of the
three at a time, the same to the boot options iommu.dma_mode.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/Kconfig | 30 +++++++++++++++++++++++++++---
 drivers/iommu/iommu.c |  4 +++-
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index b67fcabd668f7b6..19118cfdea1c335 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -74,16 +74,40 @@ config IOMMU_DEBUGFS
 	  debug/iommu directory, and then populate a subdirectory with
 	  entries as required.
 
-config IOMMU_DEFAULT_PASSTHROUGH
-	bool "IOMMU passthrough by default"
+choice
+	prompt "IOMMU dma mode"
 	depends on IOMMU_API
+	default IOMMU_DMA_MODE_STRICT
+	help
+	  IOMMU dma mode, such as: passthrough, lazy, strict.
+
+config IOMMU_DMA_MODE_PASSTHROUGH
+	bool "Configure DMA to bypass the IOMMU"
         help
 	  Enable passthrough by default, removing the need to pass in
 	  iommu.dma_mode=passthrough or iommu=pt through command line. If this
 	  is enabled, you can still disable with iommu.dma_mode={lazy|strict}
 	  or iommu=nopt depending on the architecture.
 
-	  If unsure, say N here.
+config IOMMU_DMA_MODE_LAZY
+	bool "IOMMU DMA use lazy mode to flush IOTLB and free IOVA"
+	help
+	  Support lazy mode, where for every IOMMU DMA unmap operation, the
+	  flush operation of IOTLB and the free operation of IOVA are deferred.
+	  They are only guaranteed to be done before the related IOVA will be
+	  reused. Removing the need to pass in kernel parameters through
+	  command line. For example, iommu.dma_mode=lazy on ARM64. If this is
+	  enabled, you can still disable with kernel parameters, such as
+	  iommu.dma_mode=strict depending on the architecture.
+
+config IOMMU_DMA_MODE_STRICT
+	bool "IOMMU DMA use strict mode to flush IOTLB and free IOVA"
+	help
+	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
+	  the free operation of IOVA are guaranteed to be done in the unmap
+	  function.
+
+endchoice
 
 config OF_IOMMU
        def_bool y
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e4d581e6cb8d210..b75e23a2ea08da8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -39,8 +39,10 @@
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
-#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
+#if defined(CONFIG_IOMMU_DMA_MODE_PASSTHROUGH)
 #define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_PASSTHROUGH
+#elif defined(CONFIG_IOMMU_DMA_MODE_LAZY)
+#define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_LAZY
 #else
 #define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_STRICT
 #endif
-- 
1.8.3
