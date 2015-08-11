From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 05/11] PCI: Rationalize pci_ats_queue_depth() error
 checking
Date: Tue, 11 Aug 2015 10:51:39 -0500
Message-ID: <20150811155139.21078.30228.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

We previously returned -ENODEV for devices that don't support ATS (except
that we always returned 0 for VFs, whether or not they support ATS).

For consistency, always return -EINVAL (not -ENODEV) if the device doesn't
support ATS.  Return zero for VFs that support ATS.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/pci/ats.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 690ae6e..9a98b3a 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -136,13 +136,13 @@ EXPORT_SYMBOL_GPL(pci_restore_ats_state);
  */
 int pci_ats_queue_depth(struct pci_dev *dev)
 {
+	if (!dev->ats_cap)
+		return -EINVAL;
+
 	if (dev->is_virtfn)
 		return 0;
 
-	if (dev->ats_cap)
-		return dev->ats_qdep;
-
-	return -ENODEV;
+	return dev->ats_qdep;
 }
 EXPORT_SYMBOL_GPL(pci_ats_queue_depth);
 
