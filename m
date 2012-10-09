From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 3/5] amd_iommu: Split upstream bus device lookup
Date: Mon, 08 Oct 2012 22:49:48 -0600
Message-ID: <20121009044948.16302.92834.stgit@bling.home>
References: <20121009044057.16302.44577.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20121009044057.16302.44577.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg.Roedel-5C7GfCeVMHo@public.gmane.org, florian-Q0TRQrZM+Zzk1uMJSBkQmQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/iommu/amd_iommu.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6edbd0e..3a00b5ce 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -274,6 +274,18 @@ static void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
 	*from = to;
 }
 
+static struct pci_bus *find_hosted_bus(struct pci_bus *bus)
+{
+	while (!bus->self) {
+		if (!pci_is_root_bus(bus))
+			bus = bus->parent;
+		else
+			return ERR_PTR(-ENODEV);
+	}
+
+	return bus;
+}
+
 #define REQ_ACS_FLAGS	(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
 
 static struct pci_dev *get_isolation_root(struct pci_dev *pdev)
@@ -300,14 +312,9 @@ static struct pci_dev *get_isolation_root(struct pci_dev *pdev)
 	 * Finding the next device may require skipping virtual buses.
 	 */
 	while (!pci_is_root_bus(dma_pdev->bus)) {
-		struct pci_bus *bus = dma_pdev->bus;
-
-		while (!bus->self) {
-			if (!pci_is_root_bus(bus))
-				bus = bus->parent;
-			else
-				goto root_bus;
-		}
+		struct pci_bus *bus = find_hosted_bus(dma_pdev->bus);
+		if (IS_ERR(bus))
+			break;
 
 		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
 			break;
@@ -315,7 +322,6 @@ static struct pci_dev *get_isolation_root(struct pci_dev *pdev)
 		swap_pci_ref(&dma_pdev, pci_dev_get(bus->self));
 	}
 
-root_bus:
 	return dma_pdev;
 }
 
