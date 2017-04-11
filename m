From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Subject: Re: [RFC PATCH 4/7] ACPICA: IORT: Add SMMuV3 model definitions.
Date: Tue, 11 Apr 2017 22:27:55 +0530
Message-ID: <CA+sq2CfXQAM-ooNRQBbYNYc_T=p2yrvA2FYD=2_=_-Z9kQwVcA@mail.gmail.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
 <1491921765-29475-5-git-send-email-linucherian@gmail.com> <d60a1fcc-081e-03e8-3454-6802e830ddb9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <d60a1fcc-081e-03e8-3454-6802e830ddb9@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: linucherian@gmail.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, hanjun.guo@linaro.org, sudeep.holla@arm.com, "Goutham, Sunil" <Sunil.Goutham@cavium.com>, Geethasowjanya.Akula@cavium.com, Joerg Roedel <joro@8bytes.org>, rjw@rjwysocki.net, robert.moore@intel.com, robert.richter@cavium.com, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, lv.zheng@intel.com, linu.cherian@cavium.com, devel@acpica.org, LAKML <linux-arm-kernel@lists.infradead.org>, lenb@kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 11, 2017 at 9:29 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 11/04/17 15:42, linucherian@gmail.com wrote:
>> From: Linu Cherian <linu.cherian@cavium.com>
>>
>> Add SMMuV3 model definitions.
>>
>> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
>> ---
>>  include/acpi/actbl2.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>> index 2b4af07..9db67d6 100644
>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
>> @@ -778,6 +778,11 @@ struct acpi_iort_smmu {
>>  #define ACPI_IORT_SMMU_CORELINK_MMU400  0x00000002   /* ARM Corelink MMU-400 */
>>  #define ACPI_IORT_SMMU_CORELINK_MMU500  0x00000003   /* ARM Corelink MMU-500 */
>>
>> +#define ACPI_IORT_SMMU_V3               0x00000000      /* Generic SMMUv3 */
>> +#define ACPI_IORT_SMMU_CORELINK_MMU600  0x00000001      /* ARM Corelink MMU-600 */
>> +#define ACPI_IORT_SMMU_V3_HISILICON     0x00000002      /* HiSilicon SMMUv3 */
>> +#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX 0x00000003      /* Cavium CN99xx SMMUv3 */
>
> None of those models are listed in the current IORT spec.

As mentioned in the cover letter, we are in the process of getting
model no added for
our silicon in the soon to be published updated IORT spec. Meanwhile
we wanted to take
feedback on the errata patches from experts. Hence patches were
submitted as RFC.

Thanks,
Sunil.

>
> What's MMU-600?
>
> Robin.
>
>> +
>>  /* Masks for Flags field above */
>>
>>  #define ACPI_IORT_SMMU_DVM_SUPPORTED    (1)
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
