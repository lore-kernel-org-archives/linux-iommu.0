From: Geetha sowjanya <gakula@caviumnetworks.com>
Subject: [PATCH v7 1/3] ACPI/IORT: Fixup SMMUv3 resource size for Cavium ThunderX2 SMMUv3 model
Date: Tue, 30 May 2017 17:33:39 +0530
Message-ID: <1496145821-3411-2-git-send-email-gakula@caviumnetworks.com>
References: <1496145821-3411-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496145821-3411-1-git-send-email-gakula@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org
Cc: robert.moore@intel.com, lv.zheng@intel.com, rjw@rjwysocki.net, jcm@redhat.com, linux-kernel@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, devel@acpica.org, linu.cherian@cavium.com, Charles.Garcia-Tobin@arm.com, robh@kernel.org, Geetha Sowjanya <geethasowjanya.akula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

From: Linu Cherian <linu.cherian@cavium.com>

Cavium ThunderX2 implementation doesn't support second page in SMMU
register space. Hence, resource size is set as 64k for this model.

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
---
 drivers/acpi/arm64/iort.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c5fecf9..bba2b59 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -833,12 +833,20 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
 {
 	struct acpi_iort_smmu_v3 *smmu;
 	int num_res = 0;
+	unsigned long size = SZ_128K;
 
 	/* Retrieve SMMUv3 specific data */
 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
+	/*
+	 * Override the size, for Cavium ThunderX2 implementation
+	 * which doesn't support the page 1 SMMU register space.
+	 */
+	if (smmu->model == ACPI_IORT_SMMU_CAVIUM_CN99XX)
+		size = SZ_64K;
+
 	res[num_res].start = smmu->base_address;
-	res[num_res].end = smmu->base_address + SZ_128K - 1;
+	res[num_res].end = smmu->base_address + size - 1;
 	res[num_res].flags = IORESOURCE_MEM;
 
 	num_res++;
-- 
1.7.1
