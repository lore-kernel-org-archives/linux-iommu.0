From: Gary R Hook <gary.hook@amd.com>
Subject: [PATCH 2/5] iommu/amd - Add a 'verbose' switch for IOMMU debugfs
Date: Fri, 26 Jan 2018 17:52:26 -0600
Message-ID: <151701074611.16448.6376879206073473408.stgit@taos>
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

Enable more descriptive debugfs output via a 'verbose' variable.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu_debugfs.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index 18f70934961d..c449f3a7452c 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -27,6 +27,8 @@ static DEFINE_RWLOCK(iommu_debugfs_lock);
 
 #define	MAX_NAME_LEN	20
 
+static unsigned int amd_iommu_verbose;
+
 static unsigned int amd_iommu_count_valid_dtes(int start, int end)
 {
 	unsigned int n = 0;
@@ -61,7 +63,10 @@ static ssize_t amd_iommu_debugfs_dtecount_read(struct file *filp,
 		return -ENOMEM;
 
 	n = amd_iommu_count_valid_dtes(0, 0xFFFF);
-	oboff += OSCNPRINTF("%d\n", n);
+	if (amd_iommu_verbose)
+		oboff += OSCNPRINTF("# DTEs:  %d\n", n);
+	else
+		oboff += OSCNPRINTF("%d\n", n);
 
 	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
 	kfree(obuf);
@@ -79,6 +84,7 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 {
 	char name[MAX_NAME_LEN + 1];
+	struct dentry *d_verbose;
 	struct dentry *d_dte;
 	unsigned long flags;
 
@@ -97,6 +103,12 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 	if (!iommu->debugfs_instance)
 		goto err;
 
+	d_verbose = debugfs_create_u32("verbose", 0600,
+				       iommu->debugfs_instance,
+				       &amd_iommu_verbose);
+	if (!d_verbose)
+		goto err;
+
 	d_dte = debugfs_create_file("count", 0400,
 				    iommu->debugfs_instance, iommu,
 				    &amd_iommu_debugfs_dtecount_ops);
