From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] iommu/tegra: smmu: debugfs for TLB/PTC statistics
Date: Tue, 31 Jul 2012 08:14:41 +0300
Message-ID: <1343711681-23394-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add debugfs entries to collect TLB/PTC statistics.

  $ echo "reset" > /sys/kernel/debug/smmu/mc/{tlb,ptc}
  $ echo "on" > /sys/kernel/debug/smmu/mc/{tlb,ptc}
  $ echo "off" > /sys/kernel/debug/smmu/mc/{tlb,ptc}
  $ cat /sys/kernel/debug/smmu/mc/{tlb,ptc}
  hit:0014910c miss:00014d22

  The above format is:
  hit:<HIT count><SPC>miss:<MISS count><SPC><CR+LF>

  fscanf(fp, "hit:%lx miss:%lx", &hit, &miss);

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |  202 +++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 190 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 4ba325a..2e0eee9 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -32,6 +32,8 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 
 #include <asm/page.h>
 #include <asm/cacheflush.h>
@@ -47,16 +49,29 @@
 #define SMMU_CONFIG_DISABLE			0
 #define SMMU_CONFIG_ENABLE			1
 
-#define SMMU_TLB_CONFIG				0x14
-#define SMMU_TLB_CONFIG_STATS__MASK		(1 << 31)
-#define SMMU_TLB_CONFIG_STATS__ENABLE		(1 << 31)
+/* REVISIT: To support multiple MCs */
+enum {
+	_MC = 0,
+};
+
+enum {
+	_TLB = 0,
+	_PTC,
+};
+
+#define SMMU_CACHE_CONFIG_BASE			0x14
+#define __SMMU_CACHE_CONFIG(mc, cache)		(SMMU_CACHE_CONFIG_BASE + 4 * cache)
+#define SMMU_CACHE_CONFIG(cache)		__SMMU_CACHE_CONFIG(_MC, cache)
+
+#define SMMU_CACHE_CONFIG_STATS_SHIFT		31
+#define SMMU_CACHE_CONFIG_STATS_ENABLE		(1 << SMMU_CACHE_CONFIG_STATS_SHIFT)
+#define SMMU_CACHE_CONFIG_STATS_TEST_SHIFT	30
+#define SMMU_CACHE_CONFIG_STATS_TEST		(1 << SMMU_CACHE_CONFIG_STATS_TEST_SHIFT)
+
 #define SMMU_TLB_CONFIG_HIT_UNDER_MISS__ENABLE	(1 << 29)
 #define SMMU_TLB_CONFIG_ACTIVE_LINES__VALUE	0x10
 #define SMMU_TLB_CONFIG_RESET_VAL		0x20000010
 
-#define SMMU_PTC_CONFIG				0x18
-#define SMMU_PTC_CONFIG_STATS__MASK		(1 << 31)
-#define SMMU_PTC_CONFIG_STATS__ENABLE		(1 << 31)
 #define SMMU_PTC_CONFIG_CACHE__ENABLE		(1 << 29)
 #define SMMU_PTC_CONFIG_INDEX_MAP__PATTERN	0x3f
 #define SMMU_PTC_CONFIG_RESET_VAL		0x2000003f
@@ -86,10 +101,10 @@
 
 #define SMMU_ASID_SECURITY			0x38
 
-#define SMMU_STATS_TLB_HIT_COUNT		0x1f0
-#define SMMU_STATS_TLB_MISS_COUNT		0x1f4
-#define SMMU_STATS_PTC_HIT_COUNT		0x1f8
-#define SMMU_STATS_PTC_MISS_COUNT		0x1fc
+#define SMMU_STATS_CACHE_COUNT_BASE		0x1f0
+
+#define SMMU_STATS_CACHE_COUNT(mc, cache, hitmiss)		\
+	(SMMU_STATS_CACHE_COUNT_BASE + 8 * cache + 4 * hitmiss)
 
 #define SMMU_TRANSLATION_ENABLE_0		0x228
 #define SMMU_TRANSLATION_ENABLE_1		0x22c
