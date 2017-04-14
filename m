From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] drivers/of_iommu: ignore SMMU DT nodes with status 'disabled'
Date: Fri, 14 Apr 2017 13:43:15 +0100
Message-ID: <20170414124315.2401-1-ard.biesheuvel@linaro.org>
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
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, joro@8bytes.org
Cc: robin.murphy@arm.com, will.deacon@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: iommu@lists.linux-foundation.org

DT nodes may have a status property, and if they do, such nodes should
only be considered present if the status property is set to 'okay'.

Currently, we call the init function of IOMMUs described by the device
tree without taking this into account, which may result in the output
below on systems where some SMMUs may be legally disabled.

 Failed to initialise IOMMU /smb/smmu@e0200000
 Failed to initialise IOMMU /smb/smmu@e0c00000
 arm-smmu e0a00000.smmu: probing hardware configuration...
 arm-smmu e0a00000.smmu: SMMUv1 with:
 arm-smmu e0a00000.smmu:  stage 2 translation
 arm-smmu e0a00000.smmu:  coherent table walk
 arm-smmu e0a00000.smmu:  stream matching with 32 register groups, mask 0x7fff
 arm-smmu e0a00000.smmu:  8 context banks (8 stage-2 only)
 arm-smmu e0a00000.smmu:  Supported page sizes: 0x60211000
 arm-smmu e0a00000.smmu:  Stage-2: 40-bit IPA -> 40-bit PA
 Failed to initialise IOMMU /smb/smmu@e0600000
 Failed to initialise IOMMU /smb/smmu@e0800000

Since this is not an error condition, only call the init function if
the device is enabled, which also inhibits the spurious error messages.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 2683e9fc0dcf..2dd1206e6c0d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -183,7 +183,7 @@ static int __init of_iommu_init(void)
 	for_each_matching_node_and_match(np, matches, &match) {
 		const of_iommu_init_fn init_fn = match->data;
 
-		if (init_fn(np))
+		if (of_device_is_available(np) && init_fn(np))
 			pr_err("Failed to initialise IOMMU %s\n",
 				of_node_full_name(np));
 	}
-- 
2.9.3
