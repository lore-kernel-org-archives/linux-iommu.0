From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv4 6/7] iommu/tegra: smmu: Rename hwgrp -> swgroups
Date: Mon, 11 Nov 2013 10:31:57 +0200
Message-ID: <1384158718-4756-7-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384158718-4756-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Use the correct term for SWGROUP related variables and macros.

The term "swgroup" is the collection of "memory client". A "memory
client" usually represents a HardWare Accelerator(HWA) like
GPU. Sometimes a strut device can belong to multiple "swgroup" so that
"swgroup's'" is used here. This "swgroups" is the term used in Tegra
TRM. Rename along with TRM.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Update:
New for v4
---
 drivers/iommu/tegra-smmu.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index ab198ce..904c36a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -193,14 +193,12 @@ enum {
 
 #define NUM_SMMU_REG_BANKS	3
 
-#define smmu_client_enable_hwgrp(c, m)	smmu_client_set_hwgrp(c, m, 1)
-#define smmu_client_disable_hwgrp(c)	smmu_client_set_hwgrp(c, 0, 0)
-#define __smmu_client_enable_hwgrp(c, m) __smmu_client_set_hwgrp(c, m, 1)
-#define __smmu_client_disable_hwgrp(c)	__smmu_client_set_hwgrp(c, 0, 0)
+#define smmu_client_enable_swgroups(c, m) smmu_client_set_swgroups(c, m, 1)
+#define smmu_client_disable_swgroups(c)	smmu_client_set_swgroups(c, 0, 0)
+#define __smmu_client_enable_swgroups(c, m) __smmu_client_set_swgroups(c, m, 1)
+#define __smmu_client_disable_swgroups(c) __smmu_client_set_swgroups(c, 0, 0)
 
-#define HWGRP_INIT(client) [HWGRP_##client] = SMMU_##client##_ASID
-
-#define HWGRP_ASID_REG(x) ((x) * sizeof(u32) + SMMU_AFI_ASID)
+#define SWGROUP_ASID_REG(x) ((x) * sizeof(u32) + SMMU_AFI_ASID)
 
 /*
  * Per client for address space
@@ -211,7 +209,7 @@ struct smmu_client {
 	struct device		*dev;
 	struct list_head	list;
 	struct smmu_as		*as;
-	u64			hwgrp;
+	u64			swgroups;
 };
 
 /*
@@ -329,7 +327,7 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
  */
 #define FLUSH_SMMU_REGS(smmu)	smmu_read(smmu, SMMU_CONFIG)
 
-static int __smmu_client_set_hwgrp(struct smmu_client *c,
+static int __smmu_client_set_swgroups(struct smmu_client *c,
 				   u64 map, int on)
 {
 	int i;
@@ -342,10 +340,10 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 	if (on && !map)
 		return -EINVAL;
 	if (!on)
-		map = c->hwgrp;
+		map = c->swgroups;
 
 	for_each_set_bit(i, bitmap, TEGRA_SWGROUP_MAX) {
-		offs = HWGRP_ASID_REG(i);
+		offs = SWGROUP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
 			if (WARN_ON(val & mask))
@@ -358,12 +356,12 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 		smmu_write(smmu, val, offs);
 	}
 	FLUSH_SMMU_REGS(smmu);
-	c->hwgrp = map;
+	c->swgroups = map;
 	return 0;
 
 err_hw_busy:
 	for_each_set_bit(i, bitmap, TEGRA_SWGROUP_MAX) {
-		offs = HWGRP_ASID_REG(i);
+		offs = SWGROUP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		val &= ~mask;
 		smmu_write(smmu, val, offs);
@@ -371,7 +369,7 @@ err_hw_busy:
 	return -EBUSY;
 }
 
-static int smmu_client_set_hwgrp(struct smmu_client *c, u32 map, int on)
+static int smmu_client_set_swgroups(struct smmu_client *c, u32 map, int on)
 {
 	u32 val;
 	unsigned long flags;
@@ -379,7 +377,7 @@ static int smmu_client_set_hwgrp(struct smmu_client *c, u32 map, int on)
 	struct smmu_device *smmu = as->smmu;
 
 	spin_lock_irqsave(&smmu->lock, flags);
-	val = __smmu_client_set_hwgrp(c, map, on);
+	val = __smmu_client_set_swgroups(c, map, on);
 	spin_unlock_irqrestore(&smmu->lock, flags);
 	return val;
 }
@@ -419,7 +417,7 @@ static int smmu_setup_regs(struct smmu_device *smmu)
 		smmu_write(smmu, val, SMMU_PTB_DATA);
 
 		list_for_each_entry(c, &as->client, list)
-			__smmu_client_set_hwgrp(c, c->hwgrp, 1);
+			__smmu_client_set_swgroups(c, c->swgroups, 1);
 	}
 
 	smmu_write(smmu, smmu->translation_enable_0, SMMU_TRANSLATION_ENABLE_0);
@@ -751,7 +749,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 
 	client->dev = dev;
 	client->as = as;
-	err = smmu_client_enable_hwgrp(client, client->hwgrp);
+	err = smmu_client_enable_swgroups(client, client->swgroups);
 	if (err)
 		return -EINVAL;
 
@@ -771,7 +769,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	 * Reserve "page zero" for AVP vectors using a common dummy
 	 * page.
 	 */
-	if (client->hwgrp & TEGRA_SWGROUP_BIT(AVPC)) {
+	if (client->swgroups & TEGRA_SWGROUP_BIT(AVPC)) {
 		struct page *page;
 
 		page = as->smmu->avp_vector_page;
@@ -784,7 +782,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	return 0;
 
 err_client:
-	smmu_client_disable_hwgrp(client);
+	smmu_client_disable_swgroups(client);
 	spin_unlock(&as->client_lock);
 	return err;
 }
@@ -800,7 +798,7 @@ static void smmu_iommu_detach_dev(struct iommu_domain *domain,
 
 	list_for_each_entry(c, &as->client, list) {
 		if (c->dev == dev) {
-			smmu_client_disable_hwgrp(c);
+			smmu_client_disable_swgroups(c);
 			list_del(&c->list);
 			c->as = NULL;
 			dev_dbg(smmu->dev,
@@ -912,7 +910,7 @@ static int smmu_iommu_add_device(struct device *dev)
 	if (!client)
 		return -EINVAL;
 
-	switch (client->hwgrp) {
+	switch (client->swgroups) {
 	case TEGRA_SWGROUP_BIT(PPCS):
 		map = smmu_handle->map[SYSTEM_PROTECTED];
 		break;
@@ -925,7 +923,7 @@ static int smmu_iommu_add_device(struct device *dev)
 		err = arm_iommu_attach_device(dev, map);
 
 	pr_debug("swgroups=%016llx map=%p err=%d %s\n",
-		 client->hwgrp, map, err, dev_name(dev));
+		 client->swgroups, map, err, dev_name(dev));
 
 	return err;
 }
@@ -1218,7 +1216,7 @@ static int register_smmu_client(struct smmu_device *smmu,
 
 	client->of_node = args->np;
 	for (i = 0; i < args->args_count; i++)
-		client->hwgrp |= 1ULL << args->args[i];
+		client->swgroups |= 1ULL << args->args[i];
 
 	return insert_smmu_client(smmu, client);
 }
-- 
1.8.1.5
