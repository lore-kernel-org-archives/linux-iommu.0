From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 3/7] iommu: Add "iommu.strict" command line option
Date: Fri, 28 Sep 2018 15:25:36 +0100
Message-ID: <a3839ea8-ef67-300a-49aa-19b8932b042b@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
	<799fad801970298385af3abc8ca82620ad62c000.1537458163.git.robin.murphy@arm.com>
	<20180928125130.GD1577@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180928125130.GD1577@brain-police>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 28/09/18 13:51, Will Deacon wrote:
> On Thu, Sep 20, 2018 at 05:10:23PM +0100, Robin Murphy wrote:
>> From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>
>> Add a generic command line option to enable lazy unmapping via IOVA
>> flush queues, which will initally be suuported by iommu-dma. This echoes
>> the semantics of "intel_iommu=strict" (albeit with the opposite default
>> value), but in the driver-agnostic fashion of "iommu.passthrough".
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> [rm: move handling out of SMMUv3 driver, clean up documentation]
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> v8:
>>   - Rename "non-strict" to "strict" to better match existing options
>>   - Rewrite doc text/commit message
>>   - Downgrade boot-time message from warn/taint to info
>>
>>   .../admin-guide/kernel-parameters.txt         | 12 ++++++++++
>>   drivers/iommu/iommu.c                         | 23 +++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 9871e649ffef..92ae12aeabf4 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1749,6 +1749,18 @@
>>   		nobypass	[PPC/POWERNV]
>>   			Disable IOMMU bypass, using IOMMU for PCI devices.
>>   
>> +	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
>> +			Format: { "0" | "1" }
>> +			0 - Lazy mode.
>> +			  Request that DMA unmap operations use deferred
>> +			  invalidation of hardware TLBs, for increased
>> +			  throughput at the cost of reduced device isolation.
>> +			  Will fall back to strict mode if not supported by
>> +			  the relevant IOMMU driver.
>> +			1 - Strict mode (default).
>> +			  DMA unmap operations invalidate IOMMU hardware TLBs
>> +			  synchronously.
>> +
>>   	iommu.passthrough=
>>   			[ARM64] Configure DMA to bypass the IOMMU by default.
>>   			Format: { "0" | "1" }
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 8c15c5980299..02b6603f0616 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -41,6 +41,7 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>>   #else
>>   static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>>   #endif
>> +static bool iommu_dma_strict __read_mostly = true;
>>   
>>   struct iommu_callback_data {
>>   	const struct iommu_ops *ops;
>> @@ -131,6 +132,21 @@ static int __init iommu_set_def_domain_type(char *str)
>>   }
>>   early_param("iommu.passthrough", iommu_set_def_domain_type);
>>   
>> +static int __init iommu_dma_setup(char *str)
>> +{
>> +	int ret;
>> +
>> +	ret = kstrtobool(str, &iommu_dma_strict);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!iommu_dma_strict)
>> +		pr_info("Enabling deferred TLB invalidation for DMA; protection against malicious/malfunctioning devices may be reduced.\n");
> 
> Printing here isn't quite right, because if somebody boots with something
> like:
> 
> 	"iommu.strict=1 iommu.strict=0 iommu.strict=0 iommu.strict=1"
> 
> then we'll print the wrong thing twice :)

But it's not wrong! For those two brief moments it *is* enabled :P

For reasons of conciseness, the subtlety that "enabled" doesn't 
necessarily imply "in use" is only conveyed by the "may".

> I think we either need to drop the print, or move it to a the DMA domain
> initialisation.

TBH I did toy with moving it around, but in the end it seemed neatest to 
have it right there next to the parameter handling, with the added 
advantage that it appears early in the log where system-wide things 
might be expected to appear, rather than mixed in with all the driver 
noise later.

AFAICS it's no worse than various other parameters - try booting with, 
say, "mem=640k mem=1G mem=cheese" and one finds that memory is in fact 
not limited (nor indeed cheese) regardless of what the log might say.

Robin.
