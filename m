From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv6+ 01/13] of: introduce
	of_property_for_earch_phandle_with_args()
Date: Wed, 11 Dec 2013 14:33:38 +0100
Message-ID: <20131211.153338.2186623380643957232.hdoyu@nvidia.com>
References: <1385041249-7705-1-git-send-email-hdoyu@nvidia.com><528E577C.2050506@wwwdotorg.org><20131211132845.5461FC4061A@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131211132845.5461FC4061A-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Grant,

Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote @ Wed, 11 Dec 2013 14:28:45 +0100:

> On Thu, 21 Nov 2013 11:57:00 -0700, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> > On 11/21/2013 10:17 AM, Hiroshi Doyu wrote:
> > > Iterating over a property containing a list of phandles with arguments
> > > is a common operation for device drivers. This patch adds a new
> > > of_property_for_each_phandle_with_args() macro to make the iteration
> > > simpler.
> > > 
> > > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > ---
> > > v6+:
> > > Use the description, which Grant Likely proposed, to be full enough
> > > that a future reader can figure out why a patch was written.
> > >   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/007062.html
...

> That's right, I forgot I said that. Yes please fix the implementation.

Here's the latest. I'll include this with the next v7 series.

Can I get your Acked-by with this?

--8<----

>From 8f7c0404aa68f0e8dbe0babc240590f6528ecc1f Mon Sep 17 00:00:00 2001
From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Fri, 15 Nov 2013 10:52:53 +0200
Subject: [PATCH] of: introduce of_property_for_each_phandle_with_args()

Iterating over a property containing a list of phandles with arguments
is a common operation for device drivers. This patch adds a new
of_property_for_each_phandle_with_args() macro to make the iteration
simpler.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
