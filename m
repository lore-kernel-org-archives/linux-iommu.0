From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH v2 1/7] iommu: provide early initialisation hook for IOMMU
	drivers
Date: Tue,  2 Sep 2014 18:56:21 +0100
Message-ID: <1409680587-29818-2-git-send-email-will.deacon@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409680587-29818-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
set some per-instance data on their of_node in the form of a new
iommu_data structure. This can later be used when parsing OF masters to
identify the IOMMU instance in question.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/of_iommu.c          | 14 ++++++++++++++
 include/asm-generic/vmlinux.lds.h |  2 ++
 include/linux/iommu.h             |  6 ++++++
 include/linux/of_iommu.h          | 23 +++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e550ccb7634e..f9209666157c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -89,3 +89,17 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
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
+		const int (*init_fn)(struct device_node *) = match->data;
+
+		if (init_fn(np))
+			pr_err("Failed to initialise IOMMU %s\n",
+				of_node_full_name(np));
+	}
+}
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5ba0360663a7..b75ede8f99ae 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -162,6 +162,7 @@
 #define CLKSRC_OF_TABLES()	OF_TABLE(CONFIG_CLKSRC_OF, clksrc)
 #define IRQCHIP_OF_MATCH_TABLE() OF_TABLE(CONFIG_IRQCHIP, irqchip)
 #define CLK_OF_TABLES()		OF_TABLE(CONFIG_COMMON_CLK, clk)
+#define IOMMU_OF_TABLES()	OF_TABLE(CONFIG_OF_IOMMU, iommu)
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
@@ -495,6 +496,7 @@
 	CLK_OF_TABLES()							\
 	RESERVEDMEM_OF_TABLES()						\
 	CLKSRC_OF_TABLES()						\
+	IOMMU_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20f9a527922a..fdddb14cd8f5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -57,6 +57,12 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 };
 
+struct iommu_data {
+	struct iommu_domain *domain;
+	struct iova_domain *iovad;
+	void *priv;
+};
+
 #define IOMMU_CAP_CACHE_COHERENCY	0x1
 #define IOMMU_CAP_INTR_REMAP		0x2	/* isolates device intrs */
 
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 51a560f34bca..a39e2d78f735 100644
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
@@ -16,6 +21,24 @@ static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
 	return -EINVAL;
 }
 
+static inline void of_iommu_init(void) { }
+
 #endif	/* CONFIG_OF_IOMMU */
 
+static inline void of_iommu_set_data(struct device_node *np,
+				     struct iommu_data *data)
+{
+	np->data = data;
+}
+
+static inline struct iommu_data *of_iommu_get_data(struct device_node *np)
+{
+	return np->data;
+}
+
+extern struct of_device_id __iommu_of_table;
+
+#define IOMMU_OF_DECLARE(name, compat, fn) \
+	OF_DECLARE_1(iommu, name, compat, fn)
+
 #endif /* __OF_IOMMU_H */
-- 
2.1.0
