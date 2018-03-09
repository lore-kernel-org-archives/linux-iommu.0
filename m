From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 4/5] iommu/amd - Expose the active IOMMU device table
	entries
Date: Thu, 08 Mar 2018 18:51:19 -0600
Message-ID: <152055667969.63229.11784633364919979184.stgit@sosxen2.amd.com>
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

Add a debugfs entry to dump the active device table entries from
the IOMMU's table. Active is determined by non-default values
in the first and second long words of the DTE. Aside from IOMMU
devices, this output should list every device reported by lspci.

Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_debugfs.c |   64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index 79945ce1199d..c4e071f7a5b9 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -81,9 +81,66 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 	.write = NULL,
 };
 
+#define	MAX_PCI_ID	0xFFFF
+
+#define	PRINTDTE(i)	OSCNPRINTF("%02x:%02x:%x - %016llx %016llx %016llx %016llx\n", \
+				   PCI_BUS_NUM(i), PCI_SLOT(i), PCI_FUNC(i), \
+				   amd_iommu_dev_table[i].data[0], \
+				   amd_iommu_dev_table[i].data[1], \
+				   amd_iommu_dev_table[i].data[2], \
+				   amd_iommu_dev_table[i].data[3]);
+
+static ssize_t amd_iommu_debugfs_dte_read(struct file *filp,
+					  char __user *ubuf,
+					  size_t count, loff_t *offp)
+{
+	struct amd_iommu *iommu = filp->private_data;
+	unsigned int obuflen;
+	unsigned int oboff = 0;
+	unsigned int istart, iend;
+	ssize_t ret;
+	u32 i, n;
+	char *obuf;
+
+	if (!iommu)
+		return 0;
+
+	/* Count the number of valid entries in the device table */
+	istart = 0;
+	iend = MAX_PCI_ID;
+	n = amd_iommu_count_valid_dtes(istart, iend);
+	obuflen = n * 80;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	for (i = istart ; i <= iend ; i++)
+		if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
+		     || amd_iommu_dev_table[i].data[1])
+			oboff += PRINTDTE(i);
+
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	kfree(obuf);
+
+	return ret;
+}
+
+static const struct file_operations amd_iommu_debugfs_dte_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amd_iommu_debugfs_dte_read,
+	.write = NULL,
+};
+
 static char readmetext[] =
+"devicetable             Print active entries in the device table\n"
 "count                   Count of active devices\n"
 "verbose                 Provide additional descriptive text\n"
+"\n"
+"                        Dumping the Device Table\n"
+"The device table is scanned for entries that appear to be active. The\n"
+"default range is from 0 to 0xFFFF, and only active entries will be reported\n"
 "\n";
 
 static ssize_t amd_iommu_debugfs_readme_read(struct file *filp,
@@ -134,6 +191,13 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 	if (!d_verbose)
 		goto err;
 
+	/* Device Table Entries */
+	d_dte = debugfs_create_file("devicetable", 0400,
+				    iommu->debugfs_instance, iommu,
+				    &amd_iommu_debugfs_dte_ops);
+	if (!d_dte)
+		goto err;
+
 	d_dte = debugfs_create_file("count", 0400,
 				    iommu->debugfs_instance, iommu,
 				    &amd_iommu_debugfs_dtecount_ops);
