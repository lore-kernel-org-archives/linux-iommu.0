From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] of: base: Allow more args than MAX_PHANDLE_ARGS if
	required
Date: Thu, 16 Jul 2015 10:30:43 +0200
Message-ID: <1437035444-13867-2-git-send-email-joro@8bytes.org>
References: <1437035444-13867-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437035444-13867-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The main use of MAX_PHANDLE_ARGS is to define the number of
args elements in 'struct of_phandle_args'. This struct is
often declared on the stack and thus it is impractical to
increase MAX_PHANDLE_ARGS again and again.

To handle situations where more than MAX_PHANDLE_ARGS
elements may appear in a device-tree, introduce functions
to allocate/free 'struct of_phandle_args' with more than
MAX_PHANDLE_ARGS elements and provide the new function
of_parse_phandle_with_var_args(), which can handle those
variable-size structs.

This is necessary for the ARM-SMMU driver, where the number
of mmu-masters can be up to 128.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/of/base.c  | 43 ++++++++++++++++++++++++++++++++++++-------
 include/linux/of.h |  7 +++++++
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8b5a187..2b288db 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -54,6 +54,24 @@ DEFINE_MUTEX(of_mutex);
  */
 DEFINE_RAW_SPINLOCK(devtree_lock);
 
+struct of_phandle_args *of_alloc_phandle_args(int size)
+{
+	struct of_phandle_args *args;
+	int e = max(0, size - MAX_PHANDLE_ARGS);
+
+	args =  kzalloc(sizeof(struct of_phandle_args) + e * sizeof(uint32_t),
+			GFP_KERNEL);
+
+	return args;
+}
+EXPORT_SYMBOL(of_alloc_phandle_args);
+
+void of_free_phandle_args(struct of_phandle_args *args)
+{
+	kfree(args);
+}
+EXPORT_SYMBOL(of_free_phandle_args);
+
 int of_n_addr_cells(struct device_node *np)
 {
 	const __be32 *ip;
@@ -1446,7 +1464,8 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 					const char *list_name,
 					const char *cells_name,
 					int cell_count, int index,
-					struct of_phandle_args *out_args)
+					struct of_phandle_args *out_args,
+					int elems)
 {
 	const __be32 *list, *list_end;
 	int rc = 0, size, cur_index = 0;
@@ -1525,8 +1544,8 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 
 			if (out_args) {
 				int i;
-				if (WARN_ON(count > MAX_PHANDLE_ARGS))
-					count = MAX_PHANDLE_ARGS;
+				if (WARN_ON(count > elems))
+					count = elems;
 				out_args->np = node;
 				out_args->args_count = count;
 				for (i = 0; i < count; i++)
@@ -1577,7 +1596,7 @@ struct device_node *of_parse_phandle(const struct device_node *np,
 		return NULL;
 
 	if (__of_parse_phandle_with_args(np, phandle_name, NULL, 0,
-					 index, &args))
+					 index, &args, MAX_PHANDLE_ARGS))
 		return NULL;
 
 	return args.np;
@@ -1623,10 +1642,20 @@ int of_parse_phandle_with_args(const struct device_node *np, const char *list_na
 	if (index < 0)
 		return -EINVAL;
 	return __of_parse_phandle_with_args(np, list_name, cells_name, 0,
-					    index, out_args);
+					    index, out_args, MAX_PHANDLE_ARGS);
 }
 EXPORT_SYMBOL(of_parse_phandle_with_args);
 
+int of_parse_phandle_with_var_args(const struct device_node *np, const char *list_name,
+				   const char *cells_name, int index,
+				   struct of_phandle_args *out_args, int elems)
+{
+	if (index < 0)
+		return -EINVAL;
+	return __of_parse_phandle_with_args(np, list_name, cells_name, 0,
+					    index, out_args, elems);
+}
+EXPORT_SYMBOL(of_parse_phandle_with_var_args);
 /**
  * of_parse_phandle_with_fixed_args() - Find a node pointed by phandle in a list
  * @np:		pointer to a device tree node containing a list
@@ -1664,7 +1693,7 @@ int of_parse_phandle_with_fixed_args(const struct device_node *np,
 	if (index < 0)
 		return -EINVAL;
 	return __of_parse_phandle_with_args(np, list_name, NULL, cell_count,
-					   index, out_args);
+					   index, out_args, MAX_PHANDLE_ARGS);
 }
 EXPORT_SYMBOL(of_parse_phandle_with_fixed_args);
 
@@ -1687,7 +1716,7 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
 				const char *cells_name)
 {
 	return __of_parse_phandle_with_args(np, list_name, cells_name, 0, -1,
-					    NULL);
+					    NULL, MAX_PHANDLE_ARGS);
 }
 EXPORT_SYMBOL(of_count_phandle_with_args);
 
diff --git a/include/linux/of.h b/include/linux/of.h
index edc068d..cd9f225 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -75,6 +75,10 @@ struct of_phandle_args {
 	uint32_t args[MAX_PHANDLE_ARGS];
 };
 
+/* Use these if you need more that MAX_PHANDLE_ARGS */
+extern struct of_phandle_args *of_alloc_phandle_args(int size);
+extern void of_free_phandle_args(struct of_phandle_args *args);
+
 struct of_reconfig_data {
 	struct device_node	*dn;
 	struct property		*prop;
@@ -327,6 +331,9 @@ extern struct device_node *of_parse_phandle(const struct device_node *np,
 extern int of_parse_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name, int index,
 	struct of_phandle_args *out_args);
+extern int of_parse_phandle_with_var_args(const struct device_node *np,
+	const char *list_name, const char *cells_name, int index,
+	struct of_phandle_args *out_args, int elems);
 extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
 	const char *list_name, int cells_count, int index,
 	struct of_phandle_args *out_args);
-- 
1.9.1
