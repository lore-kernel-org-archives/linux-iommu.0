From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 3/6] iommu: add iommu_default_dma_mode_get/set() helper
Date: Tue, 9 Apr 2019 20:53:05 +0800
Message-ID: <20190409125308.18304-4-thunder.leizhen__25579.3858248339$1554814483$gmane$org@huawei.com>
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

Also add IOMMU_DMA_MODE_IS_{STRICT|LAZT|PASSTHROUGH}() to make the code
looks cleaner.

There is no functional change, just prepare for the following patches.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iommu.c | 18 ++++++++++++++----
 include/linux/iommu.h | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f4171bf4b46eaeb..86239dd46003fd4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -195,6 +195,17 @@ static int __init iommu_dma_mode_setup(char *str)
 }
 early_param("iommu.dma_mode", iommu_dma_mode_setup);
 
+int iommu_default_dma_mode_get(void)
+{
+	return iommu_default_dma_mode;
+}
+
+void iommu_default_dma_mode_set(int mode)
+{
+	WARN_ON(mode > IOMMU_DMA_MODE_PASSTHROUGH);
+	iommu_default_dma_mode = mode;
+}
+
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
@@ -1136,9 +1147,8 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	 */
 	if (!group->default_domain) {
 		struct iommu_domain *dom;
-		int def_domain_type =
-			(iommu_default_dma_mode == IOMMU_DMA_MODE_PASSTHROUGH)
-			? IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_DMA;
+		int def_domain_type = IOMMU_DMA_MODE_IS_PASSTHROUGH() ?
+				IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_DMA;
 
 		dom = __iommu_domain_alloc(dev->bus, def_domain_type);
 		if (!dom && def_domain_type != IOMMU_DOMAIN_DMA) {
@@ -1154,7 +1164,7 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 		if (!group->domain)
 			group->domain = dom;
 
-		if (dom && (iommu_default_dma_mode == IOMMU_DMA_MODE_LAZY)) {
+		if (dom && IOMMU_DMA_MODE_IS_LAZY()) {
 			int attr = 1;
 			iommu_domain_set_attr(dom,
 					      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c3f4e3416176496..3668a8b3846996a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -46,6 +46,12 @@
 #define IOMMU_DMA_MODE_STRICT		0x0
 #define IOMMU_DMA_MODE_LAZY		0x1
 #define IOMMU_DMA_MODE_PASSTHROUGH	0x2
+#define IOMMU_DMA_MODE_IS_STRICT() \
+		(iommu_default_dma_mode_get() == IOMMU_DMA_MODE_STRICT)
+#define IOMMU_DMA_MODE_IS_LAZY() \
+		(iommu_default_dma_mode_get() == IOMMU_DMA_MODE_LAZY)
+#define IOMMU_DMA_MODE_IS_PASSTHROUGH() \
+		(iommu_default_dma_mode_get() == IOMMU_DMA_MODE_PASSTHROUGH)
 
 struct iommu_ops;
 struct iommu_group;
@@ -421,6 +427,9 @@ static inline void dev_iommu_fwspec_set(struct device *dev,
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 
+extern int iommu_default_dma_mode_get(void);
+extern void iommu_default_dma_mode_set(int mode);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -705,6 +714,15 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline int iommu_default_dma_mode_get(void)
+{
+	return IOMMU_DMA_MODE_PASSTHROUGH;
+}
+
+static inline void iommu_default_dma_mode_set(int mode)
+{
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-- 
1.8.3
