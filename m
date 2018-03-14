From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v3 5/5] iommu/amd - Add a debugfs entry to specify a IOMMU
	device table entry
Date: Wed, 14 Mar 2018 18:05:34 -0500
Message-ID: <152106873475.67212.6697709546085749566.stgit@sosxen2.amd.com>
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

Initially (at boot) the device table values dumped are all of the
active devices.  Add a devid debugfs file to allow the user to select a
single device table entry to dump (active or not). Let any devid value
greater than the maximum allowable PCI ID (0xFFFF) restore the
behavior to that effective at boot.

Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_debugfs.c |  121 ++++++++++++++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index 1d941c5329be..47bf718f6178 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -42,6 +42,7 @@ static DEFINE_MUTEX(iommu_debugfs_lock);
 #define	MAX_NAME_LEN	20
 
 static unsigned int amd_iommu_verbose = 0;
+static unsigned int amd_iommu_devid = ~0;
 
 static unsigned int amd_iommu_count_valid_dtes(int start, int end)
 {
@@ -92,14 +93,84 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 	.write = NULL,
 };
 
+static ssize_t amd_iommu_debugfs_devid_read(struct file *filp,
+					    char __user *ubuf,
+					    size_t count, loff_t *offp)
+{
+	unsigned int obuflen = 64;
+	unsigned int oboff = 0;
+	ssize_t ret;
+	char *obuf;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	if (amd_iommu_verbose)
+		oboff += OSCNPRINTF("%02x:%02x:%x (%u / %04x)\n",
+				    PCI_BUS_NUM(amd_iommu_devid),
+				    PCI_SLOT(amd_iommu_devid),
+				    PCI_FUNC(amd_iommu_devid),
+				    amd_iommu_devid, amd_iommu_devid);
+	else
+		oboff += OSCNPRINTF("%u\n", amd_iommu_devid);
+
+	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
+	kfree(obuf);
+
+	return ret;
+}
+
+static ssize_t amd_iommu_debugfs_devid_write(struct file *filp,
+					    const char __user *ubuf,
+					    size_t count, loff_t *offp)
+{
+	unsigned int pci_id, pci_slot, pci_func;
+	unsigned int obuflen = 80;
+	ssize_t ret;
+	char *obuf;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	ret = simple_write_to_buffer(obuf, OBUFLEN, offp, ubuf, count);
+
+	if (strnchr(obuf, OBUFLEN, ':')) {
+		int n;
+		n = sscanf(obuf, "%x:%x.%x", &pci_id, &pci_slot, &pci_func);
+		if (n == 3)
+			amd_iommu_devid = PCI_DEVID(pci_id, PCI_DEVFN(pci_slot, pci_func));
+	} else {
+		kstrtoint(obuf, 0, &amd_iommu_devid);
+	}
+
+	kfree(obuf);
+
+	return ret;
+}
+
+static const struct file_operations amd_iommu_debugfs_devid_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amd_iommu_debugfs_devid_read,
+	.write = amd_iommu_debugfs_devid_write,
+};
+
 #define	MAX_PCI_ID	0xFFFF
 
-#define	PRINTDTE(i)	OSCNPRINTF("%02x:%02x:%x - %016llx %016llx %016llx %016llx\n", \
-				   PCI_BUS_NUM(i), PCI_SLOT(i), PCI_FUNC(i), \
-				   amd_iommu_dev_table[i].data[0], \
-				   amd_iommu_dev_table[i].data[1], \
-				   amd_iommu_dev_table[i].data[2], \
-				   amd_iommu_dev_table[i].data[3]);
+static inline int amd_iommu_debugfs_printdte(int i, char *obuf, unsigned int obuflen, unsigned int oboff)
+{
+	int rc;
+
+	rc = OSCNPRINTF("%02x:%02x:%x - %016llx %016llx %016llx %016llx\n",
+			PCI_BUS_NUM(i), PCI_SLOT(i), PCI_FUNC(i),
+			amd_iommu_dev_table[i].data[0],
+			amd_iommu_dev_table[i].data[1],
+			amd_iommu_dev_table[i].data[2],
+			amd_iommu_dev_table[i].data[3]);
+	return rc;
+}
 
 static ssize_t amd_iommu_debugfs_dte_read(struct file *filp,
 					  char __user *ubuf,
@@ -113,19 +184,28 @@ static ssize_t amd_iommu_debugfs_dte_read(struct file *filp,
 	char *obuf;
 
 	/* Count the number of valid entries in the device table */
-	istart = 0;
-	iend = MAX_PCI_ID;
-	n = amd_iommu_count_valid_dtes(istart, iend);
+	if (amd_iommu_devid > MAX_PCI_ID) {
+		istart = 0;
+		iend = MAX_PCI_ID;
+		n = amd_iommu_count_valid_dtes(istart, iend);
+	} else {
+		n = 1;
+	}
 	obuflen = n * 80;
 
 	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
 	if (!obuf)
 		return -ENOMEM;
 
-	for (i = istart ; i <= iend ; i++)
-		if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
-		     || amd_iommu_dev_table[i].data[1])
-			oboff += PRINTDTE(i);
+	if (amd_iommu_devid > MAX_PCI_ID) {
+		for (i = istart ; i <= iend ; i++)
+			if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
+			     || amd_iommu_dev_table[i].data[1])
+				oboff += amd_iommu_debugfs_printdte(i, obuf, obuflen, oboff);
+	} else {
+		i = amd_iommu_devid;
+		oboff += amd_iommu_debugfs_printdte(i, obuf, obuflen, oboff);
+	}
 
 	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
 	kfree(obuf);
@@ -142,12 +222,17 @@ static const struct file_operations amd_iommu_debugfs_dte_ops = {
 
 static char readmetext[] =
 "devicetable             Print active entries in the device table\n"
+"devid                   Controls which device IDs are printed\n"
 "count                   Count of active devices\n"
 "verbose                 Provide additional descriptive text\n"
 "\n"
 "                        Dumping the Device Table\n"
-"The device table is scanned for entries that appear to be active. The\n"
-"default range is from 0 to 0xFFFF, and only active entries will be reported\n"
+"The device table is scanned for entries that appear to be active.\n"
+"The default (initial) range is from 0 to 0xFFFF, represented by a devid\n"
+"value greater than 0xFFFF, and only active entries will be reported.\n"
+"If devid is set to a specific value, only that device entry will be\n"
+"displayed (active or not). devid may be specified as ##:##:#, a decimal\n"
+"value, or a hex value.\n"
 "\n";
 
 static ssize_t amd_iommu_debugfs_readme_read(struct file *filp,
@@ -210,6 +295,12 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 	if (!d_dte)
 		goto err;
 
+	d_dte = debugfs_create_file("devid", 0400,
+				    iommu->debugfs_instance, iommu,
+				    &amd_iommu_debugfs_devid_ops);
+	if (!d_dte)
+		goto err;
+
 	d_dte = debugfs_create_file("README", 0400,
 				    iommu->debugfs_instance, iommu,
 				    &amd_iommu_debugfs_readme_ops);
