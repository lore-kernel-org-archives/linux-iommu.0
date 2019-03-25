From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu: Add config option to set lazy mode as default
Date: Mon, 25 Mar 2019 10:21:16 +0800
Message-ID: <5C983B1C.80502@huawei.com>
References: <20190322141121.18428-1-thunder.leizhen@huawei.com>
	<8cf20613-7a9a-d4a1-b52e-4b526f2c7ff2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8cf20613-7a9a-d4a1-b52e-4b526f2c7ff2-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will
	Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2019/3/22 22:42, John Garry wrote:
> On 22/03/2019 14:11, Zhen Lei wrote:
> 
>> This allows the default behaviour to be controlled by a kernel config
>> option instead of changing the command line for the kernel to include
>> "iommu.strict=0" on ARM64 where this is desired.
>>
>> This is similar to CONFIG_IOMMU_DEFAULT_PASSTHROUGH
>>
>> Note: At present, intel_iommu, amd_iommu and s390_iommu use lazy mode as
>> defalut, so there is no need to add code for them.
> 
> /s/defalut/default/
> 
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/iommu/Kconfig | 14 ++++++++++++++
>>  drivers/iommu/iommu.c |  5 +++++
> 
> Do we need to update kernel-parameters.txt for iommu.strict?
> 
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index 6f07f3b21816c64..5ec9780f564eaf8 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -85,6 +85,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
>>
>>        If unsure, say N here.
>>
>> +config IOMMU_LAZY_MODE
> 
> maybe should add "DMA" to the name, and even "DEFAULT"
OK, thanks

> 
>> +    bool "IOMMU use lazy mode to flush IOTLB and free IOVA"
>> +    depends on IOMMU_API
>> +    help
>> +      For every IOMMU unmap operation, the flush operation of IOTLB and the free
>> +      operation of IOVA are deferred.
> 
> This is a bit unclear, as there is no context. I think that you need to say something like, "Support lazy mode, where for every IOMMU DMA unmap operation, the flush operation of IOTLB and the free operation of IOVA are deferred. "
> 
> 
> They are only guaranteed to be done before
>> +      the related IOVA will be reused. Removing the need to pass in iommu.strict=0
>> +      through command line on ARM64(Now, intel_iommu, amd_iommu, s390_iommu use
>> +      lazy mode as deault).
> 
> prone to going out-of-date
> 
>  If this is enabled, you can still disable with kernel
>> +      parameters, such as iommu.strict=1, intel_iommu=strict, amd_iommu=fullflush
>> +      or s390_iommu=strict depending on the architecture.
>> +
>> +      If unsure, say N here.
>> +
>>  config OF_IOMMU
>>         def_bool y
>>         depends on OF && IOMMU_API
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 33a982e33716369..e307d70d1578b3b 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -43,7 +43,12 @@
>>  #else
>>  static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>>  #endif
>> +
>> +#ifdef CONFIG_IOMMU_LAZY_MODE
>> +static bool iommu_dma_strict __read_mostly;
>> +#else
>>  static bool iommu_dma_strict __read_mostly = true;
>> +#endif
>>
>>  struct iommu_callback_data {
>>      const struct iommu_ops *ops;
>> -- 
>> 1.8.3
>>
>>
>>
> 
> Cheers
> 
> 
> 
> 
> .
> 

-- 
Thanks!
BestRegards
