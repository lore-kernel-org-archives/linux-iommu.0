From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH v2 00/15] PCI/iommu: Fix DMA alias problems
Date: 10 May 2014 08:15:42 -0400
Message-ID: <20140510121542.5359.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: alex.williamson@redhat.com, linux@horizon.com
Cc: acooks@gmail.com, bhelgaas@google.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernrl.org, linux-pci@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Well, chalk up one test failure.

I'm running a GA-X79-UP4 motherboard with VT-d enabled.
It has 3x Marvell SATA controllers:
05:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6G=
b/s Controller (rev 11)
06:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6G=
b/s Controller (rev 11)
07:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6G=
b/s Controller (rev 11)

With Andrew's patch from https://bugzilla.kernel.org/show_bug.cgi?id=3D=
42679#c22
the Marvell SATA ports work.  With your dma-alias branch (rebased onto =
3.15-rc5),
the ports don't work:

-ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=3D0x80)
-dmar: DRHD: handling fault status reg 502
-dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000=20
-DMAR:[fault reason 02] Present bit in context entry is clear
-dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000=20
-DMAR:[fault reason 02] Present bit in context entry is clear
-dmar: DRHD: handling fault status reg 700
-dmar: DRHD: handling fault status reg 702
-dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000=20
-DMAR:[fault reason 02] Present bit in context entry is clear
-dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000=20
-DMAR:[fault reason 02] Present bit in context entry is clear
-dmar: DRHD: handling fault status reg 100
-ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
-ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
-dmar: DRHD: handling fault status reg 102
-dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000=20
-DMAR:[fault reason 02] Present bit in context entry is clear
-ata8.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=3D0x80)
-ata8: limiting SATA link speed to 1.5 Gbps
-ata7.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=3D0x80)
-ata7: limiting SATA link speed to 1.5 Gbps
-dmar: DRHD: handling fault status reg 202
-dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffc0000=20
-DMAR:[fault reason 02] Present bit in context entry is clear
-dmar: DMAR:[DMA Write] Request device [05:00.1] fault addr fffe0000=20
-DMAR:[fault reason 02] Present bit in context entry is clear
-dmar: DRHD: handling fault status reg 400

Andrew's patch was on top of 3.14.3; my initial attempts to forward-por=
t it
to the 3.15 PCI changes (appended below) failed to boot.

commit 2323d20989aca44ce0e630e7d264b3973c1ee357
Author: Andrew Cooks <acooks@gmail.com>
Date:   Mon Jan 20 07:06:58 2014 -0500

    drivers/pci: Add quirk for devices that use multiple functions.
   =20
    Patch taken from https://bugzilla.kernel.org/show_bug.cgi?id=3D4267=
9#c22
    and improved locally.

    WARNING WARNING WARNING: This is a BROKEN attempt to make it work w=
ith 3.15;
    it DOES NOT BOOT in the form shown here.

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f256ffc02e..04d430d464 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1841,6 +1841,118 @@ static int domain_context_mapping_one(struct dm=
ar_domain *domain,
 	return 0;
 }
