From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: [RFC v2 3/5] i2c: Add of_i2c_get_adapter() function
Date: Wed, 25 Apr 2012 11:45:00 +0200
Message-ID: <1335347102-14905-4-git-send-email-thierry.reding@avionic-design.de>
References: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335347102-14905-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This function resolves an OF device node to an I2C adapter registered
with the I2C core.

Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   34 ++++++++++++++++++++++++++++++++++
 include/linux/of_i2c.h |    7 +++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index feb7dc3..e73b044 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1627,6 +1627,40 @@ void i2c_put_adapter(struct i2c_adapter *adap)
 }
 EXPORT_SYMBOL(i2c_put_adapter);
 
+#ifdef CONFIG_OF
+static int of_i2c_match_node(int id, void *p, void *data)
+{
+	struct device_node *node = data;
+	struct i2c_adapter *adapter = p;
+
+	if (adapter->dev.of_node == node)
+		return id;
+
+	return 0;
+}
+
+struct i2c_adapter *of_i2c_get_adapter(struct device_node *node)
+{
+	struct i2c_adapter *adapter = NULL;
+	int err;
+
+	mutex_lock(&core_lock);
+
+	err = idr_for_each(&i2c_adapter_idr, of_i2c_match_node, node);
+	if (err < 0)
+		goto out;
+
+	adapter = idr_find(&i2c_adapter_idr, err);
+	if (adapter && !try_module_get(adapter->owner))
+		adapter = NULL;
+
+out:
+	mutex_unlock(&core_lock);
+	return adapter;
+}
+EXPORT_SYMBOL(of_i2c_get_adapter);
+#endif
+
 /* The SMBus parts */
 
 #define POLY    (0x1070U << 3)
diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
index 0efe8d4..a35c497 100644
--- a/include/linux/of_i2c.h
+++ b/include/linux/of_i2c.h
@@ -20,11 +20,18 @@ extern void of_i2c_register_devices(struct i2c_adapter *adap);
 /* must call put_device() when done with returned i2c_client device */
 extern struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
 
+extern struct i2c_adapter *of_i2c_get_adapter(struct device_node *node);
+
 #else
 static inline void of_i2c_register_devices(struct i2c_adapter *adap)
 {
 	return;
 }
+
+static inline struct i2c_adapter *of_i2c_get_adapter(struct device_node *node)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF_I2C */
 
 #endif /* __LINUX_OF_I2C_H */
-- 
1.7.10
