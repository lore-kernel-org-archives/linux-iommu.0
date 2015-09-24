From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 03/10] iommu/amd: Get the first/last device of iommu earlier
Date: Thu, 24 Sep 2015 14:37:29 +0800
Message-ID: <1443076656-31776-4-git-send-email-bhe@redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443076656-31776-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

iommu->first_device/last_device are needed by function init_iommu_from_acpi()
and init_iommu_devices(). So putting the assignment of them in iommu_init_pci()
could be late. In this patch put them earlier.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index be20a56..5845918 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1115,6 +1115,9 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	iommu->pci_seg = h->pci_seg;
 	iommu->mmio_phys = h->mmio_phys;
 
+	iommu->first_device = find_first_devid_on_pci(h);
+	iommu->last_device = find_last_devid_on_pci(h);
+
 	/* Check if IVHD EFR contains proper max banks/counters */
 	if ((h->efr != 0) &&
 	    ((h->efr & (0xF << 13)) != 0) &&
@@ -1276,16 +1279,9 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_CAP_HDR_OFFSET,
 			      &iommu->cap);
-	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_RANGE_OFFSET,
-			      &range);
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_MISC_OFFSET,
 			      &misc);
 
-	iommu->first_device = PCI_DEVID(MMIO_GET_BUS(range),
-					 MMIO_GET_FD(range));
-	iommu->last_device = PCI_DEVID(MMIO_GET_BUS(range),
-					MMIO_GET_LD(range));
-
 	if (!(iommu->cap & (1 << IOMMU_CAP_IOTLB)))
 		amd_iommu_iotlb_sup = false;
 
-- 
2.4.0
