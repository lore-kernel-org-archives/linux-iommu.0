From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 1/6] iommu: use iommu.dma_mode to replace iommu.passthrough
	and iommu.strict
Date: Sun, 7 Apr 2019 20:41:42 +0800
Message-ID: <20190407124147.13576-2-thunder.leizhen@huawei.com>
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

Currently the IOMMU dma contains 3 modes: passthrough, lazy, strict. The
passthrough mode bypass the IOMMU, the lazy mode defer the invalidation
of hardware TLBs, and the strict mode invalidate IOMMU hardware TLBs
synchronously. The three modes are mutually exclusive. So people maybe
confused about iommu.passthrough and iommu.strict, because thay can not
be coexist. Use iommu.dma_mode to replace them will be better.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 33 ++++++++---------
 drivers/iommu/Kconfig                           |  4 +--
 drivers/iommu/iommu.c                           | 48 ++++++++++++++-----------
 include/linux/iommu.h                           |  5 +++
 4 files changed, 50 insertions(+), 40 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb64470d..60409ad23b2ac8b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1792,24 +1792,21 @@
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
-	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
-			Format: { "0" | "1" }
-			0 - Lazy mode.
-			  Request that DMA unmap operations use deferred
-			  invalidation of hardware TLBs, for increased
-			  throughput at the cost of reduced device isolation.
-			  Will fall back to strict mode if not supported by
-			  the relevant IOMMU driver.
-			1 - Strict mode (default).
-			  DMA unmap operations invalidate IOMMU hardware TLBs
-			  synchronously.
-
-	iommu.passthrough=
-			[ARM64] Configure DMA to bypass the IOMMU by default.
-			Format: { "0" | "1" }
-			0 - Use IOMMU translation for DMA.
-			1 - Bypass the IOMMU for DMA.
-			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
+
+	iommu.dma_mode= [ARM64] Configure default dma mode. if unset, use the
+			value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
+		passthrough
+			Configure DMA to bypass the IOMMU by default.
+		lazy
+			Request that DMA unmap operations use deferred
+			invalidation of hardware TLBs, for increased
+			throughput at the cost of reduced device isolation.
+			Will fall back to strict mode if not supported by
+			the relevant IOMMU driver.
+		strict
+			Default. DMA unmap operations invalidate IOMMU hardware
+			TLBs synchronously.
+
 
 	io7=		[HW] IO7 for Marvel based alpha systems
 			See comment before marvel_specify_io7 in
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6f07f3b21816c64..b67fcabd668f7b6 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -79,8 +79,8 @@ config IOMMU_DEFAULT_PASSTHROUGH
 	depends on IOMMU_API
         help
 	  Enable passthrough by default, removing the need to pass in
-	  iommu.passthrough=on or iommu=pt through command line. If this
-	  is enabled, you can still disable with iommu.passthrough=off
+	  iommu.dma_mode=passthrough or iommu=pt through command line. If this
+	  is enabled, you can still disable with iommu.dma_mode={lazy|strict}
 	  or iommu=nopt depending on the architecture.
 
 	  If unsure, say N here.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 109de67d5d727c2..e4d581e6cb8d210 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -38,12 +38,13 @@
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
+
 #ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
-static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
+#define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_PASSTHROUGH
 #else
-static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
+#define IOMMU_DEFAULT_DMA_MODE		IOMMU_DMA_MODE_STRICT
 #endif
-static bool iommu_dma_strict __read_mostly = true;
+static int iommu_default_dma_mode __read_mostly = IOMMU_DEFAULT_DMA_MODE;
 
 struct iommu_callback_data {
 	const struct iommu_ops *ops;
@@ -141,25 +142,29 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 static void __iommu_detach_group(struct iommu_domain *domain,
 				 struct iommu_group *group);
 
-static int __init iommu_set_def_domain_type(char *str)
+static int __init iommu_dma_mode_setup(char *str)
 {
-	bool pt;
-	int ret;
+	if (!str)
+		goto fail;
 
-	ret = kstrtobool(str, &pt);
-	if (ret)
-		return ret;
+	if (!strncmp(str, "passthrough", 11))
+		iommu_default_dma_mode = IOMMU_DMA_MODE_PASSTHROUGH;
+	else if (!strncmp(str, "lazy", 4))
+		iommu_default_dma_mode = IOMMU_DMA_MODE_LAZY;
+	else if (!strncmp(str, "strict", 6))
+		iommu_default_dma_mode = IOMMU_DMA_MODE_STRICT;
+	else
+		goto fail;
+
+	pr_info("Force dma mode to be %d\n", iommu_default_dma_mode);
 
-	iommu_def_domain_type = pt ? IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_DMA;
 	return 0;
-}
-early_param("iommu.passthrough", iommu_set_def_domain_type);
 
-static int __init iommu_dma_setup(char *str)
-{
-	return kstrtobool(str, &iommu_dma_strict);
+fail:
+	pr_debug("Boot option iommu.dma_mode is incorrect, ignored\n");
+	return -EINVAL;
 }
-early_param("iommu.strict", iommu_dma_setup);
+early_param("iommu.dma_mode", iommu_dma_mode_setup);
 
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
@@ -1102,14 +1107,17 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	 */
 	if (!group->default_domain) {
 		struct iommu_domain *dom;
+		int def_domain_type =
+			(iommu_default_dma_mode == IOMMU_DMA_MODE_PASSTHROUGH)
+			? IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_DMA;
 
-		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
-		if (!dom && iommu_def_domain_type != IOMMU_DOMAIN_DMA) {
+		dom = __iommu_domain_alloc(dev->bus, def_domain_type);
+		if (!dom && def_domain_type != IOMMU_DOMAIN_DMA) {
 			dom = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_DMA);
 			if (dom) {
 				dev_warn(dev,
 					 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
-					 iommu_def_domain_type);
+					 def_domain_type);
 			}
 		}
 
@@ -1117,7 +1125,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 		if (!group->domain)
 			group->domain = dom;
 
-		if (dom && !iommu_dma_strict) {
+		if (dom && (iommu_default_dma_mode == IOMMU_DMA_MODE_LAZY)) {
 			int attr = 1;
 			iommu_domain_set_attr(dom,
 					      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ffbbc7e39ceeba3..c3f4e3416176496 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -42,6 +42,11 @@
  */
 #define IOMMU_PRIV	(1 << 5)
 
+
+#define IOMMU_DMA_MODE_STRICT		0x0
+#define IOMMU_DMA_MODE_LAZY		0x1
+#define IOMMU_DMA_MODE_PASSTHROUGH	0x2
+
 struct iommu_ops;
 struct iommu_group;
 struct bus_type;
-- 
1.8.3
