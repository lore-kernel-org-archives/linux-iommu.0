From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv4 5/7] iommu/tegra: smmu: Support "mmu-masters" binding
Date: Mon, 11 Nov 2013 10:31:56 +0200
Message-ID: <1384158718-4756-6-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384158718-4756-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Follow arm,smmu's "mmu-masters" binding.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Update:
Newly added for v4. In v3, I used "nvidia,swgroups" and
"nvidia,memory-clients" bindings.
---
 .../bindings/iommu/nvidia,tegra30-smmu.txt         |  28 ++++-
 drivers/iommu/tegra-smmu.c                         | 138 +++++++++++++++++----
 2 files changed, 141 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
index 89fb543..51884e9 100644
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
@@ -8,9 +8,16 @@ Required properties:
 - nvidia,#asids : # of ASIDs
 - dma-window : IOVA start address and length.
 - nvidia,ahb : phandle to the ahb bus connected to SMMU.
+- mmu-masters   : A list of phandles to device nodes representing bus
+                  masters for which the SMMU can provide a translation
+                  and their corresponding StreamIDs (see example below).
+                  Each device node linked from this list must have a
+                  "#stream-id-cells" property, indicating the number of
+                  StreamIDs(swgroup ID) associated with it, which is defined
+		  in "include/dt-bindings/memory/tegra-swgroup.h".
 
 Example:
