From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 01/22] [HACK] of: dev_node has struct device pointer
Date: Fri, 5 Jul 2013 13:44:36 +0300
Message-ID: <1373021097-32420-2-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

To prevent of_platform_populate() from trying to populate duplicate
devices if a device has been already populated.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Need to take care of early_platform_devices, or alternative solution.
---
 drivers/of/base.c     |   23 +++++++++++++++++++++++
 drivers/of/platform.c |    8 ++++++++
 include/linux/of.h    |   16 ++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5c54279..99062dd 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -230,6 +230,29 @@ const void *of_get_property(const struct device_node *np, const char *name,
 }
 EXPORT_SYMBOL(of_get_property);
 
+struct device *of_get_device(const struct device_node *node)
+{
+	struct device *dev;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+	dev = node->dev;
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	return dev;
+}
+EXPORT_SYMBOL(of_get_device);
+
+void of_set_device(struct device_node *node, struct device *dev)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+	node->dev = dev;
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+}
+EXPORT_SYMBOL(of_set_device);
+
 /** Checks if the given "compat" string matches one of the strings in
  * the device's "compatible" property
  */
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index e0a6514..a8f6b09 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -203,10 +203,17 @@ struct platform_device *of_platform_device_create_pdata(
 					struct device *parent)
 {
 	struct platform_device *dev;
+	struct device *tmp;
 
 	if (!of_device_is_available(np))
 		return NULL;
 
+	tmp = of_get_device(np);
+	if (tmp) {
+		dev_info(tmp, "Already populated\n");
+		return to_platform_device(tmp);
+	}
+
 	dev = of_device_alloc(np, bus_id, parent);
 	if (!dev)
 		return NULL;
@@ -228,6 +235,7 @@ struct platform_device *of_platform_device_create_pdata(
 		return NULL;
 	}
 
+	of_set_device(np, &dev->dev);
 	return dev;
 }
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 1fd08ca..b548522 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -60,6 +60,9 @@ struct device_node {
 	struct	kref kref;
 	unsigned long _flags;
 	void	*data;
+
+	struct device *dev;		/* Set only after populated */
+
 #if defined(CONFIG_SPARC)
 	const char *path_component_name;
 	unsigned int unique_id;
@@ -268,6 +271,8 @@ extern const void *of_get_property(const struct device_node *node,
 				int *lenp);
 #define for_each_property_of_node(dn, pp) \
 	for (pp = dn->properties; pp != NULL; pp = pp->next)
+extern struct device *of_get_device(const struct device_node *node);
+extern void of_set_device(struct device_node *node, struct device *dev);
 
 extern int of_n_addr_cells(struct device_node *np);
 extern int of_n_size_cells(struct device_node *np);
@@ -459,6 +464,17 @@ static inline const void *of_get_property(const struct device_node *node,
 	return NULL;
 }
 
+static inline struct device *of_get_device(const struct device_node *node)
+{
+	return NULL;
+}
+
+static inline void of_set_device(const struct device_node *node,
+				 struct device *dev);
+{
+	return -ENOSYS;
+}
+
 static inline int of_property_read_u64(const struct device_node *np,
 				       const char *propname, u64 *out_value)
 {
-- 
1.7.9.5
