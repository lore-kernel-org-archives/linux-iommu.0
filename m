From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 08/11] PCI: Clean up ATS error handling
Date: Mon, 20 Jul 2015 19:14:54 -0500
Message-ID: <20150721001454.28145.35617.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150721001243.28145.81610.stgit-1RhO1Y9PlrlHTL0Zs8A6p/gx64E7kk8eUsxypvmhUTTZJqsBc5GL+g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Gregor Dick <gdick-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

There's no need to BUG() if we enable ATS when it's already enabled.  We
don't need to BUG() when disabling ATS on a device that doesn't support ATS
or if it's already disabled.  If ATS is enabled, certainly we found an ATS
capability in the past, so it should still be there now.

Clean up these error paths.

Signed-off-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
 drivers/pci/ats.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 0b5b0ed..67524a7 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -44,11 +44,12 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	u16 ctrl;
 	struct pci_dev *pdev;
 
-	BUG_ON(dev->ats_cap && dev->ats_enabled);
-
 	if (!dev->ats_cap)
 		return -EINVAL;
 
+	if (pci_ats_enabled(dev))
+		return -EINVAL;
+
 	if (ps < PCI_ATS_MIN_STU)
 		return -EINVAL;
 
@@ -83,7 +84,8 @@ void pci_disable_ats(struct pci_dev *dev)
 	struct pci_dev *pdev;
 	u16 ctrl;
 
-	BUG_ON(!dev->ats_cap || !dev->ats_enabled);
+	if (!pci_ats_enabled(dev))
+		return;
 
 	if (atomic_read(&dev->ats_ref_cnt))
 		return;		/* VFs still enabled */
@@ -107,8 +109,6 @@ void pci_restore_ats_state(struct pci_dev *dev)
 
 	if (!pci_ats_enabled(dev))
 		return;
-	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS))
-		BUG();
 
 	ctrl = PCI_ATS_CTRL_ENABLE;
 	if (!dev->is_virtfn)
