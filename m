From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/5] iommu: Move REQ_ACS_FLAGS out to header and rename
Date: Wed, 26 Oct 2016 12:01:34 -0600
Message-ID: <20161026180134.23495.27520.stgit@gimli.home>
References: <20161026175156.23495.12980.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161026175156.23495.12980.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Allow other parts of the kernel to see which PCI ACS flags the IOMMU
layer considers necessary for isolation.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/iommu.c |   18 +++++-------------
 include/linux/iommu.h |   11 +++++++++++
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b06d935..f73e6f4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -610,16 +610,6 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 					       unsigned long *devfns);
 
 /*
- * To consider a PCI device isolated, we require ACS to support Source
- * Validation, Request Redirection, Completer Redirection, and Upstream
- * Forwarding.  This effectively means that devices cannot spoof their
- * requester ID, requests and completions cannot be redirected, and all
- * transactions are forwarded upstream, even as it passes through a
- * bridge where the target device is downstream.
- */
-#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
-
-/*
  * For multifunction devices which are not isolated from each other, find
  * all the other non-isolated functions and look for existing groups.  For
  * each function, we also need to look for aliases to or from other devices
@@ -631,13 +621,14 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
 	struct pci_dev *tmp = NULL;
 	struct iommu_group *group;
 
-	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
+	if (!pdev->multifunction ||
+	    pci_acs_enabled(pdev, IOMMU_REQ_PCI_ACS_FLAGS))
 		return NULL;
 
 	for_each_pci_dev(tmp) {
 		if (tmp == pdev || tmp->bus != pdev->bus ||
 		    PCI_SLOT(tmp->devfn) != PCI_SLOT(pdev->devfn) ||
-		    pci_acs_enabled(tmp, REQ_ACS_FLAGS))
+		    pci_acs_enabled(tmp, IOMMU_REQ_PCI_ACS_FLAGS))
 			continue;
 
 		group = get_pci_alias_group(tmp, devfns);
@@ -765,7 +756,8 @@ struct iommu_group *pci_device_group(struct device *dev)
 		if (!bus->self)
 			continue;
 
-		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
+		if (pci_acs_path_enabled(bus->self, NULL,
+					 IOMMU_REQ_PCI_ACS_FLAGS))
 			break;
 
 		pdev = bus->self;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a35fb8b..23f4d1d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -131,6 +131,17 @@ struct iommu_dm_region {
 	int			prot;
 };
 
+/*
+ * To consider a PCI device isolated, we require ACS to support Source
+ * Validation, Request Redirection, Completer Redirection, and Upstream
+ * Forwarding.  This effectively means that devices cannot spoof their
+ * requester ID, requests and completions cannot be redirected, and all
+ * transactions are forwarded upstream, even as it passes through a
+ * bridge where the target device is downstream.
+ */
+#define IOMMU_REQ_PCI_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | \
+				   PCI_ACS_CR | PCI_ACS_UF)
+
 #ifdef CONFIG_IOMMU_API
 
 /**
