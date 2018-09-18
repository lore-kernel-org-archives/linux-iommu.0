From: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu/amd: return devid as alias for ACPI HID devices
Date: Tue, 18 Sep 2018 15:40:58 +0530
Message-ID: <20180918101058.2365-1-arindam.nath@amd.com>
Reply-To: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

ACPI HID devices do not actually have an alias for
them in the IVRS. But dev_data->alias is still used
for indexing into the IOMMU device table for devices
being handled by the IOMMU. So for ACPI HID devices,
we simply return the corresponding devid as an alias,
as parsed from IVRS table.

Signed-off-by: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 4e04fff23977..73e47d93e7a0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -246,7 +246,13 @@ static u16 get_alias(struct device *dev)
 
 	/* The callers make sure that get_device_id() does not fail here */
 	devid = get_device_id(dev);
+
+	/* For ACPI HID devices, we simply return the devid as such */
+	if (!dev_is_pci(dev))
+		return devid;
+
 	ivrs_alias = amd_iommu_alias_table[devid];
+
 	pci_for_each_dma_alias(pdev, __last_alias, &pci_alias);
 
 	if (ivrs_alias == pci_alias)
-- 
2.17.1
