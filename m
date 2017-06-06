From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 1/2] ACPICA: IORT: Update SMMU models for IORT rev. C
Date: Tue, 6 Jun 2017 16:43:32 +0800
Message-ID: <ec4eeffe-9333-fa89-d471-6c88d8d03435@linaro.org>
References: <11ef7d28c535c01d42b7b3c8e632934f0e0f1048.1495459319.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11ef7d28c535c01d42b7b3c8e632934f0e0f1048.1495459319.git.robin.murphy@arm.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, will.deacon@arm.com, joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, gakula@caviumnetworks.com, linu.cherian@cavium.com, rrichter@cavium.com, lorenzo.pieralisi@arm.com, john.garry@huawei.com, shameerali.kolothum.thodi@huawei.com, gabriele.paoloni@huawei.com, rjw@rjwysocki.net, robert.moore@intel.com, lv.zheng@intel.comShameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 2017/5/22 23:06, Robin Murphy wrote:
> IORT revision C has been published with a number of new SMMU
> implementation identifiers. Since IORT doesn't have any way of falling
> back to a more generic model code, we really need Linux to know about
> these before vendors start updating their firmware tables to use them.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Robert Moore <robert.moore@intel.com>
> CC: Lv Zheng <lv.zheng@intel.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Update more comments, add Robert's tags.
> 
> I'm including this here as a kernel patch just for context - once I've
> figured out how we actually submit patches to ACPICA directly, I'll do
> that per the preferred process.
> 
> Robin.
> 
>   include/acpi/actbl2.h | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index faa9f2c0d5de..f469ea41f2fd 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -663,7 +663,7 @@ struct acpi_ibft_target {
>    * IORT - IO Remapping Table
>    *
>    * Conforms to "IO Remapping Table System Software on ARM Platforms",
> - * Document number: ARM DEN 0049B, October 2015
> + * Document number: ARM DEN 0049C, May 2017
>    *
>    ******************************************************************************/
>   
> @@ -778,6 +778,8 @@ struct acpi_iort_smmu {
>   #define ACPI_IORT_SMMU_V2               0x00000001	/* Generic SMMUv2 */
>   #define ACPI_IORT_SMMU_CORELINK_MMU400  0x00000002	/* ARM Corelink MMU-400 */
>   #define ACPI_IORT_SMMU_CORELINK_MMU500  0x00000003	/* ARM Corelink MMU-500 */
> +#define ACPI_IORT_SMMU_CORELINK_MMU401  0x00000004	/* ARM Corelink MMU-401 */
> +#define ACPI_IORT_SMMU_CAVIUM_SMMUV2    0x00000005	/* Cavium ThunderX SMMUv2 */
>   
>   /* Masks for Flags field above */
>   
> @@ -798,13 +800,19 @@ struct acpi_iort_smmu_v3 {
>   	u32 flags;
>   	u32 reserved;
>   	u64 vatos_address;
> -	u32 model;		/* O: generic SMMUv3 */
> +	u32 model;
>   	u32 event_gsiv;
>   	u32 pri_gsiv;
>   	u32 gerr_gsiv;
>   	u32 sync_gsiv;
>   };
>   
> +/* Values for Model field above */
> +
> +#define ACPI_IORT_SMMU_V3               0x00000000	/* Generic SMMUv3 */
> +#define ACPI_IORT_SMMU_HISILICON_HI161X 0x00000001	/* HiSilicon Hi161x SMMUv3 */
> +#define ACPI_IORT_SMMU_CAVIUM_CN99XX    0x00000002	/* Cavium CN99xx SMMUv3 */
> +
>   /* Masks for Flags field above */
>   
>   #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
> 

Looks good to me,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

By the way, how will this patch be merged? There are pending patches
on top of it, Rafael suggested to work with ACPICA upstream first [1],
Robin, will work on that?

[1]: 
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1394295.html

Thanks
Hanjun
