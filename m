From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/6] of: Introduce of_for_each_phandle() helper macro
Date: Tue, 22 Mar 2016 18:58:27 +0100
Message-ID: <1458669509-7178-5-git-send-email-joro@8bytes.org>
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

With this macro any user can easily iterate over a list of
phandles. The patch also converts __of_parse_phandle_with_args()
to make use of the macro.

The of_count_phandle_with_args() function is not converted,
because the macro hides the return value of of_phandle_iterator_init(),
which is needed in there.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/of/base.c  | 7 +------
 include/linux/of.h | 6 ++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 15593cd..471d3d9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1542,13 +1542,8 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 	struct of_phandle_iterator it;
 	int rc, cur_index = 0;
 
-	rc = of_phandle_iterator_init(&it, np, list_name,
-				      cells_name, cell_count);
-	if (rc)
-		return rc;
-
 	/* Loop over the phandles until all the requested entry is found */
-	while ((rc = of_phandle_iterator_next(&it)) == 0) {
+	of_for_each_phandle(&it, rc, np, list_name, cells_name, cell_count) {
 		/*
 		 * All of the error cases bail out of the loop, so at
 		 * this point, the parsing is successful. If the requested
diff --git a/include/linux/of.h b/include/linux/of.h
index d94388b0..05e38ed 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -908,6 +908,12 @@ static inline int of_property_read_s32(const struct device_node *np,
 	return of_property_read_u32(np, propname, (u32*) out_value);
 }
 
+#define of_for_each_phandle(it, err, np, ln, cn, cc)			\
+	for (of_phandle_iterator_init((it), (np), (ln), (cn), (cc)),	\
+	     err = of_phandle_iterator_next(it);			\
+	     err == 0;							\
+	     err = of_phandle_iterator_next(it))
+
 #define of_property_for_each_u32(np, propname, prop, p, u)	\
 	for (prop = of_find_property(np, propname, NULL),	\
 		p = of_prop_next_u32(prop, NULL, &u);		\
-- 
1.9.1
