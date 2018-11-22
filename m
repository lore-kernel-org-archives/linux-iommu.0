From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] iommu/tegra: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Thu, 22 Nov 2018 08:30:47 -0500
Message-ID: <20181122133047.24902-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, joro@8bytes.org, jonathanh@nvidia.com
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0d03341317c4..97b3c0461831 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -926,17 +926,7 @@ static int tegra_smmu_swgroups_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int tegra_smmu_swgroups_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, tegra_smmu_swgroups_show, inode->i_private);
-}
-
-static const struct file_operations tegra_smmu_swgroups_fops = {
-	.open = tegra_smmu_swgroups_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(tegra_smmu_swgroups);
 
 static int tegra_smmu_clients_show(struct seq_file *s, void *data)
 {
@@ -964,17 +954,7 @@ static int tegra_smmu_clients_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int tegra_smmu_clients_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, tegra_smmu_clients_show, inode->i_private);
-}
-
-static const struct file_operations tegra_smmu_clients_fops = {
-	.open = tegra_smmu_clients_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
 
 static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 {
-- 
2.17.0
