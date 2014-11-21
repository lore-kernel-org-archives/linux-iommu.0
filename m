From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] PCI: Extend and export pci_msi_supported() for
	multivector MSI
Date: Fri, 21 Nov 2014 15:08:46 -0700
Message-ID: <20141121220845.31095.19173.stgit@gimli.home>
References: <20141121213752.31095.30735.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141121213752.31095.30735.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Embrace and extend this existing function as an interface to test
for multivector MSI support.  Drivers can now call this function
with nvec >1 and type PCI_CAP_ID_MSI to verify whether the platform
is capable of supporting multiple MSI vectors.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/pci/msi.c   |   15 ++++++++++++---
 include/linux/pci.h |    3 +++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 36b503a..da3c709 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -793,12 +793,13 @@ out_free:
  * pci_msi_supported - check whether MSI may be enabled on a device
  * @dev: pointer to the pci_dev data structure of MSI device function
  * @nvec: how many MSIs have been requested ?
+ * @type: PCI_CAP_ID_MSI or PCI_CAP_ID_MSIX
  *
  * Look at global flags, the device itself, and its parent buses
  * to determine if MSI/-X are supported for the device. If MSI/-X is
  * supported return 1, else return 0.
  **/
-static int pci_msi_supported(struct pci_dev *dev, int nvec)
+int pci_msi_supported(struct pci_dev *dev, int nvec, int type)
 {
 	struct pci_bus *bus;
 
@@ -809,6 +810,9 @@ static int pci_msi_supported(struct pci_dev *dev, int nvec)
 	if (!dev || dev->no_msi || dev->current_state != PCI_D0)
 		return 0;
 
+	if (type != PCI_CAP_ID_MSI && type != PCI_CAP_ID_MSIX)
+		return 0;
+
 	/*
 	 * You can't ask to have 0 or less MSIs configured.
 	 *  a) it's stupid ..
@@ -828,8 +832,13 @@ static int pci_msi_supported(struct pci_dev *dev, int nvec)
 		if (bus->bus_flags & PCI_BUS_FLAGS_NO_MSI)
 			return 0;
 
+	if (type == PCI_CAP_ID_MSI && nvec > 1 &&
+	    !arch_supports_multivector_msi(dev))
+		return 0;
+
 	return 1;
 }
+EXPORT_SYMBOL(pci_msi_supported);
 
 /**
  * pci_msi_vec_count - Return the number of MSI vectors a device can send
@@ -930,7 +939,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 	int nr_entries;
 	int i, j;
 
-	if (!pci_msi_supported(dev, nvec))
+	if (!pci_msi_supported(dev, nvec, PCI_CAP_ID_MSIX))
 		return -EINVAL;
 
 	if (!entries)
@@ -1041,7 +1050,7 @@ int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
 	int nvec;
 	int rc;
 
-	if (!pci_msi_supported(dev, minvec))
+	if (!pci_msi_supported(dev, minvec, PCI_CAP_ID_MSI))
 		return -EINVAL;
 
 	WARN_ON(!!dev->msi_enabled);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c9a8904..f20605e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1197,6 +1197,7 @@ struct msix_entry {
 
 
 #ifdef CONFIG_PCI_MSI
+int pci_msi_supported(struct pci_dev *dev, int nvec, int type);
 int pci_msi_vec_count(struct pci_dev *dev);
 void pci_msi_shutdown(struct pci_dev *dev);
 void pci_disable_msi(struct pci_dev *dev);
@@ -1225,6 +1226,8 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 	return 0;
 }
 #else
+static inline int pci_msi_supported(struct pci_dev *dev, int nvec, int type)
+{ return 0; }
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline void pci_msi_shutdown(struct pci_dev *dev) { }
 static inline void pci_disable_msi(struct pci_dev *dev) { }
