From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] iommu/tegra-smmu: Add debugfs support
Date: Fri, 27 Mar 2015 11:07:24 +0100
Message-ID: <1427450847-17719-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Provide clients and swgroups files in debugfs. These files show for
which clients IOMMU translation is enabled and which ASID is associated
with each SWGROUP.

Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 109 +++++++++++++++++++++++++++++++++++++++++++++
 include/soc/tegra/mc.h     |   5 +++
 2 files changed, 114 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 6e134c7c227f..fff45b3d3e57 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -6,6 +6,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
@@ -28,6 +29,8 @@ struct tegra_smmu {
 	struct mutex lock;
 
 	struct list_head list;
+
+	struct dentry *debugfs;
 };
 
 struct tegra_smmu_as {
@@ -662,6 +665,103 @@ static void tegra_smmu_ahb_enable(void)
 	}
 }
 
+static int tegra_smmu_swgroups_show(struct seq_file *s, void *data)
+{
+	struct tegra_smmu *smmu = s->private;
+	unsigned int i;
+	u32 value;
+
+	seq_printf(s, "swgroup    enabled  ASID\n");
+	seq_printf(s, "------------------------\n");
+
+	for (i = 0; i < smmu->soc->num_swgroups; i++) {
+		const struct tegra_smmu_swgroup *group = &smmu->soc->swgroups[i];
+		const char *status;
+		unsigned int asid;
+
+		value = smmu_readl(smmu, group->reg);
+
+		if (value & SMMU_ASID_ENABLE)
+			status = "yes";
+		else
+			status = "no";
+
+		asid = value & SMMU_ASID_MASK;
+
+		seq_printf(s, "%-9s  %-7s  %#04x\n", group->name, status,
+			   asid);
+	}
+
+	return 0;
+}
+
+static int tegra_smmu_swgroups_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, tegra_smmu_swgroups_show, inode->i_private);
+}
+
+static const struct file_operations tegra_smmu_swgroups_fops = {
+	.open = tegra_smmu_swgroups_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int tegra_smmu_clients_show(struct seq_file *s, void *data)
+{
+	struct tegra_smmu *smmu = s->private;
+	unsigned int i;
+	u32 value;
+
+	seq_printf(s, "client       enabled\n");
+	seq_printf(s, "--------------------\n");
+
+	for (i = 0; i < smmu->soc->num_clients; i++) {
+		const struct tegra_mc_client *client = &smmu->soc->clients[i];
+		const char *status;
+
+		value = smmu_readl(smmu, client->smmu.reg);
+
+		if (value & BIT(client->smmu.bit))
+			status = "yes";
+		else
+			status = "no";
+
+		seq_printf(s, "%-12s %s\n", client->name, status);
+	}
+
+	return 0;
+}
+
+static int tegra_smmu_clients_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, tegra_smmu_clients_show, inode->i_private);
+}
+
+static const struct file_operations tegra_smmu_clients_fops = {
+	.open = tegra_smmu_clients_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
+{
+	smmu->debugfs = debugfs_create_dir("smmu", NULL);
+	if (!smmu->debugfs)
+		return;
+
+	debugfs_create_file("swgroups", S_IRUGO, smmu->debugfs, smmu,
+			    &tegra_smmu_swgroups_fops);
+	debugfs_create_file("clients", S_IRUGO, smmu->debugfs, smmu,
+			    &tegra_smmu_clients_fops);
+}
+
+static void tegra_smmu_debugfs_exit(struct tegra_smmu *smmu)
+{
+	debugfs_remove_recursive(smmu->debugfs);
+}
+
 struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 				    const struct tegra_smmu_soc *soc,
 				    struct tegra_mc *mc)
@@ -728,5 +828,14 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	if (err < 0)
 		return ERR_PTR(err);
 
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		tegra_smmu_debugfs_init(smmu);
+
 	return smmu;
 }
+
+void tegra_smmu_remove(struct tegra_smmu *smmu)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		tegra_smmu_debugfs_exit(smmu);
+}
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 63deb8d9f82a..09a3dabf2ea7 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -71,6 +71,7 @@ struct tegra_smmu;
 struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 				    const struct tegra_smmu_soc *soc,
 				    struct tegra_mc *mc);
+void tegra_smmu_remove(struct tegra_smmu *smmu);
 #else
 static inline struct tegra_smmu *
 tegra_smmu_probe(struct device *dev, const struct tegra_smmu_soc *soc,
@@ -78,6 +79,10 @@ tegra_smmu_probe(struct device *dev, const struct tegra_smmu_soc *soc,
 {
 	return NULL;
 }
+
+static inline void tegra_smmu_remove(struct tegra_smmu *smmu)
+{
+}
 #endif
 
 struct tegra_mc_soc {
-- 
2.3.2
