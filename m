From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 1/8] iommu: provide early initialisation hook for IOMMU
	drivers
Date: Fri, 28 Nov 2014 13:29:39 +0000
Message-ID: <1417181386-18142-2-git-send-email-will.deacon@arm.com>
References: <1417181386-18142-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417181386-18142-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

IOMMU drivers must be initialised before any of their upstream devices,
otherwise the relevant iommu_ops won't be configured for the bus in
question. To solve this, a number of IOMMU drivers use initcalls to
initialise the driver before anything has a chance to be probed.

Whilst this solves the immediate problem, it leaves the job of probing
the IOMMU completely separate from the iommu_ops to configure the IOMMU,
which are called on a per-bus basis and require the driver to figure out
exactly which instance of the IOMMU is being requested. In particular,
the add_device callback simply passes a struct device to the driver,
which then has to parse firmware tables or probe buses to identify the
relevant IOMMU instance.

This patch takes the first step in addressing this problem by adding an
early initialisation pass for IOMMU drivers, giving them the ability to
store some per-instance data in their iommu_ops structure and store that
in their of_node. This can later be used when parsing OF masters to
identify the IOMMU instance in question.

Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Tested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/of_iommu.c          | 17 +++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  2 ++
 include/linux/iommu.h             |  2 ++
 include/linux/of_iommu.h          | 25 +++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e550ccb7634e..89b903406968 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -22,6 +22,9 @@
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 
+static const struct of_device_id __iommu_of_table_sentinel
+	__used __section(__iommu_of_table_end);
+
 /**
  * of_get_dma_window - Parse *dma-window property and returns 0 if found.
  *
@@ -89,3 +92,17 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_get_dma_window);
+
+void __init of_iommu_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match, *matches = &__iommu_of_table;
+
+	for_each_matching_node_and_match(np, matches, &match) {
+		const of_iommu_init_fn init_fn = match->data;
+
+		if (init_fn(np))
+			pr_err("Failed to initialise IOMMU %s\n",
+				of_node_full_name(np));
+	}
+}
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index aa70cbda327c..bee5d683074d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -164,6 +164,7 @@
 #define CLKSRC_OF_TABLES()	OF_TABLE(CONFIG_CLKSRC_OF, clksrc)
 #define IRQCHIP_OF_MATCH_TABLE() OF_TABLE(CONFIG_IRQCHIP, irqchip)
 #define CLK_OF_TABLES()		OF_TABLE(CONFIG_COMMON_CLK, clk)
+#define IOMMU_OF_TABLES()	OF_TABLE(CONFIG_OF_IOMMU, iommu)
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
@@ -497,6 +498,7 @@
 	CLK_OF_TABLES()							\
 	RESERVEDMEM_OF_TABLES()						\
 	CLKSRC_OF_TABLES()						\
+	IOMMU_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e6a7c9ff72f2..7b83f9f8e11d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -103,6 +103,7 @@ enum iommu_attr {
  * @domain_get_attr: Query domain attributes
  * @domain_set_attr: Change domain attributes
  * @pgsize_bitmap: bitmap of supported page sizes
+ * @priv: per-instance data private to the iommu driver
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -133,6 +134,7 @@ struct iommu_ops {
 	u32 (*domain_get_windows)(struct iommu_domain *domain);
 
 	unsigned long pgsize_bitmap;
+	void *priv;
 };
 
 #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 51a560f34bca..5762cdc8effe 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -1,12 +1,17 @@
 #ifndef __OF_IOMMU_H
 #define __OF_IOMMU_H
 
+#include <linux/iommu.h>
+#include <linux/of.h>
+
 #ifdef CONFIG_OF_IOMMU
 
 extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 			     int index, unsigned long *busno, dma_addr_t *addr,
 			     size_t *size);
 
+extern void of_iommu_init(void);
+
 #else
 
 static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
@@ -16,6 +21,26 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
 	return -EINVAL;
 }
 
+static inline void of_iommu_init(void) { }
+
 #endif	/* CONFIG_OF_IOMMU */
 
+static inline void of_iommu_set_ops(struct device_node *np,
+				    const struct iommu_ops *ops)
+{
+	np->data = (struct iommu_ops *)ops;
+}
+
+static inline struct iommu_ops *of_iommu_get_ops(struct device_node *np)
+{
+	return np->data;
+}
+
+extern struct of_device_id __iommu_of_table;
+
+typedef int (*of_iommu_init_fn)(struct device_node *);
+
+#define IOMMU_OF_DECLARE(name, compat, fn) \
+	_OF_DECLARE(iommu, name, compat, fn, of_iommu_init_fn)
+
 #endif /* __OF_IOMMU_H */
-- 
2.1.1
