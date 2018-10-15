From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] iommu/arm-smmu-v3: eliminate a potential memory
	corruption on Hi16xx soc
Date: Mon, 15 Oct 2018 16:36:16 +0800
Message-ID: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: LinuxArm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

ITS translation register map:
0x0000-0x003C	Reserved
0x0040		GITS_TRANSLATER
0x0044-0xFFFC	Reserved

The standard GITS_TRANSLATER register in ITS is only 4 bytes, but Hisilicon
expands the next 4 bytes to carry some IMPDEF information. That means, 8 bytes
data will be written to MSIAddress each time.

MSIAddr: |----4bytes----|----4bytes----|
	 |    MSIData   |    IMPDEF    |

There is no problem for ITS, because the next 4 bytes space is reserved in ITS.
But it will overwrite the 4 bytes memory following "sync_count". It's very
luckly that the previous and the next neighbour of "sync_count" are both aligned
by 8 bytes, so no problem is met now.

It's good to explicitly add a workaround:
1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is always
   aligned by 8 bytes.
2. Add a "u64" union member to make sure the 4 bytes padding is always exist.

There is no functional change.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5059d09..a07bc0d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -586,7 +586,10 @@ struct arm_smmu_device {
 
 	struct arm_smmu_strtab_cfg	strtab_cfg;
 
+	union {
+	u64				padding; /* workaround for Hisilicon */
 	u32				sync_count;
+	} __attribute__((aligned(8)));
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
-- 
1.8.3
