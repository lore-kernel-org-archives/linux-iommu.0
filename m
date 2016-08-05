From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] iommu: narrow the search range by iterating on current bus
Date: Fri,  5 Aug 2016 13:47:47 +0000
Message-ID: <1470404867-26783-2-git-send-email-richard.weiyang@gmail.com>
References: <20160728090132.42c6ebc1@t450s.home>
	<1470404867-26783-1-git-send-email-richard.weiyang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470404867-26783-1-git-send-email-richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

According to the comments and code, get_pci_function_alias_group() and
get_pci_alias_group() do the search on the same pci bus. This means we can
just iterate on the bus the pci device attaches to.

This patch narrows the search range by just iterating on the current bus
and fix one typo in comment.

Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/iommu.c | 100 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3000051..2fae2c6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -634,29 +634,45 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
  * each function, we also need to look for aliases to or from other devices
  * that may already have a group.
  */
+
+struct alias_group_cb_data {
+	struct pci_dev *pdev;
+	struct iommu_group *group;
+	unsigned long *devfns;
+};
+
+static int __get_pci_function_alias_group(struct pci_dev *tmp, void *data)
+{
+	struct alias_group_cb_data *cb_data =
+		(struct alias_group_cb_data *)data;
+	struct pci_dev *pdev = cb_data->pdev;
+
+	if (tmp == pdev ||
+	    PCI_SLOT(tmp->devfn) != PCI_SLOT(pdev->devfn) ||
+	    pci_acs_enabled(tmp, REQ_ACS_FLAGS))
+		return 0;
+
+	cb_data->group = get_pci_alias_group(tmp, cb_data->devfns);
+	if (cb_data->group)
+		return 1;
+	else
+		return 0;
+}
+
 static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
 							unsigned long *devfns)
 {
-	struct pci_dev *tmp = NULL;
-	struct iommu_group *group;
+	struct alias_group_cb_data data;
 
 	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
 		return NULL;
 
-	for_each_pci_dev(tmp) {
-		if (tmp == pdev || tmp->bus != pdev->bus ||
-		    PCI_SLOT(tmp->devfn) != PCI_SLOT(pdev->devfn) ||
-		    pci_acs_enabled(tmp, REQ_ACS_FLAGS))
-			continue;
-
-		group = get_pci_alias_group(tmp, devfns);
-		if (group) {
-			pci_dev_put(tmp);
-			return group;
-		}
-	}
+	data.pdev = pdev;
+	data.group = NULL;
+	data.devfns = devfns;
+	pci_walk_bus_local(pdev->bus, __get_pci_function_alias_group, &data);
 
-	return NULL;
+	return data.group;
 }
 
 /*
@@ -668,11 +684,36 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
  * multifunction devices could have aliases between them that would cause a
  * loop.  To prevent this, we use a bitmap to track where we've been.
  */
+static int __get_pci_alias_group(struct pci_dev *tmp, void *data)
+{
+	struct alias_group_cb_data *cb_data =
+		(struct alias_group_cb_data *)data;
+	struct pci_dev *pdev = cb_data->pdev;
+
+	if (tmp == pdev)
+		return 0;
+
+	/* We alias them or they alias us */
+	if (pci_devs_are_dma_aliases(pdev, tmp)) {
+		cb_data->group = get_pci_alias_group(tmp, cb_data->devfns);
+		if (cb_data->group)
+			return 1;
+
+		cb_data->group = get_pci_function_alias_group(tmp,
+					cb_data->devfns);
+		if (cb_data->group)
+			return 1;
+	}
+
+	return 0;
+}
+
+
 static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 					       unsigned long *devfns)
 {
-	struct pci_dev *tmp = NULL;
 	struct iommu_group *group;
+	struct alias_group_cb_data data;
 
 	if (test_and_set_bit(pdev->devfn & 0xff, devfns))
 		return NULL;
@@ -681,27 +722,12 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 	if (group)
 		return group;
 
-	for_each_pci_dev(tmp) {
-		if (tmp == pdev || tmp->bus != pdev->bus)
-			continue;
-
-		/* We alias them or they alias us */
-		if (pci_devs_are_dma_aliases(pdev, tmp)) {
-			group = get_pci_alias_group(tmp, devfns);
-			if (group) {
-				pci_dev_put(tmp);
-				return group;
-			}
-
-			group = get_pci_function_alias_group(tmp, devfns);
-			if (group) {
-				pci_dev_put(tmp);
-				return group;
-			}
-		}
-	}
+	data.pdev = pdev;
+	data.group = NULL;
+	data.devfns = devfns;
+	pci_walk_bus_local(pdev->bus, __get_pci_alias_group, &data);
 
-	return NULL;
+	return data.group;
 }
 
 struct group_for_pci_data {
@@ -794,7 +820,7 @@ struct iommu_group *pci_device_group(struct device *dev)
 
 	/*
 	 * Look for existing groups on non-isolated functions on the same
-	 * slot and aliases of those funcions, if any.  No need to clear
+	 * slot and aliases of those functions, if any.  No need to clear
 	 * the search bitmap, the tested devfns are still valid.
 	 */
 	group = get_pci_function_alias_group(pdev, (unsigned long *)devfns);
-- 
2.5.0
