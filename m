From: linucherian@gmail.com
Subject: [RFC PATCH 6/7] ACPI/IORT: Fixup SMMUv3 resource size for Cavium 99xx SMMUv3 model.
Date: Tue, 11 Apr 2017 20:12:44 +0530
Message-ID: <1491921765-29475-7-git-send-email-linucherian@gmail.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc: rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robert.moore@intel.com, lv.zheng@intel.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, devel@acpica.org, Sunil.Goutham@cavium.com, Geethasowjanya.Akula@cavium.com, robert.richter@cavium.com, linu.cherian@cavium.com
List-Id: iommu@lists.linux-foundation.org

From: Linu Cherian <linu.cherian@cavium.com>

Cavium 99xx implementation doesn't support second page in SMMU
register space. Hence, resource size is set as 64k for this model.

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
---
 drivers/acpi/arm64/iort.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 22e08d2..ac22280 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -765,12 +765,20 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
 {
 	struct acpi_iort_smmu_v3 *smmu;
 	int num_res = 0;
+	unsigned long size = SZ_128K;
 
 	/* Retrieve SMMUv3 specific data */
 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
+	/*
+	 * Override the size, for Cavium CN99xx implementations
+	 * which doesn't support the page 1 SMMU register space.
+	 */
+	if (smmu->model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
+		size = SZ_64K;
+
 	res[num_res].start = smmu->base_address;
-	res[num_res].end = smmu->base_address + SZ_128K - 1;
+	res[num_res].end = smmu->base_address + size - 1;
 	res[num_res].flags = IORESOURCE_MEM;
 
 	num_res++;
-- 
1.9.1

