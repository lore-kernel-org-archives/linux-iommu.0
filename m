From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/6] of: Introduce struct of_phandle_iterator
Date: Tue, 22 Mar 2016 18:58:24 +0100
Message-ID: <1458669509-7178-2-git-send-email-joro@8bytes.org>
References: <1458669509-7178-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1458669509-7178-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This struct carrys all necessary information to iterate over
a list of phandles and extract the arguments. Add an
init-function for the iterator and make use of it in
__of_parse_phandle_with_args().

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/of/base.c  | 99 +++++++++++++++++++++++++++++++++---------------------
 include/linux/of.h | 33 ++++++++++++++++++
 2 files changed, 93 insertions(+), 39 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 017dd94..bfdb09b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1439,35 +1439,56 @@ void of_print_phandle_args(const char *msg, const struct of_phandle_args *args)
 	printk("\n");
 }
 
+int of_phandle_iterator_init(struct of_phandle_iterator *it,
+		const struct device_node *np,
+		const char *list_name,
+		const char *cells_name,
+		int cell_count)
+{
+	const __be32 *list;
+	int size;
+
+	memset(it, 0, sizeof(*it));
+
+	list = of_get_property(np, list_name, &size);
+	if (!list)
+		return -ENOENT;
+
+	it->cells_name = cells_name;
+	it->cell_count = cell_count;
+	it->parent = np;
+	it->list_end = list + size / sizeof(*list);
+	it->phandle_end = list;
+	it->cur = list;
+
+	return 0;
+}
+
 static int __of_parse_phandle_with_args(const struct device_node *np,
 					const char *list_name,
 					const char *cells_name,
 					int cell_count, int index,
 					struct of_phandle_args *out_args)
 {
-	const __be32 *list, *list_end;
-	int rc = 0, size, cur_index = 0;
-	uint32_t count = 0;
-	struct device_node *node = NULL;
-	phandle phandle;
+	struct of_phandle_iterator it;
+	int rc, cur_index = 0;
 
-	/* Retrieve the phandle list property */
-	list = of_get_property(np, list_name, &size);
-	if (!list)
-		return -ENOENT;
-	list_end = list + size / sizeof(*list);
+	rc = of_phandle_iterator_init(&it, np, list_name,
+				      cells_name, cell_count);
+	if (rc)
+		return rc;
 
 	/* Loop over the phandles until all the requested entry is found */
-	while (list < list_end) {
+	while (it.cur < it.list_end) {
 		rc = -EINVAL;
-		count = 0;
+		it.cur_count = 0;
 
 		/*
 		 * If phandle is 0, then it is an empty entry with no
 		 * arguments.  Skip forward to the next entry.
 		 */
-		phandle = be32_to_cpup(list++);
-		if (phandle) {
+		it.phandle = be32_to_cpup(it.cur++);
+		if (it.phandle) {
 			/*
 			 * Find the provider node and parse the #*-cells
 			 * property to determine the argument length.
@@ -1477,34 +1498,34 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 			 * except when we're going to return the found node
 			 * below.
 			 */
-			if (cells_name || cur_index == index) {
-				node = of_find_node_by_phandle(phandle);
-				if (!node) {
+			if (it.cells_name || cur_index == index) {
+				it.node = of_find_node_by_phandle(it.phandle);
+				if (!it.node) {
 					pr_err("%s: could not find phandle\n",
-						np->full_name);
+						it.parent->full_name);
 					goto err;
 				}
 			}
 
-			if (cells_name) {
-				if (of_property_read_u32(node, cells_name,
-							 &count)) {
+			if (it.cells_name) {
+				if (of_property_read_u32(it.node, it.cells_name,
+							 &it.cur_count)) {
 					pr_err("%s: could not get %s for %s\n",
-						np->full_name, cells_name,
-						node->full_name);
+						it.parent->full_name, it.cells_name,
+						it.node->full_name);
 					goto err;
 				}
 			} else {
-				count = cell_count;
+				it.cur_count = it.cell_count;
 			}
 
 			/*
 			 * Make sure that the arguments actually fit in the
 			 * remaining property data length
 			 */
-			if (list + count > list_end) {
+			if (it.cur + it.cur_count > it.list_end) {
 				pr_err("%s: arguments longer than property\n",
-					 np->full_name);
+					 it.parent->full_name);
 				goto err;
 			}
 		}
@@ -1517,28 +1538,28 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 		 */
 		rc = -ENOENT;
 		if (cur_index == index) {
-			if (!phandle)
+			if (!it.phandle)
 				goto err;
 
 			if (out_args) {
 				int i;
-				if (WARN_ON(count > MAX_PHANDLE_ARGS))
-					count = MAX_PHANDLE_ARGS;
-				out_args->np = node;
-				out_args->args_count = count;
-				for (i = 0; i < count; i++)
-					out_args->args[i] = be32_to_cpup(list++);
+				if (WARN_ON(it.cur_count > MAX_PHANDLE_ARGS))
+					it.cur_count = MAX_PHANDLE_ARGS;
+				out_args->np = it.node;
+				out_args->args_count = it.cur_count;
+				for (i = 0; i < it.cur_count; i++)
+					out_args->args[i] = be32_to_cpup(it.cur++);
 			} else {
-				of_node_put(node);
+				of_node_put(it.node);
 			}
 
 			/* Found it! return success */
 			return 0;
 		}
 
-		of_node_put(node);
-		node = NULL;
-		list += count;
+		of_node_put(it.node);
+		it.node = NULL;
+		it.cur += it.cur_count;
 		cur_index++;
 	}
 
@@ -1550,8 +1571,8 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 	 */
 	rc = index < 0 ? cur_index : -ENOENT;
  err:
-	if (node)
-		of_node_put(node);
+	if (it.node)
+		of_node_put(it.node);
 	return rc;
 }
 
diff --git a/include/linux/of.h b/include/linux/of.h
index dc6e396..70c2bdb 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -75,6 +75,23 @@ struct of_phandle_args {
 	uint32_t args[MAX_PHANDLE_ARGS];
 };
 
+struct of_phandle_iterator {
+	/* Common iterator information */
+	const char *cells_name;
+	int cell_count;
+	const struct device_node *parent;
+
+	/* List size information */
+	const __be32 *list_end;
+	const __be32 *phandle_end;
+
+	/* Current position state */
+	const __be32 *cur;
+	uint32_t cur_count;
+	phandle phandle;
+	struct device_node *node;
+};
+
 struct of_reconfig_data {
 	struct device_node	*dn;
 	struct property		*prop;
@@ -334,6 +351,13 @@ extern int of_parse_phandle_with_fixed_args(const struct device_node *np,
 extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
 
+/* phandle iterator functions */
+extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
+				    const struct device_node *np,
+				    const char *list_name,
+				    const char *cells_name,
+				    int cell_count);
+
 extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
@@ -608,6 +632,15 @@ static inline int of_count_phandle_with_args(struct device_node *np,
 	return -ENOSYS;
 }
 
+static inline int of_phandle_iterator_init(struct of_phandle_iterator *it,
+					   const struct device_node *np,
+					   const char *list_name,
+					   const char *cells_name,
+					   int cell_count)
+{
+	return -ENOSYS;
+}
+
 static inline int of_alias_get_id(struct device_node *np, const char *stem)
 {
 	return -ENOSYS;
-- 
1.9.1
