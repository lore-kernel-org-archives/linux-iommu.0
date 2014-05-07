From: "Su, Friendy" <Friendy.Su@sony.com.cn>
Subject: [PATCH v1 1/1] iommu/amd: fix enabling exclusion range for an exact
 device
Date: Wed, 7 May 2014 13:54:52 +0800
Message-ID: <053191AD6E9023439BF3970DE87005185086D31DA3@APSHAXMS02.ap.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "joro@8bytes.org" <joro@8bytes.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org


From: Su Friendy <friendy.su@sony.com.cn>

set_device_exclusion_range(u16 devid, struct ivmd_header *m) enables
exclusion range for ONE device. IOMMU does not translate the access
to the exclusion range from the device.

The device is specified by input argument 'devid'. But 'devid' is not
passed to the actual set function set_dev_entry_bit(), instead
'm->devid' is passed. 'm->devid' does not specify the exact device
which needs enable the exclusion range. 'm->devid' represents DeviceID
field of IVMD, which has different meaning depends on IVMD type.

The caller init_exclusion_range() sets 'devid' for ONE device. When
m->type is equal to ACPI_IVMD_TYPE_ALL or ACPI_IVMD_TYPE_RANGE,
'm->devid' is not equal to 'devid'.

This patch fixes 'm->devid' to 'devid'.

Signed-off-by: Su Friendy <friendy.su@sony.com.cn>
Signed-off-by: Tamori Masahiro <Masahiro.Tamori@jp.sony.com>
---
 drivers/iommu/amd_iommu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index b76c58d..0e08545 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -788,7 +788,7 @@ static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
 		 * per device. But we can enable the exclusion range per
 		 * device. This is done here
 		 */
-		set_dev_entry_bit(m->devid, DEV_ENTRY_EX);
+		set_dev_entry_bit(devid, DEV_ENTRY_EX);
 		iommu->exclusion_start = m->range_start;
 		iommu->exclusion_length = m->range_length;
 	}
-- 
1.8.2.1
