From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 09/13] iommu/rockchip: Use iommu_group_get_for_dev()
	for add_device
Date: Wed, 17 Jan 2018 20:47:22 +0800
Message-ID: <5A5F45DA.5000104@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
	<20180116132540.18939-10-jeffy.chen@rock-chips.com>
	<4c1b2469-9a32-c6ca-522f-73143b0fa618@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4c1b2469-9a32-c6ca-522f-73143b0fa618-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 01/17/2018 08:31 PM, Robin Murphy wrote:
> On 16/01/18 13:25, Jeffy Chen wrote:
>> IOMMU drivers are supposed to call this function instead of manually
>> creating a group in their .add_device callback. This behavior is not
>> strictly required by ARM DMA mapping implementation, but ARM64 already
>> relies on it. This patch fixes the rockchip-iommu driver to comply with
>> this requirement.
>
> FWIW that's not 100% true: what arm64 relies on is the group having a
> default DMA ops domain. Technically, you *could* open-code that in the
> driver's group allocation, but obviously using the appropriate existing
> API is nicer :)
ok, will rewrite the commit message.
>
> [...]
>> @@ -1182,6 +1164,29 @@ static void rk_iommu_remove_device(struct
>> device *dev)
>>       iommu_group_remove_device(dev);
>>   }
>> +static struct iommu_group *rk_iommu_device_group(struct device *dev)
>> +{
>> +    struct iommu_group *group;
>> +    int ret;
>> +
>> +    group = iommu_group_get(dev);
>> +    if (!group) {
>
> This check is pointless - if dev->iommu_group were non-NULL you wouldn't
> have been called in the first place.
right, it's allocated in the probe.
>
> Robin.
