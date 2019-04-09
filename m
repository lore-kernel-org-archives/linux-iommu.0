From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 2/6] iommu: add build options corresponding to
	iommu.dma_mode
Date: Tue, 9 Apr 2019 20:53:04 +0800
Message-ID: <20190409125308.18304-3-thunder.leizhen@huawei.com>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190409125308.18304-1-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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

First, add build option IOMMU_DEFAULT_{LAZY|STRICT}, so that we have the
opportunity to set {lazy|strict} mode as default at build time. Then put
the three config options in an choice, make people can only choose one of
the three at a time, the same to the boot options iommu.dma_mode.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++--
 drivers/iommu/Kconfig                           | 43 +++++++++++++++++++++----
 drivers/iommu/iommu.c                           |  4 ++-
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f7766f8ac8b9084..92d1b3151d003c2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1811,9 +1811,9 @@
 			1 - Bypass the IOMMU for DMA.
 			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
 
-	iommu.dma_mode= Configure default dma mode. if unset, use the value
-			of CONFIG_IOMMU_DEFAULT_PASSTHROUGH to determine
-			passthrough or not.
+	iommu.dma_mode= Configure default dma mode. if unset, use the build
+			options(such as CONFIG_IOMMU_DEFAULT_PASSTHROUGH) to
+			choose which mode to be used.
 			Note: For historical reasons, ARM64/S390/PPC/X86 have
 			their specific options. Currently, only ARM64 support
 			this boot option, and hope other ARCHs to use this as
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6f07f3b21816c64..1986f9767da488b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -74,17 +74,46 @@ config IOMMU_DEBUGFS
 	  debug/iommu directory, and then populate a subdirectory with
 	  entries as required.
 
-config IOMMU_DEFAULT_PASSTHROUGH
-	bool "IOMMU passthrough by default"
+choice
+	prompt "IOMMU dma mode"
 	depends on IOMMU_API
-        help
-	  Enable passthrough by default, removing the need to pass in
-	  iommu.passthrough=on or iommu=pt through command line. If this
-	  is enabled, you can still disable with iommu.passthrough=off
-	  or iommu=nopt depending on the architecture.
+	default IOMMU_DEFAULT_STRICT
+	help
+	  This option allows IOMMU dma mode to be chose at build time, to
+	  override the default dma mode of each ARCHs, removing the need to
+	  pass in kernel parameters through command line. You can still use the
+	  generic boot option iommu.dma_mode or ARCHs specific boot options to
+	  override this option again.
+
+config IOMMU_DEFAULT_PASSTHROUGH
+	bool "passthrough"
+	help
+	  In this mode, the dma access through IOMMU without any addresses
+	  transformation. That means, the wrong or illegal dma access can not
+	  be caught, no error information will be reported.
 
 	  If unsure, say N here.
 
+config IOMMU_DEFAULT_LAZY
+	bool "lazy"
+	help
+	  Support lazy mode, where for every IOMMU DMA unmap operation, the
+	  flush operation of IOTLB and the free operation of IOVA are deferred.
+	  They are only guaranteed to be done before the related IOVA will be
+	  reused.
+
+config IOMMU_DEFAULT_STRICT
+	bool "strict"
+	help
+	  For every IOMMU DMA unmap operation, the flush operation of IOTLB and
+	  the free operation of IOVA are guaranteed to be done in the unmap
+	  function.
+
+	  This mode is safer than the two above, but it maybe slow in some high
+	  performace scenarios.
+
+endchoice
+
 config OF_IOMMU
        def_bool y
        depends on OF && IOMMU_API
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index df1ce8e22385b48..f4171bf4b46eaeb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -39,8 +39,10 @@
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
-#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
+#if defined(CONFIG_IOMMU_DEFAULT_PASSTHROUGH)
 #define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_PASSTHROUGH
+#elif defined(CONFIG_IOMMU_DEFAULT_LAZY)
+#define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_LAZY
 #else
 #define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_STRICT
 #endif
-- 
1.8.3
