From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 2/5] iommu/amd - Add a 'verbose' switch for IOMMU debugfs
Date: Thu, 08 Mar 2018 18:50:58 -0600
Message-ID: <152055665818.63229.14230357529475243257.stgit@sosxen2.amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152055660594.63229.5131049527614494130.stgit-tq90VzyE+wXkLsZ8J5Uweg@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Enable more descriptive debugfs output via a 'verbose' variable.

Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_debugfs.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index b0395a47bc32..481f4d86f8f8 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -27,6 +27,8 @@ static DEFINE_RWLOCK(iommu_debugfs_lock);
 
 #define	MAX_NAME_LEN	20
 
+static unsigned int amd_iommu_verbose = 0;
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
