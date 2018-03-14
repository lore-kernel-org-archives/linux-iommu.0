From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v3 3/5] iommu/amd - Add a README variable for the IOMMU debugfs
Date: Wed, 14 Mar 2018 18:05:15 -0500
Message-ID: <152106871561.67212.3504698988832928735.stgit@sosxen2.amd.com>
References: <152106836233.67212.15861879210675477690.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <152106836233.67212.15861879210675477690.stgit-tq90VzyE+wXkLsZ8J5Uweg@public.gmane.org>
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

Provide help text via a filesystem entry

Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_debugfs.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index 170863e5e86b..d95428b1ef90 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -92,6 +92,31 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
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
@@ -125,6 +150,12 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
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
