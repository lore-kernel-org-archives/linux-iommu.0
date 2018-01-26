From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/5] iommu/amd - Expose the active IOMMU device table entries
Date: Fri, 26 Jan 2018 17:52:45 -0600
Message-ID: <151701076583.16448.16500299283239245371.stgit@taos>
References: <151701071164.16448.3611271062222336838.stgit@taos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <151701071164.16448.3611271062222336838.stgit@taos>
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
the IOMMU's table. 'Active' is determined by non-default values
in the first and second long words of the DTE. Aside from IOMMU
devices, this output should list every device reported by lspci.

Use arrays to store DTE bit field definitions for debugfs printing
in verbose mode

Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_debugfs.c |  182 +++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index 5066d3976912..87840ae9889d 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -22,6 +22,16 @@
 #define	OSCNPRINTF(fmt, ...) \
 		scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)
 
+#define	MAX_PCI_ID	0xFFFF
+
+#define	PRINTDTE(i)	OSCNPRINTF("%02x:%02x:%x - " \
+				   "%016llx %016llx %016llx %016llx\n", \
+				   PCI_BUS_NUM(i), PCI_SLOT(i), PCI_FUNC(i), \
+				   amd_iommu_dev_table[i].data[0], \
+				   amd_iommu_dev_table[i].data[1], \
+				   amd_iommu_dev_table[i].data[2], \
+				   amd_iommu_dev_table[i].data[3])
+
 static struct dentry *iommu_debugfs_dir;
 static DEFINE_RWLOCK(iommu_debugfs_lock);
 
@@ -81,9 +91,174 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 	.write = NULL,
 };
 
+struct bits {
+	uint bit;
+	uint len;
+	char *lbl;
+	char *note;
+};
+
+static struct bits dte_lft[] = {
+	{  0, 1, "V:", "[0]" },
+	{  1, 1, "TV:", "[1]" },
+	{  7, 2, "Host Access Dirty:", "[8:7]" },
+	{  9, 3, "Paging Mode:", "[11:9]" },
+	{ 52, 1, "PPR:", "[52]" },
+	{ 53, 1, "GPRP:", "[53]" },
+	{ 54, 1, "GIoV:", "[54]" },
+	{ 55, 1, "GV:", "[55]" },
+	{ 56, 2, "GLX:", "[57:56]" },
+	{ 61, 1, "IR:", "[61]" },
+	{ 62, 1, "IW:", "[62]" },
+	{ 96, 1, "I:", "[96]" },
+	{ 97, 1, "SE:", "[97]" },
+	{ 98, 1, "SA:", "[98]" },
+	{ 99, 2, "IOCtl:", "[100:99]" },
+};
+static uint lftlen = sizeof(dte_lft) / sizeof(struct bits);
+
+static struct bits dte_rght[] = {
+	{ 101, 1, "Cache:", "[101]" },
+	{ 102, 1, "SD:", "[102]" },
+	{ 103, 1, "EX  :", "[103]" },
+	{ 104, 2, "SysMgt:", "[105:104]" },
+	{ 128, 1, "IV:", "[128]" },
+	{ 129, 4, "IntTabLen:", "[132:129]" },
+	{ 133, 1, "IG:", "[133]" },
+	{ 184, 1, "InitPass:", "[184]" },
+	{ 185, 1, "EIntPass:", "[185]" },
+	{ 186, 1, "NMIPass:", "[186]" },
+	{ 188, 2, "IntClt:", "[189:188]" },
+	{ 190, 1, "Lint0Pass:", "[190]" },
+	{ 191, 1, "Lint1Pass:", "[191]" },
+	{ 246, 1, "AttrV:", "[246]" },
+	{ 247, 1, "Mode0FC:", "[247]" },
+};
+static uint rghtlen = sizeof(dte_rght) / sizeof(struct bits);
+
+#define	DTE_BIT(ds, p, n)	((ds[p/64] >> (p%64)) & ((1ULL<<n) - 1))
+
+static void amd_iommu_print_dte_verbose(int devidx, char **buf,
+					unsigned int *buflen,
+					unsigned int *offset)
+{
+	u64 *dte = amd_iommu_dev_table[devidx].data;
+	u64 part1, part2, part3;
+	unsigned int obuflen = *buflen;
+	unsigned int oboff = *offset;
+	struct bits *lft, *rght;
+	char *obuf = *buf;
+	uint max;
+	int j;
+
+	max = lftlen > rghtlen ? lftlen : rghtlen;
+
+	for (j = 0; j < max ; j++) {
+		lft = &dte_lft[j];
+		if (j < lftlen)
+			oboff += OSCNPRINTF("%-19s%3llx %*s", lft->lbl,
+					    DTE_BIT(dte, lft->bit, lft->len),
+					    (j < rghtlen) ? -16 : 1,
+					    lft->note);
+		else
+			oboff += OSCNPRINTF("%38s", "");
+
+		rght = &dte_rght[j];
+		if (j < rghtlen)
+			oboff += OSCNPRINTF("    %-19s%3llx %s\n", rght->lbl,
+					    DTE_BIT(dte, rght->bit, rght->len),
+					    rght->note);
+		else
+			oboff += OSCNPRINTF("\n");
+	}
+
+	oboff += OSCNPRINTF("%-28s:         %4llx %s\n", "Domain ID",
+			    DTE_BIT(dte, 64, 16), "[79:64]");
+	oboff += OSCNPRINTF("%-28s:         %4llx %s\n", "Snoop Attribute",
+			    DTE_BIT(dte, 248, 8), "[255:248]");
+	oboff += OSCNPRINTF("%-28s: %12llx %s\n", "Page Table Root Pointer",
+			    DTE_BIT(dte, 12, 40) << 12, "[51:12]");
+	oboff += OSCNPRINTF("%-28s: %12llx %s\n",
+			    "Interrupt Table Root Pointer",
+			    DTE_BIT(dte, 134, 46) << 6, "[179:134]");
+
+	part1 = DTE_BIT(dte, 107, 21) << 19;
+	part2 = DTE_BIT(dte, 80, 16) << 3;
+	part3 = DTE_BIT(dte, 58, 3);
+	oboff += OSCNPRINTF("%-28s: %12llx %s\n\n",
+			    "Guest CR3 Table Root Pointer",
+			    (part1 | part2 | part3) << 12,
+			    "[127:107][95:80][60:58]");
+
+	*buflen = obuflen;
+	*offset = oboff;
+	*buf = obuf;
+}
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
+	if (amd_iommu_verbose)
+		obuflen = n * 2048;
+	else
+		obuflen = n * 80;
+
+	obuf = kmalloc(OBUFLEN, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	for (i = istart ; i <= iend ; i++)
+		if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
+		     || amd_iommu_dev_table[i].data[1]) {
+			if (amd_iommu_verbose) {
+				oboff += OSCNPRINTF("Device %02x:%02x.%x\n",
+						    PCI_BUS_NUM(i),
+						    PCI_SLOT(i),
+						    PCI_FUNC(i));
+				amd_iommu_print_dte_verbose(i, &obuf,
+							    &obuflen, &oboff);
+			} else {
+				oboff += PRINTDTE(i);
+			}
+		}
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
@@ -134,6 +309,13 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
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
