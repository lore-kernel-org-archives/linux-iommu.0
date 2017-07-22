From: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
Subject: Re: [PATCH v3 2/2] acpi/iort: numa: Add numa node mapping for smmuv3 devices
Date: Sat, 22 Jul 2017 18:35:43 +0530
Message-ID: <CAFpQJXUyD1qb8wMj7NVNEWDzbGSy0_2u1udh-D0D6jKFY5SXSQ@mail.gmail.com>
References: <1496897059-8272-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1496897059-8272-3-git-send-email-ganapatrao.kulkarni@cavium.com> <5972C54F.6030000@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5972C54F.6030000@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, sudeep.holla@arm.com, Robin Murphy <robin.murphy@arm.com>, Lv Zheng <lv.zheng@intel.com>, joro@8bytes.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jayachandran C <jnair@caviumnetworks.com>
List-Id: iommu@lists.linux-foundation.org

On Sat, Jul 22, 2017 at 8:53 AM, Hanjun Guo <guohanjun@huawei.com> wrote:
> Hi Ganapat,
>
> On 2017/6/8 12:44, Ganapatrao Kulkarni wrote:
>> Add code to parse proximity domain in SMMUv3 IORT table to
>> set numa node mapping for smmuv3 devices.
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> ---
>>  drivers/acpi/arm64/iort.c | 28 ++++++++++++++++++++++++++--
>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index bba2b59..e804386 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -882,6 +882,23 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
>>       return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
>>  }
>>
>> +/*
>> + * set numa proximity domain for smmuv3 device
>> + */
>> +static void  __init arm_smmu_v3_set_proximity(struct acpi_iort_node *node,
>> +             struct device *dev)
>> +{
>> +     struct acpi_iort_smmu_v3 *smmu;
>> +
>> +     smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>> +     if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
>> +             set_dev_node(dev, acpi_map_pxm_to_node(smmu->pxm));
>                                                           ^^
> Will have compile error in !CONFIG_NUMA, I think we need to introduce
> a stub function in acpi_numa.h.

thanks Hanjun, i thought it is already there in header file, however,
there is stub for acpi_map_pxm_to_online_node and not for this
function.
it is better to have ifdef. will do it in next version.

>
> Thanks
> Hanjun
>

thanks
Ganapat
