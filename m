From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/5] iommu: of: enforce const-ness of struct iommu_ops
Date: Thu,  7 Apr 2016 18:42:05 +0100
Message-ID: <b3a7636ef956ab0f335142e4de0946836687920b.1460048991.git.robin.murphy@arm.com>
References: <cover.1460048991.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1460048991.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>

As a set of driver-provided callbacks and static data, there is no
compelling reason for struct iommu_ops to be mutable in core code, so
enforce const-ness throughout.

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm/include/asm/dma-mapping.h   |  2 +-
 arch/arm/mm/dma-mapping.c            |  6 +++---
 arch/arm64/include/asm/dma-mapping.h |  2 +-
 arch/arm64/mm/dma-mapping.c          |  4 ++--
 drivers/iommu/of_iommu.c             | 14 +++++++-------
 drivers/of/device.c                  |  2 +-
 include/linux/dma-mapping.h          |  2 +-
 include/linux/of_iommu.h             |  8 ++++----
 8 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 6ad1ced..02283eb 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -118,7 +118,7 @@ static inline unsigned long dma_max_pfn(struct device *dev)
 
 #define arch_setup_dma_ops arch_setup_dma_ops
 extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			       struct iommu_ops *iommu, bool coherent);
+			       const struct iommu_ops *iommu, bool coherent);
 
 #define arch_teardown_dma_ops arch_teardown_dma_ops
 extern void arch_teardown_dma_ops(struct device *dev);
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index deac58d..617b0cf 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2214,7 +2214,7 @@ static struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
 }
 
 static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    struct iommu_ops *iommu)
+				    const struct iommu_ops *iommu)
 {
 	struct dma_iommu_mapping *mapping;
 
@@ -2252,7 +2252,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 #else
 
 static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				    struct iommu_ops *iommu)
+				    const struct iommu_ops *iommu)
 {
 	return false;
 }
@@ -2269,7 +2269,7 @@ static struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			struct iommu_ops *iommu, bool coherent)
+			const struct iommu_ops *iommu, bool coherent)
 {
 	struct dma_map_ops *dma_ops;
 
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index ba437f0..7dbea6c 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -48,7 +48,7 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			struct iommu_ops *iommu, bool coherent);
+			const struct iommu_ops *iommu, bool coherent);
 #define arch_setup_dma_ops	arch_setup_dma_ops
 
 #ifdef CONFIG_IOMMU_DMA
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index a6e757c..5d36907 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -979,13 +979,13 @@ void arch_teardown_dma_ops(struct device *dev)
 #else
 
 static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-				  struct iommu_ops *iommu)
+				  const struct iommu_ops *iommu)
 { }
 
 #endif  /* CONFIG_IOMMU_DMA */
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
-			struct iommu_ops *iommu, bool coherent)
+			const struct iommu_ops *iommu, bool coherent)
 {
 	if (!dev->archdata.dma_ops)
 		dev->archdata.dma_ops = &swiotlb_dma_ops;
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5fea665..af499ae 100644
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
 
@@ -119,10 +119,10 @@ void of_iommu_set_ops(struct device_node *np, struct iommu_ops *ops)
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
@@ -134,12 +134,12 @@ struct iommu_ops *of_iommu_get_ops(struct device_node *np)
 	return ops;
 }
 
-struct iommu_ops *of_iommu_configure(struct device *dev,
-				     struct device_node *master_np)
+const struct iommu_ops *of_iommu_configure(struct device *dev,
+					   struct device_node *master_np)
 {
 	struct of_phandle_args iommu_spec;
 	struct device_node *np;
-	struct iommu_ops *ops = NULL;
+	const struct iommu_ops *ops = NULL;
 	int idx = 0;
 
 	/*
diff --git a/drivers/of/device.c b/drivers/of/device.c
index e5f47ce..fd5cfad 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -88,7 +88,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	int ret;
 	bool coherent;
 	unsigned long offset;
-	struct iommu_ops *iommu;
+	const struct iommu_ops *iommu;
 
 	/*
 	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 9ea9aba..71c1b21 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -514,7 +514,7 @@ extern u64 dma_get_required_mask(struct device *dev);
 
 #ifndef arch_setup_dma_ops
 static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
-				      u64 size, struct iommu_ops *iommu,
+				      u64 size, const struct iommu_ops *iommu,
 				      bool coherent) { }
 #endif
 
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index ffbe470..bd02b44 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -12,7 +12,7 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 			     size_t *size);
 
 extern void of_iommu_init(void);
-extern struct iommu_ops *of_iommu_configure(struct device *dev,
+extern const struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np);
 
 #else
@@ -25,7 +25,7 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
 }
 
 static inline void of_iommu_init(void) { }
-static inline struct iommu_ops *of_iommu_configure(struct device *dev,
+static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 					 struct device_node *master_np)
 {
 	return NULL;
@@ -33,8 +33,8 @@ static inline struct iommu_ops *of_iommu_configure(struct device *dev,
 
 #endif	/* CONFIG_OF_IOMMU */
 
-void of_iommu_set_ops(struct device_node *np, struct iommu_ops *ops);
-struct iommu_ops *of_iommu_get_ops(struct device_node *np);
+void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
+const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
 
 extern struct of_device_id __iommu_of_table;
 
-- 
2.7.3.dirty
