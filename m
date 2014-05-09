From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 09/15] iommu/amd: Update to use PCI DMA aliases
Date: Fri, 09 May 2014 09:29:19 -0600
Message-ID: <20140509152919.8321.89317.stgit@bling.home>
References: <20140509151735.8321.22017.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140509151735.8321.22017.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

AMD-Vi already has a concept of an alias provided via the IVRS table.
This alias only handles topology based aliases, such as PCIe-to-PCI
bridges.  When such an alias is present, we continue to use it.  When
a platform alias is not present, we can now add a check of the device
dma_func_alias to create our own.  Note that the current code can
only handle a single alias of a device, and we don't attempt to change
that here.  It would only become a factor for the requester ID seen by
the IOMMU if PCI-X were involved anway.

Since the alias is now potentially device specific rather than the
topology based alias provided by the platform, we need to clear it
when the device goes away.

With the DMA alias and isolation infrastructure now in PCI-core, we
could opt to ignore IVRS provided aliases.  We now do this for IOMMU
groups.  However, for this more common use case, the "don't fix what
isn't broken" mantra seems like the safer route.

This should allow AMD-Vi to work with devices like Marvell and Ricoh
with DMA function alias quirks.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |   37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 3d58de4..9b2da00 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -294,6 +294,7 @@ static int iommu_init_device(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct iommu_dev_data *dev_data;
 	u16 alias;
+	u8 func_alias;
 	int ret;
 
 	if (dev->archdata.iommu)
@@ -304,6 +305,29 @@ static int iommu_init_device(struct device *dev)
 		return -ENOMEM;
 
 	alias = amd_iommu_alias_table[dev_data->devid];
+
+	/*
+	 * If there is no platform provided alias (topology-based) check for
+	 * a device quirk-based alias.  Note that a non-existent alias (ie.
+	 * ghost alias) will also need their rlookup and dev_table setup.
+	 * Copy these from the original device since they're both functions
+	 * in the same slot.
+	 */
+	func_alias = pdev->dma_func_alias & ~(1 << PCI_SLOT(pdev->devfn));
+	if (func_alias && alias == dev_data->devid) {
+		WARN_ON(hweight8(func_alias) > 1);
+		alias = PCI_DEVID(pdev->bus->number,
+				  PCI_DEVFN(PCI_SLOT(pdev->devfn),
+					    ffs(func_alias) - 1));
+		if (!amd_iommu_rlookup_table[alias]) {
+			amd_iommu_rlookup_table[alias] =
+				amd_iommu_rlookup_table[dev_data->devid];
+			memcpy(amd_iommu_dev_table[alias].data,
+			       amd_iommu_dev_table[dev_data->devid].data,
+			       sizeof(amd_iommu_dev_table[alias].data));
+		}
+	}
+
 	if (alias != dev_data->devid) {
 		struct iommu_dev_data *alias_data;
 
@@ -351,12 +375,19 @@ static void iommu_ignore_device(struct device *dev)
 
 static void iommu_uninit_device(struct device *dev)
 {
+	struct iommu_dev_data *dev_data = search_dev_data(get_device_id(dev));
+
+	if (!dev_data)
+		return;
+
 	iommu_group_remove_device(dev);
 
+	/* Unlink from alias, it may change if another device is re-plugged */
+	dev_data->alias_data = NULL;
+
 	/*
-	 * Nothing to do here - we keep dev_data around for unplugged devices
-	 * and reuse it when the device is re-plugged - not doing so would
-	 * introduce a ton of races.
+	 * We keep dev_data around for unplugged devices and reuse it when the
+	 * device is re-plugged - not doing so would introduce a ton of races.
 	 */
 }
 