=20
+static void iommu_detach_dev(struct intel_iommu *iommu, u8 bus, u8 dev=
fn);
+
+static void quirk_unmap_multi_requesters(struct pci_dev *pdev, u8 fn_m=
ap)
+{
+	int fn;
+	u8 bus, devfn;
+	struct intel_iommu *iommu =3D device_to_iommu(&pdev->dev, &bus, &devf=
n);
+
+	/* something must be seriously wrong if we can't lookup the iommu. */
+	BUG_ON(!iommu);
+
+	fn_map &=3D ~(1<<PCI_FUNC(devfn));	/* Skip the normal case */
+
+	for (fn =3D 0; fn_map >> fn; fn++) {
+		if (fn_map & (1<<fn)) {
+			iommu_detach_dev(iommu,
+					pdev->bus->number,
+					PCI_DEVFN(PCI_SLOT(devfn), fn));
+			dev_dbg(&pdev->dev,
+				"requester id quirk; ghost func %d unmapped",
+				fn);
+		}
+	}
+}
+
+/* For quirky devices that use multiple requester ids. */
+static int quirk_map_multi_requester_ids(struct dmar_domain *domain,
+		struct pci_dev *pdev,
+		int translation)
+{
+	int fn, err =3D 0;
+	u8 fn_map =3D pci_multi_requesters(pdev);
+	u8 bus, devfn;
+	struct intel_iommu *iommu;
+
+	/* this is the common, non-quirky case. */
+	if (!fn_map)
+		return 0;
+
+	fn_map &=3D ~(1<<PCI_FUNC(pdev->devfn));	/* Skip the normal case */
+
+	iommu =3D device_to_iommu(&pdev->dev, &bus, &devfn);
+
+	for (fn =3D 0; fn_map >> fn; fn++) {
+		if (fn_map & (1<<fn)) {
+			err =3D domain_context_mapping_one(domain, iommu, bus,
+					PCI_DEVFN(PCI_SLOT(pdev->devfn), fn),
+					translation);
+			if (err) {
+				dev_err(&pdev->dev,
+					"mapping ghost func %d failed", fn);
+				quirk_unmap_multi_requesters(pdev,
+					fn_map & ((1<<fn)-1));
+				return err;
+			}
+			dev_dbg(&pdev->dev,
+				"requester id quirk; ghost func %d mapped", fn);
+		}
+	}
+	return 0;
+}
+
+
+static void quirk_unmap_requester_id(struct pci_dev *pdev)
+{
+	u8 bus, devfn;
+	struct intel_iommu *iommu =3D device_to_iommu(&pdev->dev, &bus, &devf=
n);
+	u8 devfn2 =3D pci_requester(pdev);
+
+	/* something must be seriously wrong if we can't lookup the iommu. */
+	BUG_ON(!iommu);
+
+
+	if (devfn =3D=3D devfn2)
+		return;
+
+	iommu_detach_dev(iommu,	bus, devfn2);
+	dev_dbg(&pdev->dev, "requester id quirk; bugged device unmapped");
+}
+
+static int quirk_map_requester_id(struct dmar_domain *domain,
+		struct pci_dev *pdev,
+		int translation)
+{
+	u8 bus, devfn;
+	struct intel_iommu *iommu =3D device_to_iommu(&pdev->dev, &bus, &devf=
n);
+	u8 devfn2 =3D pci_requester(pdev);
+	int err;
+
+	if (!iommu)
+		return -ENODEV;
+
+	dev_dbg(&pdev->dev,
+		"checking for incorrect pci requester id quirk...");
+
+	if (devfn =3D=3D devfn2)
+		return 0;
+
+	err =3D domain_context_mapping_one(domain, iommu, bus, devfn2,
+			translation);
+	if (err) {
+		dev_err(&pdev->dev,
+			"requester id quirk: mapping dev %02x:%02x.%d failed",
+			bus, PCI_SLOT(devfn2), PCI_FUNC(devfn2));
+		return err;
+	}
+	dev_dbg(&pdev->dev,
+		"requester id quirk; dmar context entry added: %02x:%02x.%d",
+		bus, PCI_SLOT(devfn2), PCI_FUNC(devfn2));
+	return 0;
+}
+
 static int
 domain_context_mapping(struct dmar_domain *domain, struct device *dev,
 		       int translation)
