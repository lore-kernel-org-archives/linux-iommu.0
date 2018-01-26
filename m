From: Gary R Hook <gary.hook@amd.com>
Subject: [PATCH 5/5] iommu/amd - Add a debugfs entry to specify a IOMMU
 device table entry
Date: Fri, 26 Jan 2018 17:52:55 -0600
Message-ID: <151701077595.16448.10705468886498056095.stgit@taos>
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

Initially (at boot) the device table values dumped are all of the
active devices.  Add a devid debugfs file to allow the user to select a
single device table entry to dump (active or not). Let any devid value
greater than the maximum allowable PCI ID (0xFFFF) restore the
behavior to that effective at boot.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu_debugfs.c |  127 ++++++++++++++++++++++++++++++++-----
 1 file changed, 109 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index 87840ae9889d..efb666873daa 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -38,6 +38,7 @@ static DEFINE_RWLOCK(iommu_debugfs_lock);
 #define	MAX_NAME_LEN	20
 
 static unsigned int amd_iommu_verbose;
+static unsigned int amd_iommu_devid = ~0;
 
 static unsigned int amd_iommu_count_valid_dtes(int start, int end)
 {
@@ -91,6 +92,72 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 	.write = NULL,
 };
 
+static ssize_t amd_iommu_debugfs_devid_read(struct file *filp,
+					    char __user *ubuf,
+					    size_t count, loff_t *offp)
+{
+	struct amd_iommu *iommu = filp->private_data;
+	unsigned int obuflen = 512;
+	unsigned int oboff = 0;
+	ssize_t ret;
+	char *obuf;
+
+	if (!iommu)
+		return 0;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	if (amd_iommu_verbose)
+		oboff += OSCNPRINTF("%02x:%02x.%x 0x%04x %u\n",
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
+	int n;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	ret = simple_write_to_buffer(obuf, OBUFLEN, offp, ubuf, count);
+
+	if (strnchr(obuf, OBUFLEN, ':')) {
+		n = sscanf(obuf, "%x:%x.%x", &pci_id, &pci_slot, &pci_func);
+		if (n == 3)
+			amd_iommu_devid = PCI_DEVID(pci_id, PCI_DEVFN(pci_slot, pci_func));
+	} else
+		n = kstrtouint(obuf, 0, &amd_iommu_devid);
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
 struct bits {
 	uint bit;
 	uint len;
@@ -211,9 +278,13 @@ static ssize_t amd_iommu_debugfs_dte_read(struct file *filp,
 		return 0;
 
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
 	if (amd_iommu_verbose)
 		obuflen = n * 2048;
 	else
@@ -223,20 +294,29 @@ static ssize_t amd_iommu_debugfs_dte_read(struct file *filp,
 	if (!obuf)
 		return -ENOMEM;
 
-	for (i = istart ; i <= iend ; i++)
-		if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
-		     || amd_iommu_dev_table[i].data[1]) {
-			if (amd_iommu_verbose) {
-				oboff += OSCNPRINTF("Device %02x:%02x.%x\n",
-						    PCI_BUS_NUM(i),
-						    PCI_SLOT(i),
-						    PCI_FUNC(i));
-				amd_iommu_print_dte_verbose(i, &obuf,
-							    &obuflen, &oboff);
-			} else {
-				oboff += PRINTDTE(i);
+	if (amd_iommu_devid > MAX_PCI_ID) {
+		for (i = istart ; i <= iend ; i++)
+			if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
+			     || amd_iommu_dev_table[i].data[1]) {
+				if (amd_iommu_verbose) {
+					oboff += OSCNPRINTF("Device %02x:%02x.%x\n",
+							    PCI_BUS_NUM(i),
+							    PCI_SLOT(i),
+							    PCI_FUNC(i));
+					amd_iommu_print_dte_verbose(i, &obuf,
+								    &obuflen,
+								    &oboff);
+				} else {
+					oboff += PRINTDTE(i);
+				}
 			}
-		}
+	} else {
+		i = amd_iommu_devid;
+		if (amd_iommu_verbose)
+			amd_iommu_print_dte_verbose(i, &obuf, &obuflen, &oboff);
+		else
+			oboff += PRINTDTE(i);
+	}
 
 	ret = simple_read_from_buffer(ubuf, count, offp, obuf, oboff);
 	kfree(obuf);
@@ -253,12 +333,17 @@ static const struct file_operations amd_iommu_debugfs_dte_ops = {
 
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
@@ -322,6 +407,12 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
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
