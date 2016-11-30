From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/5] iommu/exynos: Add default_domain check in
	iommu_attach_device
Date: Wed, 30 Nov 2016 10:05:28 +0100
Message-ID: <4958e5fb-f0ef-647b-1274-69a9a31ac542@samsung.com>
References: <1479986420-30859-1-git-send-email-m.szyprowski@samsung.com>
	<1479986420-30859-5-git-send-email-m.szyprowski@samsung.com>
	<CGME20161129164906epcas2p179f07684f18b446c776d5c04aa53011e@epcas2p1.samsung.com>
	<20161129164823.GD13850@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20161129164823.GD13850-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,


On 2016-11-29 17:48, Joerg Roedel wrote:
> On Thu, Nov 24, 2016 at 12:20:19PM +0100, Marek Szyprowski wrote:
>> This patch adds default_domain check before calling
>> exynos_iommu_detach_device. This path was intended only to cope with
>> default domains, which are automatically attached by the iommu core, so
>> return error if user tries to attach device, which is already attached
>> to other (non-default) domain.
>>
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
>> +			iommu_group_put(group);
>> +			return -EINVAL;
>> +		}
>> +		iommu_group_put(group);
>>   		exynos_iommu_detach_device(owner->domain, dev);
>> +	}
> Does this fix any actual bug? The iommu core should take care that the
> above never happens. See __iommu_attach_group() function for details.

I've made this patch, when I was adding default domain handling in
exynos_iommu_remove_device(), but as it has been already pointed by Robin,
there is no point for the above check in exynos_iommu_attach_device(),
because it is handled in the iommu core. Please ignore this patch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
