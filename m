From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH 4/7] ACPICA: IORT: Add SMMuV3 model definitions.
Date: Tue, 11 Apr 2017 16:59:17 +0100
Message-ID: <d60a1fcc-081e-03e8-3454-6802e830ddb9@arm.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
 <1491921765-29475-5-git-send-email-linucherian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1491921765-29475-5-git-send-email-linucherian@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linucherian@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc: rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, robert.moore@intel.com, lv.zheng@intel.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, devel@acpica.org, Sunil.Goutham@cavium.com, Geethasowjanya.Akula@cavium.com, robert.richter@cavium.com, linu.cherian@cavium.com
List-Id: iommu@lists.linux-foundation.org

On 11/04/17 15:42, linucherian@gmail.com wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Add SMMuV3 model definitions.
> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> ---
>  include/acpi/actbl2.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 2b4af07..9db67d6 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -778,6 +778,11 @@ struct acpi_iort_smmu {
>  #define ACPI_IORT_SMMU_CORELINK_MMU400  0x00000002	/* ARM Corelink MMU-400 */
>  #define ACPI_IORT_SMMU_CORELINK_MMU500  0x00000003	/* ARM Corelink MMU-500 */
>  
> +#define ACPI_IORT_SMMU_V3               0x00000000      /* Generic SMMUv3 */
> +#define ACPI_IORT_SMMU_CORELINK_MMU600  0x00000001      /* ARM Corelink MMU-600 */
> +#define ACPI_IORT_SMMU_V3_HISILICON     0x00000002      /* HiSilicon SMMUv3 */
> +#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX 0x00000003      /* Cavium CN99xx SMMUv3 */

None of those models are listed in the current IORT spec.

What's MMU-600?

Robin.

> +
>  /* Masks for Flags field above */
>  
>  #define ACPI_IORT_SMMU_DVM_SUPPORTED    (1)
> 

