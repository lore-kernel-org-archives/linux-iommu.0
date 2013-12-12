From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv7 01/12] of: introduce of_property_for_each_phandle_with_args()
Date: Thu, 12 Dec 2013 09:57:02 +0200
Message-ID: <1386835033-4701-2-git-send-email-hdoyu@nvidia.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386835033-4701-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Iterating over a property containing a list of phandles with arguments
is a common operation for device drivers. This patch adds a new
of_property_for_each_phandle_with_args() macro to make the iteration
simpler.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
v7:
Fixed some minors pointed by Rob and Stephen.

v6++++:
Iterate without intrducing a new struct.

v6+++:
Introduced a new struct "of_phandle_iter" to keep the state when
iterating over the list.

v6++:
Optimized to avoid O(n^2), suggested by Stephen Warren.
http://lists.linuxfoundation.org/pipermail/iommu/2013-November/007066.html

I didn't introduce any struct to hold params and state here.

v6+:
Use the description, which Grant Likely proposed, to be full enough
that a future reader can figure out why a patch was written.

v5:
New patch for v5.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/of/base.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index f807d0e..cd4ab05 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1201,6 +1201,52 @@ void of_print_phandle_args(const char *msg, const struct of_phandle_args *args)
 	printk("\n");
 }
 
+const __be32 *of_phandle_iter_next(const char *cells_name, int cell_count,
+				   const __be32 *cur, const __be32 *end,
+				   struct of_phandle_args *out_args)
+{
+	struct device_node *dn;
+	int i;
+
+	if (!cells_name && !cell_count)
+		return NULL;
+
+	if (!cur || (cur >= end))
+		return NULL;
+
+	dn = of_find_node_by_phandle(be32_to_cpup(cur++));
+	if (!dn)
+		return NULL;
+
+	if (cells_name)
+		if (of_property_read_u32(dn, cells_name, &cell_count))
+			return NULL;
+
+	out_args->np = dn;
+	out_args->args_count = cell_count;
+	for (i = 0; i < cell_count; i++)
+		out_args->args[i] = be32_to_cpup(cur++);
+
+	return cur;
+}
+EXPORT_SYMBOL_GPL(of_phandle_iter_next);
+
+const __be32 *of_phandle_iter_init(const struct device_node *np,
+				   const char *list_name,
+				   const __be32 **end)
+{
+	size_t bytes;
+	const __be32 *cur;
+
+	cur = of_get_property(np, list_name, &bytes);
+	*end = cur;
+	if (bytes)
+		*end += bytes / sizeof(*cur);
+
+	return cur;
+}
+EXPORT_SYMBOL_GPL(of_phandle_iter_init);
+
 static int __of_parse_phandle_with_args(const struct device_node *np,
 					const char *list_name,
 					const char *cells_name,
diff --git a/include/linux/of.h b/include/linux/of.h
index 276c546..4345582 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -303,6 +303,14 @@ extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
 extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
 
+extern const __be32 *of_phandle_iter_init(const struct device_node *np,
+					  const char *list_name,
+					  const __be32 **end);
+extern const __be32 *of_phandle_iter_next(const char *cells_name,
+					  int cell_count,
+					  const __be32 *cur, const __be32 *end,
+					  struct of_phandle_args *out_args);
+
 extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
 
@@ -527,6 +535,22 @@ static inline int of_count_phandle_with_args(struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline const __be32 *of_phandle_iter_init(const struct device_node *np,
+						 const char *list_name,
+						 const __be32 **end)
+{
+	return NULL;
+}
+
+static inline const __be32 *of_phandle_iter_next(const char *cells_name,
+						 int cell_count,
+						 const __be32 *cur,
+						 const __be32 *end,
+						 struct of_phandle_args *out_args);
+{
+	return NULL;
+}
+
 static inline int of_alias_get_id(struct device_node *np, const char *stem)
 {
 	return -ENOSYS;
@@ -613,6 +637,14 @@ static inline int of_property_read_u32(const struct device_node *np,
 		s;						\
 		s = of_prop_next_string(prop, s))
 
+#define of_property_for_each_phandle_with_args(node, list_name, cells_name, \
+					       cell_count, out_args, cur, end) \
+	for (cur = of_phandle_iter_init(node, list_name, &end),		\
+		     cur = of_phandle_iter_next(cells_name, cell_count, \
+						cur, end, &out_args);	\
+	     cur;							\
+	     cur = of_phandle_iter_next(cells_name, cell_count, cur, end, &out_args))
+
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_PROC_DEVICETREE)
 extern void proc_device_tree_add_node(struct device_node *, struct proc_dir_entry *);
 extern void proc_device_tree_add_prop(struct proc_dir_entry *pde, struct property *prop);
-- 
1.8.1.5
