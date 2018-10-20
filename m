From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on Hi16xx soc
Date: Sat, 20 Oct 2018 15:36:54 +0800
Message-ID: <1540021014-8176-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: LinuxArm <linuxarm@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

The standard GITS_TRANSLATER register in ITS is only 4 bytes, but
Hisilicon expands the next 4 bytes to carry some IMPDEF information. That
means, total 8 bytes data will be written to MSIAddress each time.

MSIAddr: |----4bytes----|----4bytes----|
	 |    MSIData   |    IMPDEF    |

There is no problem for ITS, because the next 4 bytes space is reserved
in ITS. But it will overwrite the 4 bytes memory following "sync_count".
It's very fortunately that the previous and the next neighbour of the
"sync_count" are both aligned by 8 bytes, so no problem is met now.

It's good to explicitly add a workaround:
1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is
   always aligned by 8 bytes.
2. Add a "int" struct member to make sure the 4 bytes padding is always
   exist.

There is no functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5059d09..624fdd0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -586,7 +586,20 @@ struct arm_smmu_device {
 
 	struct arm_smmu_strtab_cfg	strtab_cfg;
 
-	u32				sync_count;
+	/*
+	 * The alignment and padding is required by Hi16xx of Hisilicon.
+	 * Because the ITS hardware on Hi16xx will truncate the MSIAddress(Here
+	 * it's the address of "sync_count") to 8 bytes boundary first, then
+	 * write 32 bits MSIdata at offset 0, and 32 bits IMPDEF data at offset
+	 * 4. Without this workaround, the adjacent member maybe overwritten.
+	 *
+	 *                    |---4bytes---|---4bytes---|
+	 * MSIAddress & (~0x7):   MSIdata  | IMPDEF data|
+	 */
+	struct {
+		u32			sync_count;
+		int			padding;
+	} __attribute__((aligned(8)));
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
-- 
1.8.3
