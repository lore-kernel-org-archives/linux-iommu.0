From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 07/11] PCI: Use pci_physfn() rather than looking up
 physfn by hand
Date: Tue, 11 Aug 2015 10:51:53 -0500
Message-ID: <20150811155153.21078.69519.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, David Woodhouse <dwmw2@infradead.org>
Cc: Gregor Dick <gdick@solarflare.com>, iommu@lists.linux-foundation.org, Yinghai Lu <yinghai@kernel.org>
List-Id: iommu@lists.linux-foundation.org

Use the pci_physfn() helper rather than looking up physfn by hand.
No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/pci/ats.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 95905f3..0b5b0ed 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -42,6 +42,7 @@ void pci_ats_init(struct pci_dev *dev)
 int pci_enable_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
+	struct pci_dev *pdev;
 
 	BUG_ON(dev->ats_cap && dev->ats_enabled);
 
@@ -57,8 +58,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	 */
 	ctrl = PCI_ATS_CTRL_ENABLE;
 	if (dev->is_virtfn) {
-		struct pci_dev *pdev = dev->physfn;
-
+		pdev = pci_physfn(dev);
 		if (pdev->ats_stu != ps)
 			return -EINVAL;
 
@@ -80,6 +80,7 @@ EXPORT_SYMBOL_GPL(pci_enable_ats);
  */
 void pci_disable_ats(struct pci_dev *dev)
 {
+	struct pci_dev *pdev;
 	u16 ctrl;
 
 	BUG_ON(!dev->ats_cap || !dev->ats_enabled);
@@ -88,8 +89,7 @@ void pci_disable_ats(struct pci_dev *dev)
 		return;		/* VFs still enabled */
 
 	if (dev->is_virtfn) {
-		struct pci_dev *pdev = dev->physfn;
-
+		pdev = pci_physfn(dev);
 		atomic_dec(&pdev->ats_ref_cnt);
 	}
 
