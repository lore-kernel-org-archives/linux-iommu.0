From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Date: Mon, 12 Nov 2018 19:06:25 +0300
Message-ID: <20181112160628.86620-2-mika.westerberg@linux.intel.com>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181112160628.86620-1-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mario.Limonciello-8PEkshWhKlo@public.gmane.org, Michael Jamet <michael.jamet-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Christian Kellner <ckellner-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Yehezkel Bernat <YehezkelShB-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anthony Wong <anthony.wong-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Jacob jun Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Recent systems shipping Windows 10 version 1803 or later may support
IOMMU based DMA protection. This means that the platform utilizes IOMMU
to prevent DMA attacks over externally exposed PCIe root ports
(typically Thunderbolt ports)

The system BIOS marks these PCIe root ports as being externally facing
ports by implementing following ACPI _DSD under the root port in
question:

  Name (_DSD, Package () {
      ToUUID ("efcc06cc-73ac-4bc3-bff0-76143807c389"),
      Package () {
          Package () {"ExternalFacingPort", 1},
	  Package () {"UID", 0 }
      }
  })

This is documented [1].

To make it possible for IOMMU code to identify these external devices,
we look up for this property and mark all children devices (including
the root port itself) with a new flag (->is_external).

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 13 +++++++++++++
 drivers/pci/probe.c     | 23 +++++++++++++++++++++++
 include/linux/pci.h     |  1 +
 4 files changed, 40 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8c7c4583b52d..4bdad32f62c8 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -31,6 +31,9 @@ static const guid_t prp_guids[] = {
 	/* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
 	GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
 		  0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
+	/* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
+	GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
+		  0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
 };
 
 static const guid_t ads_guid =
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 2a4aa6468579..fc193279d24d 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -789,6 +789,18 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
+static void pci_acpi_set_external(struct pci_dev *dev)
+{
+	u8 val;
+
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+		return;
+	if (device_property_read_u8(&dev->dev, "ExternalFacingPort", &val))
+		return;
+
+	dev->is_external = val == 1;
+}
+
 static void pci_acpi_setup(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -803,6 +815,7 @@ static void pci_acpi_setup(struct device *dev)
 		set_dev_node(dev, node);
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
+	pci_acpi_set_external(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
 	if (!adev->wakeup.flags.valid)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b1c05b5054a0..f1db195a4a90 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1378,6 +1378,27 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 	}
 }
 
+static void set_pcie_external(struct pci_dev *dev)
+{
+	struct pci_dev *parent;
+
+	/*
+	 * Walk up the device hierarchy and check for any upstream
+	 * bridge that has is_external_facing set to true. This means
+	 * the hierarchy is below PCIe port that is exposed externally
+	 * (such as Thunderbolt).
+	 */
+	parent = pci_upstream_bridge(dev);
+	while (parent) {
+		if (parent->is_external) {
+			dev->is_external = true;
+			break;
+		}
+
+		parent = pci_upstream_bridge(parent);
+	}
+}
+
 /**
  * pci_ext_cfg_is_aliased - Is ext config space just an alias of std config?
  * @dev: PCI device
@@ -1638,6 +1659,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Need to have dev->cfg_size ready */
 	set_pcie_thunderbolt(dev);
 
+	set_pcie_external(dev);
+
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 11c71c4ecf75..e1c0e032da55 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -396,6 +396,7 @@ struct pci_dev {
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
+	unsigned int	is_external:1;		/* External PCIe device */
 	unsigned int	__aer_firmware_first_valid:1;
 	unsigned int	__aer_firmware_first:1;
 	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
-- 
2.19.1
