From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/5] iommu/exynos: Add default_domain check in
	iommu_attach_device
Date: Thu, 24 Nov 2016 14:05:21 +0100
Message-ID: <d572b33e-6e1b-81d7-31cc-d5c95385d9ac@samsung.com>
References: <1479986420-30859-1-git-send-email-m.szyprowski@samsung.com>
	<1479986420-30859-5-git-send-email-m.szyprowski@samsung.com>
	<CGME20161124122527epcas4p4fbc26985eb9b231b5c1c61409e134c7e@epcas4p4.samsung.com>
	<6937b5da-23cf-d9bb-0b7c-d54171b02828@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <6937b5da-23cf-d9bb-0b7c-d54171b02828-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,


On 2016-11-24 13:25, Robin Murphy wrote:
> Hi Marek,
>
> On 24/11/16 11:20, Marek Szyprowski wrote:
>> This patch adds default_domain check before calling
>> exynos_iommu_detach_device. This path was intended only to cope with
>> default domains, which are automatically attached by the iommu core, so
>> return error if user tries to attach device, which is already attached
>> to other (non-default) domain.
> I think this only applies to the current state of 32-bit ARM, where the
> initial allocation of a default domain fails without CONFIG_IOMMU_DMA.
> Since the device has a group, iommu_attach_device() will end up calling
> into __iommu_attach_group(), which does this check before calling the
> driver's .attach_dev:
>
> 	if (group->default_domain && group->domain != group->default_domain)
> 		return -EBUSY;
>
> which if group->default_domain is non-NULL would make the new check
> below redundant unless owner->domain can change independently of
> dev->iommu_group->domain, but that sounds like it would be a bigger
> problem anyway.

Thanks for your review. Default domains are used on ARM64 and they are
automatically attached by IOMMU core. This was the reason for looking into
this. But you are right, that there is no need for the additional check, as
this is already handled in the iommu core.

>> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>>   drivers/iommu/exynos-iommu.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>> index 426b1534d4d3..63d9358a6d9c 100644
>> --- a/drivers/iommu/exynos-iommu.c
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -859,8 +859,17 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
>>   	if (!has_sysmmu(dev))
>>   		return -ENODEV;
>>   
>> -	if (owner->domain)
>> +	if (owner->domain) {
>> +		struct iommu_group *group = iommu_group_get(dev);
>> +
>> +		if (!group ||
>> +		    owner->domain != iommu_group_default_domain(group)) {
> Similarly, I think this prevents reattaching to a default domain from
> iommu_detach_device(), since __iommu_detach_group() won't call
> .detach_dev first if default_domain is non-NULL, therefore owner->domain
> is presumably still pointing to the outgoing non-default domain.

Right, I forgot about reattaching to the default domain. Please drop 
this patch,
the previous code was correct.

>
>> +			iommu_group_put(group);
>> +			return -EINVAL;
>> +		}
>> +		iommu_group_put(group);
>>   		exynos_iommu_detach_device(owner->domain, dev);
>> +	}
>>   
>>   	mutex_lock(&owner->rpm_lock);
>>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
