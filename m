From: Gary R Hook <gary.hook@amd.com>
Subject: [PATCH 3/5] iommu/amd - Add a README variable for the IOMMU debugfs
Date: Fri, 26 Jan 2018 17:52:35 -0600
Message-ID: <151701075592.16448.13505485878705952024.stgit@taos>
References: <151701071164.16448.3611271062222336838.stgit@taos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151701071164.16448.3611271062222336838.stgit@taos>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Provide help text via a filesystem entry

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu_debugfs.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index c449f3a7452c..5066d3976912 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -81,6 +81,31 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 	.write = NULL,
 };
 
+static char readmetext[] =
+"count                   Count of active devices\n"
+"verbose                 Provide additional descriptive text\n"
+"\n";
+
+static ssize_t amd_iommu_debugfs_readme_read(struct file *filp,
+				      char __user *ubuf,
+				      size_t count, loff_t *offp)
+{
+	ssize_t ret;
+
+	ret = simple_read_from_buffer(ubuf, count, offp,
+				      readmetext, strlen(readmetext));
+
+	return ret;
+}
+
+
+static const struct file_operations amd_iommu_debugfs_readme_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amd_iommu_debugfs_readme_read,
+	.write = NULL,
+};
+
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 {
 	char name[MAX_NAME_LEN + 1];
@@ -115,6 +140,12 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 	if (!d_dte)
 		goto err;
 
+	d_dte = debugfs_create_file("README", 0400,
+				    iommu->debugfs_instance, iommu,
+				    &amd_iommu_debugfs_readme_ops);
+	if (!d_dte)
+		goto err;
+
 	return;
 
 err:
