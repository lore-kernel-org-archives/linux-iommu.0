From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 06/13] iommu: Make use of DMA quirking and ACS enabled check
	for groups
Date: Fri, 11 May 2012 16:56:09 -0600
Message-ID: <20120511225609.30496.92191.stgit@bling.home>
References: <20120511222148.30496.68571.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120511222148.30496.68571.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, joerg.roedel-5C7GfCeVMHo@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Incorporate DMA quirking and ACS checking into amd_iommu and
intel-iommu.  Note that IOMMU groups are not yet used for
streaming DMA, so this doesn't immediately solve the problems
with broken Ricoh devices.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/iommu/amd_iommu.c   |    3 +++
 drivers/iommu/intel-iommu.c |    3 +++
 drivers/pci/pci.h           |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b7e5ddf..a165311 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -291,6 +291,9 @@ static int iommu_init_device(struct device *dev)
 		dma_pdev = pci_get_slot(pdev->bus,
 					PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
 
+	dma_pdev = pci_dma_quirk(dma_pdev);
+	dma_pdev = pci_acs_enabled(dma_pdev);
+
 	group = iommu_group_get(&dma_pdev->dev);
 	if (!group) {
 		group = iommu_group_alloc();
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e63b33b..5f526c7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4113,6 +4113,9 @@ static int intel_iommu_add_device(struct device *dev)
 		dma_pdev = pci_get_slot(pdev->bus,
 					PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
 
+	dma_pdev = pci_dma_quirk(dma_pdev);
+	dma_pdev = pci_acs_enabled(dma_pdev);
+
 	group = iommu_group_get(&dma_pdev->dev);
 	if (!group) {
 		group = iommu_group_alloc();
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e494347..e8f2f8f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -310,6 +310,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 }
 
 extern void pci_enable_acs(struct pci_dev *dev);
+extern struct pci_dev *pci_acs_enabled(struct pci_dev *dev);
 
 struct pci_dev_reset_methods {
 	u16 vendor;
