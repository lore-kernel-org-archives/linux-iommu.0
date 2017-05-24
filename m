From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 1/7] PCI: Move ATS declarations outside of CONFIG_PCI
Date: Wed, 24 May 2017 19:01:37 +0100
Message-ID: <20170524180143.19855-2-jean-philippe.brucker@arm.com>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, okaya@codeaurora.org, sunil.kovvuri@gmail.com, thunder.leizhen@huawei.com, tn@semihalf.com
List-Id: iommu@lists.linux-foundation.org

Currently ATS helpers like pci_enable_ats are only defined when CONFIG_PCI
is enabled. The ARM SMMU driver might get built with CONFIG_PCI disabled.
It would thus have to wrap any use of ATS helpers around #ifdef
CONFIG_PCI, which isn't ideal.

A nicer solution is to always define these helpers. Since CONFIG_PCI_ATS
is only enabled in association with CONFIG_PCI, move defines outside of
CONFIG_PCI to prevent build failure when PCI is disabled.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 33c2b0b77429..775d495ef8d7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1415,19 +1415,6 @@ int  ht_create_irq(struct pci_dev *dev, int idx);
 void ht_destroy_irq(unsigned int irq);
 #endif /* CONFIG_HT_IRQ */
 
-#ifdef CONFIG_PCI_ATS
-/* Address Translation Service */
-void pci_ats_init(struct pci_dev *dev);
-int pci_enable_ats(struct pci_dev *dev, int ps);
-void pci_disable_ats(struct pci_dev *dev);
-int pci_ats_queue_depth(struct pci_dev *dev);
-#else
-static inline void pci_ats_init(struct pci_dev *d) { }
-static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
-static inline void pci_disable_ats(struct pci_dev *d) { }
-static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
-#endif
-
 #ifdef CONFIG_PCIE_PTM
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
 #else
@@ -1613,6 +1600,19 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 #define dev_is_pf(d) (false)
 #endif /* CONFIG_PCI */
 
+#ifdef CONFIG_PCI_ATS
+/* Address Translation Service */
+void pci_ats_init(struct pci_dev *dev);
+int pci_enable_ats(struct pci_dev *dev, int ps);
+void pci_disable_ats(struct pci_dev *dev);
+int pci_ats_queue_depth(struct pci_dev *dev);
+#else
+static inline void pci_ats_init(struct pci_dev *d) { }
+static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
+static inline void pci_disable_ats(struct pci_dev *d) { }
+static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
+#endif
+
 /* Include architecture-dependent settings and functions */
 
 #include <asm/pci.h>
-- 
2.12.1

