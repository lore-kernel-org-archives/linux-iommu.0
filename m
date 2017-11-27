From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] iommu/tegra: Allow devices to be grouped
Date: Mon, 27 Nov 2017 10:50:54 +0100
Message-ID: <20171127095055.21486-2-thierry.reding@gmail.com>
References: <20171127095055.21486-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171127095055.21486-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Implement the ->device_group() and ->of_xlate() callbacks which are used
in order to group devices. Each group can then share a single domain.

This is implemented primarily in order to achieve the same semantics on
Tegra210 and earlier as on Tegra186 where the Tegra SMMU was replaced by
an ARM SMMU. Users of the IOMMU API can now use the same code to share
domains between devices, whereas previously they used to attach each
device individually.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 124 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 3b6449e2cbf1..8885635d0a3b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -20,6 +20,12 @@
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
 
+struct tegra_smmu_group {
+	struct list_head list;
+	const struct tegra_smmu_group_soc *soc;
+	struct iommu_group *group;
+};
+
 struct tegra_smmu {
 	void __iomem *regs;
 	struct device *dev;
@@ -27,6 +33,8 @@ struct tegra_smmu {
 	struct tegra_mc *mc;
 	const struct tegra_smmu_soc *soc;
 
+	struct list_head groups;
+
 	unsigned long pfn_mask;
 	unsigned long tlb_mask;
 
@@ -703,19 +711,47 @@ static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
 	return mc->smmu;
 }
 
+static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
+				struct of_phandle_args *args)
+{
+	const struct iommu_ops *ops = smmu->iommu.ops;
+	int err;
+
+	err = iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
+	if (err < 0) {
+		dev_err(dev, "failed to initialize fwspec: %d\n", err);
+		return err;
+	}
+
+	err = ops->of_xlate(dev, args);
+	if (err < 0) {
+		dev_err(dev, "failed to parse SW group ID: %d\n", err);
+		iommu_fwspec_free(dev);
+		return err;
+	}
+
+	return 0;
+}
+
 static int tegra_smmu_add_device(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
+	struct tegra_smmu *smmu = NULL;
 	struct iommu_group *group;
 	struct of_phandle_args args;
 	unsigned int index = 0;
+	int err;
 
 	while (of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
 					  &args) == 0) {
-		struct tegra_smmu *smmu;
-
 		smmu = tegra_smmu_find(args.np);
 		if (smmu) {
+			err = tegra_smmu_configure(smmu, dev, &args);
+			of_node_put(args.np);
+
+			if (err < 0)
+				return err;
+
 			/*
 			 * Only a single IOMMU master interface is currently
 			 * supported by the Linux kernel, so abort after the
@@ -728,9 +764,13 @@ static int tegra_smmu_add_device(struct device *dev)
 			break;
 		}
 
+		of_node_put(args.np);
 		index++;
 	}
 
+	if (!smmu)
+		return -ENODEV;
+
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);
@@ -751,6 +791,80 @@ static void tegra_smmu_remove_device(struct device *dev)
 	iommu_group_remove_device(dev);
 }
 
+static const struct tegra_smmu_group_soc *
+tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < smmu->soc->num_groups; i++)
+		for (j = 0; j < smmu->soc->groups[i].num_swgroups; j++)
+			if (smmu->soc->groups[i].swgroups[j] == swgroup)
+				return &smmu->soc->groups[i];
+
+	return NULL;
+}
+
+static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
+						unsigned int swgroup)
+{
+	const struct tegra_smmu_group_soc *soc;
+	struct tegra_smmu_group *group;
+
+	soc = tegra_smmu_find_group(smmu, swgroup);
+	if (!soc)
+		return NULL;
+
+	mutex_lock(&smmu->lock);
+
+	list_for_each_entry(group, &smmu->groups, list)
+		if (group->soc == soc) {
+			mutex_unlock(&smmu->lock);
+			return group->group;
+		}
+
+	group = devm_kzalloc(smmu->dev, sizeof(*group), GFP_KERNEL);
+	if (!group) {
+		mutex_unlock(&smmu->lock);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&group->list);
+	group->soc = soc;
+
+	group->group = iommu_group_alloc();
+	if (!group->group) {
+		devm_kfree(smmu->dev, group);
+		mutex_unlock(&smmu->lock);
+		return NULL;
+	}
+
+	list_add_tail(&group->list, &smmu->groups);
+	mutex_unlock(&smmu->lock);
+
+	return group->group;
+}
+
+static struct iommu_group *tegra_smmu_device_group(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct tegra_smmu *smmu = dev->archdata.iommu;
+	struct iommu_group *group;
+
+	group = tegra_smmu_group_get(smmu, fwspec->ids[0]);
+	if (!group)
+		group = generic_device_group(dev);
+
+	return group;
+}
+
+static int tegra_smmu_of_xlate(struct device *dev,
+			       struct of_phandle_args *args)
+{
+	u32 id = args->args[0];
+
+	return iommu_fwspec_add_ids(dev, &id, 1);
+}
+
 static const struct iommu_ops tegra_smmu_ops = {
 	.capable = tegra_smmu_capable,
 	.domain_alloc = tegra_smmu_domain_alloc,
@@ -759,12 +873,12 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.detach_dev = tegra_smmu_detach_dev,
 	.add_device = tegra_smmu_add_device,
 	.remove_device = tegra_smmu_remove_device,
-	.device_group = generic_device_group,
+	.device_group = tegra_smmu_device_group,
 	.map = tegra_smmu_map,
 	.unmap = tegra_smmu_unmap,
 	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = tegra_smmu_iova_to_phys,
-
+	.of_xlate = tegra_smmu_of_xlate,
 	.pgsize_bitmap = SZ_4K,
 };
 
@@ -913,6 +1027,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	if (!smmu->asids)
 		return ERR_PTR(-ENOMEM);
 
+	INIT_LIST_HEAD(&smmu->groups);
 	mutex_init(&smmu->lock);
 
 	smmu->regs = mc->regs;
@@ -954,6 +1069,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 		return ERR_PTR(err);
 
 	iommu_device_set_ops(&smmu->iommu, &tegra_smmu_ops);
+	iommu_device_set_fwnode(&smmu->iommu, dev->fwnode);
 
 	err = iommu_device_register(&smmu->iommu);
 	if (err) {
-- 
2.15.0
