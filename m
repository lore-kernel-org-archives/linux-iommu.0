From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/4] iommu/vt-d: Force IOMMU on for platform opt in hint
Date: Mon, 12 Nov 2018 19:06:26 +0300
Message-ID: <20181112160628.86620-3-mika.westerberg@linux.intel.com>
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

From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Intel VT-d spec added a new DMA_CTRL_PLATFORM_OPT_IN_FLAG flag
in DMAR ACPI table for BIOS to report compliance about platform
initiated DMA restricted to RMRR ranges when transferring control
to the OS. The OS treats this as a hint that the IOMMU should be
enabled to prevent DMA attacks from possible malicious devices.

A use of this flag is Kernel DMA protection for Thunderbolt[1]
which in practice means that IOMMU should be enabled for PCIe
devices connected to the Thunderbolt ports. With IOMMU enabled
for these devices, all DMA operations are limited in the range
reserved for it, thus the DMA attacks are prevented. All these
devices are enumerated in the PCI/PCIe module and marked with
an is_external flag.

This forces IOMMU to be enabled if DMA_CTRL_PLATFORM_OPT_IN_FLAG
is set in DMAR ACPI table and there are PCIe devices marked as
is_external in the system. This can be turned off by adding
"intel_iommu=off" in the kernel command line, if any problems are
found.

[1] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c        | 25 +++++++++++++++++
 drivers/iommu/intel-iommu.c | 55 +++++++++++++++++++++++++++++++++++--
 include/linux/dmar.h        |  8 ++++++
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index d9c748b6f9e4..1edf2a251336 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -2042,3 +2042,28 @@ int dmar_device_remove(acpi_handle handle)
 {
 	return dmar_device_hotplug(handle, false);
 }
+
+/*
+ * dmar_platform_optin - Is %DMA_CTRL_PLATFORM_OPT_IN_FLAG set in DMAR table
+ *
+ * Returns true if the platform has %DMA_CTRL_PLATFORM_OPT_IN_FLAG set in
+ * the ACPI DMAR table. This means that the platform boot firmware has made
+ * sure no device can issue DMA outside of RMRR regions.
+ */
+bool dmar_platform_optin(void)
+{
+	struct acpi_table_dmar *dmar;
+	acpi_status status;
+	bool ret;
+
+	status = acpi_get_table(ACPI_SIG_DMAR, 0,
+				(struct acpi_table_header **)&dmar);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	ret = !!(dmar->flags & DMAR_PLATFORM_OPT_IN);
+	acpi_put_table((struct acpi_table_header *)dmar);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dmar_platform_optin);
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f3ccf025108b..ada786b05a59 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -184,6 +184,7 @@ static int rwbf_quirk;
  */
 static int force_on = 0;
 int intel_iommu_tboot_noforce;
+static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
 
@@ -503,6 +504,7 @@ static int __init intel_iommu_setup(char *str)
 			pr_info("IOMMU enabled\n");
 		} else if (!strncmp(str, "off", 3)) {
 			dmar_disabled = 1;
+			no_platform_optin = 1;
 			pr_info("IOMMU disabled\n");
 		} else if (!strncmp(str, "igfx_off", 8)) {
 			dmar_map_gfx = 0;
@@ -2895,6 +2897,14 @@ static int iommu_should_identity_map(struct device *dev, int startup)
 		if (device_is_rmrr_locked(dev))
 			return 0;
 
+		/*
+		 * Prevent any device marked as an external one from getting
+		 * placed into the statically identity mapping domain. This
+		 * is done because external devices are always untrusted.
+		 */
+		if (pdev->is_external)
+			return 0;
+
 		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
 			return 1;
 
@@ -4728,14 +4738,55 @@ const struct attribute_group *intel_iommu_groups[] = {
 	NULL,
 };
 
+static int __init platform_optin_force_iommu(void)
+{
+	struct pci_dev *pdev = NULL;
+	bool has_ext_dev = false;
+
+	if (!dmar_platform_optin() || no_platform_optin)
+		return 0;
+
+	for_each_pci_dev(pdev) {
+		if (pdev->is_external) {
+			has_ext_dev = true;
+			break;
+		}
+	}
+
+	if (!has_ext_dev)
+		return 0;
+
+	if (no_iommu || dmar_disabled)
+		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
+
+	/*
+	 *  If Intel-IOMMU is disabled by default, we will apply
+	 *  identity map for all devices except those marked as
+	 *  unsafe external devices.
+	 */
+	if (dmar_disabled)
+		iommu_identity_mapping |= IDENTMAP_ALL;
+
+	dmar_disabled = 0;
+#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
+	swiotlb = 0;
+#endif
+	no_iommu = 0;
+
+	return 1;
+}
+
 int __init intel_iommu_init(void)
 {
 	int ret = -ENODEV;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 
-	/* VT-d is required for a TXT/tboot launch, so enforce that */
-	force_on = tboot_force_iommu();
+	/*
+	 * Intel IOMMU is required for a TXT/tboot launch or platform
+	 * opt in, so enforce that.
+	 */
+	force_on = tboot_force_iommu() || platform_optin_force_iommu();
 
 	if (iommu_init_mempool()) {
 		if (force_on)
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 843a41ba7e28..f8af1d770520 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -39,6 +39,7 @@ struct acpi_dmar_header;
 /* DMAR Flags */
 #define DMAR_INTR_REMAP		0x1
 #define DMAR_X2APIC_OPT_OUT	0x2
+#define DMAR_PLATFORM_OPT_IN	0x4
 
 struct intel_iommu;
 
@@ -170,6 +171,8 @@ static inline int dmar_ir_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 { return 0; }
 #endif /* CONFIG_IRQ_REMAP */
 
+extern bool dmar_platform_optin(void);
+
 #else /* CONFIG_DMAR_TABLE */
 
 static inline int dmar_device_add(void *handle)
@@ -182,6 +185,11 @@ static inline int dmar_device_remove(void *handle)
 	return 0;
 }
 
+static inline bool dmar_platform_optin(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_DMAR_TABLE */
 
 struct irte {
-- 
2.19.1
