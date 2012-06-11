From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 3/5] pci: export pci_user functions for use by other drivers
Date: Mon, 11 Jun 2012 09:27:19 -0600
Message-ID: <20120611152718.25959.93716.stgit@bling.home>
References: <20120611152021.25959.71601.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120611152021.25959.71601.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

VFIO PCI support will make use of these for user initiated
PCI config accesses.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---

 drivers/pci/access.c |    6 ++++--
 drivers/pci/pci.h    |    7 -------
 include/linux/pci.h  |    8 ++++++++
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 2a58164..ba91a7e 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -162,7 +162,8 @@ int pci_user_read_config_##size						\
 	if (ret > 0)							\
 		ret = -EINVAL;						\
 	return ret;							\
-}
+}									\
+EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
 
 /* Returns 0 on success, negative values indicate error. */
 #define PCI_USER_WRITE_CONFIG(size,type)				\
@@ -181,7 +182,8 @@ int pci_user_write_config_##size					\
 	if (ret > 0)							\
 		ret = -EINVAL;						\
 	return ret;							\
-}
+}									\
+EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
 
 PCI_USER_READ_CONFIG(byte, u8)
 PCI_USER_READ_CONFIG(word, u16)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e494347..f2dcc46 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -86,13 +86,6 @@ static inline bool pci_is_bridge(struct pci_dev *pci_dev)
 	return !!(pci_dev->subordinate);
 }
 
-extern int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
-extern int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
-extern int pci_user_read_config_dword(struct pci_dev *dev, int where, u32 *val);
-extern int pci_user_write_config_byte(struct pci_dev *dev, int where, u8 val);
-extern int pci_user_write_config_word(struct pci_dev *dev, int where, u16 val);
-extern int pci_user_write_config_dword(struct pci_dev *dev, int where, u32 val);
-
 struct pci_vpd_ops {
 	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
 	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ba51a21..4cb13e59 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -777,6 +777,14 @@ static inline int pci_write_config_dword(const struct pci_dev *dev, int where,
 	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
 }
 
+/* user-space driven config access */
+int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
+int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
+int pci_user_read_config_dword(struct pci_dev *dev, int where, u32 *val);
+int pci_user_write_config_byte(struct pci_dev *dev, int where, u8 val);
+int pci_user_write_config_word(struct pci_dev *dev, int where, u16 val);
+int pci_user_write_config_dword(struct pci_dev *dev, int where, u32 val);
+
 int __must_check pci_enable_device(struct pci_dev *dev);
 int __must_check pci_enable_device_io(struct pci_dev *dev);
 int __must_check pci_enable_device_mem(struct pci_dev *dev);
