From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 3/3] iommu: of: enforce const-ness of struct iommu_ops
Date: Fri, 20 Mar 2015 16:50:34 +0000
Message-ID: <1426870234-12910-4-git-send-email-will.deacon@arm.com>
References: <1426870234-12910-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1426870234-12910-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>

With the pgsize_bitmap removed, there is no compelling reason for
the remaining callbacks in struct iommu_ops to be mutable, so enforce
const-ness throughout the core code.

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm/include/asm/dma-mapping.h   |  2 +-
 arch/arm/mm/dma-mapping.c            |  6 +++---
 arch/arm64/include/asm/dma-mapping.h |  3 ++-
 drivers/iommu/of_iommu.c             | 12 ++++++------
 drivers/of/platform.c                |  2 +-
 include/linux/dma-mapping.h          |  2 +-
 include/linux/of_iommu.h             |  8 ++++----
 7 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index b52101d37ec7..c366edc22d02 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -123,7 +123,7 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 
 #define arch_setup_dma_ops arch_setup_dma_ops
 extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			       struct iommu_ops *iommu, bool coherent);
+			       const struct iommu_ops *iommu, bool coherent);
 
 #define arch_teardown_dma_ops arch_teardown_dma_ops
 extern void arch_teardown_dma_ops(struct device *dev);
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 170a116d1b29..fd3134fd0c89 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2020,7 +2020,7 @@ static struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
 }
 
 static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    struct iommu_ops *iommu)
+				    const struct iommu_ops *iommu)
 {
 	struct dma_iommu_mapping *mapping;
 
@@ -2058,7 +2058,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 #else
 
 static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    struct iommu_ops *iommu)
+				    const struct iommu_ops *iommu)
 {
 	return false;
 }
@@ -2075,7 +2075,7 @@ static struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			struct iommu_ops *iommu, bool coherent)
+			const struct iommu_ops *iommu, bool coherent)
 {
 	struct dma_map_ops *dma_ops;
 
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 6932bb57dba0..2fbf8570d9bc 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -46,7 +46,8 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 }
 
 static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				      struct iommu_ops *iommu, bool coherent)
+				      const struct iommu_ops *iommu,
+				      bool coherent)
 {
 	dev->archdata.dma_coherent = coherent;
 }
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index af1dc6a1c0a1..17d39b419e7b 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -98,12 +98,12 @@ EXPORT_SYMBOL_GPL(of_get_dma_window);
 struct of_iommu_node {
 	struct list_head list;
 	struct device_node *np;
-	struct iommu_ops *ops;
+	const struct iommu_ops *ops;
 };
 static LIST_HEAD(of_iommu_list);
 static DEFINE_SPINLOCK(of_iommu_lock);
 
-void of_iommu_set_ops(struct device_node *np, struct iommu_ops *ops)
+void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops)
 {
 	struct of_iommu_node *iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
 
@@ -118,10 +118,10 @@ void of_iommu_set_ops(struct device_node *np, struct iommu_ops *ops)
 	spin_unlock(&of_iommu_lock);
 }
 
-struct iommu_ops *of_iommu_get_ops(struct device_node *np)
+const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
 {
 	struct of_iommu_node *node;
-	struct iommu_ops *ops = NULL;
+	const struct iommu_ops *ops = NULL;
 
 	spin_lock(&of_iommu_lock);
 	list_for_each_entry(node, &of_iommu_list, list)
@@ -133,11 +133,11 @@ struct iommu_ops *of_iommu_get_ops(struct device_node *np)
 	return ops;
 }
 
-struct iommu_ops *of_iommu_configure(struct device *dev)
+const struct iommu_ops *of_iommu_configure(struct device *dev)
 {
 	struct of_phandle_args iommu_spec;
 	struct device_node *np;
-	struct iommu_ops *ops = NULL;
+	const struct iommu_ops *ops = NULL;
 	int idx = 0;
 
 	/*
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b189733a1539..d7df0ea4f14b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -167,7 +167,7 @@ static void of_dma_configure(struct device *dev)
 	int ret;
 	bool coherent;
 	unsigned long offset;
-	struct iommu_ops *iommu;
+	const struct iommu_ops *iommu;
 
 	/*
 	 * Set default dma-mask to 32 bit. Drivers are expected to setup
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c3007cb4bfa6..68840b87a444 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -131,7 +131,7 @@ extern u64 dma_get_required_mask(struct device *dev);
 
 #ifndef arch_setup_dma_ops
 static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
-				      u64 size, struct iommu_ops *iommu,
+				      u64 size, const struct iommu_ops *iommu,
 				      bool coherent) { }
 #endif
 
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 16c75547d725..ea564d53c79d 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -12,7 +12,7 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 			     size_t *size);
 
 extern void of_iommu_init(void);
-extern struct iommu_ops *of_iommu_configure(struct device *dev);
+extern const struct iommu_ops *of_iommu_configure(struct device *dev);
 
 #else
 
@@ -24,15 +24,15 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
 }
 
 static inline void of_iommu_init(void) { }
-static inline struct iommu_ops *of_iommu_configure(struct device *dev)
+static inline const struct iommu_ops *of_iommu_configure(struct device *dev)
 {
 	return NULL;
 }
 
 #endif	/* CONFIG_OF_IOMMU */
 
-void of_iommu_set_ops(struct device_node *np, struct iommu_ops *ops);
-struct iommu_ops *of_iommu_get_ops(struct device_node *np);
+void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
+const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
 
 extern struct of_device_id __iommu_of_table;
 
-- 
2.1.4
