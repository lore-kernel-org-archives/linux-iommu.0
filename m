From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 06/11] PCI: Inline the ATS setup code into pci_ats_init()
Date: Mon, 20 Jul 2015 19:14:38 -0500
Message-ID: <20150721001438.28145.28518.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, David Woodhouse <dwmw2@infradead.org>
Cc: iommu@lists.linux-foundation.org, Gregor Dick <gdick@solarflare.com>
List-Id: iommu@lists.linux-foundation.org

The ATS setup code in ats_alloc_one() is only used by pci_ats_init(), so
inline it there.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/pci/ats.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9a98b3a..95905f3 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -17,7 +17,7 @@
 
 #include "pci.h"
 
-static void ats_alloc_one(struct pci_dev *dev)
+void pci_ats_init(struct pci_dev *dev)
 {
 	int pos;
 	u16 cap;
@@ -32,11 +32,6 @@ static void ats_alloc_one(struct pci_dev *dev)
 					    PCI_ATS_MAX_QDEP;
 }
 
-void pci_ats_init(struct pci_dev *dev)
-{
-	ats_alloc_one(dev);
-}
-
 /**
  * pci_enable_ats - enable the ATS capability
  * @dev: the PCI device
