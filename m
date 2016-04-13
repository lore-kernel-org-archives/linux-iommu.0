From: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/7] iommu/arm-smmu: Convert ThunderX workaround to new
	method
Date: Wed, 13 Apr 2016 21:16:14 +0000
Message-ID: <6BD36166-69D0-498D-A021-870AD5698FE5@caviumnetworks.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
	<98b8079ee3ede4427b045214a60ba77f1cb3552c.1460391217.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <98b8079ee3ede4427b045214a60ba77f1cb3552c.1460391217.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Content-ID: <AABCF5B5CC16FA41A8BA27F9526F9715-Tk6F3M/euE6cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "brian.starkey-5wv7dgnIgG8@public.gmane.org" <brian.starkey-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org






On 4/13/16, 10:12 AM, "Robin Murphy" <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

>With a framework for implementation-specific funtionality in place, the
>currently-FDT-dependent ThunderX workaround gets to be the first user.
>
>Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>---
> drivers/iommu/arm-smmu.c | 27 ++++++++++++++-------------
> 1 file changed, 14 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>index 2d5f357..d8bc20a 100644
>--- a/drivers/iommu/arm-smmu.c
>+++ b/drivers/iommu/arm-smmu.c
>@@ -280,6 +280,7 @@ enum arm_smmu_arch_version {
> 
> enum arm_smmu_implementation {
> 	GENERIC_SMMU,
>+	CAVIUM_SMMUV2,
> };
> 
> struct arm_smmu_smr {
>@@ -1686,6 +1687,17 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
> 	}
> 	dev_notice(smmu->dev, "\t%u context banks (%u stage-2 only)\n",
> 		   smmu->num_context_banks, smmu->num_s2_context_banks);
>+	/*
>+	 * Cavium CN88xx erratum #27704.
>+	 * Ensure ASID and VMID allocation is unique across all SMMUs in
>+	 * the system.
>+	 */
>+	if (smmu->model == CAVIUM_SMMUV2) {
>+		smmu->cavium_id_base =
>+			atomic_add_return(smmu->num_context_banks,
>+					  &cavium_smmu_context_count);
>+		smmu->cavium_id_base -= smmu->num_context_banks;
>+	}
> 
> 	/* ID2 */
> 	id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID2);
>@@ -1750,6 +1762,7 @@ static struct arm_smmu_match_data name = { .version = ver, .model = imp }
> 
> ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
> ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>+ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
> 
> static const struct of_device_id arm_smmu_of_match[] = {
> 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
>@@ -1757,7 +1770,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
> 	{ .compatible = "arm,mmu-400", .data = &smmu_generic_v1 },
> 	{ .compatible = "arm,mmu-401", .data = &smmu_generic_v1 },
> 	{ .compatible = "arm,mmu-500", .data = &smmu_generic_v2 },
>-	{ .compatible = "cavium,smmu-v2", .data = &smmu_generic_v2 },
>+	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
> 	{ },
> };
> MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>@@ -1871,18 +1884,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
> 		}
> 	}
> 
>-	/*
>-	 * Cavium CN88xx erratum #27704.
>-	 * Ensure ASID and VMID allocation is unique across all SMMUs in
>-	 * the system.
>-	 */
>-	if (of_device_is_compatible(dev->of_node, "cavium,smmu-v2")) {
>-		smmu->cavium_id_base =
>-			atomic_add_return(smmu->num_context_banks,
>-					  &cavium_smmu_context_count);
>-		smmu->cavium_id_base -= smmu->num_context_banks;
>-	}
>-
> 	INIT_LIST_HEAD(&smmu->list);
> 	spin_lock(&arm_smmu_devices_lock);
> 	list_add(&smmu->list, &arm_smmu_devices);
>-- 
>2.7.3.dirty
This looks fine too.
Acked-by: Tirumalesh Chalamarla<tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>

>
