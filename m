From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 1/2] kernel/dma: Support device-specific CMA defaults
Date: Mon,  4 Mar 2019 12:52:54 +0100
Message-ID: <20190304115255.2088-2-tzimmermann@suse.de>
References: <20190304115255.2088-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190304115255.2088-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: ptesarik-AlSwsSmVLrQ@public.gmane.org, Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Some devices require contiguous memory to be configured at boot time. While
this should be specified by the device's firmware, such as a device-tree file,
not all devices do so correctly. One example is the Raspberry Pi, which
requires CMA memory for its VC4 graphics unit.

This patch adds the necessary infrastructure to initialize CMA with device-
specific values. Initially the default is selected from the machine name, as
provided by device tree.

Signed-off-by: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
---
 kernel/dma/contiguous.c | 58 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index b2a87905846d..5bbb7a618a2d 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -23,6 +23,8 @@
 #include <linux/sizes.h>
 #include <linux/dma-contiguous.h>
 #include <linux/cma.h>
+#include <linux/bsearch.h>
+#include <linux/of_fdt.h>
 
 #ifdef CONFIG_CMA_SIZE_MBYTES
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
@@ -30,6 +32,54 @@
 #define CMA_SIZE_MBYTES 0
 #endif
 
+struct cma_default {
+	union {
+		const char *machine_name;
+	} key;
+	phys_addr_t selected_size;
+	phys_addr_t selected_base;
+	phys_addr_t selected_limit;
+};
+
+#define DECLARE_CMA_MACHINE_DEFAULT(machine_name_, selected_size_, 	\
+				    selected_base_, selected_limit_) 	\
+	{								\
+		.key = {						\
+			.machine_name = machine_name_,			\
+		},							\
+		.selected_size = (selected_size_),			\
+		.selected_base = (selected_base_),			\
+		.selected_limit = (selected_limit_)			\
+	}
+
+/* CMA defaults for various devices, keep this sorted by .machine_name.
+ */
+static const struct cma_default __initdata cma_machine_defaults[] = {
+};
+
+static int __init cmp_machine_name(const void *key, const void *elt)
+{
+	const struct cma_default *lhs = key;
+	const struct cma_default *rhs = elt;
+
+	return strcmp(lhs->key.machine_name, rhs->key.machine_name);
+}
+
+static const struct cma_default * __init cma_get_default(void)
+{
+	struct cma_default key;
+
+	memset(&key, 0, sizeof(key));
+	key.key.machine_name = of_flat_dt_get_machine_name();
+	if (!key.key.machine_name)
+		return NULL;
+
+	return bsearch(&key, cma_machine_defaults, 
+		       ARRAY_SIZE(cma_machine_defaults), 
+		       sizeof(cma_machine_defaults[0]),
+		       cmp_machine_name);
+}
+
 struct cma *dma_contiguous_default_area;
 
 /*
@@ -129,6 +179,14 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
 #elif defined(CONFIG_CMA_SIZE_SEL_MAX)
 		selected_size = max(size_bytes, cma_early_percent_memory());
 #endif
+		if (!selected_size) {
+			const struct cma_default *def = cma_get_default();
+			if (def) {
+				selected_size = def->selected_size;
+				selected_base = def->selected_base;
+				selected_limit = def->selected_limit;
+			}
+		}
 	}
 
 	if (selected_size && !dma_contiguous_default_area) {
-- 
2.20.1
