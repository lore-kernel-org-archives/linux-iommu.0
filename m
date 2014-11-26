From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] iommu: build iova.c for any IOMMU
Date: Wed, 26 Nov 2014 12:19:36 +0000
Message-ID: <5475C558.9060600@arm.com>
References: <cover.1416931258.git.robin.murphy@arm.com>
	<90240865e7cc00d0f7e471605ba9d2478b81ea88.1416931258.git.robin.murphy@arm.com>
	<54757A20.2090609@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54757A20.2090609-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: leizhen <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 26/11/14 06:58, leizhen wrote:
> On 2014/11/26 1:27, Robin Murphy wrote:
>> In preparation for sharing the IOVA allocator, build it for all
>> IOMMU API users.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   drivers/iommu/Makefile | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 16edef7..9f7910b 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -1,4 +1,4 @@
>> -obj-$(CONFIG_IOMMU_API) += iommu.o
>> +obj-$(CONFIG_IOMMU_API) += iommu.o iova.o
>
> I'm not a maintainer, so just code review comment.
>
> I don't known whether or not you will apply iova to all iommu drivers. But if only x86 and arm/arm64,
> it's no good to force other iommu drivers to include iova.o, because they have not used it yet.

I agree, the "build it anyway and rely on the linker to throw it away" 
approach is very hacky. As I mentioned in the cover letter, the other 
series which appeared as I was cleaning this up for posting duplicates 
patch 1 and 2 here, but in a nicer way, so I'm fully expecting to simply 
rebase patches 3 and 4 on top of that series.

Thanks,
Robin.

>
> Maybe it's good to define a new config, like CONFIG_IOMMU_IOVA.
>
> config INTEL_IOMMU
> 	select IOMMU_IOVA
>
> config ARM_SMMU
> 	select IOMMU_IOVA
>
> obj-$(CONFIG_IOMMU_IOVA) += iova.o
>
>>   obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>>   obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>>   obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>> @@ -7,7 +7,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
>>   obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
>>   obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
>>   obj-$(CONFIG_DMAR_TABLE) += dmar.o
>> -obj-$(CONFIG_INTEL_IOMMU) += iova.o intel-iommu.o
>> +obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o
>>   obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
>>   obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
>>   obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
>>
>
>
>
