From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 11/13] pci: Create common pcibios_err_to_errno
Date: Fri, 11 May 2012 16:56:44 -0600
Message-ID: <20120511225643.30496.36823.stgit@bling.home>
References: <20120511222148.30496.68571.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120511222148.30496.68571.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, joerg.roedel-5C7GfCeVMHo@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

For returning errors out to non-PCI code.  Re-name xen's version.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/xen/xen-pciback/conf_space.c |    6 +++---
 include/linux/pci.h                  |   26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
index 30d7be0..46ae0f9 100644
--- a/drivers/xen/xen-pciback/conf_space.c
+++ b/drivers/xen/xen-pciback/conf_space.c
@@ -124,7 +124,7 @@ static inline u32 merge_value(u32 val, u32 new_val, u32 new_val_mask,
 	return val;
 }
 
-static int pcibios_err_to_errno(int err)
+static int xen_pcibios_err_to_errno(int err)
 {
 	switch (err) {
 	case PCIBIOS_SUCCESSFUL:
@@ -202,7 +202,7 @@ out:
 		       pci_name(dev), size, offset, value);
 
 	*ret_val = value;
-	return pcibios_err_to_errno(err);
+	return xen_pcibios_err_to_errno(err);
 }
 
 int xen_pcibk_config_write(struct pci_dev *dev, int offset, int size, u32 value)
@@ -290,7 +290,7 @@ int xen_pcibk_config_write(struct pci_dev *dev, int offset, int size, u32 value)
 		}
 	}
 
-	return pcibios_err_to_errno(err);
+	return xen_pcibios_err_to_errno(err);
 }
 
 void xen_pcibk_config_free_dyn_fields(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b437225..20a8f2e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -467,6 +467,32 @@ static inline bool pci_dev_msi_enabled(struct pci_dev *pci_dev) { return false;
 #define PCIBIOS_SET_FAILED		0x88
 #define PCIBIOS_BUFFER_TOO_SMALL	0x89
 
+/*
+ * Translate above to generic errno for passing back through non-pci.
+ */
+static inline int pcibios_err_to_errno(int err)
+{
+	if (err <= PCIBIOS_SUCCESSFUL)
+		return err; /* Assume already errno */
+
+	switch (err) {
+	case PCIBIOS_FUNC_NOT_SUPPORTED:
+		return -ENOENT;
+	case PCIBIOS_BAD_VENDOR_ID:
+		return -EINVAL;
+	case PCIBIOS_DEVICE_NOT_FOUND:
+		return -ENODEV;
+	case PCIBIOS_BAD_REGISTER_NUMBER:
+		return -EFAULT;
+	case PCIBIOS_SET_FAILED:
+		return -EIO;
+	case PCIBIOS_BUFFER_TOO_SMALL:
+		return -ENOSPC;
+	}
+
+	return -ENOTTY;
+}
+
 /* Low-level architecture-dependent routines */
 
 struct pci_ops {
