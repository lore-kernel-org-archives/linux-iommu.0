From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] iommu/fsl_pamu: Use dev_is_pci() to check whether it is
	pci device
Date: Thu, 5 Dec 2013 19:42:49 +0800
Message-ID: <1386243769-22672-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Use PCI standard marco dev_is_pci() instead of directly compare
pci_bus_type to check whether it is pci device.

Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/fsl_pamu_domain.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index c857c30..93072ba 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -691,7 +691,7 @@ static int fsl_pamu_attach_device(struct iommu_domain *domain,
 	 * Use LIODN of the PCI controller while attaching a
 	 * PCI device.
 	 */
-	if (dev->bus == &pci_bus_type) {
+	if (dev_is_pci(dev)) {
 		pdev = to_pci_dev(dev);
 		pci_ctl = pci_bus_to_host(pdev->bus);
 		/*
@@ -729,7 +729,7 @@ static void fsl_pamu_detach_device(struct iommu_domain *domain,
 	 * Use LIODN of the PCI controller while detaching a
 	 * PCI device.
 	 */
-	if (dev->bus == &pci_bus_type) {
+	if (dev_is_pci(dev)) {
 		pdev = to_pci_dev(dev);
 		pci_ctl = pci_bus_to_host(pdev->bus);
 		/*
@@ -1056,7 +1056,7 @@ static int fsl_pamu_add_device(struct device *dev)
 	 * For platform devices we allocate a separate group for
 	 * each of the devices.
 	 */
-	if (dev->bus == &pci_bus_type) {
+	if (dev_is_pci(dev)) {
 		pdev = to_pci_dev(dev);
 		/* Don't create device groups for virtual PCI bridges */
 		if (pdev->subordinate)
-- 
1.7.1
