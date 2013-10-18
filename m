From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 18 Oct 2013 13:26:42 +0300
Message-ID: <1382092020-13170-2-git-send-email-hdoyu@nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

To prevent of_platform_populate() from trying to populate duplicate
devices if a device has been already populated.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/of/platform.c | 6 ++++++
 include/linux/of.h    | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9b439ac..994cea4 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -208,6 +208,11 @@ static struct platform_device *of_platform_device_create_pdata(
 	if (!of_device_is_available(np))
 		return NULL;
 
+	if (np->dev) {
+		dev_info(np->dev, "Already populated\n");
+		return to_platform_device(np->dev);
+	}
+
 	dev = of_device_alloc(np, bus_id, parent);
 	if (!dev)
 		return NULL;
@@ -232,6 +237,7 @@ static struct platform_device *of_platform_device_create_pdata(
 		return NULL;
 	}
 
+	np->dev = &dev->dev;
 	return dev;
 }
 
diff --git a/include/linux/of.h b/include/linux/of.h
index f95aee3..638a88a 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -60,6 +60,7 @@ struct device_node {
 	struct	kref kref;
 	unsigned long _flags;
 	void	*data;
+	struct device *dev;		/* Set only after populated */
 #if defined(CONFIG_SPARC)
 	const char *path_component_name;
 	unsigned int unique_id;
-- 
1.8.1.5
