From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/6] iommu/tegra: smmu: Support variable length of swgroups bitmap
Date: Tue, 15 Jan 2013 10:17:25 +0200
Message-ID: <1358237848-968-3-git-send-email-hdoyu@nvidia.com>
References: <1358237848-968-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358237848-968-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The definition of swgroups can grow in the future SoCs. This patch
allows to have longer bitmaps for that.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   67 ++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e83797b..e80312c 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -178,10 +178,10 @@ enum {
 
 #define NUM_SMMU_REG_BANKS	3
 
-#define smmu_client_enable_swgrp(c, m)	smmu_client_set_swgrp(c, m, 1)
-#define smmu_client_disable_swgrp(c)	smmu_client_set_swgrp(c, 0, 0)
-#define __smmu_client_enable_swgrp(c, m) __smmu_client_set_swgrp(c, m, 1)
-#define __smmu_client_disable_swgrp(c)	__smmu_client_set_swgrp(c, 0, 0)
+#define smmu_client_enable_swgrp(c)	smmu_client_set_swgrp(c, 1)
+#define smmu_client_disable_swgrp(c)	smmu_client_set_swgrp(c, 0)
+#define __smmu_client_enable_swgrp(c) __smmu_client_set_swgrp(c, 1)
+#define __smmu_client_disable_swgrp(c)	__smmu_client_set_swgrp(c, 0)
 
 #define SWGRP_ASID_REG(id) (4 * (id) + SMMU_SWGRP_ASID_BASE)
 
@@ -241,7 +241,9 @@ struct smmu_device {
 	struct smmu_debugfs_info *debugfs_info;
 
 	struct device_node *ahb;
-	u32 swgrp;
+
+	unsigned long *swgrp;		/* software client group bitmap */
+	size_t swgrp_bits;		/* size of bitmap in bits */
 
 	int		num_as;
 	struct smmu_as	as[0];		/* Run-time allocated array */
@@ -304,19 +306,14 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
  */
 #define FLUSH_SMMU_REGS(smmu)	smmu_read(smmu, SMMU_CONFIG)
 
-static int __smmu_client_set_swgrp(struct smmu_client *c,
-				   unsigned long map, int on)
+static int __smmu_client_set_swgrp(struct smmu_client *c, int on)
 {
 	int i;
 	struct smmu_as *as = c->as;
 	u32 val, offs, mask = SMMU_ASID_ENABLE(as->asid);
 	struct smmu_device *smmu = as->smmu;
 
-	WARN_ON(!on && map);
-	if (on && !map)
-		return -EINVAL;
-
-	for_each_set_bit(i, &map, BITS_PER_LONG) {
+	for_each_set_bit(i, smmu->swgrp, smmu->swgrp_bits) {
 		offs = SWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
@@ -333,7 +330,7 @@ static int __smmu_client_set_swgrp(struct smmu_client *c,
 	return 0;
 
 err_hw_busy:
-	for_each_set_bit(i, &map, BITS_PER_LONG) {
+	for_each_set_bit(i, smmu->swgrp, smmu->swgrp_bits) {
 		offs = SWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		val &= ~mask;
@@ -342,7 +339,7 @@ err_hw_busy:
 	return -EBUSY;
 }
 
-static int smmu_client_set_swgrp(struct smmu_client *c, u32 map, int on)
+static int smmu_client_set_swgrp(struct smmu_client *c, int on)
 {
 	u32 val;
 	unsigned long flags;
@@ -350,7 +347,7 @@ static int smmu_client_set_swgrp(struct smmu_client *c, u32 map, int on)
 	struct smmu_device *smmu = as->smmu;
 
 	spin_lock_irqsave(&smmu->lock, flags);
-	val = __smmu_client_set_swgrp(c, map, on);
+	val = __smmu_client_set_swgrp(c, on);
 	spin_unlock_irqrestore(&smmu->lock, flags);
 	return val;
 }
@@ -390,7 +387,7 @@ static int smmu_setup_regs(struct smmu_device *smmu)
 		smmu_write(smmu, val, SMMU_PTB_DATA);
 
 		list_for_each_entry(c, &as->client, list)
-			__smmu_client_set_swgrp(c, smmu->swgrp, 1);
+			__smmu_client_set_swgrp(c, 1);
 	}
 
 	smmu_write(smmu, smmu->translation_enable_0, SMMU_TRANSLATION_ENABLE_0);
@@ -710,7 +707,6 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	struct smmu_as *as = domain->priv;
 	struct smmu_device *smmu = as->smmu;
 	struct smmu_client *client, *c;
-	u32 map;
 	int err;
 
 	client = devm_kzalloc(smmu->dev, sizeof(*c), GFP_KERNEL);
@@ -718,11 +714,8 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 		return -ENOMEM;
 	client->dev = dev;
 	client->as = as;
-	map = smmu->swgrp;
-	if (!map)
-		return -EINVAL;
 
-	err = smmu_client_enable_swgrp(client, map);
+	err = smmu_client_enable_swgrp(client);
 	if (err)
 		goto err_swgrp;
 
@@ -742,7 +735,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	 * Reserve "page zero" for AVP vectors using a common dummy
 	 * page.
 	 */
-	if (map & SWG_AVPC) {
+	if (test_bit(SWG_AVPC, smmu->swgrp)) {
 		struct page *page;
 
 		page = as->smmu->avp_vector_page;
@@ -1071,6 +1064,27 @@ static int tegra_smmu_resume(struct device *dev)
 	return err;
 }
 
+static int tegra_smmu_of_get_swgrp(struct smmu_device *smmu)
+{
+	size_t bytes, num;
+	const char *propname = "nvidia,swgroups";
+	const __be32 *prop;
+
+	prop = of_get_property(smmu->dev->of_node, propname, &bytes);
+	if (!prop || !bytes)
+		return -EINVAL;
+
+	num = BITS_TO_LONGS(bytes * BITS_PER_BYTE);
+	bytes =  num * sizeof(unsigned long);
+	smmu->swgrp_bits = bytes * BITS_PER_BYTE;
+	smmu->swgrp = devm_kzalloc(smmu->dev, bytes, GFP_KERNEL);
+	if (!smmu->swgrp)
+		return -ENOMEM;
+
+	return of_property_read_u32_array(smmu->dev->of_node, propname,
+					  (u32 *)smmu->swgrp, num);
+}
+
 static int tegra_smmu_probe(struct platform_device *pdev)
 {
 	struct smmu_device *smmu;
@@ -1078,16 +1092,12 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	int i, asids, err = 0;
 	dma_addr_t uninitialized_var(base);
 	size_t bytes, uninitialized_var(size);
-	u32 swgrp;
 
 	if (smmu_handle)
 		return -EIO;
 
 	BUILD_BUG_ON(PAGE_SHIFT != SMMU_PAGE_SHIFT);
 
-	if (of_property_read_u32(dev->of_node, "nvidia,swgroups", &swgrp))
-		return -ENODEV;
-
 	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
 		return -ENODEV;
 
@@ -1126,7 +1136,6 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 
 	smmu->dev = dev;
 	smmu->num_as = asids;
-	smmu->swgrp = swgrp;
 	smmu->iovmm_base = base;
 	smmu->page_count = size;
 
@@ -1135,6 +1144,10 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	smmu->translation_enable_2 = ~0;
 	smmu->asid_security = 0;
 
+	err = tegra_smmu_of_get_swgrp(smmu);
+	if (!err)
+		return -ENODEV;
+
 	for (i = 0; i < smmu->num_as; i++) {
 		struct smmu_as *as = &smmu->as[i];
 
-- 
1.7.9.5