@@ -1859,6 +1971,16 @@ domain_context_mapping(struct dmar_domain *domai=
n, struct device *dev,
 	if (ret || !dev_is_pci(dev))
 		return ret;
=20
+	/* quirk for devices using multiple pci requester ids */
+	ret =3D quirk_map_multi_requester_ids(domain, pdev, translation);
+	if (ret)
+		return ret;
+
+	/* quirk for devices single incorrect pci requester id */
+	ret =3D quirk_map_requester_id(domain, pdev, translation);
+	if (ret)
+		return ret;
+
 	/* dependent device mapping */
 	pdev =3D to_pci_dev(dev);
 	tmp =3D pci_find_upstream_pcie_bridge(pdev);
@@ -4076,12 +4198,18 @@ static void domain_remove_one_dev_info(struct d=
mar_domain *domain,
 	list_for_each_entry_safe(info, tmp, &domain->devices, link) {
 		if (info->iommu =3D=3D iommu && info->bus =3D=3D bus &&
 		    info->devfn =3D=3D devfn) {
+			struct pci_dev *pdev;
+
 			unlink_domain_info(info);
 			spin_unlock_irqrestore(&device_domain_lock, flags);
=20
 			iommu_disable_dev_iotlb(info);
 			iommu_detach_dev(iommu, info->bus, info->devfn);
 			iommu_detach_dependent_devices(iommu, dev);
+			pdev =3D to_pci_dev(dev);
+			quirk_unmap_multi_requesters(pdev,
+						pci_multi_requesters(pdev));
+			quirk_unmap_requester_id(pdev);
 			free_devinfo_mem(info);
=20
 			spin_lock_irqsave(&device_domain_lock, flags);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e7292065a1..d7a8296cc3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3341,6 +3341,10 @@ static struct pci_dev *pci_func_0_dma_source(str=
uct pci_dev *dev)
 	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 }
=20
+/* Table of source functions for real devices. The DMA requests for th=
e
+ * device are tagged with a different real function as source. This is
+ * relevant to multifunction devices.
+ */
 static const struct pci_dev_dma_source {
 	u16 vendor;
 	u16 device;
@@ -3367,7 +3371,8 @@ static const struct pci_dev_dma_source {
  * the device doing the DMA, but sometimes hardware is broken and will
  * tag the DMA as being sourced from a different device.  This functio=
n
  * allows that translation.  Note that the reference count of the
- * returned device is incremented on all paths.
+ * returned device is incremented on all paths. Translation is done wh=
en
+ * the device is added to an IOMMU group.
  */
 struct pci_dev *pci_get_dma_source(struct pci_dev *dev)
 {
@@ -3483,6 +3488,144 @@ static int pci_quirk_intel_pch_acs(struct pci_d=
ev *dev, u16 acs_flags)
 	return acs_flags & ~flags ? 0 : 1;
 }
=20
+/* Table of multiple (ghost) source functions. Devices that may need t=
his quirk
+ * show the following behaviour:
+ * 1. the device may use multiple PCI requester IDs during operation,
+ *     (eg. one pci transaction uses xx:yy.0, the next uses xx:yy.1)
+ * 2. the requester ID may not match a known device.
+ *     (eg. lspci does not show xx:yy.1 to be present)
+ *
+ * The bitmap contains all of the functions "in use" by the device.
+ * See  https://bugzilla.redhat.com/show_bug.cgi?id=3D757166,
+ * https://bugzilla.kernel.org/show_bug.cgi?id=3D42679
+ * https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1089768
+ */
+static const struct pci_dev_dma_multi_source_map {
+	u16 vendor;
+	u16 device;
+	u8 func_map;	/* bit map. lsb is fn 0. */
+} pci_dev_dma_multi_source_map[] =3D {
+	 /* Reported by Patrick Bregman
+	  * https://bugzilla.redhat.com/show_bug.cgi?id=3D863653 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9120, (1<<0)|(1<<1)},
+
+	/* Reported by  Pawe=C5=82 =C5=BBak, Korneliusz Jarz=C4=99bski, Danie=
l Mayer
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=3D42679 and by
+	 * Justin Piszcz  https://lkml.org/lkml/2012/11/24/94 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9123, (1<<0)|(1<<1)},
+
+	/* Used in a patch by Ying Chu
+	 * https://bugzilla.redhat.com/show_bug.cgi?id=3D757166 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9125, (1<<0)|(1<<1)},
+
+	/* Reported by Robert Cicconetti
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=3D42679 and by
+	 * Fernando https://bugzilla.redhat.com/show_bug.cgi?id=3D757166 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9128, (1<<0)|(1<<1)},
+
+	/* Reported by Stijn Tintel
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=3D42679 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9130, (1<<0)|(1<<1)},
+
+	/* Reported by Gaudenz Steinlin
+	 * https://lkml.org/lkml/2013/3/5/288 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9143, (1<<0)|(1<<1)},
+
+	/* Reported by Andrew Cooks
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=3D42679 */
+	{ PCI_VENDOR_ID_MARVELL_EXT, 0x9172, (1<<0)|(1<<1)},
+
+	{ 0 }
+};
+
+/*
+ * The mapping of quirky requester ids is used when the device driver =
sets up
+ * dma, if iommu is enabled.
+ */
+u8 pci_multi_requesters(struct pci_dev *dev)
+{
+	const struct pci_dev_dma_multi_source_map *i;
+
+	for (i =3D pci_dev_dma_multi_source_map; i->func_map; i++) {
+		if ((i->vendor =3D=3D dev->vendor ||
+		     i->vendor =3D=3D (u16)PCI_ANY_ID) &&
+		    (i->device =3D=3D dev->device ||
+		     i->device =3D=3D (u16)PCI_ANY_ID)) {
+			return i->func_map;
+		}
+	}
+	return 0;
+}
+
+/* These are one-to-one translations for devices that use a single inc=
orrect
+ * requester ID. The requester id may not be the BDF of a real device.
+ */
+static const struct pci_dev_dma_source_map {
+	u16 vendor;
+	u16 device;
+	u8  devfn;
+	u8  dma_devfn;
+} pci_dev_dma_source_map[] =3D {
+
+	/* Ricoh IEEE 1394 Controller */
+	{
+		PCI_VENDOR_ID_RICOH,
+		0xe832,
+		PCI_DEVFN(0x00, 3),
+		PCI_DEVFN(0x00, 0)
+	},
+
+	/* Nils Caspar - Adaptec 3405
+	 * http://www.mail-archive.com/centos@centos.org/msg90986.html
+	 * Jonathan McCune
+	 * http://old-list-archives.xen.org/archives/html/xen-users/2010-04/m=
sg00535.html */
+	{
+		PCI_VENDOR_ID_ADAPTEC2,
+		0x028b,
+		PCI_DEVFN(0x0e, 0),
+		PCI_DEVFN(0x01, 0)
+	},
+
+	/* Mateusz Murawski - LSI SAS based MegaRAID
+	 * https://lkml.org/lkml/2011/9/12/104
+	 * M. Nunberg - Dell PERC 5/i Integrated RAID Controller
+	 * http://lists.xen.org/archives/html/xen-devel/2010-05/msg01563.html=
 */
+	{
+		PCI_VENDOR_ID_LSI_LOGIC,
+		0x0411,
+		PCI_DEVFN(0x0e, 0),
+		PCI_DEVFN(0x08, 0)
+	},
+
+	/* Steven Dake, Markus Stockhausen - Mellanox 26428
+	 * https://bugzilla.redhat.com/show_bug.cgi?id=3D713774
+	 * Note: mellanox uses decimal product numbers, convert to hex for PC=
I
+	 * device ID. ie. 26428 =3D=3D 0x673c */
+	{
+		PCI_VENDOR_ID_MELLANOX,
+		0x673c,
+		PCI_DEVFN(0x00, 0),
+		PCI_DEVFN(0x00, 6)
+	},
+
+	{ 0 }
+};
+
+u8 pci_requester(struct pci_dev *dev)
+{
+	const struct pci_dev_dma_source_map *i;
+
+	for (i =3D pci_dev_dma_source_map; i->devfn; i++) {
+		if ((i->vendor =3D=3D dev->vendor) &&
+		    (i->device =3D=3D dev->device) &&
+		    (i->devfn =3D=3D dev->devfn)) {
+			return i->dma_devfn;
+		}
+	}
+	return dev->devfn;
+}
+
+
 static const struct pci_dev_acs_enabled {
 	u16 vendor;
 	u16 device;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aab57b4abe..63582ad30f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1529,6 +1529,8 @@ enum pci_fixup_pass {
 #ifdef CONFIG_PCI_QUIRKS
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 struct pci_dev *pci_get_dma_source(struct pci_dev *dev);
+u8 pci_multi_requesters(struct pci_dev *dev);
+u8 pci_requester(struct pci_dev *dev);
 int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 void pci_dev_specific_enable_acs(struct pci_dev *dev);
 #else
@@ -1538,6 +1540,14 @@ static inline struct pci_dev *pci_get_dma_source=
(struct pci_dev *dev)
 {
 	return pci_dev_get(dev);
 }
+u8 pci_multi_requesters(struct pci_dev *dev)
+{
+	return 0;
+}
+u8 pci_requester(struct pci_dev *dev)
+{
+	return dev->devfn;
+}
 static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
 					       u16 acs_flags)
 {
