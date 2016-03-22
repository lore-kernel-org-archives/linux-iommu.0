From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/6] of: Introduce of_phandle_iterator_args()
Date: Tue, 22 Mar 2016 18:58:28 +0100
Message-ID: <1458669509-7178-6-git-send-email-joro@8bytes.org>
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

This helper function can be used to copy the arguments of a
phandle to an array.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/of/base.c  | 29 +++++++++++++++++++++++------
 include/linux/of.h | 10 ++++++++++
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 471d3d9..008988b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1533,6 +1533,23 @@ err:
 	return -EINVAL;
 }
 
+int of_phandle_iterator_args(struct of_phandle_iterator *it,
+			     uint32_t *args,
+			     int size)
+{
+	int i, count;
+
+	count = it->cur_count;
+
+	if (WARN_ON(size < count))
+		count = size;
+
+	for (i = 0; i < count; i++)
+		args[i] = be32_to_cpup(it->cur++);
+
+	return count;
+}
+
 static int __of_parse_phandle_with_args(const struct device_node *np,
 					const char *list_name,
 					const char *cells_name,
@@ -1556,13 +1573,13 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 				goto err;
 
 			if (out_args) {
-				int i;
-				if (WARN_ON(it.cur_count > MAX_PHANDLE_ARGS))
-					it.cur_count = MAX_PHANDLE_ARGS;
+				int c;
+
+				c = of_phandle_iterator_args(&it,
+							     out_args->args,
+							     MAX_PHANDLE_ARGS);
 				out_args->np = it.node;
-				out_args->args_count = it.cur_count;
-				for (i = 0; i < it.cur_count; i++)
-					out_args->args[i] = be32_to_cpup(it.cur++);
+				out_args->args_count = c;
 			} else {
 				of_node_put(it.node);
 			}
diff --git a/include/linux/of.h b/include/linux/of.h
index 05e38ed..c91f8b1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -359,6 +359,9 @@ extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
 				    int cell_count);
 
 extern int of_phandle_iterator_next(struct of_phandle_iterator *it);
+extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
+				    uint32_t *args,
+				    int size);
 
 extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
@@ -648,6 +651,13 @@ static inline int of_phandle_iterator_next(struct of_phandle_iterator *it)
 	return -ENOSYS;
 }
 
+static inline int of_phandle_iterator_args(struct of_phandle_iterator *it,
+					   uint32_t *args,
+					   int size)
+{
+	return 0;
+}
+
 static inline int of_alias_get_id(struct device_node *np, const char *stem)
 {
 	return -ENOSYS;
-- 
1.9.1
