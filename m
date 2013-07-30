From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu/amd: Add quirk for broken Marvell 88SE91xx SATA
Date: Tue, 30 Jul 2013 13:37:00 +0200
Message-ID: <20130730113659.GJ28811@8bytes.org>
References: <519A93F0.8070606@gmx.ch> <20130521203526.GE7424@8bytes.org>
	<51D3E691.8030307@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51D3E691.8030307-OI3hZJvNYWs@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Manfred Schwarb <manfred99-OI3hZJvNYWs@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Manfred,

On Wed, Jul 03, 2013 at 10:53:37AM +0200, Manfred Schwarb wrote:
> >I will look into the best way to port this to the AMD IOMMU driver. Will
> >send you a patch for testing when I have somthing.
> >
> 
> Any news on this? Had you time to look at this issue?

Can you test the attached patch please? It applies to v3.11-rc3. I
compiled and boot-tested it, but I don't have a broken Marvell
controller myself, so not sure if the patch works.

Thanks,

	Joerg

>From 04c7d4ea2171780656c4c8ff3500a97ea45aabcb Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Date: Tue, 30 Jul 2013 13:10:54 +0200
Subject: [PATCH] iommu/amd: Add quirk for broken Marvell 88SE91xx SATA
 controllers

These controlers use the wrong requestor id when sending DMA
requests. Add a quirk for this to the AMD IOMMU driver to
make them work with IOMMU enabled.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c |   54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 7acbf35..f4e0c82 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1025,6 +1025,58 @@ static void __init free_iommu_all(void)
 }
 
 /*
+ * Update IOMMU data structures to handle broken devices
+ */
+static const struct pci_dev_merge_functions {
+	u16 vendor;
+	u16 device;
+} pci_dev_merge_fn_devs[] = {
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9123 },
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9125 },
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9128 },
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9130 },
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9172 },
+	{ 0 }
+};
+
+static void amd_iommu_merge_fn_quirk(struct pci_dev *pdev)
+{
+	const struct pci_dev_merge_functions *fn;
+
+	for (fn = pci_dev_merge_fn_devs; fn->vendor; fn++) {
+		u16 base_devid, devid, i;
+
+		if ((pdev->vendor != fn->vendor && fn->vendor != PCI_ANY_ID) ||
+		    (pdev->device != fn->device && fn->device != PCI_ANY_ID))
+			continue;
+
+		pr_info("AMD-Vi: Applying merge-fn quirk for device %s\n",
+			dev_name(&pdev->dev));
+
+		devid      = PCI_DEVID(pdev->bus->number, pdev->devfn);
+		base_devid = PCI_DEVID(PCI_BUS_NUM(devid),
+				       PCI_DEVFN(PCI_SLOT(devid), 0));
+
+		/* Update alias table */
+		for (i = 1; i < 8; ++i)
+			amd_iommu_alias_table[base_devid + i] = devid;
+	}
+}
+
+static void amd_iommu_pci_quirks(void)
+{
+        struct pci_dev *pdev = NULL;
+
+	for_each_pci_dev(pdev) {
+		/*
+		 * Check for known PCI devices that use
+		 * the wrong requestor id
+		 */
+		amd_iommu_merge_fn_quirk(pdev);
+	}
+}
+
+/*
  * Family15h Model 10h-1fh erratum 746 (IOMMU Logging May Stall Translations)
  * Workaround:
  *     BIOS should disable L2B micellaneous clock gating by setting
@@ -1337,6 +1389,8 @@ static int __init amd_iommu_init_pci(void)
 			break;
 	}
 
+	amd_iommu_pci_quirks();
+
 	ret = amd_iommu_init_devices();
 
 	print_iommu_info();
-- 
1.7.9.5
