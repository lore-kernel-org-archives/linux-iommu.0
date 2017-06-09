From: Geetha Akula <geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 1/3] ACPI/IORT: Fixup SMMUv3 resource size for Cavium
	ThunderX2 SMMUv3 model
Date: Fri, 9 Jun 2017 11:30:53 +0530
Message-ID: <CANHdaib+mNgVS7g=vft-5ZtabSKkeyXO7Jp1EQhL3jduhu5F7g@mail.gmail.com>
References: <1496145821-3411-1-git-send-email-gakula@caviumnetworks.com>
	<1496145821-3411-2-git-send-email-gakula@caviumnetworks.com>
	<20170608085857.GB8607@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170608085857.GB8607@red-moon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, Charles Garcia-Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Robert Richter <robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Sunil Goutham <sgoutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 8, 2017 at 2:28 PM, Lorenzo Pieralisi
<lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org> wrote:
> On Tue, May 30, 2017 at 05:33:39PM +0530, Geetha sowjanya wrote:
>> From: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>
>> Cavium ThunderX2 implementation doesn't support second page in SMMU
>> register space. Hence, resource size is set as 64k for this model.
>>
>> Signed-off-by: Linu Cherian <linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/acpi/arm64/iort.c |   10 +++++++++-
>>  1 files changed, 9 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index c5fecf9..bba2b59 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -833,12 +833,20 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
>>  {
>>       struct acpi_iort_smmu_v3 *smmu;
>>       int num_res = 0;
>> +     unsigned long size = SZ_128K;
>>
>>       /* Retrieve SMMUv3 specific data */
>>       smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>>
>> +     /*
>> +      * Override the size, for Cavium ThunderX2 implementation
>> +      * which doesn't support the page 1 SMMU register space.
>> +      */
>> +     if (smmu->model == ACPI_IORT_SMMU_CAVIUM_CN99XX)
>> +             size = SZ_64K;
>
> Nit: add a function, say arm_smmu_v3_resource_size() with the logic
> above that by default returns SZ_128K, I do not like this switch
> in the middle of this function.

I will resubmit the patch with suggested changes.


Thanks,
Geetha.
>
> Lorenzo
>
>> +
>>       res[num_res].start = smmu->base_address;
>> -     res[num_res].end = smmu->base_address + SZ_128K - 1;
>> +     res[num_res].end = smmu->base_address + size - 1;
>>       res[num_res].flags = IORESOURCE_MEM;
>>
>>       num_res++;
>> --
>> 1.7.1
>>
