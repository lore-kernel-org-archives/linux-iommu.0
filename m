From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2 5/5] iommu: Allow default domain type to be set on the
	kernel command line
Date: Thu, 23 Mar 2017 15:52:06 +0530
Message-ID: <2fce5c37-cde1-e5d3-0490-835867789169@codeaurora.org>
References: <1489178976-15353-1-git-send-email-will.deacon@arm.com>
	<1489178976-15353-6-git-send-email-will.deacon@arm.com>
	<20170321154527.GB29659@8bytes.org> <20170321172137.GF30948@arm.com>
	<807ecbb0-c9d7-fc0a-25d2-93b5c4374107@arm.com>
	<20170321181729.GG30948@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170321181729.GG30948-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 3/21/2017 11:47 PM, Will Deacon wrote:
> On Tue, Mar 21, 2017 at 05:46:29PM +0000, Robin Murphy wrote:
>> On 21/03/17 17:21, Will Deacon wrote:
>>> On Tue, Mar 21, 2017 at 04:45:27PM +0100, Joerg Roedel wrote:
>>>> On Fri, Mar 10, 2017 at 08:49:36PM +0000, Will Deacon wrote:
>>>>> @@ -1014,8 +1027,8 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>>>>>  	 * IOMMU driver.
>>>>>  	 */
>>>>>  	if (!group->default_domain) {
>>>>> -		group->default_domain = __iommu_domain_alloc(dev->bus,
>>>>> -							     IOMMU_DOMAIN_DMA);
>>>>> +		group->default_domain =
>>>>> +			__iommu_domain_alloc(dev->bus, iommu_def_domain_type);
>>>>
>>>> It would be good to have a fall-back here if we are talking to an IOMMU
>>>> driver that uses default domains, but does not support identity-mapped
>>>> domains (yet). Exynos and Rockchip IOMMU drivers seem to fall into this
>>>> category. A dev_warn() also makes sense in case allocating a identity
>>>> domain fails.
>>>
>>> Sure, something like the diff below?
>>>
>>> Will
>>>
>>> --->8
>>>
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 42a842e3f95f..f787626a745d 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -1027,10 +1027,19 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>>>  	 * IOMMU driver.
>>>  	 */
>>>  	if (!group->default_domain) {
>>> -		group->default_domain =
>>> -			__iommu_domain_alloc(dev->bus, iommu_def_domain_type);
>>> +		struct iommu_domain *dom;
>>> +
>>> +		dom = __iommu_domain_alloc(dev->bus, iommu_def_domain_type);
>>> +		if (!dom) {
>>> +			dev_warn(dev,
>>> +				 "failed to allocate default IOMMU domain of type %u; falling back to IOMMU_DOMAIN_DMA",
>>> +				 iommu_def_domain_type);
>>
>> Conversely, that's going to be noisy if iommu_def_domain_type was
>> IOMMU_DOMAIN_DMA to begin with. I think it makes sense to warn if the
>> user asked for a specific default domain type on the command line and
>> that didn't work, but maybe not to bother otherwise. Plus, if they asked
>> for passthrough, then not allocating a default domain at all is probably
>> closer to the desired result than installing a DMA ops domain would be.
>
> You're right -- I'll hack this about to check if the default type isn't
> DOMAIN_DMA before warning about the allocation failure.

if some master devices want 'IDENTITY_DOMAIN' as default (because  those 
devices do not want any iommu resources to be used/dma_ops to be set) 
and some 'DMA_DOMAIN' as default, then should the default be 
'DMA_DOMAIN' and then masters needing IDENTITY_DOMAIN explicitly do an
detach_dev later. This [1] was adding the support for detach_dev
of the default DMA_DOMAINs.

[1] https://patchwork.codeaurora.org/patch/164933/

Regards,
  Sricharan