@@ -251,6 +266,8 @@ struct smmu_device {
 	unsigned long translation_enable_2;
 	unsigned long asid_security;
 
+	struct dentry *debugfs_root;
+
 	struct device_node *ahb;
 
 	int		num_as;
@@ -412,8 +429,8 @@ static int smmu_setup_regs(struct smmu_device *smmu)
 	smmu_write(smmu, smmu->translation_enable_1, SMMU_TRANSLATION_ENABLE_1);
 	smmu_write(smmu, smmu->translation_enable_2, SMMU_TRANSLATION_ENABLE_2);
 	smmu_write(smmu, smmu->asid_security, SMMU_ASID_SECURITY);
-	smmu_write(smmu, SMMU_TLB_CONFIG_RESET_VAL, SMMU_TLB_CONFIG);
-	smmu_write(smmu, SMMU_PTC_CONFIG_RESET_VAL, SMMU_PTC_CONFIG);
+	smmu_write(smmu, SMMU_TLB_CONFIG_RESET_VAL, SMMU_CACHE_CONFIG(_TLB));
+	smmu_write(smmu, SMMU_PTC_CONFIG_RESET_VAL, SMMU_CACHE_CONFIG(_PTC));
 
 	smmu_flush_regs(smmu, 1);
 
@@ -892,6 +909,164 @@ static struct iommu_ops smmu_iommu_ops = {
 	.pgsize_bitmap	= SMMU_IOMMU_PGSIZES,
 };
 
+/* Should be in the order of enum */
+static const char * const smmu_debugfs_mc[] = { "mc", };
+static const char * const smmu_debugfs_cache[] = {  "tlb", "ptc", };
+
+static ssize_t smmu_debugfs_stats_write(struct file *file,
+					const char __user *buffer,
+					size_t count, loff_t *pos)
+{
+	struct smmu_device *smmu;
+	struct dentry *dent;
+	int i, cache, mc;
+	enum {
+		_OFF = 0,
+		_ON,
+		_RESET,
+	};
+	const char * const command[] = {
+		[_OFF]		= "off",
+		[_ON]		= "on",
+		[_RESET]	= "reset",
+	};
+	char str[] = "reset";
+	u32 val;
+	size_t offs;
+
+	count = min_t(size_t, count, sizeof(str));
+	if (copy_from_user(str, buffer, count))
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(command); i++)
+		if (strncmp(str, command[i],
+			    strlen(command[i])) == 0)
+			break;
+
+	if (i == ARRAY_SIZE(command))
+		return -EINVAL;
+
+	dent = file->f_dentry;
+	cache = (int)dent->d_inode->i_private;
+	mc = (int)dent->d_parent->d_inode->i_private;
+	smmu = dent->d_parent->d_parent->d_inode->i_private;
+
+	offs = SMMU_CACHE_CONFIG(cache);
+	val = smmu_read(smmu, offs);
+	switch (i) {
+	case _OFF:
+		val &= ~SMMU_CACHE_CONFIG_STATS_ENABLE;
+		val &= ~SMMU_CACHE_CONFIG_STATS_TEST;
+		smmu_write(smmu, val, offs);
+		break;
+	case _ON:
+		val |= SMMU_CACHE_CONFIG_STATS_ENABLE;
+		val &= ~SMMU_CACHE_CONFIG_STATS_TEST;
+		smmu_write(smmu, val, offs);
+		break;
+	case _RESET:
+		val |= SMMU_CACHE_CONFIG_STATS_TEST;
+		smmu_write(smmu, val, offs);
+		val &= ~SMMU_CACHE_CONFIG_STATS_TEST;
+		smmu_write(smmu, val, offs);
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	dev_dbg(smmu->dev, "%s() %08x, %08x @%08x\n", __func__,
+		val, smmu_read(smmu, offs), offs);
+
+	return count;
+}
+
+static int smmu_debugfs_stats_show(struct seq_file *s, void *v)
+{
+	struct smmu_device *smmu;
+	struct dentry *dent;
+	int i, cache, mc;
+	const char * const stats[] = { "hit", "miss", };
+
+	dent = d_find_alias(s->private);
+	cache = (int)dent->d_inode->i_private;
+	mc = (int)dent->d_parent->d_inode->i_private;
+	smmu = dent->d_parent->d_parent->d_inode->i_private;
+
+	for (i = 0; i < ARRAY_SIZE(stats); i++) {
+		u32 val;
+		size_t offs;
+
+		offs = SMMU_STATS_CACHE_COUNT(mc, cache, i);
+		val = smmu_read(smmu, offs);
+		seq_printf(s, "%s %08x ", stats[i], val);
+
+		dev_dbg(smmu->dev, "%s() %s %08x @%08x\n", __func__,
+			stats[i], val, offs);
+	}
+	seq_printf(s, "\n");
+
+	return 0;
+}
+
+static int smmu_debugfs_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, smmu_debugfs_stats_show, inode);
+}
+
+static const struct file_operations smmu_debugfs_stats_fops = {
+	.open		= smmu_debugfs_stats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= smmu_debugfs_stats_write,
+};
+
+static void smmu_debugfs_delete(struct smmu_device *smmu)
+{
+	debugfs_remove_recursive(smmu->debugfs_root);
+}
+
+static void smmu_debugfs_create(struct smmu_device *smmu)
+{
+	int i;
+	struct dentry *root;
+
+	root = debugfs_create_file(dev_name(smmu->dev),
+				   S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
+				   NULL, smmu, NULL);
+	if (!root)
+		goto err_out;
+	smmu->debugfs_root = root;
+
+	for (i = 0; i < ARRAY_SIZE(smmu_debugfs_mc); i++) {
+		int j;
+		struct dentry *mc;
+
+		mc = debugfs_create_file(smmu_debugfs_mc[i],
+					 S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
+					 root, (void *)i, NULL);
+		if (!mc)
+			goto err_out;
+
+		for (j = 0; j < ARRAY_SIZE(smmu_debugfs_cache); j++) {
+			struct dentry *cache;
+
+			cache = debugfs_create_file(smmu_debugfs_cache[j],
+						    S_IWUGO | S_IRUGO, mc,
+						    (void *)j,
+						    &smmu_debugfs_stats_fops);
+			if (!cache)
+				goto err_out;
+		}
+	}
+
+	return;
+
+err_out:
+	smmu_debugfs_delete(smmu);
+}
+
 static int tegra_smmu_suspend(struct device *dev)
 {
 	struct smmu_device *smmu = dev_get_drvdata(dev);
@@ -996,6 +1171,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	if (!smmu->avp_vector_page)
 		return -ENOMEM;
 
+	smmu_debugfs_create(smmu);
 	smmu_handle = smmu;
 	return 0;
 }
@@ -1005,6 +1181,8 @@ static int tegra_smmu_remove(struct platform_device *pdev)
 	struct smmu_device *smmu = platform_get_drvdata(pdev);
 	int i;
 
+	smmu_debugfs_delete(smmu);
+
 	smmu_write(smmu, SMMU_CONFIG_DISABLE, SMMU_CONFIG);
 	for (i = 0; i < smmu->num_as; i++)
 		free_pdir(&smmu->as[i]);
-- 
1.7.5.4
