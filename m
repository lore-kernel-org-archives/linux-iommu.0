From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 1/2] PCI/ATS: Add pci_prg_resp_pasid_required() interface.
Date: Tue, 19 Feb 2019 11:04:51 -0800
Message-ID: <633c9f77321894bddce54727098092822d483f16.1550602470.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1550602470.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550602470.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, jacob.jun.pan@intel.com, keith.busch@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Return the PRG Response PASID Required bit in the Page Request
Status Register.

As per PCIe spec r4.0, sec 10.5.2.3, if this bit is Set, the device
expects a PASID TLP Prefix on PRG Response Messages when the
corresponding Page Requests had a PASID TLP Prefix. If Clear, the device
does not expect PASID TLP Prefixes on any PRG Response Message, and the
device behavior is undefined if the device receives a PRG Response Message
with a PASID TLP Prefix. Also the device behavior is undefined if this
bit is Set and the device receives a PRG Response Message with no PASID TLP
Prefix when the corresponding Page Requests had a PASID TLP Prefix.

This function will be used by drivers like IOMMU, if it is required to
check the status of the PRG Response PASID Required bit before enabling
the PASID support of the device.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c             | 30 ++++++++++++++++++++++++++++++
 include/linux/pci-ats.h       |  5 +++++
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 36 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 5b78f3b1b918..420cd0a578d0 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -368,6 +368,36 @@ int pci_pasid_features(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_pasid_features);
 
+/**
+ * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
+ *				 status.
+ * @pdev: PCI device structure
+ *
+ * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
+ *
+ * Even though the PRG response PASID status is read from PRI Status
+ * Register, since this API will mainly be used by PASID users, this
+ * function is defined within #ifdef CONFIG_PCI_PASID instead of
+ * CONFIG_PCI_PRI.
+ */
+int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{
+	u16 status;
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return 0;
+
+	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
+
+	if (status & PCI_PRI_STATUS_PASID)
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
+
 #define PASID_NUMBER_SHIFT	8
 #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
 /**
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 7c4b8e27268c..facfd6a18fe1 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -40,6 +40,7 @@ void pci_disable_pasid(struct pci_dev *pdev);
 void pci_restore_pasid_state(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
+int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 
 #else  /* CONFIG_PCI_PASID */
 
@@ -66,6 +67,10 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
 	return -EINVAL;
 }
 
+static int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{
+	return 0;
+}
 #endif /* CONFIG_PCI_PASID */
 
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e1e9888c85e6..898be572b010 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -880,6 +880,7 @@
 #define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
 #define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
 #define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
+#define  PCI_PRI_STATUS_PASID	0x8000	/* PRG Response PASID Required */
 #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
 #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
 #define PCI_EXT_CAP_PRI_SIZEOF	16
-- 
2.20.1