-	smmu {
+	iommu {
 		compatible = "nvidia,tegra30-smmu";
 		reg = <0x7000f010 0x02c
 		       0x7000f1f0 0x010
@@ -18,4 +25,23 @@ Example:
 		nvidia,#asids = <4>;		/* # of ASIDs */
 		dma-window = <0 0x40000000>;	/* IOVA start & length */
 		nvidia,ahb = <&ahb>;
+
+		mmu-masters = <&host1x TEGRA_SWGROUP_HC>,
+			      <&mpe TEGRA_SWGROUP_MPE>,
+			      <&vi TEGRA_SWGROUP_VI>,
+			      <&epp TEGRA_SWGROUP_EPP>,
+			      <&isp TEGRA_SWGROUP_ISP>,
+			      <&gr2d TEGRA_SWGROUP_G2>,
+			      <&gr3d TEGRA_SWGROUP_NV TEGRA_SWGROUP_NV2>,
+			      <&dc TEGRA_SWGROUP_DC>,
+			      <&dcb TEGRA_SWGROUP_DCB>,
+			      <&uarta TEGRA_SWGROUP_PPCS>,
+			      <&uartb TEGRA_SWGROUP_PPCS>,
+			      <&uartc TEGRA_SWGROUP_PPCS>,
+			      <&uartd TEGRA_SWGROUP_PPCS>,
+			      <&uarte TEGRA_SWGROUP_PPCS>,
+			      <&sdhci0 TEGRA_SWGROUP_PPCS>,
+			      <&sdhci1 TEGRA_SWGROUP_PPCS>,
+			      <&sdhci2 TEGRA_SWGROUP_PPCS>,
+			      <&sdhci3 TEGRA_SWGROUP_PPCS>;
 	};
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 67252e1..ab198ce 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -206,10 +206,12 @@ enum {
  * Per client for address space
  */
 struct smmu_client {
+	struct device_node	*of_node;
+	struct rb_node		node;
 	struct device		*dev;
 	struct list_head	list;
 	struct smmu_as		*as;
-	u32			hwgrp;
+	u64			hwgrp;
 };
 
 /*
@@ -249,6 +251,7 @@ struct smmu_device {
 	spinlock_t	lock;
 	char		*name;
 	struct device	*dev;
+	struct rb_root	clients;
 	struct page *avp_vector_page;	/* dummy page shared by all AS's */
 
 	/*
@@ -326,23 +329,22 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
  */
 #define FLUSH_SMMU_REGS(smmu)	smmu_read(smmu, SMMU_CONFIG)
 
-#define smmu_client_hwgrp(c) (u32)((c)->dev->platform_data)
-
 static int __smmu_client_set_hwgrp(struct smmu_client *c,
-				   unsigned long map, int on)
+				   u64 map, int on)
 {
 	int i;
 	struct smmu_as *as = c->as;
 	u32 val, offs, mask = SMMU_ASID_ENABLE(as->asid);
 	struct smmu_device *smmu = as->smmu;
+	unsigned long *bitmap = (unsigned long *)&map;
 
 	WARN_ON(!on && map);
 	if (on && !map)
 		return -EINVAL;
 	if (!on)
-		map = smmu_client_hwgrp(c);
+		map = c->hwgrp;
 
-	for_each_set_bit(i, &map, HWGRP_COUNT) {
+	for_each_set_bit(i, bitmap, TEGRA_SWGROUP_MAX) {
 		offs = HWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
@@ -360,7 +362,7 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 	return 0;
 
 err_hw_busy:
-	for_each_set_bit(i, &map, HWGRP_COUNT) {
+	for_each_set_bit(i, bitmap, TEGRA_SWGROUP_MAX) {
 		offs = HWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		val &= ~mask;
@@ -732,27 +734,26 @@ static int smmu_iommu_domain_has_cap(struct iommu_domain *domain,
 	return 0;
 }
 
+static struct smmu_client *find_smmu_client(struct smmu_device *smmu,
+					    struct device_node *dev_node);
+
 static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	struct smmu_as *as = domain->priv;
 	struct smmu_device *smmu = as->smmu;
 	struct smmu_client *client, *c;
-	u32 map;
 	int err;
 
-	client = devm_kzalloc(smmu->dev, sizeof(*c), GFP_KERNEL);
+	client = find_smmu_client(smmu, dev->of_node);
 	if (!client)
-		return -ENOMEM;
-	client->dev = dev;
-	client->as = as;
-	map = (unsigned long)dev->platform_data;
-	if (!map)
 		return -EINVAL;
 
-	err = smmu_client_enable_hwgrp(client, map);
+	client->dev = dev;
+	client->as = as;
+	err = smmu_client_enable_hwgrp(client, client->hwgrp);
 	if (err)
-		goto err_hwgrp;
+		return -EINVAL;
 
 	spin_lock(&as->client_lock);
 	list_for_each_entry(c, &as->client, list) {
@@ -770,7 +771,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	 * Reserve "page zero" for AVP vectors using a common dummy
 	 * page.
 	 */
-	if (map & TEGRA_SWGROUP_BIT(AVPC)) {
+	if (client->hwgrp & TEGRA_SWGROUP_BIT(AVPC)) {
 		struct page *page;
 
 		page = as->smmu->avp_vector_page;
@@ -785,8 +786,6 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 err_client:
 	smmu_client_disable_hwgrp(client);
 	spin_unlock(&as->client_lock);
-err_hwgrp:
-	devm_kfree(smmu->dev, client);
 	return err;
 }
 
@@ -803,7 +802,6 @@ static void smmu_iommu_detach_dev(struct iommu_domain *domain,
 		if (c->dev == dev) {
 			smmu_client_disable_hwgrp(c);
 			list_del(&c->list);
-			devm_kfree(smmu->dev, c);
 			c->as = NULL;
 			dev_dbg(smmu->dev,
 				"%s is detached\n", dev_name(c->dev));
@@ -907,11 +905,14 @@ enum {
 static int smmu_iommu_add_device(struct device *dev)
 {
 	int err = -EPROBE_DEFER;
-	u64 swgroups;
 	struct dma_iommu_mapping *map = NULL;
+	struct smmu_client *client;
+
+	client = find_smmu_client(smmu_handle, dev->of_node);
+	if (!client)
+		return -EINVAL;
 
-	swgroups = smmu_of_get_memory_client(dev);
-	switch (swgroups) {
+	switch (client->hwgrp) {
 	case TEGRA_SWGROUP_BIT(PPCS):
 		map = smmu_handle->map[SYSTEM_PROTECTED];
 		break;
@@ -924,7 +925,7 @@ static int smmu_iommu_add_device(struct device *dev)
 		err = arm_iommu_attach_device(dev, map);
 
 	pr_debug("swgroups=%016llx map=%p err=%d %s\n",
-		 swgroups, map, err, dev_name(dev));
+		 client->hwgrp, map, err, dev_name(dev));
 
 	return err;
 }
@@ -1151,6 +1152,77 @@ static void tegra_smmu_create_default_map(struct smmu_device *smmu)
 	}
 }
 
+static struct smmu_client *find_smmu_client(struct smmu_device *smmu,
+					    struct device_node *dev_node)
+{
+	struct rb_node *node = smmu->clients.rb_node;
+
+	while (node) {
+		struct smmu_client *client;
+
+		client = container_of(node, struct smmu_client, node);
+		if (dev_node < client->of_node)
+			node = node->rb_left;
+		else if (dev_node > client->of_node)
+			node = node->rb_right;
+		else
+			return client;
+	}
+
+	return NULL;
+}
+
+static int insert_smmu_client(struct smmu_device *smmu,
+			      struct smmu_client *client)
+{
+	struct rb_node **new, *parent;
+
+	new = &smmu->clients.rb_node;
+	parent = NULL;
+	while (*new) {
+		struct smmu_client *this;
+		this = container_of(*new, struct smmu_client, node);
+
+		parent = *new;
+		if (client->of_node < this->of_node)
+			new = &((*new)->rb_left);
+		else if (client->of_node > this->of_node)
+			new = &((*new)->rb_right);
+		else
+			return -EEXIST;
+	}
+
+	rb_link_node(&client->node, parent, new);
+	rb_insert_color(&client->node, &smmu->clients);
+	return 0;
+}
+
+static int register_smmu_client(struct smmu_device *smmu,
+				struct device *dev,
+				struct of_phandle_args *args)
+{
+	struct smmu_client *client;
+	int i;
+
+	client = find_smmu_client(smmu, args->np);
+	if (client) {
+		dev_err(dev,
+			"rejecting multiple registrations for client device %s\n",
+			args->np->full_name);
+		return -EBUSY;
+	}
+
+	client = devm_kzalloc(dev, sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return -ENOMEM;
+
+	client->of_node = args->np;
+	for (i = 0; i < args->args_count; i++)
+		client->hwgrp |= 1ULL << args->args[i];
+
+	return insert_smmu_client(smmu, client);
+}
+
 static int tegra_smmu_probe(struct platform_device *pdev)
 {
 	struct smmu_device *smmu;
@@ -1158,6 +1230,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	int i, asids, err = 0;
 	dma_addr_t uninitialized_var(base);
 	size_t bytes, uninitialized_var(size);
+	struct of_phandle_args args;
 
 	if (smmu_handle)
 		return -EIO;
@@ -1238,6 +1311,23 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 		return err;
 	platform_set_drvdata(pdev, smmu);
 
+	i = 0;
+	smmu->clients = RB_ROOT;
+	while (true) {
+		err = of_parse_phandle_with_args(dev->of_node, "mmu-masters",
+						 "#stream-id-cells", i, &args);
+		if (err)
+			break;
+
+		err = register_smmu_client(smmu, dev, &args);
+		if (err) {
+			dev_err(dev, "failed to add client %s\n",
+				args.np->full_name);
+		}
+
+		i++;
+	}
+
 	smmu->avp_vector_page = alloc_page(GFP_KERNEL);
 	if (!smmu->avp_vector_page)
 		return -ENOMEM;
-- 
1.8.1.5
