From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 10/10] iommu/arm-smmu: call
	iommu_free_reserved_iova_domain on domain destruction
Date: Thu, 21 Apr 2016 10:39:30 +0200
Message-ID: <571891C2.50900@linaro.org>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
	<1461084994-2355-11-git-send-email-eric.auger@linaro.org>
	<5717BDF1.7030400@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5717BDF1.7030400-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, eric.auger-qxv4g6HH51o@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,
On 04/20/2016 07:35 PM, Robin Murphy wrote:
> On 19/04/16 17:56, Eric Auger wrote:
>> When the domain gets destroyed, let's make sure all reserved iova
>> resources get released.
>>
>> Choice is made to put that call in arm-smmu(-v3).c to do something
>> similar
>> to what was done for iommu_put_dma_cookie.
>>
>> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> ---
>>
>> v7: new
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 2 ++
>>   drivers/iommu/arm-smmu.c    | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index a077a35..afd0dac 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -22,6 +22,7 @@
>>
>>   #include <linux/delay.h>
>>   #include <linux/dma-iommu.h>
>> +#include <linux/dma-reserved-iommu.h>
>>   #include <linux/err.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/iommu.h>
>> @@ -1444,6 +1445,7 @@ static void arm_smmu_domain_free(struct
>> iommu_domain *domain)
>>       struct arm_smmu_device *smmu = smmu_domain->smmu;
>>
>>       iommu_put_dma_cookie(domain);
>> +    iommu_free_reserved_iova_domain(domain);
> 
> Yikes! No, drivers shouldn't be randomly freeing things they didn't
> allocate - the owner of the domain, who presumably allocated the thing,
> can call that right _before_ they call iommu_domain_free().
OK I move that back to vfio_iommu_type1.c.

Thanks

Eric
> 
>>       free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>>
>>       /* Free the CD and ASID, if we allocated them */
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 8cd7b8a..492339f 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -30,6 +30,7 @@
>>
>>   #include <linux/delay.h>
>>   #include <linux/dma-iommu.h>
>> +#include <linux/dma-reserved-iommu.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/err.h>
>>   #include <linux/interrupt.h>
>> @@ -1009,6 +1010,7 @@ static void arm_smmu_domain_free(struct
>> iommu_domain *domain)
>>        * already been detached.
>>        */
>>       iommu_put_dma_cookie(domain);
>> +    iommu_free_reserved_iova_domain(domain);
> 
> ...which has the added bonus of preventing needless duplication everywhere.
> 
> Robin.
> 
>>       arm_smmu_destroy_domain_context(domain);
>>       kfree(smmu_domain);
>>   }
>>
> 
